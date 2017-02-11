<?php
/*
  $Id pd_title.php v1.0 20111016 Kymation $
  $Loc: /catalog/includes/modules/google_feeder/ $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class pd_title {
    var $code = 'pd_title';
    var $group = 'pdf_datasheet';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = true;

    function __construct() {
      $this->title = MODULE_PDF_DATASHEET_TITLE_TITLE;
      $this->description = MODULE_PDF_DATASHEET_TITLE_DESCRIPTION;

      if ( defined('MODULE_PDF_DATASHEET_TITLE_STATUS') ) {
        $this->sort_order = MODULE_PDF_DATASHEET_TITLE_SORT_ORDER;
        $this->enabled = (MODULE_PDF_DATASHEET_TITLE_STATUS == 'True');
      }
    }

    function execute() {
      global $PHP_SELF, $pdf, $products_id, $languages_id, $currencies, $current_y;

      if( basename( $PHP_SELF ) == 'pdf_datasheet.php' && isset( $products_id ) && $products_id > 0 ) {
        // Get the product name
        $product_info_query_raw = "
          select
            pd.products_name,
            p.products_price,
            p.products_tax_class_id,
            p.products_model
          from
            " . TABLE_PRODUCTS . " p
            join " . TABLE_PRODUCTS_DESCRIPTION . " pd
              on (pd.products_id = p.products_id)
          where
            pd.products_id = '" . ( int )$products_id . "'
            and pd.language_id = '" . ( int )$languages_id . "'
        ";
        $product_info_query = tep_db_query( $product_info_query_raw );
        $product_info = tep_db_fetch_array( $product_info_query );

        $html = '<table><tr>';
        $html .= '<td><h1>';
        //$html .= $product_info['products_name'];
        $html .= '<a href="' . tep_href_link( 'product_info.php', ($cPath ? 'cPath=' . $cPath . '&' : '') . 'products_id=' . $products_id ) . '">' . $product_info['products_name'] . '</a>';
        
        if( MODULE_PDF_DATASHEET_TITLE_MODEL == 'True' ) {
          $html .= '<br /><span style="font-size:small">[' . $product_info['products_model'] . ']</span>';
        }

        $html .= '</h1></td>';
        
        if( MODULE_PDF_DATASHEET_TITLE_PRICE == 'True' ) {
        	$wdw_vat = ( DISPLAY_PRICE_WITH_TAX == 'true' ) ? TEXT_INCL_VAT : TEXT_EXCL_VAT;
					if ($new_price = tep_get_products_special_price($products_id)) {
    				//Formular --->>>> Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100
    				$OldPrice = $currencies->display_raw($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id']));
    				$NewPrice = $currencies->display_raw($new_price, tep_get_tax_rate($product_info['products_tax_class_id']));
    				$Percent = (($NewPrice - $OldPrice) / $OldPrice) * 100;
    				$PercentRound = round($Percent, TAX_DECIMAL_PLACES);
    				$products_price = '<del>' . $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . '</del> ' . $currencies->display_price($new_price, tep_get_tax_rate($product_info['products_tax_class_id'])) . '<br />' . $PercentRound . '%<br /><span style="font-size: 12px;">' . $wdw_vat . '</span>';
					} else {
						$products_price = $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . '<br /><span style="font-size: 12px;">' . $wdw_vat . '</span>';
					}
          $html .= '<td><h1 align="right">' . $products_price . '</h1><br /></td>';
        }

        $html .= '</tr></table>';

        // Print text using writeHTMLCell()
        $pdf->writeHTMLCell( 0, 0, '', '', $html, 0, 0, 0, true, '', true );
        $current_y = $pdf->GetY();

      } // if (basename
    } // function execute

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined( 'MODULE_PDF_DATASHEET_TITLE_STATUS' );
    }

    function install() {
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable the Module', 'MODULE_PDF_DATASHEET_TITLE_STATUS', 'True', 'Do you want to add the product link to the Google feed? (Note: Required field.)', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_PDF_DATASHEET_TITLE_SORT_ORDER', '9010', 'Sort order of display. Lowest is displayed first.', '6', '2', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Show Model', 'MODULE_PDF_DATASHEET_TITLE_MODEL', 'True', 'Add the model number below the title.', '6', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Show Price', 'MODULE_PDF_DATASHEET_TITLE_PRICE', 'True', 'Add the price to the right of the product name.', '6', '4', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
    	$keys = array();

    	$keys[] = 'MODULE_PDF_DATASHEET_TITLE_STATUS';
    	$keys[] = 'MODULE_PDF_DATASHEET_TITLE_SORT_ORDER';
    	$keys[] = 'MODULE_PDF_DATASHEET_TITLE_MODEL';
    	$keys[] = 'MODULE_PDF_DATASHEET_TITLE_PRICE';

      return $keys;
    }
  }
?>
