<?php
/*
 $Id pd_features.php v1.1 20120831 Kymation $
 $Loc: /catalog/includes/modules/pdf_datasheet/ $

 osCommerce, Open Source E-Commerce Solutions
 http://www.oscommerce.com

 Copyright (c) 2011 osCommerce

 Released under the GNU General Public License
 */

	class pd_features {
		var $code = 'pd_features';
		var $group = 'pdf_datasheet';
		var $title;
		var $description;
		var $sort_order;
		var $enabled = true;

		function __construct() {
			$this->title = MODULE_PDF_DATASHEET_FEATURES_TITLE;
			$this->description = MODULE_PDF_DATASHEET_FEATURES_DESCRIPTION;

			if ( defined('MODULE_PDF_DATASHEET_FEATURES_STATUS') ) {
				$this->sort_order = MODULE_PDF_DATASHEET_FEATURES_SORT_ORDER;
				$this->enabled = (MODULE_PDF_DATASHEET_FEATURES_STATUS == 'True');
			}
		}

		function execute() {
			global $PHP_SELF, $pdf, $products_id, $languages_id, $language, $current_y;

			if( basename( $PHP_SELF ) == 'pdf_datasheet.php' && isset( $products_id ) && $products_id > 0 ) {
				//$describe_query_raw = "describe " . TABLE_PRODUCTS_DESCRIPTION;
				print $describe_query_raw . "<br>\n";
				$describe_query = tep_db_query ($describe_query_raw);

				$specification_tabs_exist = false;
				while ($describe_array = tep_db_fetch_array ($describe_query) ) {
					if( $row['Field'] == 'products_tab_1' ) {
						$specification_tabs_exist = true;
					}
				}

				if( $specification_tabs_exist == false ) {
					// Product Specifications is not installed, so abort
					$pdf->ln();
					$pdf->MultiCell( 0, 1, 'Product Specifications is not installed!', 0, 'L', false, 1, '', $current_y, true, 0, false, true, 0, 'T', false );
					$pdf->ln();
					
				} else {
					// Get the features list
					$product_info_query_raw = "
          select
            products_tab_" . MODULE_PDF_DATASHEET_TAB_NUMBER . "
          from 
          " . TABLE_PRODUCTS_DESCRIPTION . "
          where
            products_id = '" . $products_id . "'
            and language_id = '" . ( int )$languages_id . "'
        ";
					$product_info_query = tep_db_query( $product_info_query_raw );

					if( tep_db_num_rows( $product_info_query ) > 0 ) {
						$product_info = tep_db_fetch_array( $product_info_query );

						if( $product_info['products_tab_' . MODULE_PDF_DATASHEET_TAB_NUMBER] != '' ) {
							// Add vertical space above the text
							if( MODULE_PDF_DATASHEET_FEATURES_PADDING > 0 ) {
								$pdf->Cell( 0, MODULE_PDF_DATASHEET_FEATURES_PADDING, '', 0, 1, '', false, '', 0, true, 'T', 'M' );
								$pdf->ln();
							}

							// Start the HTML for the Features
							$html = '';

							// Add the heading
							if( constant( 'MODULE_PDF_DATASHEET_FEATURES_HEADING_' . strtoupper( $language ) ) != '' ) {
								$html .= constant( 'MODULE_PDF_DATASHEET_FEATURES_HEADING_' . strtoupper( $language ) );
							}

							$html .= '<ul>';

							$features = stripslashes ($product_info['products_tab_' . MODULE_PDF_DATASHEET_TAB_NUMBER]);
							$desc = explode ("\n", $features);

							foreach ($desc as $desc_row) {
								if (strlen ($desc_row) > 0) {
									$html .= '<li>' . $desc_row . '</li>';
								}
							} // foreach ($desc

							$html .= '</ul>';

							// Get the page width
							$page_width = $pdf->getPageWidth( );

							// Calculate the space available to use
							// NOTE: You'd think this would need both margins, but it works out with only one.
							$content_width = $page_width - PDF_MARGIN_LEFT;

							// write html text
							$current_y = $pdf->GetY();
							$pdf->writeHTMLCell( $content_width, 0, PDF_MARGIN_LEFT, $current_y, $html, $border=0, $ln=0, $fill=false, $reseth=true, $align='', $autopadding=true);
							$pdf->ln();

							// Set the y coordinate of the bottom of the text
							$current_y = $pdf->GetY();
						} // if( $product_info['products_tab
					} // if( tep_db_num_rows( $product_info_query
				} // if( $specification_tabs_exist ... else
			} // if (basename
		} // function execute

		function isEnabled() {
			return $this->enabled;
		}

		function check() {
			return defined( 'MODULE_PDF_DATASHEET_FEATURES_STATUS' );
		}

		function install() {
			include_once( 'includes/classes/' . 'language.php' );
			$bm_banner_language_class = new language;
			$languages = $bm_banner_language_class->catalog_languages;

			foreach( $languages as $this_language ) {
				$this->languages_array[$this_language['id']] = $this_language['directory'];
			}

			tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable the Module', 'MODULE_PDF_DATASHEET_FEATURES_STATUS', 'True', 'Do you want to add the product description/image to the PDF datasheet?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
			tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_PDF_DATASHEET_FEATURES_SORT_ORDER', '9050', 'Sort order of display. Lowest is displayed first.', '6', '2', now())");
			tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Padding', 'MODULE_PDF_DATASHEET_FEATURES_PADDING', '2', 'Add space above the heading/text.', '6', '3', now())");
			tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tab Number', 'MODULE_PDF_DATASHEET_TAB_NUMBER', '1', 'Number of the tab that contains the features list.', '6', '4', now())");

			foreach( $this->languages_array as $language_name ) {
				tep_db_query( "insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ( '" . ucwords( $language_name ) . " Heading', 'MODULE_PDF_DATASHEET_FEATURES_HEADING_" . strtoupper( $language_name ) . "', '<strong>Features</strong>', 'Add a section heading in " . $language_name . " above the features list in the PDF', '6', '14', now())" );
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

			$keys[] = 'MODULE_PDF_DATASHEET_FEATURES_STATUS';
			$keys[] = 'MODULE_PDF_DATASHEET_FEATURES_SORT_ORDER';
			$keys[] = 'MODULE_PDF_DATASHEET_FEATURES_PADDING';
			$keys[] = 'MODULE_PDF_DATASHEET_TAB_NUMBER';

			foreach( $this->languages_array as $language_name ) {
				$keys[] = 'MODULE_PDF_DATASHEET_FEATURES_HEADING_' . strtoupper( $language_name );
			}

			return $keys;
		}
	}

?>