<?php
/*
  $Id: image_protect_setup.php version 2 by Kevin L. Shelton 2012-09-05
  
  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2009 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');


  $action = (isset($HTTP_GET_VARS['action']) ? $HTTP_GET_VARS['action'] : '');
  if ($action == 'process') {
    $error = false;
    $largewidth = intval($HTTP_POST_VARS['largewidth']);
    $largeheight = intval($HTTP_POST_VARS['largeheight']);
    $maxwidth = intval($HTTP_POST_VARS['maxwidth']);
    $maxheight = intval($HTTP_POST_VARS['maxheight']);
    $autodel = ($HTTP_POST_VARS['autodel'] == 1);
    $autocorrect = ($HTTP_POST_VARS['autocorrect'] == 1);
    $delinvalid = ($HTTP_POST_VARS['delinvalid'] == 1);
    $update_database = ($HTTP_POST_VARS['update_database'] == 1);
    if ($maxwidth < 500) {
      $error = true;
      $messageStack->add('Maximum original image width is too small!', 'error');
    }
    if ($maxheight < 400) {
      $error = true;
      $messageStack->add('Maximum original image height is too small!', 'error');
    }
    if ($error) $action = '';
  }

  require(DIR_WS_INCLUDES . 'template_top.php');
?>
<table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td width="100%"><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td class="pageHeading">Setup Protected Images</td>
            <td class="pageHeading" align="right"><?php echo tep_draw_separator('pixel_trans.gif', HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT); ?></td>
          </tr>
        </table></td>
      </tr>
      <?php if ($action == 'process') { ?>
      <tr>
        <td>
        <?php
        echo 'Beginning setup process.<br />';
        if ((DIR_WS_CATALOG_IMAGES_CAT != (DIR_WS_CATALOG_IMAGES . 'categories/')) ||
        (DIR_WS_CATALOG_IMAGES_MFG != (DIR_WS_CATALOG_IMAGES . 'manufacturers/'))  ||
        (DIR_WS_CATALOG_IMAGES_PROD != (DIR_WS_CATALOG_IMAGES . 'products/'))  ||
        (DIR_WS_CATALOG_IMAGES_THUMBS != (DIR_WS_CATALOG_IMAGES . 'product_thumbnails/')) ||
        (DIR_WS_CATALOG_IMAGES_TEMP != (DIR_WS_CATALOG_IMAGES . 'temporary/')) ||
        (DIR_WS_CATALOG_IMAGES_ORIG != (DIR_WS_CATALOG_IMAGES . 'originals/')) ||
        (DIR_FS_CATALOG_IMAGES_ORIG != (DIR_FS_CATALOG_IMAGES . 'originals/')) ||
        (DIR_FS_CATALOG_IMAGES_CAT != (DIR_FS_CATALOG_IMAGES . 'categories/')) ||
        (DIR_FS_CATALOG_IMAGES_MFG != (DIR_FS_CATALOG_IMAGES . 'manufacturers/')) ||
        (DIR_FS_CATALOG_IMAGES_PROD != (DIR_FS_CATALOG_IMAGES . 'products/')) ||
        (DIR_FS_CATALOG_IMAGES_THUMBS != (DIR_FS_CATALOG_IMAGES . 'product_thumbnails/')) ||
        (DIR_FS_CATALOG_IMAGES_TEMP != (DIR_FS_CATALOG_IMAGES . 'temporary/'))) {
          echo 'ERROR! Your admin/includes/config.php file has not been set up properly! This setup program requires that the defines for the image directories be completed first! This program is now stopping.';
          exit;
        }
        if (!function_exists('tep_create_thumbnail')) {
          echo 'ERROR! The tep_create_thumbnail function must be defined in admin/includes/functions/general.php before proceeding! This program is now stopping.';
          exit;
        }
        $query = tep_db_query('describe ' . TABLE_PRODUCTS . ' "%image%"');
        $found_display = false;
        $found_folder = false;
        while ($check = tep_db_fetch_array($query)) {
         if ($check['Field'] == 'image_display') $found_display = true;
         if ($check['Field'] == 'image_folder') $found_folder = true;
        }
        if (!$found_display) {
          tep_db_query('alter table ' . TABLE_PRODUCTS . ' add image_display tinyint unsigned not null default 0 after products_image');
          echo 'Created needed field "image_display" in products table.<br />';
        }
        if (!$found_folder) {
          tep_db_query('alter table ' . TABLE_PRODUCTS . ' add image_folder varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci default null after products_image');
          echo 'Created needed field "image_folder" in products table.<br />';
        }
        if (!defined('LARGE_IMAGE_WIDTH'))
          tep_db_query("INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Product Image Width', 'LARGE_IMAGE_WIDTH', '" . (int)$largewidth . "', 'The pixel width for product images on the product info page', '4', '101', now())");
        if (!defined('LARGE_IMAGE_HEIGHT'))
          tep_db_query("INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Product Image Height', 'LARGE_IMAGE_HEIGHT', '" . (int)$largeheight . "', 'The pixel height for product images on the product info page', '4', '102', now())");
        if (!defined('MAX_ORIGINAL_IMAGE_WIDTH'))
          tep_db_query("INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Maximum Image Width', 'MAX_ORIGINAL_IMAGE_WIDTH', '" . (int)$maxwidth . "', 'The maximum pixel width allowed for original images', '4', '103', now())");
        if (!defined('MAX_ORIGINAL_IMAGE_HEIGHT'))
          tep_db_query("INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Maximum Image Height', 'MAX_ORIGINAL_IMAGE_HEIGHT', '" . (int)$maxheight . "', 'The maximum pixel height allowed for original images', '4', '103', now())");
         
        $dir = rtrim(DIR_FS_CATALOG_IMAGES_ORIG, '/');
        if (!is_dir($dir)) {
          if (!mkdir($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' was not found and it could not be created! This program is now stopping.';
            exit;
          }
        } else {
          chmod($dir, 0755);
        }
        if (!tep_is_writable($dir)) {  // attempt to make writeable with lowest possible permissions first
          if (!chmod($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) {  // if first attempt failed try again with next higher level of permissions
          if (!chmod($dir, 0775)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) { // if still not writeable try making it so anyone can read or write to the directory
          if (!chmod($dir, 0777)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) {
          echo 'ERROR! Directory ' . $dir . ' is not writeable and all attempts to make it writeable have failed! This program is now stopping.';
          exit;
        }
        $dir = rtrim(DIR_FS_CATALOG_IMAGES_CAT, '/');
        if (!is_dir($dir)) {
          if (!mkdir($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' was not found and it could not be created! This program is now stopping.';
            exit;
          }
        } else {
          chmod($dir, 0755);
        }
        if (!tep_is_writable($dir)) {  // attempt to make writeable with lowest possible permissions first
          if (!chmod($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) {  // if first attempt failed try again with next higher level of permissions
          if (!chmod($dir, 0775)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) { // if still not writeable try making it so anyone can read or write to the directory
          if (!chmod($dir, 0777)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) {
          echo 'ERROR! Directory ' . $dir . ' is not writeable and all attempts to make it writeable have failed! This program is now stopping.';
          exit;
        }
        $dir = rtrim(DIR_FS_CATALOG_IMAGES_MFG, '/');
        if (!is_dir($dir)) {
          if (!mkdir($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' was not found and it could not be created! This program is now stopping.';
            exit;
          }
        } else {
          chmod($dir, 0755);
        }
        if (!tep_is_writable($dir)) {  // attempt to make writeable with lowest possible permissions first
          if (!chmod($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) {  // if first attempt failed try again with next higher level of permissions
          if (!chmod($dir, 0775)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) { // if still not writeable try making it so anyone can read or write to the directory
          if (!chmod($dir, 0777)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) {
          echo 'ERROR! Directory ' . $dir . ' is not writeable and all attempts to make it writeable have failed! This program is now stopping.';
          exit;
        }
        $dir = rtrim(DIR_FS_CATALOG_IMAGES_PROD, '/');
        if (!is_dir($dir)) {
          if (!mkdir($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' was not found and it could not be created! This program is now stopping.';
            exit;
          }
        } else {
          chmod($dir, 0755);
        }
        if (!tep_is_writable($dir)) {  // attempt to make writeable with lowest possible permissions first
          if (!chmod($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) {  // if first attempt failed try again with next higher level of permissions
          if (!chmod($dir, 0775)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) { // if still not writeable try making it so anyone can read or write to the directory
          if (!chmod($dir, 0777)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) {
          echo 'ERROR! Directory ' . $dir . ' is not writeable and all attempts to make it writeable have failed! This program is now stopping.';
          exit;
        }
        $dir = rtrim(DIR_FS_CATALOG_IMAGES_THUMBS, '/');
        if (!is_dir($dir)) {
          if (!mkdir($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' was not found and it could not be created! This program is now stopping.';
            exit;
          }
        } else {
          chmod($dir, 0755);
        }
        if (!tep_is_writable($dir)) {  // attempt to make writeable with lowest possible permissions first
          if (!chmod($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) {  // if first attempt failed try again with next higher level of permissions
          if (!chmod($dir, 0775)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) { // if still not writeable try making it so anyone can read or write to the directory
          if (!chmod($dir, 0777)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) {
          echo 'ERROR! Directory ' . $dir . ' is not writeable and all attempts to make it writeable have failed! This program is now stopping.';
          exit;
        }
        $dir = rtrim(DIR_FS_CATALOG_IMAGES_TEMP, '/');
        if (!is_dir($dir)) {
          if (!mkdir($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' was not found and it could not be created! This program is now stopping.';
            exit;
          }
        } else {
          chmod($dir, 0755);
        }
        $mode = 0755;
        if (!tep_is_writable($dir)) {  // attempt to make writeable with lowest possible permissions first
          if (!chmod($dir, 0755)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
        }
        if (!tep_is_writable($dir)) {  // if first attempt failed try again with next higher level of permissions
          if (!chmod($dir, 0775)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
          $mode = 0775;
        }
        if (!tep_is_writable($dir)) { // if still not writeable try making it so anyone can read or write to the directory
          if (!chmod($dir, 0777)) {
            echo 'ERROR! Directory ' . $dir . ' is not writeable and the permissions could not be changed! This program is now stopping.';
            exit;
          }
          $mode = 0777;
        }
        if (!tep_is_writable($dir)) {
          echo 'ERROR! Directory ' . $dir . ' is not writeable and all attempts to make it writeable have failed! This program is now stopping.';
          exit;
        }
        echo 'New image directories have been created if needed and made writeable with the lowest permissions possible.<br />';
        echo 'Preparing to copy images. ';
        if ($autocorrect) {
          echo 'If a database entry points to a file that does not exist or is not a valid web image file the database entry will be cleared. ';
        } else {
          echo 'If a database entry points to a file that does not exist or is not a valid web image file this program will halt and allow you to fix the error manually. ';
        }
        if ($delinvalid && $autocorrect) {
          echo 'If a database image entry points to a file that is not a valid web image that file will immediately be deleted from the base catalog images directory. ';
        } elseif ($autodel) {
          echo 'If a database image entry points to a file that is not a valid web image that file will be deleted from the base catalog images directory once all other images have been moved. ';
        } else {
          echo 'If a database image entry points to a file that is not a valid web image that file will be left in the base catalog images directory for you to delete manually. ';
        }
        if ($autodel) {
          echo 'Category, manufacturer and product image files will be removed from the base catalog images folder once all images have been copied to their new locations.<br />';
        } else {
          echo 'The original category, manufacturer and product image files will remain in the base catalog images folder and will need to be removed manually once this program has completed.<br />';
        }
        $files_copied = 0;
        // copy manufacturer images
        echo '<h2>Preparing to copy manufacturer images.</h2>';
        $query = tep_db_query('select * from ' . TABLE_MANUFACTURERS);
        $mfg_images = array();
        $mfg_db_changes = array();
        echo '<table><tr><td><strong>ID</strong></td><td><strong>Name</strong></td><td><strong>Current Image File</strong></td></tr>';
        while ($mfg = tep_db_fetch_array($query)) {
          echo '<tr><td>' . $mfg['manufacturers_id'] . '</td><td>' . $mfg['manufacturers_name'] . '</td><td>' . $mfg['manufacturers_image'] . '</td></tr>';
          if ($mfg['manufacturers_image'] == '') {
            echo '<tr><td colspan=3>No Image File</td></tr>';
          } else {
            $image = DIR_FS_CATALOG_IMAGES . $mfg['manufacturers_image'];
            if (file_exists($image)) {
              $type = tep_get_web_image_type($image);
              if ($type == false) {
                if ($autocorrect) {
                  echo '<tr><td colspan=3>Image file for ' . $mfg['manufacturers_name'] . ' is not a valid web type. The reference will be removed from the database.<br />';
                  $mfg_db_changes[] = ('update ' . TABLE_MANUFACTURERS . ' set manufacturers_image = null where manufacturers_id = ' . (int)$mfg['manufacturers_id']);
                  if ($delinvalid) {
                    if (unlink($image)) {
                      echo 'The file has been deleted from the base catalog images folder.</td></tr>';
                    } else {
                      echo 'This program was unable to delete the file from the base catalog images folder. You will need to delete it manually.</td></tr>';
                    }
                  } else {
                    echo 'The file is being left in the base catalog images folder. You will need to delete it manually.</td></tr>';
                  }
                } else {
                  echo '</table><h1>ERROR! Image file for ' . $mfg['manufacturers_name'] . ' is not a valid web type!  This program is now stopping.</h1>';
                  exit;
                }
              } else {
                $new_file_name = 'mfg' . $mfg['manufacturers_id'] . '.' . $type;
                $dest = DIR_FS_CATALOG_IMAGES_ORIG . $new_file_name;
                $result =  tep_create_thumbnail($image, $dest, MAX_ORIGINAL_IMAGE_WIDTH, MAX_ORIGINAL_IMAGE_HEIGHT); // copy unpadded original
                if ($result >= 0) {
                  if (!in_array($image, $mfg_images)) $mfg_images[] = $image;
                  $mfg_db_changes[] = ('update ' . TABLE_MANUFACTURERS . ' set manufacturers_image = "' . tep_db_input($new_file_name) . '" where manufacturers_id = ' . (int)$mfg['manufacturers_id']);
                  $files_copied++;
                  echo '<tr><td colspan=3>Original image file for ' . $mfg['manufacturers_name'] . ' was successfully copied.</td></tr>';
                } else {
                  echo '</table><h1>ERROR! Unable to copy image file for ' . $mfg['manufacturers_name'] . ' to ' . DIR_FS_CATALOG_IMAGES_ORIG . '!  This program is now stopping.</h1>';
                  exit;
                }
                $dest = DIR_FS_CATALOG_IMAGES_MFG . $new_file_name;
                $result =  tep_create_thumbnail($image, $dest, HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT, true); // create padded thumbnail
                if ($result >= 0) {
                  echo '<tr><td colspan=3>Thumbnail image file for ' . $mfg['manufacturers_name'] . ' was successfully created.</td></tr>';
                } else {
                  echo '</table><h1>ERROR! Unable to create thumbnail image file for ' . $mfg['manufacturers_name'] . ' in ' . DIR_FS_CATALOG_IMAGES_MFG . '!  This program is now stopping.</h1>';
                  exit;
                }
              }
            } else {
              if ($autocorrect) {
                echo '<tr><td colspan=3>Image file for ' . $mfg['manufacturers_name'] . ' not found. The reference will be removed from the database.</td></tr>';
                $mfg_db_changes[] = ('update ' . TABLE_MANUFACTURERS . ' set manufacturers_image = null where manufacturers_id = ' . (int)$mfg['manufacturers_id']);
              } else {
                echo '</table><h1>ERROR! Image file not found for ' . $mfg['manufacturers_name'] . '!  This program is now stopping.</h1>';
                exit;
              }
            }
          }
        }
        echo '</table>';
        // copy category images
        echo '<h2>Preparing to copy category images.</h2>';
        $query = tep_db_query('select categories_id, categories_image from ' . TABLE_CATEGORIES);
        $cat_images = array();
        $cat_db_changes = array();
        echo '<table><tr><td><strong>ID</strong></td><td><strong>Name</strong></td><td><strong>Current Image File</strong></td></tr>';
        while ($cat = tep_db_fetch_array($query)) {
          $name_query = tep_db_query('select categories_name from ' . TABLE_CATEGORIES_DESCRIPTION . ' where categories_id = ' . (int)$cat['categories_id'] . ' and language_id = ' . (int)$languages_id);
          $name = tep_db_fetch_array($name_query);
          echo '<tr><td>' . $cat['categories_id'] . '</td><td>' . $name['categories_name'] . '</td><td>' . $cat['categories_image'] . '</td></tr>';
          if ($cat['categories_image'] == '') {
            echo '<tr><td colspan=3>No Image File</td></tr>';
          } else {
            $image = DIR_FS_CATALOG_IMAGES . $cat['categories_image'];
            if (file_exists($image)) {
              $type = tep_get_web_image_type($image);
              if ($type == false) {
                if ($autocorrect) {
                  echo '<tr><td colspan=3>Image file for ' . $name['categories_name'] . ' is not a valid web type. The reference will be removed from the database.<br />';
                  $cat_db_changes[] = ('update ' . TABLE_CATEGORIES . ' set categories_image = null where categories_id = ' . (int)$cat['categories_id']);
                  if ($delinvalid) {
                    if (unlink($image)) {
                      echo 'The file has been deleted from the base catalog images folder.</td></tr>';
                    } else {
                      echo 'This program was unable to delete the file from the base catalog images folder. You will need to delete it manually.</td></tr>';
                    }
                  } else {
                    echo 'The file is being left in the base catalog images folder. You will need to delete it manually.</td></tr>';
                  }
                } else {
                  echo '</table><h1>ERROR! Image file for ' . $name['categories_name'] . ' is not a valid web type!  This program is now stopping.</h1>';
                  exit;
                }
              } else {
                $new_file_name = 'cat' . $cat['categories_id'] . '.' . $type;
                $dest = DIR_FS_CATALOG_IMAGES_ORIG . $new_file_name;
                $result =  tep_create_thumbnail($image, $dest, MAX_ORIGINAL_IMAGE_WIDTH, MAX_ORIGINAL_IMAGE_HEIGHT); // copy unpadded original
                if ($result >= 0) {
                  if (!in_array($image, $cat_images)) $cat_images[] = $image;
                  $cat_db_changes[] = ('update ' . TABLE_CATEGORIES . ' set categories_image = "' . tep_db_input($new_file_name) . '" where categories_id = ' . (int)$cat['categories_id']);
                  $files_copied++;
                  echo '<tr><td colspan=3>Original image file for ' . $name['categories_name'] . ' was successfully copied.</td></tr>';
                } else {
                  echo '</table><h1>ERROR! Unable to copy original image file for ' . $name['categories_name'] . ' to ' . DIR_FS_CATALOG_IMAGES_ORIG . '!  This program is now stopping.</h1>';
                  exit;
                }
                $dest = DIR_FS_CATALOG_IMAGES_CAT . $new_file_name;
                $result =  tep_create_thumbnail($image, $dest, SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT, true); // create padded thumbnail
                if ($result >= 0) {
                  echo '<tr><td colspan=3>Thumbnail image file for ' . $name['categories_name'] . ' was successfully created.</td></tr>';
                } else {
                  echo '</table><h1>ERROR! Unable to create thumbnail image file for ' . $name['categories_name'] . ' in ' . DIR_FS_CATALOG_IMAGES_CAT . '!  This program is now stopping.</h1>';
                  exit;
                }
              }
            } else {
              if ($autocorrect) {
                echo '<tr><td colspan=3>Image file for ' . $name['categories_name'] . ' not found. The reference will be removed from the database.</td></tr>';
                $cat_db_changes[] = ('update ' . TABLE_CATEGORIES . ' set categories_image = null where categories_id = ' . (int)$cat['categories_id']);
              } else {
                echo '</table><h1>ERROR! Image file not found for ' . $name['categories_name'] . '!  This program is now stopping.</h1>';
                exit;
              }
            }
          }
        }
        echo '</table>';
        // copy product images
        echo '<h2>Preparing to copy product images and create thumbnails.</h2>';
        $query = tep_db_query('select products_id, 	products_image from ' . TABLE_PRODUCTS);
        $prod_images = array();
        $prod_db_changes = array();
        echo '<table><tr><td><strong>ID</strong></td><td><strong>Name</strong></td><td><strong>Current Image File</strong></td></tr>';
        while ($product = tep_db_fetch_array($query)) {
          $name_query = tep_db_query('select products_name from ' . TABLE_PRODUCTS_DESCRIPTION . ' where products_id = ' . (int)$product['products_id'] . ' and language_id = ' . (int)$languages_id);
          $name = tep_db_fetch_array($name_query);
          echo '<tr><td>' . $product['products_id'] . '</td><td>' . $name['products_name'] . '</td><td>' . $product['products_image'] . '</td></tr>';
          $prod_dir = 'prod' . $product['products_id'];
          if (!is_dir(DIR_FS_CATALOG_IMAGES_ORIG . $prod_dir))
            if (!mkdir(DIR_FS_CATALOG_IMAGES_ORIG . $prod_dir, $mode)) {
              echo '</table><h1>ERROR! Unable to create original image subdirectory for ' . $name['products_name'] . ': ' . DIR_FS_CATALOG_IMAGES_ORIG . $prod_dir . '!  This program is now stopping.</h1>';
              exit;
            }
          if (!is_dir(DIR_FS_CATALOG_IMAGES_PROD . $prod_dir))
            if (!mkdir(DIR_FS_CATALOG_IMAGES_PROD . $prod_dir, $mode)) {
              echo '</table><h1>ERROR! Unable to create large image subdirectory for ' . $name['products_name'] . ': ' . DIR_FS_CATALOG_IMAGES_PROD . $prod_dir . '!  This program is now stopping.</h1>';
              exit;
            }
          if (!is_dir(DIR_FS_CATALOG_IMAGES_THUMBS . $prod_dir))
            if (!mkdir(DIR_FS_CATALOG_IMAGES_THUMBS . $prod_dir, $mode)) {
              echo '</table><h1>ERROR! Unable to create thumbnail image subdirectory for ' . $name['products_name'] . ': ' . DIR_FS_CATALOG_IMAGES_THUMBS . $prod_dir . '!  This program is now stopping.</h1>';
              exit;
            }
          $prod_dir .= '/';
          $prod_db_changes[] = ('update ' . TABLE_PRODUCTS . ' set image_folder = "' . tep_db_input($prod_dir) . '" where products_id = ' . (int)$product['products_id']);
          echo '<tr><td colspan=3>Product image subdirectories for ' . $name['products_name'] . ' were successfully created.<br />';
          if ($product['products_image'] == '') {
            echo 'No Primary Image File<br />';
          } else {
            $image = DIR_FS_CATALOG_IMAGES . $product['products_image'];
            if (file_exists($image)) {
              $type = tep_get_web_image_type($image);
              if ($type == false) {
                if ($autocorrect) {
                  echo 'Primary image file ' . $product['products_image'] . ' for ' . $name['products_name'] . ' is not a valid web type. The reference will be removed from the database.<br />';
                  $prod_db_changes[] = ('update ' . TABLE_PRODUCTS . ' set products_image = null where products_id = ' . (int)$product['products_id']);
                  if ($delinvalid) {
                    if (unlink($image)) {
                      echo 'The file has been deleted from the base catalog images folder.<br />';
                    } else {
                      echo 'This program was unable to delete the file from the base catalog images folder. You will need to delete it manually.<br />';
                    }
                  } else {
                    echo 'The file is being left in the base catalog images folder. You will need to delete it manually.<br />';
                  }
                } else {
                  echo '</td></tr></table><h1>ERROR! Image file for ' . $name['products_name'] . ' is not a valid web type!  This program is now stopping.</h1>';
                  exit;
                }
              } else {
                $correct_ext = false;
                switch ($type) {
                  case 'gif':
                    $correct_ext = (strtolower(substr($product['products_image'], strrpos($product['products_image'], '.')+1)) == 'gif');
                    break;
                  case 'png':
                    $correct_ext = (strtolower(substr($product['products_image'], strrpos($product['products_image'], '.')+1)) == 'png');
                    break;
                  case 'jpg':
                    $correct_ext = in_array(strtolower(substr($product['products_image'], strrpos($product['products_image'], '.')+1)), array('jpg', 'jpeg'));
                    break;
                }
                if ($correct_ext) { // use the current product image file name as long as it has the correct extension for the type
                  $new_file_name = $product['products_image'];
                } else { // otherwise change the extension to match the file type
                  $new_file_name = substr($product['products_image'], 0, strrpos($product['products_image'], '.')) . '.' . $type;
                }
                if (strpos($new_file_name, '/') !== false) $new_file_name = substr($new_file_name, strrpos($new_file_name, '/') + 1);
                $dest_image = DIR_FS_CATALOG_IMAGES_ORIG . $prod_dir . $new_file_name;
                $dest_large = DIR_FS_CATALOG_IMAGES_PROD . $prod_dir . $new_file_name;
                $dest_thumb = DIR_FS_CATALOG_IMAGES_THUMBS . $prod_dir . $new_file_name;
                $result =  tep_create_thumbnail($image, $dest_image, $maxwidth, $maxheight); //copy unpadded original
                if ($result >= 0) {
                  if (!in_array($image, $prod_images)) $prod_images[] = $image;
                  $files_copied++;
                  if ($new_file_name != $product['products_image']) $prod_db_changes[] = ('update ' . TABLE_PRODUCTS . ' set products_image = "' . tep_db_input($new_file_name) . '" where products_id = ' . (int)$product['products_id']);
                  echo 'Original image file ' . $product['products_image'] . ' for ' . $name['products_name'] . ' was successfully copied.<br />';
                } else {
                  echo '</td></tr></table><h1>ERROR! Unable to copy original image file for ' . $name['products_name'] . ' to ' . DIR_FS_CATALOG_IMAGES_ORIG . $prod_dir . '!  This program is now stopping.</h1>';
                  exit;
                }
                if (tep_create_thumbnail($image, $dest_large, $largewidth, $largeheight, true) >= 0) {
                  echo 'Large image file ' . $product['products_image'] . ' for ' . $name['products_name'] . ' was successfully created.<br />';
                } else {
                  echo '</td></tr></table><h1>ERROR! Unable to create large image file for ' . $name['products_name'] . ' in ' . DIR_FS_CATALOG_IMAGES_PROD . $prod_dir . '!  This program is now stopping.</h1>';
                  exit;
                }
                if (tep_create_thumbnail($image, $dest_thumb, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, true) >= 0) {
                  echo 'Thumbnail image file ' . $product['products_image'] . ' for ' . $name['products_name'] . ' was successfully created.<br />';
                } else {
                  echo '</td></tr></table><h1>ERROR! Unable to create thumbnail image file for ' . $name['products_name'] . ' in ' . DIR_FS_CATALOG_IMAGES_THUMBS . $prod_dir . '!  This program is now stopping.</h1>';
                  exit;
                }
              }
            } else {
              if ($autocorrect) {
                echo 'Image file for ' . $name['products_name'] . ' not found. The reference will be removed from the database.</td></tr>';
                $prod_db_changes[] = ('update ' . TABLE_PRODUCTS . ' set products_image = null where products_id = ' . (int)$product['products_id']);
              } else {
                echo '</td></tr></table><h1>ERROR! Image file not found for ' . $name['products_name'] . '!  This program is now stopping.</h1>';
                exit;
              }
            }
          }
          $additional_images_query = tep_db_query('select * from ' . TABLE_PRODUCTS_IMAGES . ' where products_id = ' . (int)$product['products_id']);
          while ($ximg = tep_db_fetch_array($additional_images_query)) {
            if ($ximg['image'] == '') {
              echo 'Missing Extra Image File id #' . $ximg['id'] . '<br />';
              if (tep_not_null($ximg['htmlcontent'])) { // if there is html content set image to main image
                $prod_db_changes[] = ('update ' . TABLE_PRODUCTS_IMAGES . ' set image = "' . tep_db_input($product['products_image']) . '" where products_id = ' . (int)$product['products_id'] . ' and id = ' . (int)$ximg['id']);
              } else { // otherwise remove entry
                $prod_db_changes[] = ('delete from ' . TABLE_PRODUCTS_IMAGES . ' where products_id = ' . (int)$product['products_id'] . ' and id = ' . (int)$ximg['id']);
              }
            } else {
              $image = DIR_FS_CATALOG_IMAGES . $ximg['image'];
              if (file_exists($image)) {
                $type = tep_get_web_image_type($image);
                if ($type == false) {
                  if ($autocorrect) {
                    echo 'Extra image file ' . $ximg['image'] . ' for ' . $name['products_name'] . ' is not a valid web type. The reference will be removed from the database.<br />';
                    if (tep_not_null($ximg['htmlcontent'])) { // if there is html content set image to main image
                      $prod_db_changes[] = ('update ' . TABLE_PRODUCTS_IMAGES . ' set image = "' . tep_db_input($product['products_image']) . '" where products_id = ' . (int)$product['products_id'] . ' and id = ' . (int)$ximg['id']);
                    } else { // otherwise remove entry
                      $prod_db_changes[] = ('delete from ' . TABLE_PRODUCTS_IMAGES . ' where products_id = ' . (int)$product['products_id'] . ' and id = ' . (int)$ximg['id']);
                    }
                    if ($delinvalid) {
                      if (unlink($image)) {
                        echo 'The file has been deleted from the base catalog images folder.<br />';
                      } else {
                        echo 'This program was unable to delete the file from the base catalog images folder. You will need to delete it manually.<br />';
                      }
                    } else {
                      echo 'The file is being left in the base catalog images folder. You will need to delete it manually.<br />';
                    }
                  } else {
                    echo '</td></tr></table><h1>ERROR! Extra image file for ' . $name['products_name'] . ' is not a valid web type!  This program is now stopping.</h1>';
                    exit;
                  }
                } else {
                  $correct_ext = false;
                  switch ($type) {
                    case 'gif':
                      $correct_ext = (strtolower(substr($ximg['image'], strrpos($ximg['image'], '.')+1)) == 'gif');
                      break;
                    case 'png':
                      $correct_ext = (strtolower(substr($ximg['image'], strrpos($ximg['image'], '.')+1)) == 'png');
                      break;
                    case 'jpg':
                      $correct_ext = in_array(strtolower(substr($ximg['image'], strrpos($ximg['image'], '.')+1)), array('jpg', 'jpeg'));
                      break;
                  }
                  if ($correct_ext) { // use the current product image file name as long as it has the correct extension for the type
                    $new_file_name = $ximg['image'];
                  } else { // otherwise change the extension to match the file type
                    $new_file_name = substr($ximg['image'], 0, strrpos($ximg['image'], '.')) . '.' . $type;
                  }
                  if (strpos($new_file_name, '/') !== false) $new_file_name = substr($new_file_name, strrpos($new_file_name, '/') + 1);
                  $dest_image = DIR_FS_CATALOG_IMAGES_ORIG . $prod_dir . $new_file_name;
                  $dest_large = DIR_FS_CATALOG_IMAGES_PROD . $prod_dir . $new_file_name;
                  $dest_thumb = DIR_FS_CATALOG_IMAGES_THUMBS . $prod_dir . $new_file_name;
                  if (tep_create_thumbnail($image, $dest_image, $maxwidth, $maxheight) >= 0) { //copy unpadded original
                    if (!in_array($image, $prod_images)) $prod_images[] = $image;
                    $files_copied++;
                    if ($new_file_name != $ximg['image']) $prod_db_changes[] = ('update ' . TABLE_PRODUCTS_IMAGES . ' set image = "' . tep_db_input($new_file_name) . '" where products_id = ' . (int)$product['products_id'] . ' and id = ' . (int)$ximg['id']);
                    echo 'Original image file ' . $ximg['image'] . ' for ' . $name['products_name'] . ' was successfully copied.<br />';
                  } else {
                    echo '</td></tr></table><h1>ERROR! Unable to copy original image file for ' . $name['products_name'] . ' to ' . DIR_FS_CATALOG_IMAGES_ORIG . $prod_dir . '!  This program is now stopping.</h1>';
                    exit;
                  }
                  if (tep_create_thumbnail($image, $dest_large, $largewidth, $largeheight, true) >= 0) { // create padded large image
                    echo 'Large image file ' . $ximg['image'] . ' for ' . $name['products_name'] . ' was successfully created.<br />';
                  } else {
                    echo '</td></tr></table><h1>ERROR! Unable to create large image file for ' . $name['products_name'] . ' in ' . DIR_FS_CATALOG_IMAGES_PROD . $prod_dir . '!  This program is now stopping.</h1>';
                    exit;
                  }
                  if (tep_create_thumbnail($image, $dest_thumb, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, true) >= 0) { // create padded thumbnail image
                    echo 'Thumbnail image file ' . $ximg['image'] . ' for ' . $name['products_name'] . ' was successfully created.<br />';
                  } else {
                    echo '</td></tr></table><h1>ERROR! Unable to create thumbnail image file for ' . $name['products_name'] . ' in ' . DIR_FS_CATALOG_IMAGES_THUMBS . $prod_dir . '!  This program is now stopping.</h1>';
                    exit;
                  }
                }
              } else {
                if ($autocorrect) {
                  echo 'Image file ' . $ximg['image'] . ' for ' . $name['products_name'] . ' not found. The reference will be removed from the database.<br />';
                  if (tep_not_null($ximg['htmlcontent'])) { // if there is html content set image to main image
                    $prod_db_changes[] = ('update ' . TABLE_PRODUCTS_IMAGES . ' set image = "' . tep_db_input($product['products_image']) . '" where products_id = ' . (int)$product['products_id'] . ' and id = ' . (int)$ximg['id']);
                  } else { // otherwise remove entry
                    $prod_db_changes[] = ('delete from ' . TABLE_PRODUCTS_IMAGES . ' where products_id = ' . (int)$product['products_id'] . ' and id = ' . (int)$ximg['id']);
                  }
                } else {
                  echo '</td></tr></table><h1>ERROR! Image file not found for ' . $name['products_name'] . '!  This program is now stopping.</h1>';
                  exit;
                }
              }
            }
          }
        }
        echo '</td></tr></table>';
        if ($files_copied == 0) {
          echo '<h1>No image files were copied! Apparently this program has been previously run and the database was updated and/or original files were deleted. To prevent potential problems this program is stopping now!';
          exit;
        } else {
          echo $files_copied . ' image files have been copied.<br />';
        }
        if ($update_database) {
          echo '<h2>Updating Manufacturers database information.</h2>';
          foreach ($mfg_db_changes as $mfg_query) tep_db_query($mfg_query);
          echo '<h2>Updating Categories database information.</h2>';
          foreach ($cat_db_changes as $cat_query) tep_db_query($cat_query);
          echo '<h2>Updating Products database information.</h2>';
          foreach ($prod_db_changes as $prod_query) tep_db_query($prod_query);
        } else {
          echo '<h1>The database files have not been updated with the new file names as copied by this program. If you have already installed the contribution to your web site the image files are not currently accessible by your web site due to the file name changes.</h1>';
        }
        if ($update_database && $autodel) {
          echo '<h2>Preparing to remove original manufacturer images from the base catalog images directory ' . DIR_FS_CATALOG_IMAGES . '</h2>';
          foreach ($mfg_images as $image) {
            if (unlink($image)) {
              echo $image . ' successfully deleted.<br />';
            } else {
              echo '<strong>Unable to delete ' . $image . '</strong><br />';
            }
          }
          echo '<h2>Preparing to remove original category images from the base catalog images directory ' . DIR_FS_CATALOG_IMAGES . '</h2>';
          foreach ($cat_images as $image) {
            if (unlink($image)) {
              echo $image . ' successfully deleted.<br />';
            } else {
              echo '<strong>Unable to delete ' . $image . '</strong><br />';
            }
          }
          echo '<h2>Preparing to remove original product images from the base catalog images directory ' . DIR_FS_CATALOG_IMAGES . '</h2>';
          foreach ($prod_images as $image) {
            if (unlink($image)) {
              echo $image . ' successfully deleted.<br />';
            } else {
              echo '<strong>Unable to delete ' . $image . '</strong><br />';
            }
          }
          echo '<h2>Original image removal has been completed with any exceptions noted above.</h2>';
        } else {
          echo '<h2>Image copy complete. Original product, manufacturer and category images have been left in the base catalog images directory ' . DIR_FS_CATALOG_IMAGES . ' for you to delete manually.</h2>';
        }
        echo '<h1>Program Complete!</h1><p>If you have completed all image setup and no longer need this program you should now delete it from your server.</p>';
        ?>
        </td>
      </tr>
      <?php } else { ?>
      <tr>
        <td>
        <?php
        echo tep_draw_form('preliminary', 'image_protect_setup.php', 'action=process', 'post', 'enctype="multipart/form-data"');
        if (!defined('LARGE_IMAGE_WIDTH')) {
          echo 'Enter the width for large product images: ' . tep_draw_input_field('largewidth', 800) . '<br />';
        } else {
          echo 'Width for large product images: ' . LARGE_IMAGE_WIDTH . tep_draw_hidden_field('largewidth', LARGE_IMAGE_WIDTH) . '<br />';
        }
        if (!defined('LARGE_IMAGE_HEIGHT')) {
          echo 'Enter the height for large product images: ' . tep_draw_input_field('largeheight', 600) . '<br />';
        } else {
          echo 'Height for large product images: ' . LARGE_IMAGE_HEIGHT . tep_draw_hidden_field('largeheight', LARGE_IMAGE_HEIGHT) . '<br />';
        }
        if (!defined('MAX_ORIGINAL_IMAGE_WIDTH')) {
          echo 'Enter the maximum width allowed for original images (minimum 500): ' . tep_draw_input_field('maxwidth', 4000) . '<br />';
        } else {
          echo 'Maximum width allowed for original images: ' . MAX_ORIGINAL_IMAGE_WIDTH . tep_draw_hidden_field('maxwidth', MAX_ORIGINAL_IMAGE_WIDTH) . '<br />';
        }
        if (!defined('MAX_ORIGINAL_IMAGE_HEIGHT')) {
          echo 'Enter the maximum height allowed for original images (minimum 400): ' . tep_draw_input_field('maxheight', 4000) . '<br />';
        } else {
          echo 'Maximum height allowed for original images: ' . MAX_ORIGINAL_IMAGE_HEIGHT . tep_draw_hidden_field('maxheight', MAX_ORIGINAL_IMAGE_HEIGHT) . '<br />';
        }
        echo 'Note: Images that are larger that these settings will be resized to fit during setup. Large product images will be padded as needed to equal the specified size in order to keep the jQuery image gallery looking neat and orderly.';
        echo '<p>Automatically remove invalid image information from the database (set image to null) if the image filename stored does not exist or points to a file that is not a valid web image (types: GIF, JPEG or PNG)? Note that this program will halt when it finds an error if this is set to No to allow you to manually correct the error. ' . tep_draw_radio_field('autocorrect', '1', false) . '&nbsp;Yes&nbsp;' . tep_draw_radio_field('autocorrect', '0', true) . "&nbsp;No</p>\n";
        echo '<p>Automatically delete files for categories, manufacturers and products that are not a valid web image (types: GIF, JPEG or PNG) from the base catalog images directory during auto correction? Note that this setting only applies if the above setting to automatically remove invalid information from the database is set to Yes. ' . tep_draw_radio_field('delinvalid', '1', true) . '&nbsp;Yes&nbsp;' . tep_draw_radio_field('delinvalid', '0', false) . "&nbsp;No</p>\n";
        echo '<p>Update the database files for categories, manufacturers and products once all images are successfully copied to their new locations and any corrections are made? Note that this setting is required to be Yes for the new web site code for this contribution to be able to access the images since they are all renamed as they are copied. Select No only if you wish to find image file problems that require correcting before making this contribution live. ' . tep_draw_radio_field('update_database', '1', true) . '&nbsp;Yes&nbsp;' . tep_draw_radio_field('update_database', '0', false) . "&nbsp;No</p>\n";
        echo '<p>Automatically delete category, manufacturer and product images from the base catalog images folder once they have all been copied to the appropriate folder for categories, manufacturers or products (requires database to be updated)? ' . tep_draw_radio_field('autodel', '1', false) . '&nbsp;Yes&nbsp;' . tep_draw_radio_field('autodel', '0', true) . "&nbsp;No</p>\n";
        echo tep_draw_input_field('go', "Begin Setup", 'alt="Begin Setup"', false, 'submit') . '</form>';
        ?>
        </td>
      </tr>
<?php } ?>
    </table>
    
<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
