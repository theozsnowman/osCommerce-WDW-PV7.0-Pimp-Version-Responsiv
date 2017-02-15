<?php
/*
  $Id: cm_category_new_products.php, v1.1 19th Sept. 2016 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
*/

  class cm_category_new_products {
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

      $this->title = MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_TITLE;
      $this->description = MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_DESCRIPTION;
      $this->description .= '<div class="secWarning">' . MODULE_CONTENT_BOOTSTRAP_ROW_DESCRIPTION . '</div>';

      if ( defined('MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_STATUS') ) {
        $this->sort_order = MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_SORT_ORDER;
        $this->enabled = (MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_STATUS == 'True');
      }

      if ( $this->enabled && $category_depth != 'nested' ) {
        $this->enabled = false;
      }
    }

    public function execute() {
      global $oscTemplate, $currencies, $PHP_SELF, $currency;

      $new_products_query = $this->get_data();
      $num_new_products = tep_db_num_rows($new_products_query);
      if( $num_new_products > 0 ) {

        ob_start();
        include('includes/modules/content/' . $this->group . '/templates/new_products.php');
        $template = ob_get_clean();

        $oscTemplate->addContent($template, $this->group);
      }
    }

    public function isEnabled() {
      return $this->enabled;
    }

    public function check() {
      return defined('MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_STATUS');
    }

    public function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Module Version', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_VERSION', '" . $this->version . "', 'The version of this module that you are running.', '6', '0', 'tep_cfg_disabled(', now() ) ");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Category New Products Module', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_STATUS', 'True', 'Should the new products be shown in the category?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', '6', '2', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Product Width', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CONTENT_WIDTH_EACH', '3', 'What width container should each product be shown in? (12 = full width, 6 = half width).', '6', '3', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Max Products', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_MAX_DISPLAY_NEW_PRODUCTS', '9', 'Maximum number of new products to show in the category.', '6', '4', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_SORT_ORDER', '50', 'Sort order of display. Lowest is displayed first.', '6', '5', now())");
    }

    public function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    public function keys() {
      $keys = array();
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_VERSION';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_STATUS';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CONTENT_WIDTH';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CONTENT_WIDTH_EACH';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_MAX_DISPLAY_NEW_PRODUCTS';
      $keys[] = 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_SORT_ORDER';
      return $keys;
    }

    private function get_data() {
      global $languages_id, $current_category_id;

      $new_products_query = tep_db_query("
        select distinct
          p.products_id,
          p.products_image,
          p.image_folder, 
          p.image_display,
          p.products_tax_class_id,
          pd.products_name,
          if(s.status, s.specials_new_products_price, p.products_price) as products_price
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
          c.parent_id = '" . (int)$current_category_id . "'
          and p.products_status = '1'
          and pd.language_id = '" . (int)$languages_id . "'
        order by
          p.products_date_added desc
        limit " . MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_MAX_DISPLAY_NEW_PRODUCTS
      );

      return $new_products_query;
    }

  } // end class

  // independent function to show a disabled entry in admin i.e. for version number
  if( !function_exists( 'tep_cfg_disabled' ) ) {
    function tep_cfg_disabled( $value ) {
      return tep_draw_input_field( 'configuration_value', $value, ' disabled' );
    }
  }
