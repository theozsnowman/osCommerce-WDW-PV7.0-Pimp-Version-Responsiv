<?php
/*
  $Id: cm_category_new_products_carousel.php, v1.4 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
*/

  class cm_category_new_products_carousel {
    var $code;
    var $group;
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {
      global $current_category_id, $category_depth;

      $this->code = get_class($this);
      $this->group = basename(dirname(__FILE__));

      $this->api_version = 'Category New Products Carousel (stand alone version) v1.4';

      $this->title = MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_TITLE;
      $this->description = MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_DESCRIPTION;

      if ( defined('MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_STATUS') ) {
        $this->sort_order = MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SORT_ORDER;
        $this->enabled = (MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_STATUS == 'True');
      }
      
      if ( $this->enabled ) {
        if ( isset($_GET['manufacturers_id']) ) {
          $this->enabled = false;
        } else if ( (!isset($current_category_id) || $current_category_id == '0') && MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_FRONT_PAGE == 'False' ) {
          $this->enabled = false;
        } else if ( $category_depth == 'products' && MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PROD_PAGE == 'False' ) {
          $this->enabled = false;
        } else if ( $category_depth == 'nested' && MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CAT_PAGE == 'False' ) {
          $this->enabled = false;
        }
      }
    }

    function execute() {
      global $oscTemplate, $currencies, $PHP_SELF, $current_category_id, $category_depth, $currency;

      $show_description = ( MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SHOW_DESCRIPTION == 'True' && MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_DESCRIPTION_LENGTH > 0 );
      $show_old_price = ( MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SHOW_OLD_PRICE == 'True' );
      $new_products_query = $this->get_data($show_description);
      $num_new_products = tep_db_num_rows($new_products_query);
      if( $num_new_products > 0 ) {

        ob_start();
        include('includes/modules/content/' . $this->group . '/templates/new_products_carousel.php');
        $template = ob_get_clean();

        $oscTemplate->addContent($template, $this->group);
      }
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_STATUS');
    }

    function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable New Products Carousel Module', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_STATUS', 'True', 'Should the new products carousel be shown on the category pages? (Requires jQuery Owl Carousel v1.3.3 Javascript loaded.)', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Show on the Front Page', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_FRONT_PAGE', 'True', 'Should the new products carousel be shown on the front page?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Show on Top Level Category Pages', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CAT_PAGE', 'True', 'Should the new products carousel be shown on the top level category pages?', '6', '2', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Show on Sub-Category Product Pages', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PROD_PAGE', 'True', 'Should the new products carousel be shown on the sub-category product pages?', '6', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Allow Close', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CLOSE', 'False', 'Allow the panel box to be closed/hidden by displaying an X in the corner (except the front page).', '6', '4', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Max Products', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_MAX_DISPLAY_NEW_PRODUCTS', '20', 'Maximum number of new products to show in the new products carousel. (When inside a category, only new products for that category are shown)', '6', '5', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Show Old Price', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SHOW_OLD_PRICE', 'False', 'When there is a special, do you want to show the old product price with the new special price in the new products carousel? Default: False (only show special price).', '6', '6', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Show Product Description', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SHOW_DESCRIPTION', 'False', 'Do you want to show the product description in the new products carousel?', '6', '7', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Maximum Word Length', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_WORD_LENGTH', '40', 'When show product description is set to true, set the maximum number of characters in a single word (Needed to prevent breaking box width). Default: 40.', '6', '8', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Maximum Description Length', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_DESCRIPTION_LENGTH', '100', 'When show product description is set to true, set the number of characters (to the nearest word) of the description to display in the new products carousel. Default: 100.', '6', '9', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Auto Play', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_AUTOPLAY', 'True', 'Should the carousel play (slide) automatically?', '6', '10', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Auto Play Speed', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_AUTOPLAY_SPEED', '5000', 'When auto play is set to true, set the time delay between slides, in millisecs (ms). Lower number is faster, higher is slower. Default: 5000.', '6', '11', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Navigation Slide Speed', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_NAV_SLIDE_SPEED', '700', 'Slide speed when using navigation buttons, in millisecs (ms). Lower number is faster, higher is slower. Default: 700.', '6', '12', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Page Slide Speed', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PAGE_SLIDE_SPEED', '800', 'Page slide speed during auto play, in millisecs (ms). Lower number is faster, higher is slower. Default: 800.', '6', '13', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SORT_ORDER', '50', 'Sort order of display. Lowest is displayed first.', '6', '14', now())");
    }

    function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      $keys = array();
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_STATUS';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_FRONT_PAGE';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CAT_PAGE';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PROD_PAGE';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CLOSE';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_MAX_DISPLAY_NEW_PRODUCTS';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SHOW_OLD_PRICE';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SHOW_DESCRIPTION';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_WORD_LENGTH';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_DESCRIPTION_LENGTH';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_AUTOPLAY';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_AUTOPLAY_SPEED';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_NAV_SLIDE_SPEED';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PAGE_SLIDE_SPEED';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SORT_ORDER';
      return $keys;
    }
    
    function get_data($show_description) {
      global $languages_id, $current_category_id, $category_depth, $cPath;
    
      if ( (!isset($current_category_id)) || ($current_category_id == '0') ) {
        $new_products_query = tep_db_query("
          select
            p.products_id,
            p.products_image,
            p.image_folder, 
            p.image_display,
            p.products_price,
            p.products_tax_class_id,
            pd.products_name,
            " . ($show_description ? "pd.products_description," : "") . "
            IF(s.status, s.specials_new_products_price, NULL) as specials_new_products_price
          from
            products p
            join products_description pd
              on (p.products_id = pd.products_id)
            left join specials s
              on (p.products_id = s.products_id)
          where
            p.products_status = '1'
            and pd.language_id = '" . (int)$languages_id . "'
          order by
            p.products_date_added desc
          limit " . MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_MAX_DISPLAY_NEW_PRODUCTS
        );
      } else {
        if ( $category_depth == 'products' ) {
          $new_products_query = tep_db_query("
            select
              p.products_id,
              p.products_image,
              p.image_folder, 
              p.image_display,
              p.products_price,
              p.products_tax_class_id,
              pd.products_name,
              " . ($show_description ? "pd.products_description," : "") . "
              IF(s.status, s.specials_new_products_price, NULL) as specials_new_products_price
            from
              products p
              left join specials s
                on (p.products_id = s.products_id)
              join products_description pd
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
              p.products_date_added desc
            limit " . MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_MAX_DISPLAY_NEW_PRODUCTS
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

          $new_products_query = tep_db_query("
            select
              p.products_id,
              p.products_image,
              p.image_folder, 
              p.image_display,
              p.products_price,
              p.products_tax_class_id,
              pd.products_name,
              " . ($show_description ? "pd.products_description," : "") . "
              IF(s.status, s.specials_new_products_price, NULL) as specials_new_products_price
            from
              products p
              left join specials s
                on (p.products_id = s.products_id)
              join products_description pd
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
              p.products_date_added desc
            limit " . MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_MAX_DISPLAY_NEW_PRODUCTS
          );
        }
      }

      return $new_products_query;
    }
    
  } // end class

  // Limit the size of text blocks to the nearest full word
  //    $text is string to be truncated,
  //    $maxchar is number of characters to limit to,
  //    $wordlength is maximum length of a single word, to avoid long words breaking linewrap
  function tep_category_new_products_carousel_limit_text( $text, $maxchar, $wordlength = 40 ) {

    // ----- remove HTML TAGs -----
    $text = preg_replace('/<[^>]*>/', ' ', $text);

    $text = str_replace("\n", ' ', $text);
    $text = str_replace("\r", ' ', $text);
    $text = str_replace("\t", ' ', $text);

    $text = wordwrap($text, $wordlength, ' ', true);

    // ----- remove multiple spaces -----
    $text = trim(preg_replace('/ {2,}/', ' ', $text));

    $text_length = strlen($text);
    $text_array = explode(" ", $text);

    $newtext = '';
    for ($array_key = 0, $length = 0; $length <= $text_length; $array_key++) {
      $length = strlen($newtext) + strlen($text_array[$array_key]) + 1;
      if ($length > $maxchar) break;
      $newtext = $newtext . ' ' . $text_array[$array_key];
    }

    return $newtext;
  }

