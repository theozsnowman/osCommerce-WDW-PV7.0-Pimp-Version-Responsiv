<?php
/*
  $Id$ Scroll Boxes v1.7bs

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
*/

  class bm_whats_new_scroller {
    var $version;
    var $code;
    var $group;
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {
      $this->version = '1.7';
      $this->code = get_class($this);
      $this->group = basename(dirname(__FILE__));

      $this->title = MODULE_BOXES_WHATS_NEW_SCROLLER_TITLE;
      $this->description = MODULE_BOXES_WHATS_NEW_SCROLLER_DESCRIPTION;

      if ( defined('MODULE_BOXES_WHATS_NEW_SCROLLER_STATUS') ) {
        $this->sort_order = MODULE_BOXES_WHATS_NEW_SCROLLER_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_WHATS_NEW_SCROLLER_STATUS == 'True');

        $this->group = ((MODULE_BOXES_WHATS_NEW_SCROLLER_CONTENT_PLACEMENT == 'Left Column') ? 'boxes_column_left' : 'boxes_column_right');
      }
    }

    function execute() {
      global $currencies, $oscTemplate;

      $np_query = $this->get_data();
      $np_count = tep_db_num_rows($np_query);

      if ($np_count > 0) {

        // set values for use in javascript below
        $scroller_height = (MODULE_BOXES_WHATS_NEW_SCROLLER_HEIGHT > 0 ? MODULE_BOXES_WHATS_NEW_SCROLLER_HEIGHT : 200); // height of scroller in px set in admin or use default
        $scroller_pause = (MODULE_BOXES_WHATS_NEW_SCROLLER_PAUSE > 0 ? MODULE_BOXES_WHATS_NEW_SCROLLER_PAUSE*1000 : 5000); // pause time of scroller (1000 - 1 sec, admin enters in secs ie 2 = 2secs then multiply by 1000 for carousel interval option) set in admin or use default
        $scrolling_on = (MODULE_BOXES_WHATS_NEW_SCROLLER_MODE == 'Scrolling' ? 1 : 0); // scrolling on or else averything is static
        $no_auto_scroll = (MODULE_BOXES_WHATS_NEW_SCROLLER_NO_AUTO_SCROLL == 'True' ? 1 : 0); // if scrolling is on, only scroll using swipe or nav buttons or else also auto scroll
        $no_swiping = (MODULE_BOXES_WHATS_NEW_SCROLLER_NO_SWIPING == 'True' ? 1 : 0); // if scrolling is on, only nav buttons and auto scroll will operate, not swiping
        $jquery_mobile_active = (defined('MODULE_HEADER_TAGS_JQUERY_MOBILE_STATUS') && MODULE_HEADER_TAGS_JQUERY_MOBILE_STATUS == 'True' ? 1 : 0); // is the jQuery Mobile Javascript header tag module is loaded and active, if not don't allow swiping to be enabled

        $i = 0;
        $np = '<div id="npCarousel" class="carousel slide ' . (MODULE_BOXES_WHATS_NEW_SCROLLER_METHOD == 'Fade' ? 'carousel-fade' : '') . '">';
        $np .= '<div class="carousel-inner">';
        while ($new_product = tep_db_fetch_array($np_query)) {
          
          $new_product['specials_new_products_price'] = tep_get_products_special_price($new_product['products_id']);

					$image = ''; 
					$image_overlay_sales = '';
    
    			$wdw_vat = ( DISPLAY_TAX_INFO == 'true' ) ? ( DISPLAY_PRICE_WITH_TAX == 'true' ) ? '<br /><span class="wdw_vat_text">'. sprintf(TEXT_INCL_VAT, tep_get_tax_rate($new_product['products_tax_class_id']).'%') . '</span>' : '<br /><span class="wdw_vat_text">' . TEXT_EXCL_VAT . '</span>' : '';
   				$wdw_shipping = ( DISPLAY_SHIPPING_INFO == 'true' ) ?  '<br /><span class="wdw_shipping_text">' . TEXT_SHIPPING . '</span>' : '';
           			
    			if (tep_not_null($new_product['specials_new_products_price'])) {
    				if ( DISPLAY_OVERLAY_IMAGES_SALES == 'true') {
							$image_overlay_sales = tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'overlay-sale.png', IMAGE_SALE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'style="margin-left: 0px; margin-top: -75%;"');
						}
    				if ( DISPLAY_DISCOUNT_INFO == 'true' ) {
    					//Formular --->>>> Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100
    					$OldPrice = $currencies->display_raw($new_product['products_price'], tep_get_tax_rate($new_product['products_tax_class_id']));
    					$NewPrice = $currencies->display_raw($new_product['specials_new_products_price'], tep_get_tax_rate($new_product['products_tax_class_id']));
    					$Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100;
    					$PercentRound = '<br />' . round($Percent, TAX_DECIMAL_PLACES) . '%';
    				}

    				$whats_new_price = '<del>' . $currencies->display_price($new_product['products_price'], tep_get_tax_rate($new_product['products_tax_class_id'])) . '</del><br />';
    				$whats_new_price .= '<span class="productSpecialPrice">' . $currencies->display_price($new_product['specials_new_products_price'], tep_get_tax_rate($new_product['products_tax_class_id'])) . '</span>' . $PercentRound . $wdw_vat . $wdw_shipping;
    			} else {
    				$whats_new_price = $currencies->display_price($new_product['products_price'], tep_get_tax_rate($new_product['products_tax_class_id'])). $wdw_vat . $wdw_shipping;
    			}

					if ($new_product['image_display'] == 1) {
    				$image = '<span class="thumbnail">' . tep_image('includes/languages/' . $_SESSION['language'] . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT) . '</span>' . $image_overlay_sales;
    			} elseif (($new_product['image_display'] != 2) && tep_not_null($new_product['products_image'])) {
    				$image = tep_image(DIR_WS_IMAGES_THUMBS . $new_product['image_folder'] . $new_product['products_image'], $new_product['products_name'], SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT) . $image_overlay_sales;
    			}

          $np .= '<div class="' . ($i == 0 ? 'active ' : '') . 'item">';
          $np .= '<div class="content_vAlign">';
          //$np .= '<div onclick="document.location.href=\'' . tep_href_link('product_info.php', 'products_id=' . $new_product['products_id']) . '\'; return false;" onmouseover="this.style.cursor=\'pointer\'">';
          $np .= (tep_not_null($new_product['products_image']) ? '<p class="text-center"><a href="' . tep_href_link('product_info.php', 'products_id=' . $new_product['products_id']) . '">' . $image . '</a></p>' : '');
          $np .= '<p class="text-center"><a href="' . tep_href_link('product_info.php', 'products_id=' . $new_product['products_id']) . '">' . $new_product['products_name'] . '</a></p>';
          $np .= (MODULE_BOXES_WHATS_NEW_SCROLLER_SHORT_DESCRIPTION > 0 && tep_not_null($new_product['products_description']) ? '<p class="text-center">' .  tep_break_string(substr(strip_tags($new_product['products_description']), 0, MODULE_BOXES_WHATS_NEW_SCROLLER_SHORT_DESCRIPTION), 15, '-<br />') . '...<br /></p>' : '');
          $np .= '<p class="text-center">' . $whats_new_price . '</p>';
          //$np .= '</div>';

          if (MODULE_BOXES_WHATS_NEW_SCROLLER_VIEW_BUTTON == 'True') {
          	$np .= '<p class="text-center"><a href="' . tep_href_link('product_info.php', 'products_id=' . $new_product['products_id']) . '" class="btn btn-success" role="button">' . SMALL_IMAGE_BUTTON_VIEW . '</a></p>';
          }

          $np .= '</div>';
          $np .= '</div>';
          
          $i++;
          
          if ( (MODULE_BOXES_WHATS_NEW_SCROLLER_MODE != 'Scrolling') ||
                 (MODULE_BOXES_WHATS_NEW_SCROLLER_NO_AUTO_SCROLL == 'True' && MODULE_BOXES_WHATS_NEW_SCROLLER_NO_SWIPING == 'True' &&
                  MODULE_BOXES_WHATS_NEW_SCROLLER_NAV_BUTTONS == 'False' && MODULE_BOXES_WHATS_NEW_SCROLLER_SWIPE_ARROWS == 'False') ) break;

        }
        $np .= '</div>';

        // Nav controls if enabled and more than 1 new product (also hidden if javascript disabled)
        if (MODULE_BOXES_WHATS_NEW_SCROLLER_MODE == 'Scrolling' && $np_count > 1) {
          if (MODULE_BOXES_WHATS_NEW_SCROLLER_NAV_BUTTONS == 'True') {
            $np .= '<div class="hidden-xs hidden-sm hidden-md text-center nav-buttons" style="height: 25px; padding-top: 3px;">';
            $np .= '<a class="btn-sm btn-primary" href="#npCarousel" data-slide="next"><i class="icon-white fa fa-angle-left"></i></a>';
            $np .= '<a class="btn-sm btn-primary" href="#npCarousel" data-slide="prev"><i class="icon-white fa fa-angle-right"></i></a>';
            $np .= '</div>';
          }
          if (MODULE_BOXES_WHATS_NEW_SCROLLER_SWIPE_ARROWS == 'True') {
            $np .= '<div class="hidden-lg swipe-arrows" style="width: 100%;">';
            $np .= '<a href="#npCarousel" data-slide="next"><i class="fa fa-angle-left pull-left" style="opacity: 0.3; font-size: 24px;" onmousedown="this.style.opacity=\'0.9\'" onmouseup="this.style.opacity=\'0.3\'"></i></a>';
            $np .= '<a href="#npCarousel" data-slide="prev"><i class="fa fa-angle-right pull-right" style="opacity: 0.3; font-size: 24px;" onmousedown="this.style.opacity=\'0.9\'" onmouseup="this.style.opacity=\'0.3\'"></i></a>';
            $np .= '</div>';
          }
        }

        $np .= '</div>';

        $np .= '<noscript><style> #npCarousel .content_vAlign { top: 0; -webkit-transform: translateY(0); -ms-transform: translateY(0); transform: translateY(0); } #npCarousel div.nav-buttons, #npCarousel div.swipe-arrows { display: none; } </style></noscript>';

        $np .= <<<EOD
<script>

function set_npHeights(resize) {
  var resize = resize || false;
  var scroller = "#npCarousel"; // the scrolling container
  var scroller_height = $scroller_height; // height of scroller set in admin or use default
  var maxHeight = 0;

  if (resize) {
    $(scroller+" div.item").height('auto'); // needed this for window resize
  }
  // get the biggest item height
  $(scroller+" div.item").each(function() {
    if ($(this).height() > maxHeight) {
      maxHeight = $(this).height();
    }
  });

  // if the biggest item height is greater than the admin setting height then set the new height of scroller to accomadate the biggest item
  if (maxHeight > scroller_height){
    scroller_height = maxHeight;
  }

  // set all items height the same, using either the biggest item height or the admin setting height, which ever is the greater
  $(scroller+" div.item").height(scroller_height+10);
  // set the "small device" swipe indicators near the bottom of scroll box
  if ($(scroller+" div.swipe-arrows").is(":visible")) {
    $(scroller+" div.swipe-arrows").css({"position": "absolute", "top": scroller_height-5+"px"});
  }
}

$(document).ready(function() {
  var scrolling_on = $scrolling_on; // scrolling on or else averything is static
  var no_swiping = $no_swiping; // if scrolling is on, only nav buttons and auto scroll will operate, not swiping
  var jquery_mobile_active = $jquery_mobile_active; // if the jQuery Mobile Javascript header tag module is loaded and active then allow swiping to be enabled

  if (scrolling_on) {
    var scroller_pause = $scroller_pause; // pause time of scroller set in admin or use default
    $("#npCarousel.carousel").carousel({
      interval: scroller_pause
    });
    var no_auto_scroll = $no_auto_scroll; // if scrolling is on, only scroll using swipe or nav buttons or else also auto scroll
    if (no_auto_scroll) {
      $("#npCarousel.carousel").carousel('pause');
    }
  }

  if (jquery_mobile_active) {
    if (!no_swiping) {
      $("#npCarousel").swiperight(function() {
        $(this).carousel('prev');
      });
      $("#npCarousel").swipeleft(function() {
        $(this).carousel('next');
      });
    }
  }

});

$(document).ready(function() {
  set_npHeights();
});

$(window).resize(function() { // corrects each item size when resizing window otherwise items will be too small or too large inside box
  set_npHeights(true);
});

</script>
EOD;

        ob_start();
        include('includes/modules/boxes/templates/whats_new_scroller.php');
        $data = ob_get_clean();

        $oscTemplate->addBlock($data, $this->group);
      }
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_WHATS_NEW_SCROLLER_STATUS');
    }

    function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Module Version', 'MODULE_BOXES_WHATS_NEW_SCROLLER_VERSION', '" . $this->version . "', 'The version of this module that you are running', '6', '0', 'tep_cfg_wns_version_check', 'tep_cfg_disabled(', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable What\'s New Scrolling Module', 'MODULE_BOXES_WHATS_NEW_SCROLLER_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Target New Products to Category', 'MODULE_BOXES_WHATS_NEW_SCROLLER_TARGET_TO_CAT', 'False', 'Do you want to target new products within the current category only (when browsing categories)? Default behaviour is new products are shown store wide.', '6', '2', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_WHATS_NEW_SCROLLER_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '3', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display Mode (Static or Scrolling)', 'MODULE_BOXES_WHATS_NEW_SCROLLER_MODE', 'Scrolling', 'Set the display mode. Scrolling items or static (i.e. one random new product per page load). In static mode, all scroll/swipe functions are disabled', '6', '4', 'tep_cfg_select_option(array(\'Static\', \'Scrolling\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Scrolling Method', 'MODULE_BOXES_WHATS_NEW_SCROLLER_METHOD', 'Scroll', 'When Display Mode is Scrolling, select whether to scroll or fade items in the Scroll Box', '6', '5', 'tep_cfg_select_option(array(\'Scroll\', \'Fade\'), ',now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Disable Auto Scroll', 'MODULE_BOXES_WHATS_NEW_SCROLLER_NO_AUTO_SCROLL', 'False', 'When Display Mode is Scrolling, set whether to disable auto scrolling/fading and allow swipe and navigation indicators only', '6', '6', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Disable Swiping', 'MODULE_BOXES_WHATS_NEW_SCROLLER_NO_SWIPING', 'False', 'When Display Mode is Scrolling, set whether to disable swiping. Navigation indicators will still operate', '6', '7', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Scroller Height', 'MODULE_BOXES_WHATS_NEW_SCROLLER_HEIGHT', '200', 'Set the Scroll Box Height, default: 200px (When Scrolling is activated, if height is set too small it will automatically be adjusted to fit the largest scrolling item)', '6', '8', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Scrolling Pause Time', 'MODULE_BOXES_WHATS_NEW_SCROLLER_PAUSE', '5', 'When Display Mode is Scrolling, set how long each item pauses inside the Scroll Box (in secs), default: 5 secs', '6', '9', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Description Length', 'MODULE_BOXES_WHATS_NEW_SCROLLER_SHORT_DESCRIPTION', '20', 'Display part of products description (i.e. set the number of characters to show), default: 20 (0 = No description)', '6', '10', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display View Button', 'MODULE_BOXES_WHATS_NEW_SCROLLER_VIEW_BUTTON', 'True', 'Display the View details buttons', '6', '11', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display Navigation Buttons', 'MODULE_BOXES_WHATS_NEW_SCROLLER_NAV_BUTTONS', 'True', 'When Display Mode is Scrolling, set whether to show the navigation buttons (for destkops etc.)', '6', '12', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display Swipe Indicators', 'MODULE_BOXES_WHATS_NEW_SCROLLER_SWIPE_ARROWS', 'True', 'When Display Mode is Scrolling, set whether to show the swipe indicators (for smaller devices)', '6', '13', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_WHATS_NEW_SCROLLER_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '14', now())");
    }

    function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_WHATS_NEW_SCROLLER_VERSION', 'MODULE_BOXES_WHATS_NEW_SCROLLER_STATUS', 'MODULE_BOXES_WHATS_NEW_SCROLLER_TARGET_TO_CAT', 'MODULE_BOXES_WHATS_NEW_SCROLLER_CONTENT_PLACEMENT', 'MODULE_BOXES_WHATS_NEW_SCROLLER_MODE', 'MODULE_BOXES_WHATS_NEW_SCROLLER_METHOD', 'MODULE_BOXES_WHATS_NEW_SCROLLER_NO_AUTO_SCROLL', 'MODULE_BOXES_WHATS_NEW_SCROLLER_NO_SWIPING', 'MODULE_BOXES_WHATS_NEW_SCROLLER_HEIGHT', 'MODULE_BOXES_WHATS_NEW_SCROLLER_PAUSE', 'MODULE_BOXES_WHATS_NEW_SCROLLER_SHORT_DESCRIPTION', 'MODULE_BOXES_WHATS_NEW_SCROLLER_VIEW_BUTTON', 'MODULE_BOXES_WHATS_NEW_SCROLLER_NAV_BUTTONS', 'MODULE_BOXES_WHATS_NEW_SCROLLER_SWIPE_ARROWS', 'MODULE_BOXES_WHATS_NEW_SCROLLER_SORT_ORDER');
    }

    function get_data() {
      global $languages_id, $current_category_id, $category_depth, $cPath;

      // MAX_RANDOM_SELECT_NEW is set in "admin->configuration->maximum values->Selection of Random New Products"

      // grab the number of MAX_RANDOM_SELECT_NEW in random order
      if ( !isset($current_category_id) || $current_category_id == '0' || MODULE_BOXES_WHATS_NEW_SCROLLER_TARGET_TO_CAT == 'False' ) {
        $np_query = tep_db_query("
          select
            p.products_id,
            pd.products_name,
            pd.products_description,
            p.products_price,
            p.products_tax_class_id,
            p.products_image,
            p.image_folder, 
            p.image_display
          from
            products p,
            products_description pd
          where
            p.products_status = '1'
            and p.products_id = pd.products_id
            and pd.language_id = '" . (int) $languages_id . "'
          order by
            rand()
          limit " . MAX_RANDOM_SELECT_NEW
        );
      } else {
        if ( $category_depth == 'products' ) {
          $np_query = tep_db_query("
            select
              p.products_id,
              pd.products_name,
              pd.products_description,
              p.products_price,
              p.products_tax_class_id,
              p.products_image
            from
              products p
              left join products_description pd
                on (p.products_id = pd.products_id)
              join products_to_categories p2c
                on (p.products_id = p2c.products_id)
              join categories c
                on (p2c.categories_id = c.categories_id)
            where
              c.categories_id = '" . (int)$current_category_id . "'
              and p.products_status = '1'
              and pd.language_id = '" . (int)$languages_id . "'
            order by
              rand()
            limit " . MAX_RANDOM_SELECT_NEW
          );
        } else { // $category_depth == 'nested'
        
          // this code checks to see if the Index -> "Nested Product Listing" module is installed that combines products from within current nested category and all sub-categories
          $nested_listing = false;
          if ( defined('MODULE_CONTENT_IN_PRODUCT_LISTING_STATUS') && MODULE_CONTENT_IN_PRODUCT_LISTING_STATUS == 'True' ) {
            $cPath_bits = explode("_", $cPath);
            $bits_size = sizeof($cPath_bits)-1;
            $subcategories_array = array();
            tep_get_subcategories($subcategories_array, $cPath_bits[$bits_size]);
            $sc_size = sizeof($subcategories_array);
            $cat_search = "(";
            for($i = 0; $i < $sc_size; $i++){
              $cat_search .= "p2c.categories_id = '" . $subcategories_array[$i] . "' or ";
            }
            $cat_search .= "p2c.categories_id = '" . $cPath_bits[$bits_size] . "'" . ")";
            $nested_listing = true;
          }

          $np_query = tep_db_query("
            select
              p.products_id,
              pd.products_name,
              pd.products_description,
              p.products_price,
              p.products_tax_class_id,
              p.products_image
            from
              products p
              left join products_description pd
                on (p.products_id = pd.products_id)
              join products_to_categories p2c
                on (p.products_id = p2c.products_id)
              join categories c
                on (p2c.categories_id = c.categories_id)
            where
              " . ($nested_listing ? "" . $cat_search . "" : "c.parent_id = '" . (int)$current_category_id . "'") . "
              and p.products_status = '1'
              and pd.language_id = '" . (int)$languages_id . "'
            order by
              rand()
            limit " . MAX_RANDOM_SELECT_NEW
          );
        }
      }

      return $np_query;
    }
  }

  // Checks/updates the module version number when only needing to over-write this file
  if (!function_exists('tep_cfg_wns_version_check')) {
    function tep_cfg_wns_version_check($current_version) {

      // When updating the module by overwriting this file with a new version of the file, this updates the version configuration entry without having to remove and reinstall the module.
      // When viewing this module in admin (after overwriting this file) you will have to refresh the page to see the new version number.
      $bm_whats_new_scroller = new bm_whats_new_scroller;
      if ($current_version != $bm_whats_new_scroller->version) {
        tep_db_query("update configuration set configuration_value = '" . $bm_whats_new_scroller->version . "' where configuration_key = 'MODULE_BOXES_WHATS_NEW_SCROLLER_VERSION'");
      }
      return $current_version;

    }
  }

  // function to display a disabled field
  if(!function_exists('tep_cfg_disabled')) {
    function tep_cfg_disabled($value) {
      return tep_draw_input_field('configuration_value', $value, 'disabled');
    }
  }
