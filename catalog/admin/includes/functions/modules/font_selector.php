<?php
/*
  $Id: font_selector.php 20111021 Kymation $
  $Loc: catalog/admin/includes/functions/modules/ $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/


  ////
  // Generate a pulldown menu of the available jquery icons
  //   Requires a text file containing a list of the icons, one per line
  //   at: admin/includes/functions/modules/boxes/icons.txt
  if( !function_exists( 'tep_cfg_pull_down_fonts' ) ) {
    function tep_cfg_pull_down_fonts( $font, $key = '' ) {
      $fonts_array = array ();

      $file = DIR_FS_DOCUMENT_ROOT . 'ext/tcpdf/fonts/font_list.txt';
      if (file_exists($file) && is_file($file)) {
        $name = (($key) ? 'configuration[' . $key . ']' : 'configuration_value' );
        $file_contents = @file( $file );

        foreach( $file_contents as $font_name ) {
          $font_name = trim( $font_name );

          if( strlen( $font_name ) > 0 ) {
            $fonts_array[] = array (
              'id' => $font_name,
              'text' => $font_name
            );

          } // if (strlen
        } // foreach ($file_contents
      } // if( file_exists

      return tep_draw_pull_down_menu( $name, $fonts_array, $font );
    } // function tep_cfg_pull_down_icon
  } // if (!function_exists

?>