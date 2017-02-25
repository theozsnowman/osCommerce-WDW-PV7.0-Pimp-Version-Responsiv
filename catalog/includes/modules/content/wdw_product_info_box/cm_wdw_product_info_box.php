<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2014 osCommerce

  Released under the GNU General Public License
*/

  class cm_wdw_product_info_box {
    var $code;
    var $group;
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {
      $this->code = get_class($this);
      $this->group = basename(dirname(__FILE__));
      
      $this->api_version = 'WDW Product Info Box 1.0.0';
      
      $this->title = MODULE_CONTENT_WDW_PRODUCT_INFO_BOX_TITLE;
      $this->description = MODULE_CONTENT_WDW_PRODUCT_INFO_BOX_DESCRIPTION;

      if ( defined('MODULE_CONTENT_WDW_PRODUCT_INFO_BOX_STATUS') ) {
        $this->sort_order = MODULE_CONTENT_WDW_PRODUCT_INFO_BOX_SORT_ORDER;
        $this->enabled = (MODULE_CONTENT_WDW_PRODUCT_INFO_BOX_STATUS == 'True');
      }
    }

    function execute() {
      global $oscTemplate, $languages_id;
      
			$product_info_query = tep_db_query("select p.products_id, pd.products_name, pd.products_description, pd.products_seo_keywords, p.products_model, p.products_quantity, p.products_image, p.image_display, p.image_folder, pd.products_url, p.products_price, p.products_tax_class_id, p.products_date_added, p.products_date_available, p.products_weight, p.manufacturers_id, p.products_gtin from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = '" . (int)$_GET['products_id'] . "' and pd.products_id = p.products_id and pd.language_id = '" . (int)$languages_id . "'");
      $product_info = tep_db_fetch_array($product_info_query);

      ob_start();
      include('includes/modules/content/' . $this->group . '/templates/wdw_product_info_box.php');
      $template = ob_get_clean();

        $oscTemplate->addContent($template, $this->group);
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_CONTENT_WDW_PRODUCT_INFO_BOX_STATUS');
    }

    function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable WDW Product Box Module', 'MODULE_CONTENT_WDW_PRODUCT_INFO_BOX_STATUS', 'True', 'Should the WDW Product Box be shown on the product info page?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_WDW_PRODUCT_INFO_BOX_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
    }

    function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_CONTENT_WDW_PRODUCT_INFO_BOX_STATUS', 'MODULE_CONTENT_WDW_PRODUCT_INFO_BOX_SORT_ORDER');
    }
  }

