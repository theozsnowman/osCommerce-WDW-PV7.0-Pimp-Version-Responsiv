<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  class bm_manufacturer_info {
    var $code = 'bm_manufacturer_info';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {
      $this->title = MODULE_BOXES_MANUFACTURER_INFO_TITLE;
      $this->description = MODULE_BOXES_MANUFACTURER_INFO_DESCRIPTION;

      if ( defined('MODULE_BOXES_MANUFACTURER_INFO_STATUS') ) {
        $this->sort_order = MODULE_BOXES_MANUFACTURER_INFO_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_MANUFACTURER_INFO_STATUS == 'True');
        
        $this->group = ((MODULE_BOXES_MANUFACTURER_INFO_CONTENT_PLACEMENT == 'Left Column') ? 'boxes_column_left' : 'boxes_column_right');
      }
    }

    function execute() {
      global $languages_id, $oscTemplate;

      if (isset($_GET['products_id'])) {
        $manufacturer_query = tep_db_query("select m.manufacturers_id, m.manufacturers_name, m.manufacturers_image, mi.manufacturers_url from " . TABLE_MANUFACTURERS . " m left join " . TABLE_MANUFACTURERS_INFO . " mi on (m.manufacturers_id = mi.manufacturers_id and mi.languages_id = '" . (int)$languages_id . "'), " . TABLE_PRODUCTS . " p  where p.products_id = '" . (int)$_GET['products_id'] . "' and p.manufacturers_id = m.manufacturers_id");
        if (tep_db_num_rows($manufacturer_query)) {
          $manufacturer = tep_db_fetch_array($manufacturer_query);

          $manufacturer_info_string = NULL;
          
          $image = '';
    			if (tep_not_null($manufacturer['manufacturers_image'])) {
    				$image = tep_image(DIR_WS_IMAGES_MFG . $manufacturer['manufacturers_image'], $manufacturer['manufacturers_name']);
    			} else {
    				$image = tep_image('includes/languages/' . $language . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT);
    			}
    			
          if (tep_not_null($manufacturer['manufacturers_image'])) $manufacturer_info_string .= '<div>' . $image . '</div>';
          if (tep_not_null($manufacturer['manufacturers_url'])) $manufacturer_info_string .= '<div class="text-center"><a href="' . tep_href_link('redirect.php', 'action=manufacturer&manufacturers_id=' . $manufacturer['manufacturers_id']) . '" target="_blank">' . sprintf(MODULE_BOXES_MANUFACTURER_INFO_BOX_HOMEPAGE, $manufacturer['manufacturers_name']) . '</a></div>';

          ob_start();
          include('includes/modules/boxes/templates/manufacturer_info.php');
          $data = ob_get_clean();
          
          $oscTemplate->addBlock($data, $this->group);
        }
      }
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_MANUFACTURER_INFO_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Manufacturer Info Module', 'MODULE_BOXES_MANUFACTURER_INFO_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_MANUFACTURER_INFO_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_MANUFACTURER_INFO_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_MANUFACTURER_INFO_STATUS', 'MODULE_BOXES_MANUFACTURER_INFO_CONTENT_PLACEMENT', 'MODULE_BOXES_MANUFACTURER_INFO_SORT_ORDER');
    }
  }
?>
