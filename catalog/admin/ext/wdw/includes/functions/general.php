<?php
/* -----------------------------------------------------------------------------------------
   $Id: general.php 2016-07-01

   Version: 20160701 WDW-PV7.0
   https://www.webdesign-wedel.de

   Released under the GNU General Public License!
   
   Author: Manfred Wedel
   Copyright (c) 2016 Webdesign Wedel
   -----------------------------------------------------------------------------------------*/

function wdw_ckeditor($name, $languages, $toolsbar, $width, $height, $text) {
	if ( empty ($languages) ) { $languages = 'en'; }
	$ckeditor = new CKEditor($name);
	$ckeditor->basePath	= DIR_WS_CKEDITOR;
	$ckeditor->config['allowedContent'] = true;
	$ckeditor->config['enterMode'] = 'CKEDITOR.ENTER_BR';
  $ckeditor->config['shiftEnterMode'] = 'CKEDITOR.ENTER_P';
  $ckeditor->config['skin'] = 'moonocolor';
  $ckeditor->config['uiColor'] = '#dfeffc';
  $ckeditor->config['width'] = $width;
  $ckeditor->config['height'] = $height;
  $ckeditor->config['language'] = $languages;
  $ckeditor->config['toolbar'] = $toolsbar;
  
  $ckeditor->config['filebrowserBrowseUrl'] = DIR_WS_KCFINDER.'browse.php?opener=ckeditor&type=files';
  $ckeditor->config['filebrowserImageBrowseUrl'] = DIR_WS_KCFINDER.'browse.php?opener=ckeditor&type=images';
  $ckeditor->config['filebrowserFlashBrowseUrl'] = DIR_WS_KCFINDER.'browse.php?opener=ckeditor&type=flash';
  $ckeditor->config['filebrowserUploadUrl'] = DIR_WS_KCFINDER.'upload.php?opener=ckeditor&type=files';
  $ckeditor->config['filebrowserImageUploadUrl'] = DIR_WS_KCFINDER.'upload.php?opener=ckeditor&type=images';
  $ckeditor->config['filebrowserFlashUploadUrl'] = DIR_WS_KCFINDER.'upload.php?opener=ckeditor&type=flash';
  
  if ($name == '') { $ckeditor->config['toolbarStartupExpanded'] = false; }
	$ck_content = $ckeditor->editor($name, $text);
  return $ck_content;
}
