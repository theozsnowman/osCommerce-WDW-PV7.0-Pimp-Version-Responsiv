<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
*/
?>
<div class="col-sm-<?php echo $content_width; ?> new-products">

  <h3><?php echo sprintf(MODULE_CONTENT_NEW_PRODUCTS_HEADING, strftime('%B')); ?></h3>
  
  <div class="row" itemtype="http://schema.org/ItemList">
    <meta itemprop="numberOfItems" content="<?php echo (int)$num_new_products; ?>" />
    <?php 
    while ($new_products = tep_db_fetch_array($new_products_query)) {
    	
    	$image = ''; $PercentRound = ''; $image_overlay_sales = '';
    	$ProductPrice = $currencies->display_price($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id']));
      
     	$wdw_vat = ( DISPLAY_TAX_INFO == 'true' ) ? ( DISPLAY_PRICE_WITH_TAX == 'true' ) ? '<br /><span class="wdw_vat_text">'. sprintf(TEXT_INCL_VAT, tep_get_tax_rate($new_products['products_tax_class_id']).'%') . '</span>' : '<br /><span class="wdw_vat_text">' . TEXT_EXCL_VAT . '</span>' : '';
   		$wdw_shipping = ( DISPLAY_SHIPPING_INFO == 'true' ) ?  '<br /><span class="wdw_shipping_text">' . TEXT_SHIPPING . '</span>' : '';
            	
    	if ( $new_products['products_price'] != $new_products['specials_new_products_price'] ) {
    		if ( DISPLAY_OVERLAY_IMAGES_SALES == 'true') {
    	 		$image_overlay_sales = tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'overlay-sale.png', IMAGE_SALE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'style="margin-top: -75%"');
      	}
        if ( DISPLAY_DISCOUNT_INFO == 'true' ) {
    			//Formular --->>>> Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100
    			$OldPrice = $currencies->display_raw($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id']));
    			$NewPrice = $currencies->display_raw($new_products['specials_new_products_price'], tep_get_tax_rate($new_products['products_tax_class_id']));
    			$Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100;
    			$PercentRound = '<br />' . round($Percent, TAX_DECIMAL_PLACES) . '%';
    		}
    		$ProductPrice = '<del>' . $currencies->display_price($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id'])).'</del>&nbsp;&nbsp;' . $currencies->display_price($new_products['specials_new_products_price'], tep_get_tax_rate($new_products['products_tax_class_id'])) . $PercentRound;
    	}
    	
    	if ($new_products['image_display'] == 1) {
    		$image = tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT) . $image_overlay_sales;
    	} elseif (($new_products['image_display'] != 2) && tep_not_null($new_products['products_image'])) {
    		$image = tep_image(DIR_WS_IMAGES_THUMBS . $new_products['image_folder'] . $new_products['products_image'], $new_products['products_name'], SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'itemprop="image"') . $image_overlay_sales;
    	}
		?>
		
    <div class="col-sm-<?php echo $product_width; ?>" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/Product">
      <div class="thumbnail equal-height">
        <a href="<?php echo tep_href_link('product_info.php', 'products_id=' . (int)$new_products['products_id']); ?>"><?php echo $image; ?></a>
        <div class="caption">
          <p class="text-center"><a itemprop="url" href="<?php echo tep_href_link('product_info.php', 'products_id=' . (int)$new_products['products_id']); ?>"><span itemprop="name"><?php echo $new_products['products_name']; ?></span></a></p>
          <hr>
          <p class="text-center" itemprop="offers" itemscope itemtype="http://schema.org/Offer"><meta itemprop="priceCurrency" content="<?php echo tep_output_string($currency); ?>" /><span itemprop="price" content="<?php echo $currencies->display_raw($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id'])); ?>"><?php echo $ProductPrice . $wdw_vat . $wdw_shipping; ?></span></p>
          <div class="text-center">
            <div class="btn-group">
              <a href="<?php echo tep_href_link('product_info.php', tep_get_all_get_params(array('action')) . 'products_id=' . (int)$new_products['products_id']); ?>" class="btn btn-default" role="button"><?php echo MODULE_CONTENT_NEW_PRODUCTS_BUTTON_VIEW; ?></a>
              <a href="<?php echo tep_href_link($PHP_SELF, tep_get_all_get_params(array('action')) . 'action=buy_now&products_id=' . (int)$new_products['products_id']); ?>" class="btn btn-success" role="button"><?php echo MODULE_CONTENT_NEW_PRODUCTS_BUTTON_BUY; ?></a>
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
         