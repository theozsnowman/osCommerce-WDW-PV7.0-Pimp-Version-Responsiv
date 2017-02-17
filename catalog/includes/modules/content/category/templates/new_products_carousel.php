<?php
/*
  $Id: new_products_carousel.php, v1.4 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
 */

  // template with panel border

  // carousel slide preperation
  $new_prods_content = NULL;

  $new_prods_content .= '<div id="cat-new-products" class="owl-carousel owl-theme">';
  $wrapper_slides = '';

  while ($new_products = tep_db_fetch_array($new_products_query)) {

  	$image = ''; 
  	$image_overlay_sales = '';
  	
  	if (tep_not_null($new_products['specials_new_products_price'])) {
  		if ( DISPLAY_OVERLAY_IMAGES_SALES == 'true') {
				$image_overlay_sales = tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'overlay-sale.png', IMAGE_SALE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'style="margin-left: 0px; margin-top: -75%;"');
			}
		}
    if ($new_products['image_display'] == 1) {
    	$image = tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT) . $image_overlay_sales;	  
    } elseif (($new_products['image_display'] != 2) && tep_not_null($new_products['products_image'])) {
    	$image = tep_image(DIR_WS_IMAGES_THUMBS . $new_products['image_folder'] . $new_products['products_image'], $new_products['products_name'], SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'itemprop="image"') . $image_overlay_sales;
    }
  	
    $wrapper_slides .= '  <div class="item box-height" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/Product">';
    $wrapper_slides .= '    <div class="thumbnail item-height">';
    $wrapper_slides .= '      <div class="img-height">';
    $wrapper_slides .= '        <a href="' . tep_href_link('product_info.php', 'products_id=' . $new_products['products_id']) . '"><span class="thumbnail">' . $image . '</span></a>';
    $wrapper_slides .= '      </div>';
    $wrapper_slides .= '      <div class="caption">';
    $wrapper_slides .= '        <p class="text-center caption-height"><a itemprop="url" href="' . tep_href_link('product_info.php', 'products_id=' . $new_products['products_id']) . '"><span itemprop="name">' . $new_products['products_name'] . '</span></a></p>';

    // Show the products description if enabled in Admin
    if ( $show_description ) {
      $wrapper_slides .= '      <p class="text-height">';
      if ( strlen($new_products['products_description']) > MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_DESCRIPTION_LENGTH ) {
        $description_text = tep_category_new_products_carousel_limit_text( $new_products['products_description'], MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_DESCRIPTION_LENGTH, MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_WORD_LENGTH );
        $wrapper_slides .= '      <span itemprop="description">' . $description_text . '</span> <a href="' . tep_href_link ('product_info.php', 'products_id=' . $new_products['products_id']) . '" style="white-space: nowrap;">' . MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_DESCRIPTION_SHOW_MORE . '</a>';
      } else {
        $wrapper_slides .= '      <span itemprop="description">' . $new_products['products_description'] . '</span>';
      }
      $wrapper_slides .= '      </p>';
    }

    $wrapper_slides .= '        <hr>';

    $wrapper_slides .= '        <div class="price-height">';
    $wrapper_slides .= '          <p class="text-center" itemprop="offers" itemscope itemtype="http://schema.org/Offer"><meta itemprop="priceCurrency" content="' . tep_output_string($currency) . '" />';
    
   	$wdw_vat = ( DISPLAY_TAX_INFO == 'true' ) ? ( DISPLAY_PRICE_WITH_TAX == 'true' ) ? '<br /><span class="wdw_vat_text">'. sprintf(TEXT_INCL_VAT, tep_get_tax_rate($new_products['products_tax_class_id']).'%') . '</span>' : '<br /><span class="wdw_vat_text">' . TEXT_EXCL_VAT . '</span>' : '';
   	$wdw_shipping = ( DISPLAY_SHIPPING_INFO == 'true' ) ?  '<br /><span class="wdw_shipping_text">' . TEXT_SHIPPING . '</span>' : '';
    
    if (tep_not_null($new_products['specials_new_products_price'])) {
    	if ( DISPLAY_DISCOUNT_INFO == 'true' ) {
    		//Formular --->>>> Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100
    		$OldPrice = $currencies->display_raw($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id']));
    		$NewPrice = $currencies->display_raw($new_products['specials_new_products_price'], tep_get_tax_rate($new_products['products_tax_class_id']));
    		$Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100;
    		$PercentRound = '<br />' . round($Percent, TAX_DECIMAL_PLACES) . '%';
    	}
      // Show the products old price if enabled in Admin
      if ($show_old_price) {
      	$wrapper_slides .= '        <del>' .  $currencies->display_price($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id'])) . '</del>&nbsp;&nbsp;';
      }
      $wrapper_slides .= '          <span class="productSpecialPrice" itemprop="price" content="' . $currencies->display_raw($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id'])) . '">' . $currencies->display_price($new_products['specials_new_products_price'], tep_get_tax_rate($new_products['products_tax_class_id'])) . $PercentRound . $wdw_vat . $wdw_shipping . '</span>';
    } else {
      $wrapper_slides .= '          <span itemprop="price" content="' . $currencies->display_raw($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id'])) . '">' . $currencies->display_price($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id'])) . $wdw_vat . $wdw_shipping . '</span>';
    }
    $wrapper_slides .= '          </p>';
    $wrapper_slides .= '        </div>';

    $wrapper_slides .= '        <div class="text-center">';
    $wrapper_slides .= '          <div class="btn-group">';
    $wrapper_slides .= '            <a href="' . tep_href_link('product_info.php', tep_get_all_get_params(array('action')) . 'products_id=' . $new_products['products_id']) . '" class="btn btn-default" role="button">' . MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_BUTTON_VIEW . '</a>';
    $wrapper_slides .= '            <a href="' . tep_href_link($PHP_SELF, tep_get_all_get_params(array('action')) . 'action=buy_now&products_id=' . $new_products['products_id']) . '" class="btn btn-success" role="button">' . MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_BUTTON_BUY . '</a>';
    $wrapper_slides .= '          </div>';
    $wrapper_slides .= '        </div>';
    $wrapper_slides .= '      </div>';
    $wrapper_slides .= '    </div>';
    $wrapper_slides .= '  </div>';
  }

  $new_prods_content .= $wrapper_slides;
  $new_prods_content .= '</div>';
?>

<!-- local template css -->
<style type="text/css">
#cat-new-products {
  padding: 0 10px 0 10px;
}
#cat-new-products .item {
  margin: 15px 10px 15px 10px;
}
#cat-new-products .thumbnail:hover {
  border: 1px solid #428bca;
}
#cat-new-products .owl-pagination {
  margin-top: -15px;
}
#cat-new-products .img-height {
  padding-top: 5px;
}
#cat-new-products .owl-prev, #cat-new-products .owl-next {
  position: absolute;
  top: 50%;
  margin-top: -40px;
  font-size: 50px;
  height: 60px;
}
#cat-new-products .owl-prev {
  left: -2px;
  padding-left: 18px;
}
#cat-new-products .owl-next {
  right: -2px;
  padding-right: 18px;
}
</style>

  <!-- carousel slide output -->
  <div id="cat_new_products_carousel" class="col-sm-12">
    <div class="panel panel-info">
      <div class="panel-heading">
          <h4 class="panel-title">
            <?php echo sprintf(MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_HEADING, strftime('%B')) . (!isset($current_category_id) || $current_category_id == '0' ? '' : ' <i><span style="font-size: 12px;">' . sprintf(MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CATEGORY, ($category_depth == 'products' ? '' : MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SUB_CATEGORY)) . '</span></i>') . ' <i><a style="font-size: 12px; text-decoration: none; outline: none; white-space: nowrap;" href="' . tep_href_link('products_new.php') . '">' . MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_HEADING_SHOW_MORE . '</a></i>'; ?>

