<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  class bm_whats_new {
    var $code = 'bm_whats_new';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {
      $this->title = MODULE_BOXES_WHATS_NEW_TITLE;
      $this->description = MODULE_BOXES_WHATS_NEW_DESCRIPTION;

      if ( defined('MODULE_BOXES_WHATS_NEW_STATUS') ) {
        $this->sort_order = MODULE_BOXES_WHATS_NEW_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_WHATS_NEW_STATUS == 'True');
        
        $this->group = ((MODULE_BOXES_WHATS_NEW_CONTENT_PLACEMENT == 'Left Column') ? 'boxes_column_left' : 'boxes_column_right');
      }
    }

    function execute() {
      global $currencies, $oscTemplate;

      if ($random_product = tep_random_select("select products_id, products_image, image_folder, image_display, products_tax_class_id, products_price from " . TABLE_PRODUCTS . " where products_status = '1' order by products_date_added desc limit " . MAX_RANDOM_SELECT_NEW)) {
        $random_product['products_name'] = tep_get_products_name($random_product['products_id']);
        $random_product['specials_new_products_price'] = tep_get_products_special_price($random_product['products_id']);
        
				$wdw_vat = ( DISPLAY_TAX_INFO == 'true' ) ? ( DISPLAY_PRICE_WITH_TAX == 'true' ) ? '<br /><span class="wdw_vat_text">'. sprintf(TEXT_INCL_VAT, tep_get_tax_rate($random_product['products_tax_class_id']).'%') . '</span>' : '<br /><span class="wdw_vat_text">' . TEXT_EXCL_VAT . '</span>' : '';
   	$wdw_shipping = ( DISPLAY_SHIPPING_INFO == 'true' ) ?  '<br /><span class="wdw_shipping_text">' . TEXT_SHIPPING . '</span>' : '';
    
        if (tep_not_null($random_product['specials_new_products_price'])) {
        	if ( DISPLAY_DISCOUNT_INFO == 'true' ) {
    				//Formular --->>>> Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100
    				$OldPrice = $currencies->display_raw($random_product['products_price'], tep_get_tax_rate($random_product['products_tax_class_id']));
    				$NewPrice = $currencies->display_raw($random_product['specials_new_products_price'], tep_get_tax_rate($random_product['products_tax_class_id']));
    				$Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100;
    				$PercentRound = '<br />' . round($Percent, TAX_DECIMAL_PLACES) . '%';
    			}
          $whats_new_price .= '<span class="productSpecialPrice">' . $currencies->display_price($random_product['specials_new_products_price'], tep_get_tax_rate($random_product['products_tax_class_id'])) . $PercentRound . $wdw_vat . $wdw_shipping . '</span>';
        } else {
          $whats_new_price = $currencies->display_price($random_product['products_price'], tep_get_tax_rate($random_product['products_tax_class_id'])) . $wdw_vat . $wdw_shipping;
        }
                 
        ob_start();
        include('includes/modules/boxes/templates/whats_new.php');
        $data = ob_get_clean();

        $oscTemplate->addBlock($data, $this->group);
      }
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_WHATS_NEW_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable What\'s New Module', 'MODULE_BOXES_WHATS_NEW_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_WHATS_NEW_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_WHATS_NEW_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_WHATS_NEW_STATUS', 'MODULE_BOXES_WHATS_NEW_CONTENT_PLACEMENT', 'MODULE_BOXES_WHATS_NEW_SORT_ORDER');
    }
  }

