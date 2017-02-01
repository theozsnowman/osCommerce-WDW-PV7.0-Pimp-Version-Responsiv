<?php
/*
  $Id: image_viewer.php 2012-08-10 for osCommerce 2.3.2 by Kevin L. Shelton $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2003 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');


  $products_query = tep_db_query("select pd.products_name, p.products_image, p.image_folder from " . TABLE_PRODUCTS . " p left join " . TABLE_PRODUCTS_DESCRIPTION . " pd on p.products_id = pd.products_id where p.products_status = '1' and p.products_id = '" . (int)$HTTP_GET_VARS['pID'] . "' and pd.language_id = '" . (int)$languages_id . "'");
  $products = tep_db_fetch_array($products_query);
  $image_files = array();
  if ($handle = opendir(DIR_FS_CATALOG_IMAGES_ORIG . $products['image_folder'])) {
    while ($file = readdir($handle)) { // build list of image files in product's image directory
      if (in_array(strtolower(substr($file, strrpos($file, '.')+1)), array('gif', 'png', 'jpg', 'jpeg')))
        $image_files[] = $file;
    }
    closedir($handle);
  }
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta name="robots" content="noindex, nofollow" />
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>" />
<title><?php echo HEADING_TITLE . tep_output_string_protected($products['products_name']); ?></title>
<base href="<?php echo HTTP_SERVER . DIR_WS_ADMIN; ?>" />
<link rel="stylesheet" type="text/css" href="stylesheet.css" />
<script type="text/javascript"><!--
function view_image(id) {
<?php
  foreach ($image_files as $key => $file) {
    echo "  document.getElementById('" . $key . "').style.display = 'none';\n";
  }
?>
  document.getElementById(id).style.display = '';
}
//--></script>
</head>
<body>
<?php
  if (isset($HTTP_GET_VARS['image'])) {
    $selected = tep_db_prepare_input($HTTP_GET_VARS['image']);
  } else {
    $selected = $products['products_image'];
  }
  if (!in_array($selected, $image_files)) {
    $selected = $image_files[0];
  }
  echo '<table width="100%"><tr><td class="pageHeading">' . HEADING_TITLE . $products['products_name'] . "\n";
  echo '</td><td class="main" style="text-align: right;"><a href="javascript:window.close()">' . tep_image(DIR_WS_IMAGES . 'cal_close_small.gif') . TEXT_CLOSE . "</a></td></tr>\n";
  echo '<tr><td colspan=2 class="main">' . TEXT_CLICK_ENLARGE . "</td></tr><table>\n";
  echo "<table><tr><td style='vertical-align: top'>\n";
  foreach ($image_files as $key => $file) {
    if (file_exists(DIR_FS_CATALOG_IMAGES_THUMBS . $products['image_folder'] . $file)) {
      $thumb = tep_catalog_image(DIR_WS_CATALOG_IMAGES_THUMBS . $products['image_folder'] . $file, $products['products_name'], SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT);
    } else {
      $thumb = TEXT_MISSING_THUMB;
    }
    echo '<p><a href="javascript:view_image(' . $key . ')">' . $thumb . "</a></p>\n";
  }
  echo "</td><td style='vertical-align: top'>\n";
  foreach ($image_files as $key => $file) {
    echo '<p>' . tep_catalog_image(DIR_WS_CATALOG_IMAGES_ORIG . $products['image_folder'] . $file, $products['products_name'], '', '', 'id="' . $key . '"' . (($file == $selected) ? '' : ' style="display: none"')) . "</p>\n";
  }
?>
</td></tr></table>
</body>
</html>
<?php require('includes/application_bottom.php'); ?>
