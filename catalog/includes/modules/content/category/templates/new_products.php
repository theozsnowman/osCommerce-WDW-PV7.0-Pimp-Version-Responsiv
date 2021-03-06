<?php
/*
  $Id: new_products.php, v1.1 19th Sept. 2016 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
 */
 
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
    
    if (tep_not_null($new_products['specials_new_products_price'])) {
    	// included by webmaster@webdesign-wedel.de (2017)
    	// BOM
    	//Formular --->>>> Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100
    	$OldPrice = $currencies->display_raw($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id']));
    	$NewPrice = $currencies->display_raw($new_products['specials_new_products_price'], tep_get_tax_rate($new_products['products_tax_class_id']));
    	$Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100;
    	$PercentRound = round($Percent, TAX_DECIMAL_PLACES);
    } 
?>

  <div id="new_products" class="col-sm-<?php echo (int)MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CONTENT_WIDTH; ?>">
    <h3><?php echo sprintf(MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_HEADING, strftime('%B')); ?></h3>

    <div class="row" itemtype="http://schema.org/ItemList">
      <meta itemprop="numberOfItems" content="<?php echo (int)$num_new_products; ?>" />
<?php
  while ($new_products = tep_db_fetch_array($new_products_query)) {
?>
      <div class="col-sm-<?php echo MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CONTENT_WIDTH_EACH; ?>" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/Product">
        <div class="thumbnail equal-height">
          <a href="<?php echo tep_href_link('product_info.php', 'products_id=' . $new_products['products_id']); ?>"><?php echo $image; ?></a>
          <div class="caption">
              <p class="text-center"><a itemprop="url" href="<?php echo tep_href_link('product_info.php', 'products_id=' . $new_products['products_id']); ?>"><span itemprop="name"><?php echo $new_products['products_name']; ?></span></a></p>
            <hr>
            <p class="text-center" itemprop="offers" itemscope itemtype="http://schema.org/Offer"><meta itemprop="priceCurrency" content="<?php echo tep_output_string($currency); ?>" /><span itemprop="price" content="<?php echo $currencies->display_raw($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id'])); ?>"><?php echo $currencies->display_price($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id'])); ?></span></p>
            <div class="text-center">
              <div class="btn-group">
                <a href="<?php echo tep_href_link('product_info.php', tep_get_all_get_params(array('action')) . 'products_id=' . $new_products['products_id']); ?>" class="btn btn-default" role="button"><?php echo MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_BUTTON_VIEW; ?></a>
                <a href="<?php echo tep_href_link($PHP_SELF, tep_get_all_get_params(array('action')) . 'action=buy_now&products_id=' . $new_products['products_id']); ?>" class="btn btn-success" role="button"><?php echo MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_BUTTON_BUY; ?></a>
              </div>
            </div>
          </div>
        </div>
      </div>
<?php
  }
?>
    </div>
  </div>
