<?php
/*
  $Id pd_description.php v1.0 20111016 Kymation $
  $Loc: /catalog/includes/modules/pdf_datasheet/ $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class pd_description {
    var $code = 'pd_description';
    var $group = 'pdf_datasheet';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = true;

    function __construct() {
      $this->title = MODULE_PDF_DATASHEET_DESCRIPTION_TITLE;
      $this->description = MODULE_PDF_DATASHEET_DESCRIPTION_DESCRIPTION;

      if ( defined('MODULE_PDF_DATASHEET_DESCRIPTION_STATUS') ) {
        $this->sort_order = MODULE_PDF_DATASHEET_DESCRIPTION_SORT_ORDER;
        $this->enabled = (MODULE_PDF_DATASHEET_DESCRIPTION_STATUS == 'True');
      }
    }

    function execute() {
      global $PHP_SELF, $pdf, $products_id, $languages_id, $currencies, $current_y;

      if( basename( $PHP_SELF ) == 'pdf_datasheet.php' && isset( $products_id ) && $products_id > 0 ) {
        // Get the product name
        $product_info_query_raw = "
          select
            pd.products_description,
            pi.image
          from
            " . TABLE_PRODUCTS_DESCRIPTION . " pd
            left join " . TABLE_PRODUCTS_IMAGES . " pi
              on (pi.products_id = pd.products_id
                  and pi.sort_order = '1')
          where
            pd.products_id = '" . $products_id . "'
            and pd.language_id = '" . ( int )$languages_id . "'
        ";
        $product_info_query = tep_db_query( $product_info_query_raw );
        $product_info = tep_db_fetch_array( $product_info_query );

        // Get the image information
        $image_size = getimagesize( 'images/product_thumbnails/' . $product_info['image'] );

        //Get the type of this image
        switch( $image_size[2] ) {
          case 1 :
            // image is 'gif'
            $image_type = 'GIF';
            break;

          case 2 :
            //image is 'jpg'
            $image_type = 'JPG';
            break;

          case 3 :
          default:
            //image is 'png'
            $image_type = 'PNG';
            break;
        } // switch

        //// Get the position and size of the image and image mask (page region)
        // Calculate the image aspect ratio
        if ($image_size[1] == 0) {
          $aspect_ratio = 1;
        } else {
          $aspect_ratio = $image_size[0] / $image_size[1];
        }

        // Image width is entered in the config settings for this module
        //   then converted from pixels to user units (mm)
        $image_width = $pdf->pixelsToUnits( MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_WIDTH );

        // Image height is calculated from the width and the calculated aspect ratio
        $image_height = $image_width / $aspect_ratio;

        // Get the page width
			  $page_width = $pdf->getPageWidth( );

			  // Get the page height
			  $page_height = $pdf->getPageHeight( );

			  // Calculate the space available to use
			  // NOTE: You'd think this would need both margins, but it works out with only one.
        $content_width = $page_width - PDF_MARGIN_LEFT;

        // Image on the right -- calculate the distance from the left margin to the image
        $image_offset = $content_width - $image_width;

        // Image on the left -- calculate the distance from the left margin to the text
        $text_offset = $image_width + MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_PADDING;

        // Calculate the width available for text
        $text_width = $content_width - $image_width - MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_PADDING;
        $exclude = $text_width;

        // Set the side of the exclusion zone (blank area to contain the iamge)
        $side = 'R';

        // Set the top of the image/text space
        $top_level = $current_y;

        // calculate the top of the image
        $image_top = $top_level + MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_PADDING;

        // Calculate the bottom of the image / top of text wrap space
        $region_bottom = $image_top + $image_height + MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_PADDING;

        // The image offset only needs to happen if the image is on the right
        if( MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_LOCATION == 'left' ) {
          $image_offset = PDF_MARGIN_LEFT;
          $exclude = $text_offset + PDF_MARGIN_LEFT;
          $side = 'L';
        }

      	// Add vertical space above the text
        if( MODULE_PDF_DATASHEET_DESCRIPTION_PADDING > 0 ) {
          $pdf->ln( MODULE_PDF_DATASHEET_DESCRIPTION_PADDING );
          $current_y = $pdf->GetY();
        }

        // Show the image and set a page region to block other content in that area -- if selected
        if ( MODULE_PDF_DATASHEET_DESCRIPTION_SHOW_IMAGE == 'True' ) {
          // print the large product image on the left or right side
          $pdf->Image( DIR_WS_IMAGES_THUMBS . $product_info['image'], $image_offset, $current_y, $image_width, '', $image_type, '', '', true, 300, '', false, false, 0, false );

          // Calculate a noprint region to keep text out of the image
          $regions = array( array( 'page' => '', 'xt' => $exclude, 'yt' => $current_y, 'xb' => $exclude, 'yb' => $region_bottom, 'side' => $side ) );

          // set page region
          $pdf->setPageRegions( $regions );
        }

        // The product description field can contain HTML
        $html = stripslashes( stripslashes( $product_info['products_description'] ) );

        // write html text
//        $pdf->writeHTML( $html, true, false, false, false, '' );
        $current_y = $pdf->GetY();
        $pdf->writeHTMLCell( $content_width, 0, PDF_MARGIN_LEFT, $current_y, $html, $border=0, $ln=0, $fill=false, $reseth=true, $align='', $autopadding=true);

        // Set the y coordinate of the bottom of the text/image
        $current_y = $pdf->GetY();
        $image_based_y = $top_level + $image_height + 2 * MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_PADDING;
        if( $image_based_y > $current_y && MODULE_PDF_DATASHEET_DESCRIPTION_SHOW_IMAGE == 'True' ) {
          $current_y = $image_based_y;
        }
        $pdf->ln();

      } // if (basename
    } // function execute

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined( 'MODULE_PDF_DATASHEET_DESCRIPTION_STATUS' );
    }

    function install() {
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable the Module', 'MODULE_PDF_DATASHEET_DESCRIPTION_STATUS', 'True', 'Do you want to add the product description/image to the PDF datasheet?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_PDF_DATASHEET_DESCRIPTION_SORT_ORDER', '9050', 'Sort order of display. Lowest is displayed first.', '6', '2', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Show Image', 'MODULE_PDF_DATASHEET_DESCRIPTION_SHOW_IMAGE', 'True', 'Show the image next to the description.', '6', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Image Width', 'MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_WIDTH', '300', 'Width of the image im pixels.', '6', '4', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Image Location', 'MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_LOCATION', 'right', 'Locate the image on the left or right side of the page.', '6', '5', 'tep_cfg_select_option(array(\'left\', \'right\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Image Padding', 'MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_PADDING', '2', 'White space around the image in user units.', '6', '6', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Top Padding', 'MODULE_PDF_DATASHEET_DESCRIPTION_PADDING', '2', 'Add space above the text/image in user units.', '6', '7', now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
    	$keys = array();

    	$keys[] = 'MODULE_PDF_DATASHEET_DESCRIPTION_STATUS';
    	$keys[] = 'MODULE_PDF_DATASHEET_DESCRIPTION_SORT_ORDER';
    	$keys[] = 'MODULE_PDF_DATASHEET_DESCRIPTION_SHOW_IMAGE';
    	$keys[] = 'MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_WIDTH';
    	$keys[] = 'MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_LOCATION';
    	$keys[] = 'MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_PADDING';
    	$keys[] = 'MODULE_PDF_DATASHEET_DESCRIPTION_PADDING';

      return $keys;
    }
  }
?>