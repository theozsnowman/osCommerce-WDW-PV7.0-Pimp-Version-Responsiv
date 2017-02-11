<?php
/*
  $Id pd_manufacturer.php v1.1 20120831 Kymation $
  $Loc: /catalog/includes/modules/pdf_datasheet/ $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class pd_manufacturer {
    var $code = 'pd_manufacturer';
    var $group = 'pdf_datasheet';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = true;

    function __construct() {
      $this->title = MODULE_PDF_DATASHEET_MANUFACTURER_TITLE;
      $this->description = MODULE_PDF_DATASHEET_MANUFACTURER_DESCRIPTION;

      if ( defined('MODULE_PDF_DATASHEET_MANUFACTURER_STATUS') ) {
        $this->sort_order = MODULE_PDF_DATASHEET_MANUFACTURER_SORT_ORDER;
        $this->enabled = (MODULE_PDF_DATASHEET_MANUFACTURER_STATUS == 'True');
      }
    }

    function execute() {
      global $PHP_SELF, $pdf, $products_id, $language, $current_y;

      if( basename( $PHP_SELF ) == 'pdf_datasheet.php' && isset( $products_id ) && $products_id > 0 ) {
        // Get the product name
        $manufacturer_info_query_raw = "
          select
            manufacturers_name
          from
            " . TABLE_PRODUCTS . " p
            join " . TABLE_MANUFACTURERS . " m
              on (m.manufacturers_id = p.manufacturers_id)
          where
            p.products_id = '" . $products_id . "'
        ";
        $manufacturer_info_query = tep_db_query( $manufacturer_info_query_raw );

        if( tep_db_num_rows( $manufacturer_info_query ) > 0 ) {
          $manufacturer_info = tep_db_fetch_array( $manufacturer_info_query );

          $manufacturer_string = '';
          if( constant( 'MODULE_PDF_DATASHEET_MANUFACTURER_PREFIX_' . strtoupper( $language ) ) != '' ) {
            $manufacturer_string .= constant( 'MODULE_PDF_DATASHEET_MANUFACTURER_PREFIX_' . strtoupper( $language ) ) . ' ';
          }

          $manufacturer_string .= $manufacturer_info['manufacturers_name'];

          if( constant( 'MODULE_PDF_DATASHEET_MANUFACTURER_SUFFIX_' . strtoupper( $language ) ) != '' ) {
            $manufacturer_string .= constant( 'MODULE_PDF_DATASHEET_MANUFACTURER_SUFFIX_' . strtoupper( $language ) ) . ' ';
          }

          // Reset the start position of the text
          $pdf->SetY( $current_y, true );

          // Add top padding
          $text_top = $current_y + ( float )MODULE_PDF_DATASHEET_MANUFACTURER_TOP_PADDING;

          // Print the manufacturer's name
          $pdf->MultiCell( 0, 1, $manufacturer_string, 0, 'L', false, 1, '', $text_top, true, 0, false, true, 0, 'T', false );

          // Reset the height for the next module
          $current_y = $pdf->GetY();
        }
      } // if (basename
    } // function execute

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined( 'MODULE_PDF_DATASHEET_MANUFACTURER_STATUS' );
    }

    function install() {
      include_once( 'includes/classes/' . 'language.php' );
      $bm_banner_language_class = new language;
      $languages = $bm_banner_language_class->catalog_languages;

      foreach( $languages as $this_language ) {
        $this->languages_array[$this_language['id']] = $this_language['directory'];
      }

      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable the Module', 'MODULE_PDF_DATASHEET_MANUFACTURER_STATUS', 'True', 'Do you want to add the manufacturer\'s name to the PDF?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_PDF_DATASHEET_MANUFACTURER_SORT_ORDER', '9065', 'Sort order of display. Lowest is displayed first.', '6', '2', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Top Padding', 'MODULE_PDF_DATASHEET_MANUFACTURER_TOP_PADDING', '2', 'Add extra space above the manufacturer\'s name.', '6', '2', now())");

    	foreach( $this->languages_array as $language_name ) {
        tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ( '" . ucwords( $language_name ) . " Prefix', 'MODULE_PDF_DATASHEET_MANUFACTURER_PREFIX_" . strtoupper( $language_name ) . "', 'Manufacturer:', 'Additional text in " . $language_name . " to add before the manufacturer\'s name.', '6', '13', now())" );
        tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ( '" . ucwords( $language_name ) . " Suffix', 'MODULE_PDF_DATASHEET_MANUFACTURER_SUFFIX_" . strtoupper( $language_name ) . "', '', 'Additional text in " . $language_name . " to add after the manufacturer\'s name.', '6', '14', now())" );
      }
    }

    function remove() {
      tep_db_query( "delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')" );
    }

    function keys() {
      include_once( 'includes/classes/' . 'language.php' );
      $bm_banner_language_class = new language;
      $languages = $bm_banner_language_class->catalog_languages;

      foreach( $languages as $this_language ) {
        $this->languages_array[$this_language['id']] = $this_language['directory'];
      }

    	$keys = array();

    	$keys[] = 'MODULE_PDF_DATASHEET_MANUFACTURER_STATUS';
    	$keys[] = 'MODULE_PDF_DATASHEET_MANUFACTURER_SORT_ORDER';
    	$keys[] = 'MODULE_PDF_DATASHEET_MANUFACTURER_TOP_PADDING';

    	foreach( $this->languages_array as $language_name ) {
    	  $keys[] = 'MODULE_PDF_DATASHEET_MANUFACTURER_PREFIX_' . strtoupper( $language_name );
    	  $keys[] = 'MODULE_PDF_DATASHEET_MANUFACTURER_SUFFIX_' . strtoupper( $language_name );
    	}

      return $keys;
    }
  }
?>
