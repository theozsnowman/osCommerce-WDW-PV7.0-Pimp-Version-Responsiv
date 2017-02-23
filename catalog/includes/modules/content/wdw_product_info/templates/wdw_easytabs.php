<div class="clearfix"></div>
<div style="margin-bottom: 10px"></div>
<div class="col-sm-<?php echo $content_width; ?> reviews">
	<div id="tab-container" class="tab-container">
  <ul class='etabs'>
    <li class='tab'><a href="#tabs1"><?php echo '<span class="fa fa-info-circle"></span> ' . MODULE_HEADER_TAGS_WDW_EASYTABS_DESCRIPTION_TAB; ?></a></li>
    <li class='tab'><a href="#tabs2"><?php echo '<span class="fa fa-info-circle"></span> ' . MODULE_HEADER_TAGS_WDW_EASYTABS_MORE_INFO_TAB; ?></a></li>
    <?php if ( !empty($product_info['products_gtin']) ) { ?>
    	<li class='tab'><a href="#tabs3"><?php echo '<span class="fa fa-barcode"></span> ' . MODULE_HEADER_TAGS_WDW_EASYTABS_BARCODE_TAB . ' ' . strtoupper(MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_BARCODES_STYLE); ?></a></li>
    <?php } ?>
    <li class='tab'><a href="#tabs4"><?php echo '<span class="fa fa-qrcode"></span> ' . MODULE_HEADER_TAGS_WDW_EASYTABS_ORCODE_TAB; ?></a></li>
    <li class='tab'><a href="#tabs5"><?php echo '<span class="fa fa-tags"></span> ' . MODULE_HEADER_TAGS_WDW_EASYTABS_TAGS_TAB; ?></a></li>
    <?php if ( !empty($review_data) ) { ?>
    	<li class='tab'><a href="#tabs6"><?php echo '<span class="fa fa-commenting"></span> ' . MODULE_HEADER_TAGS_WDW_EASYTABS_REVIEWS_TAB; ?></a></li>
    <?php } ?>
  </ul>
  <div id="tabs1" class="easy-tabs">
  	<div itemprop="description">
  		<?php echo stripslashes($product_info['products_description']); ?>
		</div>
  </div>
  <div id="tabs2" class="easy-tabs">
    <?php
    	echo MODULE_HEADER_TAGS_WDW_EASYTABS_PRODUCT_MODEL . ': ' . $product_info['products_model'] . '<br />';
    	echo $wdw_manufacturer;
    	echo MODULE_HEADER_TAGS_WDW_EASYTABS_PRODUCT_QUANTITY . ': ' . $product_info['products_quantity'] . '<br />';
    	echo MODULE_HEADER_TAGS_WDW_EASYTABS_PRODUCT_WEIGHT_TEXT . ': ' . $product_info['products_weight'] . ' ' .MODULE_HEADER_TAGS_WDW_EASYTABS_PRODUCT_WEIGHT_VALUE . '<br />';
    	echo MODULE_HEADER_TAGS_WDW_EASYTABS_PRODUCT_DATE_ADDED . ': ' . tep_date_long($product_info['products_date_added']) . '<br />';
    ?>
  </div>
  <?php if ( !empty($product_info['products_gtin']) ) { ?>
  	<div id="tabs3" class="easy-tabs">
    	<?php 
    		rename('images/barcodes/' . substr($product_info['products_gtin'], $wdw_character_value) . '.png', 'images/barcodes/' . MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_BARCODES_STYLE . '_' . substr($product_info['products_gtin'], $wdw_character_value) . '.png');
    		echo '<img src="images/barcodes/' . MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_BARCODES_STYLE . '_' . substr($product_info['products_gtin'], $wdw_character_value) . '.png" />'; 
    	?>
  	</div>
  <?php } ?>
  <div id="tabs4" class="easy-tabs">
    <?php
    	require('ext/barcodes/QRCode/qrlib.php');
    	QRcode::png(tep_href_link('product_info.php', 'products_id=' . $product_info['products_id']), 'images/barcodes/' . $product_info['products_id'].'.png', QR_ECLEVEL_H);
    	echo '<img src="images/barcodes/' . $product_info['products_id'] . '.png" />';
    	echo '<br />' . MODULE_HEADER_TAGS_WDW_EASYTABS_PRODUCT_LINK_TEXT; 
    ?>
  </div>
  	<div id="tabs5" class="easy-tabs">
  		<span itemprop="tags">
    	<?php
    		$wdw_tags_first = '<span class="fa fa-tags"></span>' . $product_info['products_name'] . ' <span class="fa fa-tags"></span>' . $wdw_manufacturer_name;
    		if ( !empty ($product_info['products_seo_keywords']) ) { $wdw_tags_content = explode(',', $product_info['products_seo_keywords']); }
    		for ($i=0; $i < sizeof($wdw_tags_content); $i++) { $wdw_tags .= ' <span class="fa fa-tags"></span>' . $wdw_tags_content[$i]; }
    		echo $wdw_tags_first.$wdw_tags;
    	?>
    </span>
  	</div>
  <?php if ( !empty($review_data) ) { ?>
  	<div id="tabs6" class="easy-tabs">
  		<?php echo $review_data; ?>  	  
  	</div>
  <?php } ?>
</div>
<br />

</div>

<script type="text/javascript">
	jQuery(document).ready(function(){
		$("#tab-container").easytabs({
			
		});
  });
</script>
