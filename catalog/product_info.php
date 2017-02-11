<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  if (!isset($_GET['products_id'])) {
    tep_redirect(tep_href_link('index.php'));
  }

  require('includes/languages/' . $language . '/product_info.php');

  $product_check_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = '" . (int)$_GET['products_id'] . "' and pd.products_id = p.products_id and pd.language_id = '" . (int)$languages_id . "'");
  $product_check = tep_db_fetch_array($product_check_query);

  require('includes/template_top.php');

  if ($product_check['total'] < 1) {
?>

<div class="contentContainer">
  <div class="contentText">
    <div class="alert alert-warning"><?php echo TEXT_PRODUCT_NOT_FOUND; ?></div>
  </div>

  <div class="pull-right">
    <?php echo tep_draw_button(IMAGE_BUTTON_CONTINUE, 'fa fa-angle-right', tep_href_link('index.php')); ?>
  </div>
</div>

<?php
  } else {
    $product_info_query = tep_db_query("select p.products_id, pd.products_name, pd.products_description, p.products_model, p.products_quantity, p.products_image, p.image_display, p.image_folder, pd.products_url, p.products_price, p.products_tax_class_id, p.products_date_added, p.products_date_available, p.manufacturers_id, p.products_gtin from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = '" . (int)$_GET['products_id'] . "' and pd.products_id = p.products_id and pd.language_id = '" . (int)$languages_id . "'");
    $product_info = tep_db_fetch_array($product_info_query);

    tep_db_query("update " . TABLE_PRODUCTS_DESCRIPTION . " set products_viewed = products_viewed+1 where products_id = '" . (int)$_GET['products_id'] . "' and language_id = '" . (int)$languages_id . "'");
    
    $wdw_vat = ( DISPLAY_PRICE_WITH_TAX == 'true' ) ? '<div class="wdw_vat_text">'.TEXT_INCL_VAT.'</div>' : '<div class="wdw_vat_text">'.TEXT_EXCL_VAT.'</div>';
    if ($new_price = tep_get_products_special_price($product_info['products_id'])) {
    	// included by webmaster@webdesign-wedel.de (2017)
    	// BOM
    	//Formular --->>>> Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100
    	$OldPrice = $currencies->display_raw($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id']));
    	$NewPrice = $currencies->display_raw($new_price, tep_get_tax_rate($product_info['products_tax_class_id']));
    	$Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100;
    	$PercentRound = round($Percent, TAX_DECIMAL_PLACES);
      $products_price = '<del>' . $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . '</del> <span class="productSpecialPrice" itemprop="price" content="' . $currencies->display_raw($new_price, tep_get_tax_rate($product_info['products_tax_class_id'])) . '">' . $currencies->display_price($new_price, tep_get_tax_rate($product_info['products_tax_class_id'])) . '<br />' . $PercentRound . '%<br />' . $wdw_vat . '</span>';
      
    	// EOM
    } else {
      $products_price = '<span itemprop="price" content="' . $currencies->display_raw($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . '">' . $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . '<br />' . $wdw_vat . '</span>';
    }

    if ($product_info['products_date_available'] > date('Y-m-d H:i:s')) {
      $products_price .= '<link itemprop="availability" href="http://schema.org/PreOrder" />';
    } elseif ((STOCK_CHECK == 'true') && ($product_info['products_quantity'] < 1)) {
      $products_price .= '<link itemprop="availability" href="http://schema.org/OutOfStock" />';
    } else {
      $products_price .= '<link itemprop="availability" href="http://schema.org/InStock" />';
    }

    $products_price .= '<meta itemprop="priceCurrency" content="' . tep_output_string($currency) . '" />';

    $products_name = '<a href="' . tep_href_link('product_info.php', 'products_id=' . $product_info['products_id']) . '" itemprop="url"><span itemprop="name">' . $product_info['products_name'] . '</span></a>';

    if (tep_not_null($product_info['products_model'])) {
      $products_name .= '<br /><small>[<span itemprop="model">' . $product_info['products_model'] . '</span>]</small>';
    }
?>

<?php echo tep_draw_form('cart_quantity', tep_href_link('product_info.php', tep_get_all_get_params(array('action')). 'action=add_product', 'NONSSL'), 'post', 'class="form-horizontal" role="form"'); ?>

<div itemscope itemtype="http://schema.org/Product">

<div class="page-header">
  <div class="row">  
    <h1 class="col-sm-8"><?php echo $products_name; ?></h1>
    <h2 class="col-sm-4 text-right-not-xs" itemprop="offers" itemscope itemtype="http://schema.org/Offer"><?php echo $products_price; ?></h2>
  </div>
</div>

<?php
  if ($messageStack->size('product_action') > 0) {
    echo $messageStack->output('product_action');
  }
?>

<div class="contentContainer">
  <div class="contentText">

<?php
		$image = ''; 
		$image_overlay_sales = '';

		if ( tep_not_null(tep_get_products_special_price($product_info['products_id'])) ) {
			if ( DISPLAY_OVERLAY_IMAGES_SALES == 'true') {
				$image_overlay_sales = '<div id="wdw_overlay_sale_product_info" class="wdw_overlay_sale_product_info">' . tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'overlay-sale.png', IMAGE_SALE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'style="margin-left: 0px; margin-top: ' . -SMALL_IMAGE_HEIGHT . 'px;"') . '</div>';
			}
		}
		
    if ($product_info['image_display'] == 1) { // use "No Picture Available" image
      echo '<div class="pull-left" style="padding: 0px 10px 0px 0px;">';
      //echo tep_image('includes/languages/' . $language . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'hspace="5" vspace="5" style="float: right;"');
      echo '<span class="thumbnail">' . tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT) . '</span>' . $image_overlay_sales;
      echo '</div>';
    } elseif (($product_info['image_display'] != 2) && (tep_not_null($product_info['products_image']))) { // show product images
      //echo tep_image(DIR_WS_IMAGES_PROD . $product_info['image_folder'] . $product_info['products_image'], NULL, NULL, NULL, 'itemprop="image" style="display:none;"');

      $photoset_layout = (int)MODULE_HEADER_TAGS_PRODUCT_COLORBOX_LAYOUT;

      $pi_query = tep_db_query("select image, htmlcontent from " . TABLE_PRODUCTS_IMAGES . " where products_id = '" . (int)$product_info['products_id'] . "' order by sort_order");
      $pi_total = tep_db_num_rows($pi_query);

      if ($pi_total > 1) {
?>
<div class="pull-left" data-imgcount="<?php echo $photoset_layout; ?>" style="padding: 0px 10px 0px 0px;">
	<div id="gallery_01">
		<?php
			$pi_counter = 0;
			$pi_html = array();
	
			while ($pi = tep_db_fetch_array($pi_query)) {
				$pi_counter++;

				if ( $pi_counter == 1 ) {
					echo '<span class="thumbnail">';
					echo tep_image(DIR_WS_IMAGES_THUMBS . $product_info['image_folder'] . $pi['image'], '', SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'data-zoom-image="' . DIR_WS_IMAGES_PROD . $product_info['image_folder'] . $pi['image'] . '" title="' . $product_info['products_name'] . '" id="zoom_01"') . $image_overlay_sales;
					echo '</span>';
				} 
				if (tep_not_null($pi['htmlcontent'])) {
					$pi_html[] = '<div id="GalDiv_' . $pi_counter . '">' . $pi['htmlcontent'] . '</div>';
        }
        
	  ?>
				
					<a href="#" data-image="<?php echo DIR_WS_IMAGES_THUMBS . $product_info['image_folder'] . $pi['image']; ?>" data-zoom-image="<?php echo DIR_WS_IMAGES_PROD . $product_info['image_folder'] . $pi['image']; ?>" title="<?php echo $product_info['products_name']; ?>">
    				<span class="thumbnail" style="float: left; width: 70px; height: 60px; margin-top: 5px; margin-right: 5px; margin-bottom: 5px;">
    					<?php echo tep_image(DIR_WS_IMAGES_THUMBS . $product_info['image_folder'] . $pi['image'], '', '100', '80', 'data-zoom-image="' . DIR_WS_IMAGES_PROD . $product_info['image_folder'] . $pi['image'] . '" title="' . $product_info['products_name'] . '" id="zoom_01"'); ?>
    				</span>
  				</a>
			<?php } ?>
	</div>
</div>

<?php
        if ( !empty($pi_html) ) {
          echo '    <div style="display: none;">' . implode('', $pi_html) . '</div>';
        }
    } else {
?>
    <div class="pull-left" style="padding: 0px 10px 10px 0px;">
    	<div id="gallery_01">    		
    			<a href="#" data-image="<?php echo DIR_WS_IMAGES_THUMBS . $product_info['image_folder'] . $product_info['products_image']; ?>" data-zoom-image="<?php echo DIR_WS_IMAGES_PROD . $product_info['image_folder'] . $product_info['products_image']; ?>" title="<?php echo $product_info['products_name']; ?>">
   					<span class="thumbnail">
   						<?php echo tep_image(DIR_WS_IMAGES_THUMBS . $product_info['image_folder'] . $product_info['products_image'], '', SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'data-zoom-image="' . DIR_WS_IMAGES_PROD . $product_info['image_folder'] . $product_info['products_image'] . '" title="' . $product_info['products_name'] . '" id="zoom_01"') . $image_overlay_sales; ?>
   					</span>
   	  		</a>
   	  </div>
    </div> 
<?php
    }
  }
?>
<script>
	//initiate the plugin and pass the id of the div containing gallery images
	$("#zoom_01").elevateZoom({gallery:'gallery_01', cursor: 'pointer', galleryActiveClass: 'active', imageCrossfade: true, scrollZoom: true, easing: true, zoomType: "window", cursor: "crosshair", responsive: "true", loadingIcon: 'false'});

	//pass the images to Fancybox
	$("#zoom_01").bind("click", function(e) {  
  	var ez =   $('#zoom_01').data('elevateZoom');	
		$.fancybox(ez.getGalleryList());
  	return false;
	});
</script>

<div itemprop="description">
  <?php echo stripslashes($product_info['products_description']); ?>
</div>

<?php
    $products_attributes_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_ATTRIBUTES . " patrib where patrib.products_id='" . (int)$_GET['products_id'] . "' and patrib.options_id = popt.products_options_id and popt.language_id = '" . (int)$languages_id . "'");
    $products_attributes = tep_db_fetch_array($products_attributes_query);
    if ($products_attributes['total'] > 0) {
?>

    <h4><?php echo TEXT_PRODUCT_OPTIONS; ?></h4>

    <p>
<?php
      $products_options_name_query = tep_db_query("select distinct popt.products_options_id, popt.products_options_name from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_ATTRIBUTES . " patrib where patrib.products_id='" . (int)$_GET['products_id'] . "' and patrib.options_id = popt.products_options_id and popt.language_id = '" . (int)$languages_id . "' order by popt.products_options_name");
      while ($products_options_name = tep_db_fetch_array($products_options_name_query)) {
        $products_options_array = array();
        $products_options_query = tep_db_query("select pov.products_options_values_id, pov.products_options_values_name, pa.options_values_price, pa.price_prefix from " . TABLE_PRODUCTS_ATTRIBUTES . " pa, " . TABLE_PRODUCTS_OPTIONS_VALUES . " pov where pa.products_id = '" . (int)$_GET['products_id'] . "' and pa.options_id = '" . (int)$products_options_name['products_options_id'] . "' and pa.options_values_id = pov.products_options_values_id and pov.language_id = '" . (int)$languages_id . "'");
        while ($products_options = tep_db_fetch_array($products_options_query)) {
          $products_options_array[] = array('id' => $products_options['products_options_values_id'], 'text' => $products_options['products_options_values_name']);
          if ($products_options['options_values_price'] != '0') {
            $products_options_array[sizeof($products_options_array)-1]['text'] .= ' (' . $products_options['price_prefix'] . $currencies->display_price($products_options['options_values_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) .') ';
          }
        }

        if (is_string($_GET['products_id']) && isset($cart->contents[$_GET['products_id']]['attributes'][$products_options_name['products_options_id']])) {
          $selected_attribute = $cart->contents[$_GET['products_id']]['attributes'][$products_options_name['products_options_id']];
        } else {
          $selected_attribute = false;
        }
?>
      <strong><?php echo $products_options_name['products_options_name'] . ':'; ?></strong><br /><?php echo tep_draw_pull_down_menu('id[' . $products_options_name['products_options_id'] . ']', $products_options_array, $selected_attribute, 'style="width: 200px;"'); ?><br />
<?php
      }
?>
    </p>

<?php
    }
?>

    <div class="clearfix"></div>

<?php
    if ($product_info['products_date_available'] > date('Y-m-d H:i:s')) {
?>

    <div class="alert alert-info"><?php echo sprintf(TEXT_DATE_AVAILABLE, tep_date_long($product_info['products_date_available'])); ?></div>

<?php
    }
?>

  </div>

<?php
    $reviews_query = tep_db_query("select count(*) as count, avg(reviews_rating) as avgrating from " . TABLE_REVIEWS . " r, " . TABLE_REVIEWS_DESCRIPTION . " rd where r.products_id = '" . (int)$_GET['products_id'] . "' and r.reviews_id = rd.reviews_id and rd.languages_id = '" . (int)$languages_id . "' and reviews_status = 1");
    $reviews = tep_db_fetch_array($reviews_query);

    if ($reviews['count'] > 0) {
      echo '<span itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating"><meta itemprop="ratingValue" content="' . $reviews['avgrating'] . '" /><meta itemprop="ratingCount" content="' . $reviews['count'] . '" /></span>';
    }
?>

  <div class="buttonSet row">
    <div class="col-xs-6"><?php echo tep_draw_button(IMAGE_BUTTON_REVIEWS . (($reviews['count'] > 0) ? ' (' . $reviews['count'] . ')' : ''), 'fa fa-commenting', tep_href_link('product_reviews.php', tep_get_all_get_params())); ?></div>
    <div class="col-xs-6 text-right"><?php echo tep_draw_hidden_field('products_id', $product_info['products_id']) . tep_draw_button(IMAGE_BUTTON_IN_CART, 'fa fa-shopping-cart', null, 'primary', null, 'btn-success'); ?></div>
  </div>

  <div class="row">
    <?php echo $oscTemplate->getContent('product_info'); ?>
  </div>

<?php
    if ((USE_CACHE == 'true') && empty($SID)) {
      echo tep_cache_also_purchased(3600);
    } else {
      include('includes/modules/also_purchased_products.php');
    }

    if ($product_info['manufacturers_id'] > 0) {
      $manufacturer_query = tep_db_query("select manufacturers_name from " . TABLE_MANUFACTURERS . " where manufacturers_id = '" . (int)$product_info['manufacturers_id'] . "'");
      if (tep_db_num_rows($manufacturer_query)) {
        $manufacturer = tep_db_fetch_array($manufacturer_query);
        echo '<span itemprop="manufacturer" itemscope itemtype="http://schema.org/Organization"><meta itemprop="name" content="' . tep_output_string($manufacturer['manufacturers_name']) . '" /></span>';
      }
    }
?>

</div>

</div>

</form>

<?php
  }
  require('includes/template_bottom.php');
  require('includes/application_bottom.php');
?>
