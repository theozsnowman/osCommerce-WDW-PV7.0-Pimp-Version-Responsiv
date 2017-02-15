<?php
/*
  $Id pd_initialize.php v1.1 20120831 Kymation $
  $Loc: /catalog/includes/modules/google_feeder/ $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class pd_initialize {
    var $code = 'pd_initialize';
    var $group = 'pdf_datasheet';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = true;

    function __construct() {
      $this->title = MODULE_PDF_DATASHEET_INITIALIZE_TITLE;
      $this->description = MODULE_PDF_DATASHEET_INITIALIZE_DESCRIPTION;

      if ( defined('MODULE_PDF_DATASHEET_INITIALIZE_STATUS') ) {
        $this->sort_order = MODULE_PDF_DATASHEET_INITIALIZE_SORT_ORDER;
        $this->enabled = (MODULE_PDF_DATASHEET_INITIALIZE_STATUS == 'True');
      }
    }

    function execute() {
      global $PHP_SELF, $oscTemplate, $pdf, $products_id, $language, $languages_id;

      if( basename( $PHP_SELF ) == 'pdf_datasheet.php' && isset( $products_id ) && $products_id > 0 ) {
        // set document information
        $pdf_creator = PDF_CREATOR;
        if( MODULE_PDF_DATASHEET_INITIALIZE_PDF_CREATOR != '' ) {
          $pdf_creator = MODULE_PDF_DATASHEET_INITIALIZE_PDF_CREATOR;
        }

        $pdf->SetCreator( $pdf_creator );
        $pdf->SetAuthor( MODULE_PDF_DATASHEET_INITIALIZE_AUTHOR );

        // Now get the current value of the heading title, even if it's blank
        $product_info_query_raw = "
          select
            products_name
          from
            " . TABLE_PRODUCTS_DESCRIPTION . "
          where
            products_id = '" . ( int )$products_id . "'
            and language_id = '" . ( int )$languages_id . "'
        ";
        $product_info_query = tep_db_query( $product_info_query_raw );
        $product_info = tep_db_fetch_array( $product_info_query );
        $title = $subject = $product_info['products_name'];

        if( constant( 'MODULE_PDF_DATASHEET_INITIALIZE_TITLE_' . strtoupper( $language ) ) != '' ) {
          $title .= constant( 'MODULE_PDF_DATASHEET_INITIALIZE_TITLE_' . strtoupper( $language ) );
        }

        $pdf->SetTitle( $title );

        $subject = '';
        if( constant( 'MODULE_PDF_DATASHEET_INITIALIZE_SUBJECT_' . strtoupper( $language ) ) != '' ) {
          $subject = constant( 'MODULE_PDF_DATASHEET_INITIALIZE_SUBJECT_' . strtoupper( $language ) );
        }

        $pdf->SetSubject( $subject );

        $pdf->SetKeywords( constant( 'MODULE_PDF_DATASHEET_INITIALIZE_KEYWORDS_' . strtoupper( $language ) ) );
      } // if (basename
    } // function execute

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined( 'MODULE_PDF_DATASHEET_INITIALIZE_STATUS' );
    }

    function install() {
      include_once( 'includes/classes/' . 'language.php' );
      $bm_banner_language_class = new language;
      $languages = $bm_banner_language_class->catalog_languages;

      foreach( $languages as $this_language ) {
        $this->languages_array[$this_language['id']] = $this_language['directory'];
      }

      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable the Module', 'MODULE_PDF_DATASHEET_INITIALIZE_STATUS', 'True', 'Do you want to add the product link to the Google feed? (Note: Required field.)', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_PDF_DATASHEET_INITIALIZE_SORT_ORDER', '9000', 'Sort order of display. Lowest is displayed first.', '6', '2', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('PDF Creator', 'MODULE_PDF_DATASHEET_INITIALIZE_PDF_CREATOR', '', 'Enter the name of the Creator (Leave blank for Config value).', '6', '6', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Author', 'MODULE_PDF_DATASHEET_INITIALIZE_AUTHOR', '', 'Enter the name of the Author (Leave blank for Store Owner).', '6', '7', now())");

    	foreach( $this->languages_array as $language_name ) {
        tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ( '" . ucwords( $language_name ) . " Title', 'MODULE_PDF_DATASHEET_INITIALIZE_TITLE_" . strtoupper( $language_name ) . "', '', 'Enter the title that you want for your PDF in " . $language_name . "', '6', '12', now())" );
        tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ( '" . ucwords( $language_name ) . " Subject', 'MODULE_PDF_DATASHEET_INITIALIZE_SUBJECT_" . strtoupper( $language_name ) . "', '', 'Enter the subject that you want for your PDF in " . $language_name . "', '6', '13', now())" );
        tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ( '" . ucwords( $language_name ) . " Keywords', 'MODULE_PDF_DATASHEET_INITIALIZE_KEYWORDS_" . strtoupper( $language_name ) . "', '', 'Enter the keywords that you want for your PDF in " . $language_name . "', '6', '14', now())" );
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

    	$keys[] = 'MODULE_PDF_DATASHEET_INITIALIZE_STATUS';
    	$keys[] = 'MODULE_PDF_DATASHEET_INITIALIZE_SORT_ORDER';
    	$keys[] = 'MODULE_PDF_DATASHEET_INITIALIZE_PDF_CREATOR';
    	$keys[] = 'MODULE_PDF_DATASHEET_INITIALIZE_AUTHOR';

    	foreach( $this->languages_array as $language_name ) {
    	  $keys[] = 'MODULE_PDF_DATASHEET_INITIALIZE_TITLE_' . strtoupper( $language_name );
    	  $keys[] = 'MODULE_PDF_DATASHEET_INITIALIZE_SUBJECT_' . strtoupper( $language_name );
    	  $keys[] = 'MODULE_PDF_DATASHEET_INITIALIZE_KEYWORDS_' . strtoupper( $language_name );
    	}

      return $keys;
    }
  }
?>
