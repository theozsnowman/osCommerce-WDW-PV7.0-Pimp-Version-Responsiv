<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2014 osCommerce

  Released under the GNU General Public License
*/

  class cm_wdw_easytabs {
    var $code;
    var $group;
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {
      $this->code = get_class($this);
      $this->group = basename(dirname(__FILE__));
      
      $this->api_version = 'WDW EasyTabs 1.0.0';
      
      $this->title = MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_TITLE;
      $this->description = MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_DESCRIPTION;
      $this->description .= '<div class="secWarning">' . MODULE_CONTENT_BOOTSTRAP_ROW_DESCRIPTION . '</div>';

      if ( defined('MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_STATUS') ) {
        $this->sort_order = MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_SORT_ORDER;
        $this->enabled = (MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_STATUS == 'True');
      }
    }

    function execute() {
      global $oscTemplate, $languages_id;
      
      $content_width = (int)MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_CONTENT_WIDTH;

			$product_info_query = tep_db_query("select p.products_id, pd.products_name, pd.products_description, pd.products_seo_keywords, p.products_model, p.products_quantity, p.products_image, p.image_display, p.image_folder, pd.products_url, p.products_price, p.products_tax_class_id, p.products_date_added, p.products_date_available, p.products_weight, p.manufacturers_id, p.products_gtin from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = '" . (int)$_GET['products_id'] . "' and pd.products_id = p.products_id and pd.language_id = '" . (int)$languages_id . "'");
      $product_info = tep_db_fetch_array($product_info_query);

      if ( !empty($product_info['products_gtin']) ) {
				switch (MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_BARCODES_STYLE) {
        	case 'ean8':
        	$wdw_character_value = -8;
        	// Including the barcode technology
					require_once('ext/barcodes/GTIN/class/BCGean8.barcode.php');
        	$code = new BCGean8();
        	break;
        	case 'ean13':
        	$wdw_character_value = -12;
        	// Including the barcode technology
					require_once('ext/barcodes/GTIN/class/BCGean13.barcode.php');
        	$code = new BCGean13();
        	break;
        	case 'isbn':
        	$wdw_character_value = -10;
        	// Including the barcode technology
					require_once('ext/barcodes/GTIN/class/BCGisbn.barcode.php');
        	$code = new BCGisbn();
        	break;
        	case 'upca':
        	$wdw_character_value = -11;
        	// Including the barcode technology
					require_once('ext/barcodes/GTIN/class/BCGupca.barcode.php');
        	$code = new BCGupca();
        	break;
				}
    		
     		// Including all required classes
				require_once('ext/barcodes/GTIN/class/BCGFontFile.php');
				require_once('ext/barcodes/GTIN/class/BCGColor.php');
				require_once('ext/barcodes/GTIN/class/BCGDrawing.php');

				// Loading Font
				$font = new BCGFontFile('ext/barcodes/GTIN/font/Arial.ttf', 18);
				// Don't forget to sanitize user inputs
				$text = isset($_GET['text']) ? $_GET['text'] : substr($product_info['products_gtin'], $wdw_character_value);

				// The arguments are R, G, B for color.
				$color_black = new BCGColor(0, 0, 0);
				$color_white = new BCGColor(255, 255, 255);

				$drawException = null;
			
				try {
   				$code->setScale(3); // Resolution
   				$code->setThickness(30); // Thickness
   				$code->setForegroundColor($color_black); // Color of bars
   				$code->setBackgroundColor($color_white); // Color of spaces
   				$code->setFont($font); // Font (or 0)
   				$code->parse($text); // Text
				} catch(Exception $exception) {
					$drawException = $exception;
				}

				// Here is the list of the arguments
				// 1 - Filename (empty : display on screen)
				// 2 - Background color
				$drawing = new BCGDrawing('images/barcodes/' . substr($product_info['products_gtin'], $wdw_character_value) . '.png', $color_white);
				if($drawException) {
					$drawing->drawException($drawException);
				} else {
   				$drawing->setBarcode($code);
   				$drawing->draw();
				}

				// Header that says it is an image (remove it if you save the barcode to a file)
				// header('Content-Type: image/png');
				// header('Content-Disposition: inline; filename="barcode.png"');
		
				// Draw (or save) the image into PNG format.
				$drawing->finish(BCGDrawing::IMG_FORMAT_PNG);
			}

			if ($product_info['manufacturers_id'] > 0) {
      	$manufacturer_query = tep_db_query("select manufacturers_name from " . TABLE_MANUFACTURERS . " where manufacturers_id = '" . (int)$product_info['manufacturers_id'] . "'");
      	if (tep_db_num_rows($manufacturer_query)) {
        	$manufacturer = tep_db_fetch_array($manufacturer_query);
        	$wdw_manufacturer = MODULE_HEADER_TAGS_WDW_EASYTABS_PRODUCT_MANUFACTURER . ': <span itemprop="manufacturer" itemscope itemtype="http://schema.org/Organization"><meta itemprop="name" content="' . tep_output_string($manufacturer['manufacturers_name']) . '" />' . '<a href="' . tep_href_link('index.php', 'manufacturers_id=' . (int)$product_info['manufacturers_id']) . '">' . $manufacturer['manufacturers_name'] . '</a></span>';
        	$wdw_manufacturer_name = '<a href="' . tep_href_link('index.php', 'manufacturers_id=' . (int)$product_info['manufacturers_id']) . '">' . $manufacturer['manufacturers_name'] . '</a>';
      	}
    	}
			
      $review_query = tep_db_query("select SUBSTRING_INDEX(rd.reviews_text, ' ', 20) as reviews_text, r.reviews_rating, r.reviews_id, r.customers_name, r.date_added, r.reviews_read, p.products_id, p.products_price, p.products_tax_class_id, p.products_image, p.products_model, pd.products_name from reviews r, reviews_description rd, products p, products_description pd where r.products_id = '" . (int)$_GET['products_id'] . "' and r.reviews_id = rd.reviews_id and rd.languages_id = '" . (int)$languages_id . "' and r.products_id = p.products_id and p.products_status = '1' and r.reviews_status = '1' and p.products_id = pd.products_id and pd.language_id = '". (int)$languages_id . "' order by r.reviews_rating DESC limit " . (int)MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_CONTENT_LIMIT);
      $review_data = NULL;
			
      if (tep_db_num_rows($review_query) > 0) {
      	$reviews_count_query = tep_db_query("select count(*) as count, avg(reviews_rating) as avgrating from " . TABLE_REVIEWS . " r, " . TABLE_REVIEWS_DESCRIPTION . " rd where r.products_id = '" . (int)$_GET['products_id'] . "' and r.reviews_id = rd.reviews_id and rd.languages_id = '" . (int)$languages_id . "' and reviews_status = 1");
    		$reviews_count = tep_db_fetch_array($reviews_count_query);
      	
      	while ($review = tep_db_fetch_array($review_query)) {
          //$review_data .=  '<blockquote class="col-sm-6">';
          $review_data .= '<h4 class="page-header">' . REVIEWS_TEXT_TITLE . '</h4>';
          $review_data .=   '  <p>' . tep_output_string_protected($review['reviews_text']) . ' ... </p>';
          //$review_name = tep_output_string_protected($review['customers_name']);
          $review_data .=   '  <footer>' . sprintf(MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_TEXT_RATED, tep_draw_stars($review['reviews_rating']), $review_name, $review_name) . '</footer>';
          $review_data .= '<span itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating"><meta itemprop="ratingValue" content="' . $reviews['avgrating'] . '" /><meta itemprop="ratingCount" content="' . $reviews['count'] . '" /></span>';
          //$review_data .=   '</blockquote>';
        }
      }
      $review_data .= '<br /><div class="buttonSet row"><div class="col-xs-6">' . tep_draw_button(IMAGE_BUTTON_REVIEWS . (($reviews_count['count'] > 0) ? ' (' . $reviews_count['count'] . ')' : ''), 'fa fa-commenting', tep_href_link('product_reviews.php', tep_get_all_get_params())) . '</div></div>';
      
      ob_start();
      include('includes/modules/content/' . $this->group . '/templates/wdw_easytabs.php');
      $template = ob_get_clean();

        $oscTemplate->addContent($template, $this->group);
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_STATUS');
    }

    function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable WDW easytabs Module', 'MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_STATUS', 'True', 'Should the WDW easytabs block be shown on the product info page?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Barcodes Style', 'MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_BARCODES_STYLE', 'ean13', 'What barcode should be shown in?', '6', '1', 'tep_cfg_select_option(array(\'ean8\', \'ean13\', \'isbn\', \'upca\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Number of Reviews', 'MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_CONTENT_LIMIT', '4', 'How many reviews (inside the tab) should be shown?', '6', '1', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
    }

    function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_STATUS', 'MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_BARCODES_STYLE', 'MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_CONTENT_WIDTH', 'MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_CONTENT_LIMIT', 'MODULE_CONTENT_WDW_PRODUCT_INFO_EASYTABS_SORT_ORDER');
    }
  }

