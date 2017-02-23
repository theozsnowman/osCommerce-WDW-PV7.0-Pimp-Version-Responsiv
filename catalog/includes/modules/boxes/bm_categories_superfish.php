<?php
/*
  $Id: bm_categories_superfish.php v1.2.1 20150303 Kymation $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2015 osCommerce

  Released under the GNU General Public License
*/

  class bm_categories_superfish {
    var $code = 'bm_categories_superfish';
    var $group = 'boxes';
    var $header_group = 'header_tags';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;
    var $languages_array = array ();
    
    
    ////
    // Set up the defaults
    public function __construct() {
      global $cache_blocks;
      
      $this->title = MODULE_BOXES_CATEGORIES_SUPERFISH_TITLE;
      $this->description = MODULE_BOXES_CATEGORIES_SUPERFISH_DESCRIPTION;

      if (defined('MODULE_BOXES_CATEGORIES_SUPERFISH_STATUS')) {
        $this->sort_order = MODULE_BOXES_CATEGORIES_SUPERFISH_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_CATEGORIES_SUPERFISH_STATUS == 'True');
      }

      $this->group = ((MODULE_BOXES_CATEGORIES_SUPERFISH_CONTENT_PLACEMENT == 'Left Column') ? 'boxes_column_left' : 'boxes_column_right');
      
      // Add to the cache blocks array in the Admin
      if ( defined ( 'DIR_WS_ADMIN' ) )  {
        $cache_blocks[] = array ( 
          'title' => TEXT_CACHE_CATEGORIES_SUPERFISH, 
          'code' => 'categories_superfish', 
          'file' => 'categories_superfish_box-language.cache', 
          'multiple' => true
        );
      }
    }
    
    
    ////
    // Used by the oscTemplate class to generate the module
    public function execute() {
      global $oscTemplate;

      // Add the Superfish scripts to the template_top
      ob_start();
      require_once 'includes/modules/boxes/templates/categories_superfish_scripts.php' ;
      $header_contents = ob_get_clean();
      
      $oscTemplate->addBlock ( $header_contents, $this->header_group );
      
      // Add the Superfish box from cache or live
      if ((USE_CACHE == 'true') && empty ($SID)) {
        $module_contents = tep_cache_categories_superfish_box();
      } else {
        $module_contents = $this->generate_box();
      } // if ((USE_CACHE ... else

      $oscTemplate->addBlock( $module_contents, $this->group );
    } // function execute
    
    
    ////
    // Is the module enabled?
    public function isEnabled() {
      return $this->enabled;
    }
    
    
    ////
    // Check the module status
    public function check() {
      return defined('MODULE_BOXES_CATEGORIES_SUPERFISH_STATUS');
    }
    
    
    ////
    // Install the module
    public function install() {
      include_once( 'includes/classes/language.php' );
      $bm_superfish_language_class = new language;
      $languages = $bm_superfish_language_class->catalog_languages;

      foreach( $languages as $this_language ) {
        $this->languages_array[$this_language['id']] = $this_language['directory'];
      }

      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_CATEGORIES_SUPERFISH_SORT_ORDER', '1002', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Superfish Categories Box', 'MODULE_BOXES_CATEGORIES_SUPERFISH_STATUS', 'True', 'Do you want to show the Superfish Categories box?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_CATEGORIES_SUPERFISH_CONTENT_PLACEMENT', 'Left Column', 'Where should the module be loaded?', '6', '2', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now())");

      foreach ($this->languages_array as $language_id => $language_name) {
        tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ( '" . ucwords( $language_name ) . " Title', 'MODULE_BOXES_CATEGORIES_SUPERFISH_FRONT_TITLE_" . strtoupper( $language_name ) . "', '', 'Enter the title that you want in the header in " . $language_name . ". Leave this blank for no header or title.', '6', '10', now())" );
      }
    }
    
    
    ////
    // Uninstall the module
    public function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }
    
    
    ////
    // Database keys
    public function keys() {
      include_once( 'includes/classes/language.php' );
      $bm_superfish_language_class = new language;
      $languages = $bm_superfish_language_class->catalog_languages;

      foreach( $languages as $this_language ) {
        $this->languages_array[$this_language['id']] = $this_language['directory'];
      }

      $keys = array ();

      $keys[] = 'MODULE_BOXES_CATEGORIES_SUPERFISH_SORT_ORDER';
      $keys[] = 'MODULE_BOXES_CATEGORIES_SUPERFISH_STATUS';
      $keys[] = 'MODULE_BOXES_CATEGORIES_SUPERFISH_CONTENT_PLACEMENT';

      foreach ($this->languages_array as $language_name) {
        $keys[] = 'MODULE_BOXES_CATEGORIES_SUPERFISH_FRONT_TITLE_' . strtoupper($language_name);
      }

      return $keys;
    }
    
    
    ////
    // Get the categories from the database and load them into a tree array
    private function get_subcategories( $parent_id ) {
      if( tep_has_category_subcategories( $parent_id ) ) {
        global $languages_id;

        $categories_data = array ();
        // Retrieve the data on the subcategories
        $categories_query_raw = "
          select
            c.categories_id,
            c.parent_id,
            cd.categories_name
          from " . TABLE_CATEGORIES_DESCRIPTION . " cd
            join " . TABLE_CATEGORIES . " c
              on (c.categories_id = cd.categories_id)
          where
            c.parent_id = '" . ( int ) $parent_id . "'
            and cd.language_id = '" . ( int ) $languages_id . "'
          order by
            c.sort_order,
            cd.categories_name
        ";
        //print 'Categories Query: ' . $categories_query_raw . '<br />';
        $categories_query = tep_db_query( $categories_query_raw );

        // Load the subcategory data into an array
        $index = 0;
        while( $categories = tep_db_fetch_array( $categories_query ) ) {
          $categories_id = ( int )$categories['categories_id'];
          $path_string = $this->get_category_path( $categories_id );

          if ($categories_id != 0) {
            $categories_data[$index] = array (
              'id' => $categories_id,
              'name' => $categories['categories_name'],
              'parent_id' => $categories['parent_id'],
              'path' => $path_string
            );

            // If the category has subcats, add them to the array
            if( tep_has_category_subcategories( $categories_id ) ) {
              $categories_data[$index]['subcat'] = $this->get_subcategories( $categories_id );

            } else {
              $categories_data[$index]['subcat'] = false;
            }
          } // if( $categories_id
          
          $index++;
        } //while ($categories

        return $categories_data;
      } else {
        return false;
      }
    }
    
    
    ////
    // Format the category tree with the correct HTML
    private function format_data( $data_array, $pass = false ) {
      if( is_array( $data_array ) && count( $data_array ) > 0 ) {
        if( $pass == false ) {
          $output = '    <ul class="sf-menu sf-vertical">' . PHP_EOL;
        } else {
          $output = '    <ul>' . PHP_EOL;
        }
        
        foreach( $data_array as $category ) {
          if( $category['parent_id'] == 0 ) {
            $output .= '      <li class="top_cat">' . PHP_EOL;
          } else {
            $output .= '      <li class="subcat">' . PHP_EOL;
          }
          
          $output .= '        <a href="' . tep_href_link( 'index.php', $category['path'], 'NONSSL' ) . '">';
          $output .= $category['name'];
          $output .= '</a>' . PHP_EOL;
          if( $category['subcat'] !== false ) {
            $output .= $this->format_data( $category['subcat'], true );
          }
          $output .= '      </li>' . PHP_EOL;
        }

        $output .= '    </ul>' . PHP_EOL;

        return $output;

      } else {
        return false;
      }
    } //private function format_data
    
    
    ////
    // Generate the Superfish categories box
    //   Used internally to supply the box HTML to either the cache function or the module template
    private function generate_box() {
      global $language;

      // Get the appropriate title for this language
      $title = constant( 'MODULE_BOXES_CATEGORIES_SUPERFISH_FRONT_TITLE_' . strtoupper( $language ) );

      // Get the category tree array
      $category_tree = $this->get_subcategories(0);

      // feed the tree array to the formatting method
      $formatted_data = $this->format_data( $category_tree );

      // Add the Superfish code for the box
      ob_start();
      require_once 'includes/modules/boxes//templates/categories_superfish.php' ;
      $module_contents = ob_get_clean();
      
      return $module_contents;
    } // private function generate_box
    
    ////
    // Generate the output for the cache function
    public function getData() {
      return $this->generate_box();
    }

    ////
    // Generate a path to categories
    private function get_category_path( $category_id ) {
      if( tep_not_null( $category_id ) ) {
        $cPath_new = '';
        $categories = array (); // Initialize the array so the function doesn't complain
        tep_get_parent_categories($categories, $category_id);

        $categories = array_reverse($categories);

        $cPath_new .= implode('_', $categories);
        if (tep_not_null($cPath_new))
          $cPath_new .= '_';
        $cPath_new .= $category_id;

        return 'cPath=' . $cPath_new;
      }

      return false;
    } // private function get_category_path(

  } // class bm_categories_superfish
  

  ////
  // Cache the categories superfish box
  function tep_cache_categories_superfish_box ( $auto_expire = false, $refresh = false ) {
    global $cPath, $language;
  
    $cache_output = '';
  
    if( ( $refresh == true ) || !read_cache( $cache_output, 'categories_superfish_box-' . $language . '.cache' . $cPath, $auto_expire ) ) {
      $new_bm_categories_superfish = new bm_categories_superfish();
      $cache_output = $new_bm_categories_superfish->getData();
  
      write_cache ( $cache_output, 'categories_superfish_box-' . $language . '.cache' . $cPath );
    }
  
    return $cache_output;
  }
  // End superfish categories box
  
?>