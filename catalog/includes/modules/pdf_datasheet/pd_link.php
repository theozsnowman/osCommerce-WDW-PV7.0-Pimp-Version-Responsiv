<?php
/*
  $Id pd_link.php v1.1 20120831 Kymation $
  $Loc: /catalog/includes/modules/pdf_datasheet/ $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class pd_link {
    var $code = 'pd_link';
    var $group = 'pdf_datasheet';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = true;

    function __construct() {
      $this->title = MODULE_PDF_DATASHEET_LINK_TITLE;
      $this->description = MODULE_PDF_DATASHEET_LINK_DESCRIPTION;

      if ( defined('MODULE_PDF_DATASHEET_LINK_STATUS') ) {
        $this->sort_order = MODULE_PDF_DATASHEET_LINK_SORT_ORDER;
        $this->enabled = (MODULE_PDF_DATASHEET_LINK_STATUS == 'True');
      }
    }

    function execute() {
      global $PHP_SELF, $pdf, $products_id, $languages_id, $language, $cPath, $current_y;

      if( basename( $PHP_SELF ) == 'pdf_datasheet.php' && isset( $products_id ) && $products_id > 0 ) {
      	// Add vertical space above the text
        if( MODULE_PDF_DATASHEET_LINK_PADDING > 0 ) {
          $pdf->ln( MODULE_PDF_DATASHEET_LINK_PADDING );
          $current_y = $pdf->GetY();
        }

        // Get the product name
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

        $html = '<br /><p style="font-size:80%">';
        if( constant( 'MODULE_PDF_DATASHEET_LINK_TEXT_' . strtoupper( $language ) ) != '' ) {
          $html .= constant( 'MODULE_PDF_DATASHEET_LINK_TEXT_' . strtoupper( $language ) ) . '&nbsp;';
        }
        $html .= '<a href="' . tep_href_link( 'product_info.php', ($cPath ? 'cPath=' . $cPath . '&' : '') . 'products_id=' . $products_id ) . '">' . $product_info['products_name'] . '</a>';
        $html .= '</p>';

        // write html text
        $pdf->writeHTML( $html, true, false, false, false, '' );
        $current_y = $pdf->GetY();

      } // if (basename
    } // function execute

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined( 'MODULE_PDF_DATASHEET_LINK_STATUS' );
    }

    function install() {
      include_once( 'includes/classes/' . 'language.php' );
      $bm_banner_language_class = new language;
      $languages = $bm_banner_language_class->catalog_languages;

      foreach( $languages as $this_language ) {
        $this->languages_array[$this_language['id']] = $this_language['directory'];
      }

      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable the Module', 'MODULE_PDF_DATASHEET_LINK_STATUS', 'True', 'Do you want to add the product link to the PDF?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_PDF_DATASHEET_LINK_SORT_ORDER', '9070', 'Sort order of display. Lowest is displayed first.', '6', '2', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Padding', 'MODULE_PDF_DATASHEET_LINK_PADDING', '2', 'Add space above the heading/text.', '6', '3', now())");

    	foreach( $this->languages_array as $language_name ) {
        tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ( '" . ucwords( $language_name ) . " Text', 'MODULE_PDF_DATASHEET_LINK_TEXT_" . strtoupper( $language_name ) . "', '', 'Add text in " . $language_name . " to the PDF file name', '6', '14', now())" );
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

    	$keys[] = 'MODULE_PDF_DATASHEET_LINK_STATUS';
    	$keys[] = 'MODULE_PDF_DATASHEET_LINK_SORT_ORDER';
    	$keys[] = 'MODULE_PDF_DATASHEET_LINK_PADDING';

    	foreach( $this->languages_array as $language_name ) {
    	  $keys[] = 'MODULE_PDF_DATASHEET_LINK_TEXT_' . strtoupper( $language_name );
    	}

      return $keys;
    }
  }
?>
