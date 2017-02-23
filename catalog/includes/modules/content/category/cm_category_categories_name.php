<?php
/*
  $Id: cm_category_categories_name.php, v1.1 19th Sept. 2016 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
*/

  class cm_category_categories_name {
    public $code;
    public $group;
    public $title;
    public $description;
    public $sort_order;
    public $enabled = false;

    function __construct() {
      global $category_depth;

      $this->version = '1.1';
      $this->code = get_class($this);
      $this->group = basename(dirname(__FILE__));

      $this->title = MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_TITLE;
      $this->description = MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_DESCRIPTION;
      $this->description .= '<div class="secWarning">' . MODULE_CONTENT_BOOTSTRAP_ROW_DESCRIPTION . '</div>';

      if ( defined('MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_STATUS') ) {
        $this->sort_order = MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_SORT_ORDER;
        $this->enabled = (MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_STATUS == 'True');
      }

      if ( $this->enabled && $category_depth != 'nested' ) {
        $this->enabled = false;
      }
    }

    public function execute() {
      global $oscTemplate, $category;

      if (tep_not_null($category['categories_name'])) {

        ob_start();
        include('includes/modules/content/' . $this->group . '/templates/categories_name.php');
        $template = ob_get_clean();

        $oscTemplate->addContent($template, $this->group);
      }
    }

    public function isEnabled() {
      return $this->enabled;
    }

    public function check() {
      return defined('MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_STATUS');
    }

    public function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Module Version', 'MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_VERSION', '" . $this->version . "', 'The version of this module that you are running.', '6', '0', 'tep_cfg_disabled(', now() ) ");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Category Name Module', 'MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_STATUS', 'True', 'Should the category name be shown in the category?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', '6', '2', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '3', now())");
    }

    public function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    public function keys() {
      $keys = array();
      $keys[] = 'MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_VERSION';
      $keys[] = 'MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_STATUS';
      $keys[] = 'MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_CONTENT_WIDTH';
      $keys[] = 'MODULE_CONTENT_CATEGORY_CATEGORIES_NAME_SORT_ORDER';
      return $keys;
    }
  } // end class

  // independent function to show a disabled entry in admin i.e. for version number
  if( !function_exists( 'tep_cfg_disabled' ) ) {
    function tep_cfg_disabled( $value ) {
      return tep_draw_input_field( 'configuration_value', $value, ' disabled' );
    }
  }
