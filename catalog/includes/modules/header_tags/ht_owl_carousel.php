<?php
/*
  $Id$ ht_owl_carousel.php, v1.2 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
*/

  class ht_owl_carousel {
    var $code;
    var $group ;
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {
      $this->code = get_class($this);
      $this->group = basename(dirname(__FILE__));

      $this->api_version = '"jQuery Owl Carousel v1.3.3" v1.2';
      $this->script_version = '1.3.3';

      $this->title = MODULE_HEADER_TAGS_OWL_CAROUSEL_TITLE;
      $this->description = MODULE_HEADER_TAGS_OWL_CAROUSEL_DESCRIPTION;

      if ( defined('MODULE_HEADER_TAGS_OWL_CAROUSEL_STATUS') ) {
        $this->sort_order = MODULE_HEADER_TAGS_OWL_CAROUSEL_SORT_ORDER;
        $this->enabled = (MODULE_HEADER_TAGS_OWL_CAROUSEL_STATUS == 'True');
      }
    }

    function execute() {
      global $PHP_SELF, $oscTemplate;

      if (tep_not_null(MODULE_HEADER_TAGS_OWL_CAROUSEL_VIEW_PAGES)) {
        $pages_array = array();

        foreach (explode(';', MODULE_HEADER_TAGS_OWL_CAROUSEL_VIEW_PAGES) as $page) {
          $page = trim($page);

          if (!empty($page)) {
            $pages_array[] = $page;
          }
        }

        if (in_array(basename($PHP_SELF), $pages_array)) {
          // load global css in header (needed to load earlier)
          $oscTemplate->addBlock('<link rel="stylesheet" href="ext/owl-carousel/owl.carousel.css" />' . "\n", $this->group);
          $oscTemplate->addBlock('<link rel="stylesheet" href="ext/owl-carousel/owl.theme.css" />' . "\n", $this->group);
      
          // load global javascript in footer
          $oscTemplate->addBlock('<script src="ext/owl-carousel/owl.carousel.min.js"></script>' . "\n", 'footer_scripts');
        }
      }
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_HEADER_TAGS_OWL_CAROUSEL_STATUS');
    }

    function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Owl Carousel Version', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_JAVASCRIPT_VERSION', '" . $this->script_version . "', 'The version of this jQuery Owl Carousel.', '6', '1', 'tep_cfg_disabled(', now() ) ");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable jQuery Owl Carousel Module', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_STATUS', 'True', 'Do you want to add jQuery Owl Carousel Javascript to your shop? (Required for modules that need owl carousel to function i.e. New Products Carousel.)', '6', '2', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Pages', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_VIEW_PAGES', '" . implode(';', $this->get_default_pages()) . "', 'The pages to add the script to.', '6', '3', 'ht_owl_carousel_show_pages', 'ht_owl_carousel_edit_pages(', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_SORT_ORDER', '0', 'Sort order. Lowest is first.', '6', '4', now())");
    }

    function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_HEADER_TAGS_OWL_CAROUSEL_JAVASCRIPT_VERSION', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_STATUS', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_VIEW_PAGES', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_SORT_ORDER');
    }

    function get_default_pages() {
      return array('index.php');
    }
  } // end class

  // independent functions follow

  function ht_owl_carousel_show_pages($text) {
    return nl2br(implode("\n", explode(';', $text)));
  }

  function ht_owl_carousel_edit_pages($values, $key) {
    global $PHP_SELF;

    $file_extension = substr($PHP_SELF, strrpos($PHP_SELF, '.'));
    $files_array = array();
	  if ($dir = @dir(DIR_FS_CATALOG)) {
	    while ($file = $dir->read()) {
	      if (!is_dir(DIR_FS_CATALOG . $file)) {
	        if (substr($file, strrpos($file, '.')) == $file_extension) {
            $files_array[] = $file;
          }
        }
      }
      sort($files_array);
      $dir->close();
    }

    $values_array = explode(';', $values);

    $output = '';
    foreach ($files_array as $file) {
      $output .= tep_draw_checkbox_field('ht_owl_carousel_file[]', $file, in_array($file, $values_array)) . '&nbsp;' . tep_output_string($file) . '<br />';
    }

    if (!empty($output)) {
      $output = '<br />' . substr($output, 0, -6);
    }

    $output .= tep_draw_hidden_field('configuration[' . $key . ']', '', 'id="htrn_files"');

    $output .= '<script>
                function htrn_update_cfg_value() {
                  var htrn_selected_files = \'\';

                  if ($(\'input[name="ht_owl_carousel_file[]"]\').length > 0) {
                    $(\'input[name="ht_owl_carousel_file[]"]:checked\').each(function() {
                      htrn_selected_files += $(this).attr(\'value\') + \';\';
                    });

                    if (htrn_selected_files.length > 0) {
                      htrn_selected_files = htrn_selected_files.substring(0, htrn_selected_files.length - 1);
                    }
                  }

                  $(\'#htrn_files\').val(htrn_selected_files);
                }

                $(function() {
                  htrn_update_cfg_value();

                  if ($(\'input[name="ht_owl_carousel_file[]"]\').length > 0) {
                    $(\'input[name="ht_owl_carousel_file[]"]\').change(function() {
                      htrn_update_cfg_value();
                    });
                  }
                });
                </script>';

    return $output;
  }

