<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2012 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  require('includes/languages/' . $language . '/product_reviews_write.php');

  if (!tep_session_is_registered('customer_id')) {
    $navigation->set_snapshot();
    tep_redirect(tep_href_link('login.php', '', 'SSL'));
  }

  if (!isset($_GET['products_id'])) {
    tep_redirect(tep_href_link('product_reviews.php', tep_get_all_get_params(array('action'))));
  }

  $product_info_query = tep_db_query("select p.products_id, p.products_model, p.products_image, p.image_folder, p.image_display, p.products_price, p.products_tax_class_id, pd.products_name from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_id = '" . (int)$_GET['products_id'] . "' and p.products_status = '1' and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "'");
  if (!tep_db_num_rows($product_info_query)) {
    tep_redirect(tep_href_link('product_reviews.php', tep_get_all_get_params(array('action'))));
  } else {
    $product_info = tep_db_fetch_array($product_info_query);
  }

  $customer_query = tep_db_query("select customers_firstname, customers_lastname from " . TABLE_CUSTOMERS . " where customers_id = '" . (int)$customer_id . "'");
  $customer = tep_db_fetch_array($customer_query);

  if (isset($_GET['action']) && ($_GET['action'] == 'process') && isset($_POST['formid']) && ($_POST['formid'] == $sessiontoken)) {
    $rating = tep_db_prepare_input($_POST['rating']);
    $review = tep_db_prepare_input($_POST['review']);

    $error = false;
    if (strlen($review) < REVIEW_TEXT_MIN_LENGTH) {
      $error = true;

      $messageStack->add('review', JS_REVIEW_TEXT);
    }

    if (($rating < 1) || ($rating > 5)) {
      $error = true;

      $messageStack->add('review', JS_REVIEW_RATING);
    }

    if ($error == false) {
      tep_db_query("insert into " . TABLE_REVIEWS . " (products_id, customers_id, customers_name, reviews_rating, date_added) values ('" . (int)$_GET['products_id'] . "', '" . (int)$customer_id . "', '" . tep_db_input($customer['customers_firstname']) . ' ' . tep_db_input($customer['customers_lastname']) . "', '" . tep_db_input($rating) . "', now())");
      $insert_id = tep_db_insert_id();

      tep_db_query("insert into " . TABLE_REVIEWS_DESCRIPTION . " (reviews_id, languages_id, reviews_text) values ('" . (int)$insert_id . "', '" . (int)$languages_id . "', '" . tep_db_input($review) . "')");

      $messageStack->add_session('product_reviews', TEXT_REVIEW_RECEIVED, 'success');
      tep_redirect(tep_href_link('product_reviews.php', tep_get_all_get_params(array('action'))));
    }
  }

	$wdw_vat = ( DISPLAY_TAX_INFO == 'true' ) ? ( DISPLAY_PRICE_WITH_TAX == 'true' ) ? '<br /><div class="wdw_vat_text">'. sprintf(TEXT_INCL_VAT, tep_get_tax_rate($product_info['products_tax_class_id']).'%') . '</div>' : '<br /><div class="wdw_vat_text">' . TEXT_EXCL_VAT . '</div>' : '';
  $wdw_shipping = ( DISPLAY_SHIPPING_INFO == 'true' ) ?  '<div class="wdw_shipping_text">' . TEXT_SHIPPING . '</div>' : '';

  if ($new_price = tep_get_products_special_price($product_info['products_id'])) {
  	if ( DISPLAY_DISCOUNT_INFO == 'true' ) {
    	//Formular --->>>> Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100
    	$OldPrice = $currencies->display_raw($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id']));
    	$NewPrice = $currencies->display_raw($new_price, tep_get_tax_rate($product_info['products_tax_class_id']));
    	$Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100;
    	$PercentRound = '<br />' . round($Percent, TAX_DECIMAL_PLACES) . '%';
    }
    $products_price = '<del>' . $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . '</del> <span class="productSpecialPrice">' . $currencies->display_price($new_price, tep_get_tax_rate($product_info['products_tax_class_id'])) . $PercentRound . $wdw_vat . $wdw_shipping . '</span>';
  } else {
    $products_price = $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . $wdw_vat . $wdw_shipping;
  }

  if (tep_not_null($product_info['products_model'])) {
    $products_name = $product_info['products_name'] . '<br /><small>[' . $product_info['products_model'] . ']</small>';
  } else {
    $products_name = $product_info['products_name'];
  }
  
  $products_name .= ' <a href="' . tep_href_link( 'pdf_datasheet.php', 'products_id=' . ( int )$_GET['products_id'] . '&language=' . $language ) . '" alt="' . $product_info['products_name'].TEXT_PDF_DATASHEET . '" title="' . $product_info['products_name'].TEXT_PDF_DATASHEET . '">' . tep_image( 'images/icons/pdf.png', $product_info['products_name'].TEXT_PDF_DATASHEET, '40', '42', 'style="float: left; margin-right: 10px;"' ) . '</a>';
  
  $breadcrumb->add(NAVBAR_TITLE, tep_href_link('product_reviews.php', tep_get_all_get_params()));

  require('includes/template_top.php');
?>

<script><!--
function checkForm() {
  var error = 0;
  var error_message = "<?php echo JS_ERROR; ?>";

  var review = document.product_reviews_write.review.value;

  if (review.length < <?php echo REVIEW_TEXT_MIN_LENGTH; ?>) {
    error_message = error_message + "<?php echo JS_REVIEW_TEXT; ?>";
    error = 1;
  }

  if ((document.product_reviews_write.rating[0].checked) || (document.product_reviews_write.rating[1].checked) || (document.product_reviews_write.rating[2].checked) || (document.product_reviews_write.rating[3].checked) || (document.product_reviews_write.rating[4].checked)) {
  } else {
    error_message = error_message + "<?php echo JS_REVIEW_RATING; ?>";
    error = 1;
  }

  if (error == 1) {
    alert(error_message);
    return false;
  } else {
    return true;
  }
}
//--></script>

<div class="page-header">  
  <div class="row">
    <h1 class="col-sm-8"><?php echo $products_name; ?></h1>
    <h2 class="col-sm-4 text-right-not-xs"><?php echo $products_price; ?></h2>
  </div>
</div>

<?php
  if ($messageStack->size('review') > 0) {
    echo $messageStack->output('review');
  }
?>

<?php echo tep_draw_form('product_reviews_write', tep_href_link('product_reviews_write.php', 'action=process&products_id=' . $_GET['products_id']), 'post', 'class="form-horizontal" onsubmit="return checkForm();"', true); ?>

<div class="contentContainer">

<?php
  if (tep_not_null($product_info['products_image'])) {
  	$image = ''; 
		$image_overlay_sales = '';

		if ( tep_not_null(tep_get_products_special_price($product_info['products_id'])) ) {
			if ( DISPLAY_OVERLAY_IMAGES_SALES == 'true') {
				$image_overlay_sales = '<span id="wdw_overlay_sale_product_info" class="wdw_overlay_sale_product_info">' . tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'overlay-sale.png', IMAGE_SALE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'style="margin-left: 0px; margin-top: -79%"') . '</span>';
			}
		}
    
    if ($product_info['image_display'] == 1) {
      $image = tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT) . $image_overlay_sales;
    } elseif (($product_info['image_display'] != 2) && tep_not_null($product_info['products_image'])) {     	
     	$image = tep_image(DIR_WS_IMAGES_THUMBS . $product_info['image_folder'] . $product_info['products_image'], $product_info['products_name'], SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'itemprop="image"', NULL, 'img-responsive thumbnail group list-group-image') . $image_overlay_sales;
    }
?>

  <div class="pull-right text-center">
    <?php echo '<a href="' . tep_href_link('product_info.php', 'products_id=' . $product_info['products_id']) . '">' . $image . '</a>'; ?>

    <p><?php echo tep_draw_button(IMAGE_BUTTON_IN_CART, 'fa fa-shopping-cart', tep_href_link(basename($PHP_SELF), tep_get_all_get_params(array('action')) . 'action=buy_now')); ?></p>
  </div>

  <div class="clearfix"></div>

<?php
  }