<?php
  if (MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CLOSE == 'True' && $category_depth != 'top') { // only allow to close in nested category pages or product pages, not front page
?>

            <button type="button" class="close" data-target="#cat_new_products_carousel" data-dismiss="alert">
              <span aria-hidden="true">&times;</span><span class="sr-only"><?php echo MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PANEL_CLOSE; ?></span>
            </button>

<?php
  }
?>

          </h4>
      </div>
      <div class="panel-body" style="padding-bottom: 0px; padding-top: 0px;">
        <div class="row" itemtype="http://schema.org/ItemList">
          <meta itemprop="numberOfItems" content="<?php echo (int)$num_new_products; ?>" />
          <?php echo $new_prods_content; ?>
        </div>
      </div>
    </div>
  </div>
  
<?php
// local template script, loaded in footer
$footer_scripts = '<script type="text/javascript">

$(document).ready(function() {
  var owl = $("#cat-new-products");
  owl.owlCarousel({
      items : 4, // This variable allows you to set the maximum amount of items displayed at a time with the widest browser width
      itemsDesktop : [1199,3], // This allows you to preset the number of slides visible with a particular browser width. For example [1199,3] means that if(window<=1199){ show 3 slides per page}
      itemsTablet: [768,2], // As above
      itemsMobile : [479,1], // As above
      autoPlay: ' . (MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_AUTOPLAY == 'True' ? (MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_AUTOPLAY_SPEED > '0' ? MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_AUTOPLAY_SPEED : 'true') : 'false') . ', // by default, when true, auto plays every 5 secs (5000), change true to false to NOT auto play or to another value ie 4000 to change auto play speed
      stopOnHover: true, // Stop autoplay on mouse hover
      scrollPerPage: true, // Scroll per page not per item.
      itemsScaleUp: true, // Option to stretch items when it is less than the supplied items.
      navigation: true, // Display "next" and "prev" buttons.
      rewindSpeed: 1500, // Rewind speed in milliseconds
      paginationSpeed: ' . (MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PAGE_SLIDE_SPEED > '0' ? MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PAGE_SLIDE_SPEED : '800') . ', // Page slide speed in milliseconds - default 800
      slideSpeed: ' . (MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_NAV_SLIDE_SPEED > '0' ? MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_NAV_SLIDE_SPEED : '700') . ', // Slide speed (using nav buttons) in milliseconds - default 700
      navigationText: [\'<span class="fa fa-angle-left pull-left"></span><span class="sr-only">' . MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CONTROL_SR_PREV . '</span>\',
                       \'<span class="fa fa-angle-right pull-right"></span><span class="sr-only">' . MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CONTROL_SR_NEXT . '</span>\']
  });

  var box_height = $("#cat-new-products .box-height");
  var item_height = $("#cat-new-products .item-height");
  var img_height = $("#cat-new-products .img-height");
  var caption_height = $("#cat-new-products .caption-height");
  var price_height = $("#cat-new-products .price-height");
  var text_height = false;
  if ($("#cat-new-products .text-height").is(":visible")) {
    text_height = $("#cat-new-products .text-height");
  }

  function new_equalHeight(group, resize) {
    var resize = resize || false;
    var maxHeight = 0;
    if (resize) {
      group.height(\'auto\'); // need this for window resize
    }
    group.each(function() {
      if ($(this).height() > maxHeight) {
        maxHeight = $(this).height();
      }
    });
    group.height(maxHeight);
  }

  var timer;
  $(window).resize(function() {
    clearTimeout(timer);
    timer = setTimeout(function() {
      new_equalHeight(img_height, true);
      new_equalHeight(caption_height, true);
      new_equalHeight(price_height, true);
      if (text_height != false) {
        new_equalHeight(text_height, true);
      }
      new_equalHeight(item_height, true);
      new_equalHeight(box_height, true);
    }, 200);
  });

  new_equalHeight(img_height);
  new_equalHeight(caption_height);
  new_equalHeight(price_height);
  if (text_height != false) {
    new_equalHeight(text_height);
  }
  new_equalHeight(item_height);
  new_equalHeight(box_height);
});

</script>' . PHP_EOL;

$oscTemplate->addBlock($footer_scripts, 'footer_scripts');
?>
