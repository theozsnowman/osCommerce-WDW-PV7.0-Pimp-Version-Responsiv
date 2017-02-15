<?php
/*
  $Id pd_image_price.php v1.0 20111016 Kymation $
  $Loc: /catalog/includes/modules/pdf_datasheet/ $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class pd_image_price {
    var $code = 'pd_image_price';
    var $group = 'pdf_datasheet';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = true;

    function __construct() {
      $this->title = MODULE_PDF_DATASHEET_IMAGE_PRICE_TITLE;
      $this->description = MODULE_PDF_DATASHEET_IMAGE_PRICE_DESCRIPTION;

      if ( defined('MODULE_PDF_DATASHEET_IMAGE_PRICE_STATUS') ) {
        $this->sort_order = MODULE_PDF_DATASHEET_IMAGE_PRICE_SORT_ORDER;
        $this->enabled = (MODULE_PDF_DATASHEET_IMAGE_PRICE_STATUS == 'True');
      }
    }

    function execute() {
      global $PHP_SELF, $pdf, $products_id, $languages_id, $language, $currencies, $current_y, $cPath;

      if( basename( $PHP_SELF ) == 'pdf_datasheet.php' && isset( $products_id ) && $products_id > 0 ) {
      	// Check whether the list price column is available
       	$description_query_raw =  "
          show columns from
            " . TABLE_PRODUCTS . "
          like '%price%'
        ";
      	$description_query = tep_db_query( $description_query_raw );

        $columns = '';
        while( $description = tep_db_fetch_array( $description_query ) ) {
          if( $description['Field'] == 'products_list_price' ) {
            $columns = ', p.products_list_price';
          }
        }

        // Get the product prices and the image
        $product_info_query_raw = "
          select
            p.products_price,
            p.products_tax_class_id,
            pi.image
            " . $columns . "
          from
            " . TABLE_PRODUCTS . " p
            left join " . TABLE_PRODUCTS_IMAGES . " pi
              on (pi.products_id = p.products_id
                  and pi.sort_order = '1')
          where
            p.products_id = '" . $products_id . "'
        ";
        $product_info_query = tep_db_query( $product_info_query_raw );
        $product_info = tep_db_fetch_array( $product_info_query );

//        $price_in_cart_only = false;  // Optional Price in Cart mod, not stock osCommerce
//        if( $product_info['price_in_cart_only'] == 1 ) {
//          $price_in_cart_only = true;
//        }

//        $has_list_price = false;
//        $list_price = '';
//        if( $columns != '' && $product_info['products_list_price'] > 0) {
//          $list_price = $currencies->display_price ($product_info['products_list_price'], tep_get_tax_rate ($product_info['products_tax_class_id']) );
//          $has_list_price = true;
//        }

        $has_products_price = false;
        $products_price = '';
        if( $product_info['products_price'] > 0 ) {
          $has_products_price = true;
          $products_price = $currencies->display_price ($product_info['products_price'], tep_get_tax_rate ($product_info['products_tax_class_id']) );
        }

        // Check for quantity discounts
        $has_discount_price = false;
       	$tables_query_raw =  "
          show tables
          like '%quantity_discounts'
        ";
      	$tables_query = tep_db_query( $tables_query_raw );

        if( tep_db_num_rows( $tables_query ) > 0 ) {
          $discount_price = array();
          $discount_price_query_raw = "
            select
              pd.products_price,
              dd.discount
            from
              " . TABLE_PRODUCTS_DISCOUNT . " pd
              join " . TABLE_DISCOUNTS . " dd
                on dd.discounts_id = pd.discounts_id
            where
              pd.products_id = '" . ( int )$products_id . "'
            order by
              dd.sort_order
          ";
          // print $discount_price_query_raw . "<br>\n";
          $discount_price_query = tep_db_query( $discount_price_query_raw );

          if( tep_db_num_rows( $discount_price_query ) > 0 ) {
            $has_discount_price = true;
            while( $discount_price_array = tep_db_fetch_array( $discount_price_query ) ) {
              $discount_price[] = array(
                'price' => $currencies->display_price ($discount_price_array['products_price'], tep_get_tax_rate ($product_info['products_tax_class_id']) ),
                'discount' => sprintf(TEXT_DISCOUNT_PRICE, $discount_price_array['discount'])
              );
            } // while( $discount_price_array
          } // if( tep_db_num_rows( $discount_price_query
        } // if( tep_db_num_rows( $description_query

        $has_sale_price = false;
        $new_price = tep_get_products_special_price( $products_id );
        if ($new_price > 0) {
          $has_sale_price = true;
          $sale_price = $currencies->display_price ($new_price, tep_get_tax_rate ($product_info['products_tax_class_id']) );
        }

        // List price mod, not stock osCommerce
//        $max_price = 0;
//        if( $has_list_price == true ) {
//          $max_price = $product_info['products_list_price'];
//        } elseif( $has_products_price == true ) {
          $max_price = $product_info['products_price'];
//        }

        $min_price = 0;
        if( $has_sale_price == true ) {
          $min_price = $new_price;
        } elseif( $has_products_price == true ) {
          $min_price = $product_info['products_price'];
        }

        $has_you_save = false;
        $you_save = 0;
        if( $max_price > 0 && $min_price > 0 && $max_price > $min_price ) {
          $has_you_save = true;
          $you_save = $max_price - $min_price;
          $you_save = $currencies->display_price ($you_save, tep_get_tax_rate ($product_info['products_tax_class_id']) );
        }

        // Replace image with a placeholder if no image is specified
        if( $product_info['image'] == '' ) {
          $product_info['image'] = 'pixel_trans.gif';
        }

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
        $image_width = $pdf->pixelsToUnits( MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_WIDTH );

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
        $text_offset = $image_width + MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_PADDING;

        // Calculate the width available for text
        $text_width = $content_width - $image_width - MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_PADDING;
        $exclude = $text_width;

        // Set the side of the exclusion zone (blank area to contain the iamge)
        $side = 'R';

        // Set the top of the image/text space
        $top_level = $current_y;

        // calculate the top of the image
        $image_top = $top_level + MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_PADDING;

        // Calculate the bottom of the image / top of text wrap space
        $region_bottom = $image_top + $image_height + MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_PADDING;

        // The image offset only needs to happen if the image is on the right
        if( MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_LOCATION == 'left' ) {
          $image_offset = PDF_MARGIN_LEFT;
          $exclude = $text_offset + PDF_MARGIN_LEFT;
          $side = 'L';
        }

        // Show the image and set a page region to block other content in that area -- if selected
        if ( MODULE_PDF_DATASHEET_IMAGE_PRICE_SHOW_IMAGE == 'True' ) {
          // print the large product image on the left or right side
          $pdf->Image( 'images/product_thumbnails/' . $product_info['image'], $image_offset, $current_y, $image_width, '', $image_type, '', '', true, 300, '', false, false, 0, false );

          // Calculate a noprint region to keep text out of the image
          $regions = array( array( 'page' => '', 'xt' => $exclude, 'yt' => $current_y, 'xb' => $exclude, 'yb' => $region_bottom, 'side' => $side ) );

          // set page region
          $pdf->setPageRegions( $regions );
        }

        // The product prices

        $text_top = $pdf->GetY();
//        if( $price_in_cart_only == true ) {
//          $text = constant( 'MODULE_PDF_DATASHEET_IMAGE_PRICE_TEXT_' . strtoupper( $language ) );
//          $pdf->Cell( $text_width, 0, $text, 0, 1, '', false, '', 0, false, 'T', 'M');

//        } else {
//          if ($has_list_price == true || $has_products_price == true || $has_sale_price == true) {
//            if( $has_list_price == true ) {
//            	$list_text = str_replace( '&nbsp;', ' ', TEXT_LIST_PRICE );
//              $pdf->Cell( 3, 0, ' ', 0, 0, '', false, '', 0, false, 'T', 'M');
//              $pdf->Cell( 22, 0, $list_text, 0, 0, '', false, '', 1, false, 'T', 'M');
//              $pdf->Cell( 22, 0, $list_price, 0, 1, 'R', false, '', 1, false, 'T', 'M');
//            }

            if( $has_you_save == true ) {
          	  $save_text = str_replace( '&nbsp;', ' ', TEXT_YOU_SAVE );
              $normal_font_size = $pdf->getFontSizePt();
              $pdf->SetFontSize( 8, true );
              $pdf->Cell( 3, 0, ' ', 0, 0, '', false, '', 0, false, 'T', 'M');
              $pdf->Cell( 22, 0, $save_text, 0, 0, '', false, '', 0, false, 'T', 'M');
              $pdf->Cell( 22, 0, $you_save, 0, 1, 'R', false, '', 0, false, 'T', 'M');
              $pdf->SetFontSize( $normal_font_size, true );
            }

            if( $has_products_price = true && $has_sale_price == false ) {
            	$your_text = str_replace( '&nbsp;', ' ', TEXT_YOUR_PRICE );
              $pdf->SetFont( '', 'B', $size=0, $fontfile='', $subset='default', $out=true);
              $pdf->Cell( 3, 0, ' ', 0, 0, '', false, '', 0, false, 'T', 'M');
              $pdf->Cell( 22, 6, $your_text, 0, 0, '', false, '', 1, false, 'T', 'M');
              $pdf->Cell( 22, 6, $products_price, 'T', 1, 'R', false, '', 1, false, 'T', 'M');
              $pdf->SetFont( '', '', $size=0, $fontfile='', $subset='default', $out=true);
            }

            if( $has_sale_price == true ) {
            	$sale_text = str_replace( '&nbsp;', ' ', TEXT_SALE_PRICE );
              $pdf->SetFont( '', 'B', $size=0, $fontfile='', $subset='default', $out=true);
              $sale_text_color = array( 189, 27, 33 );
              $pdf->SetTextColorArray( $sale_text_color );

              $pdf->Cell( 3, 0, ' ', 0, 0, '', false, '', 0, false, 'T', 'M');
              $pdf->Cell( 22, 6, $sale_text, 0, 0, '', false, '', 1, false, 'T', 'M');
              $pdf->Cell( 22, 6, $sale_price, 'T', 1, 'R', false, '', 1, false, 'T', 'M');
              $pdf->SetFont( '', '', $size=0, $fontfile='', $subset='default', $out=true);
              $normal_text_color = array( 0, 0, 0 );
              $pdf->SetTextColorArray( $normal_text_color );
            }

//            if( $has_discount_price == true ) {
//              foreach( $discount_price as $quantity_discount ) {
//              	if( $quantity_discount['discount'] != '' && $quantity_discount['price'] != '' ) {
//                  $pdf->Cell( 3, 0, ' ', 0, 0, '', false, '', 0, false, 'T', 'M');
//                  $pdf->Cell( 22, 0, $quantity_discount['discount'], 0, 0, '', false, '', 1, false, 'T', 'M');
//                  $pdf->Cell( 22, 0, $quantity_discount['price'], 0, 1, 'R', false, '', 1, false, 'T', 'M');
//              	}
//              }
//            }

//          } else {
//            $image_size = getimagesize( 'images/product_thumbnails/' . 'button_call_for_price.gif' );
//            $pdf->Image( 'images/product_thumbnails/' . 'button_call_for_price.gif', $text_offset, $current_y, $image_size[0], $image_size[1], $image_size[2], '', '', true, 300, '', false, false, 0, false );

//          }
//        }

        // Print the options list
        $options_array = tep_get_products_attributes( $products_id, ( int )$languages_id, $product_info['products_tax_class_id'] );
        if( $options_array != false && is_array( $options_array ) && count( $options_array ) > 0 ) {
          $pdf->Cell( 0, 0, ' ', 0, 1, '', false, '', 1, false, 'T', 'M');
          foreach( $options_array as $options ) {
            if( $options['name'] != 'Condition' ) {
              $pdf->SetFont( '', 'B' );
              $pdf->Cell( 3, 0, ' ', 0, 0, '', false, '', 0, false, 'T', 'M');
              $pdf->Cell( 44, 0, $options['name'] . ':', 0, 1, '', false, '', 1, false, 'T', 'M');
              $pdf->SetFont( '', '' );
              foreach( $options['values'] as $option_value ) {
                  $pdf->Cell( 6, 0, ' ', 0, 0, '', false, '', 0, false, 'T', 'M');
                  $pdf->Cell( 41, 0, $option_value['text'], 0, 1, '', false, '', 1, false, 'T', 'M');
              }
            }
          }
        }

        $text_bottom = $pdf->GetY();


        // Set the y coordinate of the bottom of the text/image
        $current_y = $pdf->GetY();
        $image_based_y = $top_level + $image_height + 2 * MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_PADDING;
        if( $image_based_y > $current_y && MODULE_PDF_DATASHEET_IMAGE_PRICE_SHOW_IMAGE == 'True' ) {
          $current_y = $image_based_y;
        }

        $fill_height = $image_height + (3 * MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_PADDING) - ( $text_bottom - $text_top );

        $pdf->Cell( 3, $fill_height, '', 0, 0, '', false, '', 0, false, 'T', 'M');

      } // if (basename
    } // function execute

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined( 'MODULE_PDF_DATASHEET_IMAGE_PRICE_STATUS' );
    }

    function install() {
//      include_once( 'includes/classes/' . 'language.php' );
//      $bm_banner_language_class = new language;
//      $languages = $bm_banner_language_class->catalog_languages;

//      foreach( $languages as $this_language ) {
//        $this->languages_array[$this_language['id']] = $this_language['directory'];
//      }

      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable the Module', 'MODULE_PDF_DATASHEET_IMAGE_PRICE_STATUS', 'True', 'Do you want to add the product description/image to the PDF datasheet?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_PDF_DATASHEET_IMAGE_PRICE_SORT_ORDER', '9025', 'Sort order of display. Lowest is displayed first.', '6', '2', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Show Image', 'MODULE_PDF_DATASHEET_IMAGE_PRICE_SHOW_IMAGE', 'True', 'Show the image next to the description.', '6', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Image Width', 'MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_WIDTH', '300', 'Width of the image im pixels.', '6', '4', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Image Location', 'MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_LOCATION', 'right', 'Locate the image on the left or right side of the page.', '6', '5', 'tep_cfg_select_option(array(\'left\', \'right\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Image Padding', 'MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_PADDING', '2', 'White space around the image in user units.', '6', '4', now())");

//    	foreach( $this->languages_array as $language_name ) {
//        tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ( '" . ucwords( $language_name ) . " Price in Cart Text', 'MODULE_PDF_DATASHEET_IMAGE_PRICE_TEXT_" . strtoupper( $language_name ) . "', '', 'Add text in " . $language_name . " to replace the price when Price in Cart is set.', '6', '14', now())" );
//      }
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

    	$keys[] = 'MODULE_PDF_DATASHEET_IMAGE_PRICE_STATUS';
    	$keys[] = 'MODULE_PDF_DATASHEET_IMAGE_PRICE_SORT_ORDER';
    	$keys[] = 'MODULE_PDF_DATASHEET_IMAGE_PRICE_SHOW_IMAGE';
    	$keys[] = 'MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_WIDTH';
    	$keys[] = 'MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_LOCATION';
    	$keys[] = 'MODULE_PDF_DATASHEET_IMAGE_PRICE_IMAGE_PADDING';

//    	foreach( $this->languages_array as $language_name ) {
//    	  $keys[] = 'MODULE_PDF_DATASHEET_IMAGE_PRICE_TEXT_' . strtoupper( $language_name );
//    	}

      return $keys;
    }
  }


////
// Get the attributes info
if( !function_exists( 'tep_get_products_attributes' ) ) {
  function tep_get_products_attributes ($products_id, $languages_id, $tax_class_id) {
    global $currencies, $current_categories_id;
    $products_attributes_query_raw = "
      select
        count(*) as total
      from
        " . TABLE_PRODUCTS_OPTIONS . " popt,
        " . TABLE_PRODUCTS_ATTRIBUTES . " patrib
      where
        patrib.products_id='" . (int) $products_id . "'
        and patrib.options_id = popt.products_options_id
        and popt.language_id = '" . (int) $languages_id . "'
    ";
    $products_attributes_query = tep_db_query ($products_attributes_query_raw);
    $products_attributes = tep_db_fetch_array ($products_attributes_query);
    if ($products_attributes['total'] > 0) {
      // There are options
      $output_array = array();
      // Options Types added
      $products_options_name_query_raw =  "
        select distinct
          popt.products_options_id,
          popt.products_options_name
        from
          " . TABLE_PRODUCTS_OPTIONS . " popt
          join " . TABLE_PRODUCTS_ATTRIBUTES . " patrib
            on (patrib.options_id = popt.products_options_id)
        where
          patrib.products_id='" . (int) $products_id . "'
          and popt.language_id = '" . (int) $languages_id . "'
        order by
          popt.products_options_name
      ";
/*          popt.products_options_sort_order,
          popt.products_options_type,
          popt.products_options_length,
          popt.products_options_comment  */
      $products_options_name_query = tep_db_query ($products_options_name_query_raw);
      while ($products_options_name = tep_db_fetch_array ($products_options_name_query) ) {
        // Step through the options and build an array of values
        $products_options_array = array();
        $products_options_query_raw = "
          select
            pov.products_options_values_id,
            pov.products_options_values_name,
            pa.options_values_price,
            pa.price_prefix
          from
            " . TABLE_PRODUCTS_ATTRIBUTES . " pa
            join " . TABLE_PRODUCTS_OPTIONS_VALUES . " pov
              on pov.products_options_values_id = pa.options_values_id
          where
            pa.products_id = '" . (int) $products_id . "'
            and pa.options_id = '" . (int) $products_options_name['products_options_id'] . "'
            and pov.language_id = '" . (int) $languages_id . "'
          order by
            pov.sort_order,
            pov.products_options_values_name
        ";
        $products_options_query = tep_db_query ($products_options_query_raw);

        while ($products_options = tep_db_fetch_array ($products_options_query) ) {
          $options_text = $products_options['products_options_values_name'];
          // Add the price to the text if not zero
          if ($products_options['options_values_price'] != '0') {
            $options_text .= ' ' . $products_options['price_prefix'] . $currencies->display_price ($products_options['options_values_price'], tep_get_tax_rate ($tax_class_id) );

            $options_text = str_replace( '.00', '', $options_text );
          } // if ($products_options
          
          // Build the array of values to display
          $products_options_array[] = array (
            'id' => $products_options['products_options_values_id'],
            'text' => $options_text
          );
        } // while ($products_options

        // Options Types added
        $output_array[] = array (
          'id' => $products_options_name['products_options_id'],
          'name' => $products_options_name['products_options_name'],
/*          'type' => $products_options_name['products_options_type'],
          'length' => $products_options_name['products_options_length'],  */
           'values' => $products_options_array
        );
      } // while ($products_options_name

      return $output_array;
    } else {
      return false;
    } // if ($products_attributes ... else ....
  } // function tep_get_products_attributes
}
  
?>