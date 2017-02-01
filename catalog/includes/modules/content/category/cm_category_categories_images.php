<?php
/*
  $Id: cm_category_categories_images.php, v1.1 19th Sept. 2016 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
*/

  class cm_category_categories_images {
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

      $this->title = MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_TITLE;
      $this->description = MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_DESCRIPTION;
      $this->description .= '<div class="secWarning">' . MODULE_CONTENT_BOOTSTRAP_ROW_DESCRIPTION . '</div>';

      if ( defined('MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_STATUS') ) {
        $this->sort_order = MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_SORT_ORDER;
        $this->enabled = (MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_STATUS == 'True');
      }

      if ( $this->enabled && $category_depth != 'nested' ) {
        $this->enabled = false;
      }
    }

    public function execute() {
      global $oscTemplate, $category;

      $categories_query = $this->get_data();

      ob_start();
      include('includes/modules/content/' . $this->group . '/templates/categories_images.php');
      $template = ob_get_clean();

      $oscTemplate->addContent($template, $this->group);
    }

    public function isEnabled() {
      return $this->enabled;
    }

    public function check() {
      return defined('MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_STATUS');
    }

    public function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Module Version', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_VERSION', '" . $this->version . "', 'The version of this module that you are running', '6', '0', 'tep_cfg_disabled(', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Category Sub-categories Listing Module', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_STATUS', 'True', 'Should the category sub-categories listing be shown in the category?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', '6', '2', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Category Width', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_CONTENT_WIDTH_EACH', '4', 'What width container should each Category be shown in?', '6', '3', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', '6', '4', now())");
    }

    public function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    public function keys() {
      $keys = array();
      $keys[] = 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_VERSION';
      $keys[] = 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_STATUS';
      $keys[] = 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_CONTENT_WIDTH';
      $keys[] = 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_CONTENT_WIDTH_EACH';
      $keys[] = 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_SORT_ORDER';
      return $keys;
    }
    
    private function get_data() {
      global $languages_id, $cPath, $cPath_array, $current_category_id;
    
      if (isset($cPath) && strpos('_', $cPath)) {
        // check to see if there are deeper categories within the current category
        $category_links = array_reverse($cPath_array);
        for($i=0, $n=sizeof($category_links); $i<$n; $i++) {
          $categories_query = tep_db_query("select count(*) as total from categories c, categories_description cd where c.parent_id = '" . (int)$category_links[$i] . "' and c.categories_id = cd.categories_id and cd.language_id = '" . (int)$languages_id . "'");
          $categories = tep_db_fetch_array($categories_query);
          if ($categories['total'] < 1) {
            // do nothing, go through the loop
          } else {
            $categories_query = tep_db_query("select c.categories_id, cd.categories_name, c.categories_image, c.parent_id from categories c, categories_description cd where c.parent_id = '" . (int)$category_links[$i] . "' and c.categories_id = cd.categories_id and cd.language_id = '" . (int)$languages_id . "' order by sort_order, cd.categories_name");
            break; // we've found the deepest category the customer is in
          }
        }
      } else {
        $categories_query = tep_db_query("select c.categories_id, cd.categories_name, c.categories_image, c.parent_id from categories c, categories_description cd where c.parent_id = '" . (int)$current_category_id . "' and c.categories_id = cd.categories_id and cd.language_id = '" . (int)$languages_id . "' order by sort_order, cd.categories_name");
      }

      return $categories_query;
    }
  } // end class

  // independent function to show a disabled entry in admin i.e. for version number
  if( !function_exists( 'tep_cfg_disabled' ) ) {
    function tep_cfg_disabled( $value ) {
      return tep_draw_input_field( 'configuration_value', $value, ' disabled' );
    }
  }
