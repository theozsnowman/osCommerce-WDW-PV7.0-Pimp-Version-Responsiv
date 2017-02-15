<?php
/*
  $Id pd_fonts.php v1.0 20110721 Kymation $
  $Loc: /catalog/includes/modules/google_feeder/ $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class pd_fonts {
    var $code = 'pd_fonts';
    var $group = 'pdf_datasheet';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = true;

    function __construct() {
      global $PHP_SELF;

      $this->title = MODULE_PDF_DATASHEET_FONTS_TITLE;
      $this->description = MODULE_PDF_DATASHEET_FONTS_DESCRIPTION;

      if ( defined('MODULE_PDF_DATASHEET_FONTS_STATUS') ) {
        $this->sort_order = MODULE_PDF_DATASHEET_FONTS_SORT_ORDER;
        $this->enabled = (MODULE_PDF_DATASHEET_FONTS_STATUS == 'True');
      }

      // Include the function that is used to select fonts in the Admin
      if( $PHP_SELF == 'modules.php' ) {
        include_once( 'includes/functions/' . 'modules/font_selector.php' );
      }
    }

    function execute() {
      global $PHP_SELF, $oscTemplate, $pdf, $products_id, $language, $languages_id;

      if( basename( $PHP_SELF ) == 'pdf_datasheet.php' && isset( $products_id ) && $products_id > 0 ) {
        // set the header font
        $header_font = PDF_FONT_NAME_MAIN;
        if( MODULE_PDF_DATASHEET_FONTS_HEADER_FONT_NAME != '' ) {
          $header_font = MODULE_PDF_DATASHEET_FONTS_HEADER_FONT_NAME;
        }

        $header_font_size = PDF_FONT_SIZE_MAIN;
        if( MODULE_PDF_DATASHEET_FONTS_HEADER_FONT_SIZE != '' ) {
          $header_font_size = ( int )MODULE_PDF_DATASHEET_FONTS_HEADER_FONT_SIZE;
        }

        $pdf->setHeaderFont( array( $header_font, '', $header_font_size ) );

        // set the footer font
        $footer_font = PDF_FONT_NAME_MAIN;
        if( MODULE_PDF_DATASHEET_FONTS_FOOTER_FONT_NAME != '' ) {
          $footer_font = MODULE_PDF_DATASHEET_FONTS_FOOTER_FONT_NAME;
        }

        $footer_font_size = PDF_FONT_SIZE_MAIN;
        if( MODULE_PDF_DATASHEET_FONTS_FOOTER_FONT_SIZE != '' ) {
          $footer_font_size = ( int )MODULE_PDF_DATASHEET_FONTS_FOOTER_FONT_SIZE;
        }

        $pdf->setFooterFont( array( $footer_font, '', $footer_font_size ) );

        // set the default monospace font
        $monospace_font = PDF_FONT_MONOSPACED;
        if( MODULE_PDF_DATASHEET_FONTS_MONOSPACE_FONT_NAME != '' ) {
          $monospace_font = MODULE_PDF_DATASHEET_FONTS_MONOSPACE_FONT_NAME;
        }

        $pdf->SetDefaultMonospacedFont( $monospace_font );

        // set the margins
        $margin_top = PDF_MARGIN_TOP;
        if( MODULE_PDF_DATASHEET_FONTS_MARGIN_TOP != '' ) {
          $margin_top = MODULE_PDF_DATASHEET_FONTS_MARGIN_TOP;
        }

        $margin_bottom = PDF_MARGIN_BOTTOM;
        if( MODULE_PDF_DATASHEET_FONTS_MARGIN_BOTTOM != '' ) {
          $margin_bottom = MODULE_PDF_DATASHEET_FONTS_MARGIN_BOTTOM;
        }

        $margin_left = PDF_MARGIN_LEFT;
        if( MODULE_PDF_DATASHEET_FONTS_MARGIN_LEFT != '' ) {
          $margin_left = MODULE_PDF_DATASHEET_FONTS_MARGIN_LEFT;
        }

        $margin_right = PDF_MARGIN_RIGHT;
        if( MODULE_PDF_DATASHEET_FONTS_MARGIN_RIGHT != '' ) {
          $margin_right = MODULE_PDF_DATASHEET_FONTS_MARGIN_RIGHT;
        }

        $margin_header = PDF_MARGIN_HEADER;
        if( MODULE_PDF_DATASHEET_FONTS_MARGIN_HEADER != '' ) {
          $margin_header = MODULE_PDF_DATASHEET_FONTS_MARGIN_HEADER;
        }

        $margin_footer = PDF_MARGIN_FOOTER;
        if( MODULE_PDF_DATASHEET_FONTS_MARGIN_FOOTER != '' ) {
          $margin_footer = MODULE_PDF_DATASHEET_FONTS_MARGIN_FOOTER;
        }

        $pdf->SetMargins( $margin_left, $margin_top, $margin_right );
        $pdf->SetHeaderMargin( $margin_header );
        $pdf->SetFooterMargin( $margin_footer );
        $pdf->SetAutoPageBreak( TRUE, $margin_bottom );

        //set image scale factor
        $image_ratio = PDF_IMAGE_SCALE_RATIO;
        if( MODULE_PDF_DATASHEET_FONTS_IMAGE_RATIO != '' ) {
          $image_ratio = MODULE_PDF_DATASHEET_FONTS_IMAGE_RATIO;
        }

        $pdf->setImageScale( $image_ratio );

        // set default font
        $default_font = 'dejavusans';
        if( MODULE_PDF_DATASHEET_FONTS_FONT_NAME != '' ) {
          $default_font = MODULE_PDF_DATASHEET_FONTS_FONT_NAME;
        }

        $default_font_size = 10;
        if( MODULE_PDF_DATASHEET_FONTS_FONT_SIZE != '' ) {
          $default_font_size = ( int )MODULE_PDF_DATASHEET_FONTS_FONT_SIZE;
        }

        $pdf->SetFont( $default_font, '', $default_font_size );

        // set default font subsetting mode to reduce file size
        $subsetting = true;
        if( MODULE_PDF_DATASHEET_FONTS_SUBSETTING != 'True' ) {
          $subsetting = false;
        }

        $pdf->setFontSubsetting( $subsetting );

        // Start the first page
        $pdf->AddPage();
      } // if (basename
    } // function execute

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined( 'MODULE_PDF_DATASHEET_FONTS_STATUS' );
    }

    function install() {
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable the Module', 'MODULE_PDF_DATASHEET_FONTS_STATUS', 'True', 'Set the default fonts and margins for the PDF datasheet? (Note: Required settings.)', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_PDF_DATASHEET_FONTS_SORT_ORDER', '9002', 'Sort order of display. Lowest is displayed first.', '6', '2', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Header Font', 'MODULE_PDF_DATASHEET_FONTS_HEADER_FONT_NAME', 'helvetica', 'Select the font used in the header.', '6', '3', 'tep_cfg_pull_down_fonts(', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Header Font Size', 'MODULE_PDF_DATASHEET_FONTS_HEADER_FONT_SIZE', '10', 'Select the font size used in the header.', '6', '4', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Footer Font', 'MODULE_PDF_DATASHEET_FONTS_FOOTER_FONT_NAME', 'helvetica', 'Select the font used in the footer.', '6', '5', 'tep_cfg_pull_down_fonts(', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Footer Font Size', 'MODULE_PDF_DATASHEET_FONTS_FOOTER_FONT_SIZE', '10', 'Select the font size used in the footer.', '6', '6', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Proportional Font', 'MODULE_PDF_DATASHEET_FONTS_FONT_NAME', 'dejavusans', 'Select the default proportionally spaced font.', '6', '7', 'tep_cfg_pull_down_fonts(', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Proportional Font Size', 'MODULE_PDF_DATASHEET_FONTS_FONT_SIZE', '10', 'Select the default proportionally spaced font size.', '6', '8', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Monospace Font', 'MODULE_PDF_DATASHEET_FONTS_MONOSPACE_FONT_NAME', 'courier', 'Select the default monospaced font.', '6', '9', 'tep_cfg_pull_down_fonts(', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Top Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_TOP', '27', 'Set the top margin in mm.', '6', '10', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Bottom Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_BOTTOM', '25', 'Set the bottom margin in mm.', '6', '11', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Left Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_LEFT', '15', 'Set the left margin in mm.', '6', '12', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Right Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_RIGHT', '15', 'Set the right margin in mm.', '6', '13', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Header Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_HEADER', '5', 'Set the header margin in mm.', '6', '14', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Footer Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_FOOTER', '10', 'Set the footer margin in mm.', '6', '15', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Image Ratio', 'MODULE_PDF_DATASHEET_FONTS_IMAGE_RATIO', '1.25', 'Set the image scale ratio.', '6', '16', now())" );
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Font Subsetting', 'MODULE_PDF_DATASHEET_FONTS_SUBSETTING', 'True', 'Allow font subsetting? (Reduces file size.)', '6', '17', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())" );
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
    	$keys = array();

    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_STATUS';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_SORT_ORDER';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_HEADER_FONT_NAME';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_HEADER_FONT_SIZE';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_FOOTER_FONT_NAME';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_FOOTER_FONT_SIZE';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_FONT_NAME';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_FONT_SIZE';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_MONOSPACE_FONT_NAME';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_MARGIN_TOP';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_MARGIN_BOTTOM';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_MARGIN_LEFT';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_MARGIN_RIGHT';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_MARGIN_HEADER';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_MARGIN_FOOTER';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_IMAGE_RATIO';
    	$keys[] = 'MODULE_PDF_DATASHEET_FONTS_SUBSETTING';

      return $keys;
    }
  }
?>
