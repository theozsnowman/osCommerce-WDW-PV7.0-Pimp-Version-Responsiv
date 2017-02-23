<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  require('includes/languages/' . $language . '/reviews.php');

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link('reviews.php'));

  require('includes/template_top.php');
?>

<div class="page-header">
  <h1><?php echo HEADING_TITLE; ?></h1>
</div>

<div class="contentContainer">

<?php
  $reviews_query_raw = "select r.reviews_id, SUBSTRING_INDEX(rd.reviews_text, ' ', 20) as reviews_text, r.reviews_rating, r.date_added, p.products_id, pd.products_name, p.products_image, p.image_folder, p.image_display, r.customers_name from " . TABLE_REVIEWS . " r, " . TABLE_REVIEWS_DESCRIPTION . " rd, " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = r.products_id and r.reviews_id = rd.reviews_id and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' and rd.languages_id = '" . (int)$languages_id . "' and reviews_status = 1 order by r.reviews_rating DESC";
  $reviews_split = new splitPageResults($reviews_query_raw, MAX_DISPLAY_NEW_REVIEWS);

  if ($reviews_split->number_of_rows > 0) {
    if ((PREV_NEXT_BAR_LOCATION == '1') || (PREV_NEXT_BAR_LOCATION == '3')) {
?>
<div class="row">
  <div class="col-sm-6 pagenumber hidden-xs">
    <?php echo $reviews_split->display_count(TEXT_DISPLAY_NUMBER_OF_REVIEWS); ?>
  </div>
  <div class="col-sm-6">
    <span class="pull-right pagenav"><ul class="pagination"><?php echo $reviews_split->display_links(MAX_DISPLAY_PAGE_LINKS, tep_get_all_get_params(array('page', 'info'))); ?></ul></span>
    <span class="pull-right"><?php echo TEXT_RESULT_PAGE; ?></span>
  </div>
</div>
<?php
    }
    ?>
    <div class="contentText">
      <div class="reviews">
<?php
    $reviews_query = tep_db_query($reviews_split->sql_query);
    while ($reviews = tep_db_fetch_array($reviews_query)) {
    	
    	$image = ''; 
			$image_overlay_sales = '';

			if ( tep_not_null(tep_get_products_special_price($reviews['products_id'])) ) {
				if ( DISPLAY_OVERLAY_IMAGES_SALES == 'true') {
					$image_overlay_sales = '<div id="wdw_overlay_sale_product_info" class="wdw_overlay_sale_product_info">' . tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'overlay-sale.png', IMAGE_SALE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'style="margin-left: -20px; margin-top: ' . -SMALL_IMAGE_HEIGHT . 'px;"') . '</div>';
				}
			}
    	if ($reviews['image_display'] == 1) {
    		$image = tep_image('includes/languages/' . $language . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT);
    	} elseif (($reviews['image_display'] != 2) && tep_not_null($reviews['products_image'])) {
    		$image = tep_image(DIR_WS_IMAGES_THUMBS . $reviews['image_folder'] . tep_output_string_protected($reviews['products_image']), tep_output_string_protected($reviews['products_name']), SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT);
    	}
    	
      echo '<blockquote class="col-sm-12">';
      echo '  <p><span class="pull-left">' . $image . '</span>' . tep_output_string_protected($reviews['reviews_text']) . ' ... </p><div class="clearfix"></div>' . $image_overlay_sales;
      $reviews_name = tep_output_string_protected($reviews['customers_name']);
      echo '  <footer>' . sprintf(REVIEWS_TEXT_RATED, tep_draw_stars($reviews['reviews_rating']), $reviews_name, $reviews_name) . ' <a href="' . tep_href_link('product_reviews.php', 'products_id=' . (int)$reviews['products_id']) . '"><span class="pull-right label label-info">' . REVIEWS_TEXT_READ_MORE . '</span></a></footer>';
      echo '</blockquote>';
    }
    ?>
      </div>
      <div class="clearfix"></div>
    </div>
<?php
  } else {
?>

  <div class="alert alert-info">
    <?php echo TEXT_NO_REVIEWS; ?>
  </div>

<?php
  }

  if (($reviews_split->number_of_rows > 0) && ((PREV_NEXT_BAR_LOCATION == '2') || (PREV_NEXT_BAR_LOCATION == '3'))) {
?>
<div class="row">
  <div class="col-sm-6 pagenumber hidden-xs">
    <?php echo $reviews_split->display_count(TEXT_DISPLAY_NUMBER_OF_REVIEWS); ?>
  </div>
  <div class="col-sm-6">
    <span class="pull-right pagenav"><ul class="pagination"><?php echo $reviews_split->display_links(MAX_DISPLAY_PAGE_LINKS, tep_get_all_get_params(array('page', 'info'))); ?></ul></span>
    <span class="pull-right"><?php echo TEXT_RESULT_PAGE; ?></span>
  </div>
</div>
<?php
  }
?>

</div>

<?php
  require('includes/template_bottom.php');
  require('includes/application_bottom.php');
?>
