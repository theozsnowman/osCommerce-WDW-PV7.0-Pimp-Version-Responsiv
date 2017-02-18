<?php
/*
  $Id pd_extra_images.php v1.1 20120831 Kymation $
  $Loc: /catalog/includes/modules/pdf_datasheet/ $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class pd_extra_images {
    var $code = 'pd_extra_images';
    var $group = 'pdf_datasheet';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = true;

    function __construct() {
      $this->title = MODULE_PDF_DATASHEET_EXTRA_IMAGES_TITLE;
      $this->description = MODULE_PDF_DATASHEET_EXTRA_IMAGES_DESCRIPTION;

      if ( defined('MODULE_PDF_DATASHEET_EXTRA_IMAGES_STATUS') ) {
        $this->sort_order = MODULE_PDF_DATASHEET_EXTRA_IMAGES_SORT_ORDER;
        $this->enabled = (MODULE_PDF_DATASHEET_EXTRA_IMAGES_STATUS == 'True');
      }
    }

    function execute() {
      global $PHP_SELF, $pdf, $products_id, $current_y;

      if( basename( $PHP_SELF ) == 'pdf_datasheet.php' && isset( $products_id ) && $products_id > 0 ) {
        // Get the product name
        $product_info_query_raw = "
          select
            image
          from
            " . TABLE_PRODUCTS_IMAGES . "
          where
            products_id = '" . $products_id . "'
            and sort_order >= '" . ( int )MODULE_PDF_DATASHEET_EXTRA_IMAGES_FIRST_IMAGE . "'
            and sort_order <= '" . ( int )MODULE_PDF_DATASHEET_EXTRA_IMAGES_LAST_IMAGE . "'
        ";
        $product_info_query = tep_db_query( $product_info_query_raw );

        $image_number = 0;
        if( tep_db_num_rows( $product_info_query ) > 0 ) {
          while( $product_info = tep_db_fetch_array( $product_info_query ) ) {

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

          //// Get the position and size of the image
          // Calculate the image aspect ratio
          if ($image_size[1] == 0) {
            $aspect_ratio = 1;
          } else {
            $aspect_ratio = $image_size[0] / $image_size[1];
          }

          // Image width is entered in the config settings for this module
          //   then converted from pixels to user units (mm)
          $image_width = $pdf->pixelsToUnits( MODULE_PDF_DATASHEET_EXTRA_IMAGES_IMAGE_WIDTH );

          // Image height is calculated from the width and the calculated aspect ratio
          $image_height = $image_width / $aspect_ratio;

          // calculate the top of the image
          $image_top = $current_y + ( float )MODULE_PDF_DATASHEET_EXTRA_IMAGES_IMAGE_TOP_PADDING;

          // calculate the left edge of the image
          $image_offset = PDF_MARGIN_LEFT + ($image_width + 2) * $image_number; // 2 mm padding for each image

          // print the product image
          $pdf->Image( 'images/product_thumbnails/' . $product_info['image'], $image_offset, $image_top, $image_width, '', $image_type, '', '', true, 300, '', false, false, 0, false );
          $image_number++;
          }

          // Set the y coordinate of the bottom of the images
          $current_y = $image_top + $image_height + 4;
        }
      } // if (basename
    } // function execute

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined( 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_STATUS' );
    }

    function install() {
      include_once( 'includes/classes/' . 'language.php' );
      $bm_banner_language_class = new language;
      $languages = $bm_banner_language_class->catalog_languages;

      foreach( $languages as $this_language ) {
        $this->languages_array[$this_language['id']] = $this_language['directory'];
      }

      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable the Module', 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_STATUS', 'True', 'Do you want to add the extra images to the PDF datasheet?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_SORT_ORDER', '9060', 'Sort order of display. Lowest is displayed first.', '6', '2', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('First Image', 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_FIRST_IMAGE', '2', 'The ID of the first extra image to show.', '6', '3', 'tep_cfg_select_option(array(\'1\', \'2\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Last Image', 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_LAST_IMAGE', '4', 'The ID of the last extra image to show.', '6', '4', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Image Width', 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_IMAGE_WIDTH', '100', 'Width of each of the images im pixels.', '6', '5', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Image Top Padding', 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_IMAGE_TOP_PADDING', '4', 'Additional space above the images in mm.', '6', '6', now())");
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

    	$keys[] = 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_STATUS';
    	$keys[] = 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_SORT_ORDER';
    	$keys[] = 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_FIRST_IMAGE';
    	$keys[] = 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_LAST_IMAGE';
    	$keys[] = 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_IMAGE_WIDTH';
    	$keys[] = 'MODULE_PDF_DATASHEET_EXTRA_IMAGES_IMAGE_TOP_PADDING';

      return $keys;
    }
  }
?>
