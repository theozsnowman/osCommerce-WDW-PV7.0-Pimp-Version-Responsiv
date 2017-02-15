<?php
/*
  $Id: cfg_pdf_datasheet.php 20111014 Kymation $
  $Loc: catalog/admin/includes/modules/cfg_modules/ $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class cfgm_pdf_datasheet {
    var $code = 'pdf_datasheet';
    var $directory;
    var $language_directory = DIR_FS_CATALOG_LANGUAGES;
    var $key = 'MODULE_PDF_DATASHEET_INSTALLED';
    var $title;
    var $template_integration = true;

    function __construct() {
      $this->directory = DIR_FS_CATALOG_MODULES . 'pdf_datasheet/';
      $this->title = MODULE_CFG_MODULE_PDF_DATASHEET_TITLE;
    }
  }
?>
