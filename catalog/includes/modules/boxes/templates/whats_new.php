<?php
		$image = ''; 
		$image_overlay_sales = '';
 		$image_overlay_new = '';

		if ( DISPLAY_OVERLAY_IMAGES_NEW == 'true') {
			$image_overlay_new = tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'overlay-new.png', IMAGE_NEW, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'style=margin-top:' . -SMALL_IMAGE_HEIGHT . 'px;');
		} 

		if (tep_not_null($random_product['specials_new_products_price'])) {
			$image_overlay_sales = tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'overlay-sale.png', IMAGE_SALE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'style=margin-top:' . -SMALL_IMAGE_HEIGHT . 'px;');
		}
		
    if ($random_product['image_display'] == 1) {
    	$image = tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT) . $image_overlay_sales . $image_overlay_new;
    } elseif (($random_product['image_display'] != 2) && tep_not_null($random_product['products_image'])) {
    	$image = tep_image(DIR_WS_IMAGES_THUMBS . $random_product['image_folder'] . $random_product['products_image'], $random_product['products_name'], SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT) . $image_overlay_sales . $image_overlay_new;
    }
?>
<div class="panel panel-default">
  <div class="panel-heading"><a href="<?php echo tep_href_link('products_new.php'); ?>"><?php echo MODULE_BOXES_WHATS_NEW_BOX_TITLE; ?></a></div>
  <div class="panel-body text-center">
    <?php echo '<a href="' . tep_href_link('product_info.php', 'products_id=' . $random_product['products_id']) . '">' . $image . '</a><br /><a href="' . tep_href_link('product_info.php', 'products_id=' . $random_product['products_id']) . '">' . $random_product['products_name'] . '</a><br />' . $whats_new_price . '</div>'; ?>
</div>