?>

  <div class="contentText">
    <div class="row">
      <p class="col-sm-3 text-right-not-xs"><strong><?php echo SUB_TITLE_FROM; ?></strong></p>
      <p class="col-sm-9"><?php echo tep_output_string_protected($customer['customers_firstname'] . ' ' . $customer['customers_lastname']); ?></p>
    </div>
    <div class="form-group has-feedback">
      <label for="inputReview" class="control-label col-sm-3"><?php echo SUB_TITLE_REVIEW; ?></label>
      <div class="col-sm-9">
        <?php
        echo tep_draw_textarea_field('review', 'soft', 60, 15, NULL, 'required aria-required="true" id="inputReview" placeholder="' . SUB_TITLE_REVIEW_TEXT . '"');
        echo FORM_REQUIRED_INPUT;
        ?>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-3"><?php echo SUB_TITLE_RATING; ?></label>
      <div class="col-sm-9">
        <label class="radio-inline">
          <?php echo tep_draw_radio_field('rating', '1'); ?>
        </label>
        <label class="radio-inline">
          <?php echo tep_draw_radio_field('rating', '2'); ?>
        </label>
        <label class="radio-inline">
          <?php echo tep_draw_radio_field('rating', '3'); ?>
        </label>
        <label class="radio-inline">
          <?php echo tep_draw_radio_field('rating', '4'); ?>
        </label>
        <label class="radio-inline">
          <?php echo tep_draw_radio_field('rating', '5', 1); ?>
        </label>
        <?php echo '<div class="help-block justify" style="width: 150px;">' . TEXT_BAD . '<p class="pull-right">' . TEXT_GOOD . '</p></div>'; ?>
      </div>
    </div>

  </div>

  <div class="buttonSet row">
    <div class="col-xs-6"><?php echo tep_draw_button(IMAGE_BUTTON_BACK, 'fa fa-angle-left', tep_href_link('product_reviews.php', tep_get_all_get_params(array('reviews_id', 'action')))); ?></div>
    <div class="col-xs-6 text-right"><?php echo tep_draw_button(IMAGE_BUTTON_CONTINUE, 'fa fa-angle-right', null, 'primary', null, 'btn-success'); ?></div>
  </div>
</div>

</form>

<?php
  require('includes/template_bottom.php');
  require('includes/application_bottom.php');
?>
