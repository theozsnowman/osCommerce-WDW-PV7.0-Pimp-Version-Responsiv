<?php
/*
  $Id pd_header.php v1.1 20120831 Kymation $
  $Loc: /catalog/includes/modules/google_feeder/ $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class pd_header {
    var $code = 'pd_header';
    var $group = 'pdf_datasheet';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {
      $this->title = MODULE_PDF_DATASHEET_HEADER_TITLE;
      $this->description = MODULE_PDF_DATASHEET_HEADER_DESCRIPTION;

      if ( defined('MODULE_PDF_DATASHEET_HEADER_STATUS') ) {
        $this->sort_order = MODULE_PDF_DATASHEET_HEADER_SORT_ORDER;
        $this->enabled = (MODULE_PDF_DATASHEET_HEADER_STATUS == 'True');
      }
    }

    function execute() {
      global $pdf, $PHP_SELF, $products_id, $language, $current_y;
      if( basename( $PHP_SELF ) == 'pdf_datasheet.php' && isset( $products_id ) && $products_id > 0 ) {

      	// Specify the logo image filename
        $logo_image = 'store_logo.png';

        if( MODULE_PDF_DATASHEET_HEADER_IMAGE_NAME != '' ) {
          $logo_image = MODULE_PDF_DATASHEET_HEADER_IMAGE_NAME;
        }

        $logo_image = 'images/' . $logo_image;
        $image_size_raw = getimagesize( $logo_image );
        $image_size = $pdf->pixelsToUnits($image_size_raw[0]);
        $image_size = $image_size * ( float )MODULE_PDF_DATASHEET_HEADER_IMAGE_MULTIPLIER;

        // Specify the header title (the first line of text)
        $pdf_header_title = PDF_HEADER_TITLE;

        if( MODULE_PDF_DATASHEET_HEADER_STORE_OWNER == 'True' ) {
          $pdf_header_title = STORE_OWNER;
        }

        // Specify the header string (the lines of text after the title)
        $pdf_header_string = PDF_HEADER_STRING;
        $string_exists = false;

        // Use the preset store name and address if selected
        if( MODULE_PDF_DATASHEET_HEADER_STORE_NAME_ADDRESS == 'True' ) {
          $pdf_header_string = STORE_NAME;
          $string_exists = true;
        }

        // Add a custom string to the header, either after the stock name/address or in place of it.
        if( constant( 'MODULE_PDF_DATASHEET_HEADER_TEXT_' . strtoupper( $language ) ) != '' ) {
        	if( $string_exists == false ) $pdf_header_string = '';
          $pdf_header_string .= constant( 'MODULE_PDF_DATASHEET_HEADER_TEXT_' . strtoupper( $language ) );
        }

        // Set up the header with the above data
        $pdf->SetHeaderData( $logo_image, $image_size, $pdf_header_title, $pdf_header_string);
        $current_y = $pdf->GetY();

      } // if (basename
    } // function execute

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined( 'MODULE_PDF_DATASHEET_HEADER_STATUS' );
    }

    function install() {
      include_once( 'includes/classes/' . 'language.php' );
      $bm_banner_language_class = new language;
      $languages = $bm_banner_language_class->catalog_languages;

      foreach( $languages as $this_language ) {
        $this->languages_array[$this_language['id']] = $this_language['directory'];
      }

      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable the Module', 'MODULE_PDF_DATASHEET_HEADER_STATUS', 'True', 'Do you want to add the product link to the Google feed? (Note: Required field.)', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_PDF_DATASHEET_HEADER_SORT_ORDER', '9001', 'Sort order of display. Lowest is displayed first.', '6', '2', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Image Name', 'MODULE_PDF_DATASHEET_HEADER_IMAGE_NAME', '', 'If yor header image is not the standard header image, put your iamge name here.', '6', '3', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Image Multiplier', 'MODULE_PDF_DATASHEET_HEADER_IMAGE_MULTIPLIER', '1.0', 'Multiply the image size by this number.', '6', '3', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Show Store Owner', 'MODULE_PDF_DATASHEET_HEADER_STORE_OWNER', 'True', 'Show the Store Owner in the header?', '6', '4', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Show Store Address', 'MODULE_PDF_DATASHEET_HEADER_STORE_NAME_ADDRESS', 'True', 'Show the Store Address in the header?', '6', '5', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");

    	foreach( $this->languages_array as $language_name ) {
        tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ( '" . ucwords( $language_name ) . " Additional Text', 'MODULE_PDF_DATASHEET_HEADER_TEXT_" . strtoupper( $language_name ) . "', '', 'Enter the additional text that you want in your header in " . $language_name . "', '6', '14', now())" );
      }
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      include_once( 'includes/classes/' . 'language.php' );
      $bm_banner_language_class = new language;
      $languages = $bm_banner_language_class->catalog_languages;

      foreach( $languages as $this_language ) {
        $this->languages_array[$this_language['id']] = $this_language['directory'];
      }

    	$keys = array();

    	$keys[] = 'MODULE_PDF_DATASHEET_HEADER_STATUS';
    	$keys[] = 'MODULE_PDF_DATASHEET_HEADER_SORT_ORDER';
    	$keys[] = 'MODULE_PDF_DATASHEET_HEADER_IMAGE_NAME';
    	$keys[] = 'MODULE_PDF_DATASHEET_HEADER_IMAGE_MULTIPLIER';
    	$keys[] = 'MODULE_PDF_DATASHEET_HEADER_STORE_OWNER';
    	$keys[] = 'MODULE_PDF_DATASHEET_HEADER_STORE_NAME_ADDRESS';

    	foreach( $this->languages_array as $language_name ) {
    	  $keys[] = 'MODULE_PDF_DATASHEET_HEADER_TEXT_' . strtoupper( $language_name );
    	}

      return $keys;
    }
  }
?>
