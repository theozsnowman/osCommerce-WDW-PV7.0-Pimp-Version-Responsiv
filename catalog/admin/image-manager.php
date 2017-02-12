<?php
/*
  $Id: prod-img-manager.php v2.0 2012-09-12 by Kevin L. Shelton $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2007 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');
  require('includes/classes/' . 'currencies.php');
  $currencies = new currencies();

  $action = (isset($HTTP_GET_VARS['action']) ? $HTTP_GET_VARS['action'] : '');
  $products_id = (isset($HTTP_GET_VARS['pid']) ? $HTTP_GET_VARS['pid'] : '');
  $query = tep_db_query("select * from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_PRODUCTS_TO_CATEGORIES . " ptoc where p.products_id = pd.products_id and p.products_id = ptoc.products_id and pd.language_id = '" . (int)$languages_id . "' and p.products_id = " . (int)$products_id);
  $actions_not_requiring_product = array('find', 'cat', 'mfg', 'rebuild_mfg_thumbs', 'rebuild_cat_thumbs', 'mfg_copy_thumb', 'mfg_delimg', 'mfg_delimg_confirm', 'mfg_add', 'mfg_save', 'mfg_fix_thumb', 'cat_copy_thumb', 'cat_delimg', 'cat_delimg_confirm', 'cat_add', 'cat_save', 'cat_fix_thumb', 'orphans', 'orphans_remove');
  if ((tep_db_num_rows($query) == 0) && !in_array($action, $actions_not_requiring_product)) $action = "select_product";
  $product_info = tep_db_fetch_array($query);
  $product_images = array();
  if (tep_not_null($product_info['products_image'])) $product_images[] = $product_info['products_image'];
  $image_table = array();
  $query = tep_db_query('select * from ' . TABLE_PRODUCTS_IMAGES . ' where products_id = ' . (int)$products_id . ' order by sort_order');
  while ($image = tep_db_fetch_array($query)) {
    $product_images[] = $image['image'];
    $image_table[] = $image;
  }

  if (tep_not_null($action)) {
    switch ($action) {
      case 'orphans_remove':
        $location = tep_db_prepare_input($HTTP_POST_VARS['location']);
        $type = tep_db_prepare_input($HTTP_POST_VARS['type']);
        $source = tep_db_prepare_input($HTTP_POST_VARS['source']);
        $entry = tep_db_prepare_input($HTTP_POST_VARS['entry']);
        $folders = array();
        $owner = fileowner(rtrim(DIR_FS_CATALOG_IMAGES_TEMP, '/'));
        $errors = false;
        foreach ($location as $key => $loc) {
          if (isset($entry[$key]) && ($entry[$key] == $key)) { // if checked for deletion
            if (file_exists($loc)) {
              if (fileowner($loc) != $owner) chown($loc, $owner); // attempt to change file owner if needed
              if (!tep_is_writable($loc)) @chmod($loc, 0777); // attempt to make writable if it isn't already
              if ($type[$key] == 'folder') {
                $folders[$key] = $loc; //save folders to remove once files are deleted
              } else {
                if (!unlink($loc)) {
                  $messageStack->add_session(sprintf(ERROR_FILE_NOT_REMOVED, $loc) . TEXT_ORPHAN_SOURCE . $source[$key], 'error');
                  $errors = true;
                }
              }
            }
          }
        }
        foreach ($folders as $key => $loc) {
          if (!rmdir($loc)) {
            $messageStack->add_session(sprintf(ERROR_DIRECTORY_NOT_REMOVED, $loc) . TEXT_ORPHAN_SOURCE . $source[$key], 'error');
            $errors = true;
          }
        }
        if ($errors) tep_redirect(tep_href_link('image-manager.php', 'action=orphans'));
        tep_redirect(tep_href_link('image-manager.php'));
        break;
      
      case 'rebuild_cat_thumbs':
        $query = tep_db_query('select categories_id, categories_image from ' . TABLE_CATEGORIES);
        while ($cat = tep_db_fetch_array($query)) {
          $source = DIR_FS_CATALOG_IMAGES_ORIG . $cat['categories_image'];
          if (is_file($source) && tep_get_web_image_type($source)) {
            if (tep_create_thumbnail($source, DIR_FS_CATALOG_IMAGES_CAT . $cat['categories_image'], SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT, true) < 0) {
              $messageStack->add_session(tep_output_generated_category_path($cat['categories_id']) . ": " . TEXT_THUMBNAIL_FAILURE, 'error');
            }
          }
        }
        tep_redirect(tep_href_link('image-manager.php', 'action=cat'));
        break;
      
      case 'cat_fix_thumb':
        $cid = $HTTP_GET_VARS['cid'];
        $query = tep_db_query('select categories_image from ' . TABLE_CATEGORIES . ' where categories_id = ' . (int)$cid);
        if (tep_db_num_rows($query) == 1) { // as long as category id is valid
          $cat = tep_db_fetch_array($query);
          $source = DIR_FS_CATALOG_IMAGES_ORIG . $cat['categories_image'];
          if (is_file($source) && tep_get_web_image_type($source)) {
            if (tep_create_thumbnail($source, DIR_FS_CATALOG_IMAGES_CAT . $cat['categories_image'], SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT, true) >= 0) {
              $messageStack->add_session(TEXT_THUMBNAIL_SUCCESS, 'success');
            } else {
              $messageStack->add_session(TEXT_THUMBNAIL_FAILURE, 'error');
            }
          }
        }
        tep_redirect(tep_href_link('image-manager.php', 'action=cat'));
        break;
      
      case 'cat_copy_thumb':
        $cid = $HTTP_GET_VARS['cid'];
        $query = tep_db_query('select categories_image from ' . TABLE_CATEGORIES . ' where categories_id = ' . (int)$cid);
        if (tep_db_num_rows($query) == 1) {
          $cat = tep_db_fetch_array($query);
          $source = DIR_FS_CATALOG_IMAGES_CAT . $cat['categories_image'];
          if (is_file($source) && tep_get_web_image_type($source)) {
            $result = tep_create_thumbnail($source, DIR_FS_CATALOG_IMAGES_ORIG . $cat['categories_image'], MAX_ORIGINAL_IMAGE_WIDTH, MAX_ORIGINAL_IMAGE_HEIGHT);
            if ($result >= 0) {
              $messageStack->add_session(TEXT_ORIGINAL_SUCCESS, 'success');
            } else {
              switch ($result) {
                case -1:
                  $reason = TEXT_THUMBNAIL_FAILURE1;
                  break;
                case -2:
                  $reason = TEXT_THUMBNAIL_FAILURE2;
                  break;
                case -3:
                  $reason = TEXT_THUMBNAIL_FAILURE3;
                  break;
                case -4:
                  $reason = TEXT_THUMBNAIL_FAILURE4;
                  break;
                case -7:
                  $reason = TEXT_THUMBNAIL_FAILURE7 . DIR_FS_CATALOG_IMAGES_ORIG;
                  break;
                default:
                  $reason = '';
              }
              $messageStack->add_session(TEXT_ORIGINAL_FAILURE . $reason, 'error');
            }
          } else {
            $messageStack->add_session(TEXT_ORIGINAL_FAILURE . TEXT_ERROR_INVALID_THUMB, 'error');
          }
        }
        tep_redirect(tep_href_link('image-manager.php', 'action=cat'));
        break;
      
      case 'cat_save':
        $cid = intval($HTTP_POST_VARS['cid']);
        $query = tep_db_query('select categories_image from ' . TABLE_CATEGORIES . ' where categories_id = ' . (int)$cid);
        if (tep_db_num_rows($query) == 1) { // as long as manufacturer id is valid
          $cat_image = new upload('image');
          $webimgtypes = array ('jpg', 'jpeg', 'gif', 'png');
          $cat_image->set_extensions($webimgtypes);
          $cat_image->set_destination(DIR_FS_CATALOG_IMAGES_TEMP);
          $cat_image->set_output_messages('session');
          $cat_image->set_no_file_warning(true);
          if ($cat_image->parse() && $cat_image->save()) {
            $source = DIR_FS_CATALOG_IMAGES_TEMP . $cat_image->filename;
            if ($ext = tep_get_web_image_type($source)) {
              if ($ext != false) {
                $new_file_name = 'cat' . $cid . '.' . $ext;
                $dest = DIR_FS_CATALOG_IMAGES_ORIG . $new_file_name;
                $success = (tep_create_thumbnail($source, $dest, MAX_ORIGINAL_IMAGE_WIDTH, MAX_ORIGINAL_IMAGE_HEIGHT) >= 0); // save unpadded original image
                if ($success) {
                  $messageStack->add_session(TEXT_ORIGINAL_SUCCESS, 'success');
                } else {
                  $messageStack->add_session(TEXT_ORIGINAL_FAILURE, 'error');
                }
                $dest = DIR_FS_CATALOG_IMAGES_CAT . $new_file_name;
                $success = (tep_create_thumbnail($source, $dest, SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT, true) >= 0); // create padded thumbnail image
                if ($success) {
                  tep_db_query("update " . TABLE_CATEGORIES . " set categories_image = '" . tep_db_input($new_file_name) . "', last_modified = now() where categories_id = '" . (int)$cid . "'");
                  $messageStack->add_session(TEXT_THUMBNAIL_SUCCESS, 'success');
                } else {
                  $messageStack->add_session(TEXT_THUMBNAIL_FAILURE, 'error');
                }
              } else {
                $messageStack->add_session(ERROR_FILE_NOT_SAVED, 'error');
              }
            }
            @unlink($source); // remove temporary file
          }
        }
        tep_redirect(tep_href_link('image-manager.php', 'action=cat'));
        break;
      
      case 'cat_delimg_confirm':
        $cid = $HTTP_POST_VARS['cid'];
        $query = tep_db_query('select categories_image from ' . TABLE_CATEGORIES . ' where categories_id = ' . (int)$cid);
        if (tep_db_num_rows($query) == 1) {
          $cat = tep_db_fetch_array($query);
          if (is_file(DIR_FS_CATALOG_IMAGES_CAT . $cat['categories_image']))
            @unlink(DIR_FS_CATALOG_IMAGES_CAT . $cat['categories_image']);
          if (is_file(DIR_FS_CATALOG_IMAGES_ORIG . $cat['categories_image']))
            @unlink(DIR_FS_CATALOG_IMAGES_ORIG . $cat['categories_image']);
          tep_db_query('update ' . TABLE_CATEGORIES . ' set categories_image = null where categories_id = ' . (int)$cid);
        }
        tep_redirect(tep_href_link('image-manager.php', 'action=cat'));
        break;
      
      case 'rebuild_mfg_thumbs':
        $query = tep_db_query('select manufacturers_name, manufacturers_image from ' . TABLE_MANUFACTURERS . ' order by manufacturers_name');
        while ($mfg = tep_db_fetch_array($query)) {
          $source = DIR_FS_CATALOG_IMAGES_ORIG . $mfg['manufacturers_image'];
          if (is_file($source) && tep_get_web_image_type($source)) {
            if (tep_create_thumbnail($source, DIR_FS_CATALOG_IMAGES_MFG . $mfg['manufacturers_image'], SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT, true) < 0) {
              $messageStack->add_session($mfg['manufacturers_name'] . ": " . TEXT_THUMBNAIL_FAILURE, 'error');
            }
          }
        }
        tep_redirect(tep_href_link('image-manager.php', 'action=mfg'));
        break;
      
      case 'mfg_fix_thumb':
        $mid = intval($HTTP_GET_VARS['mid']);
        $query = tep_db_query('select manufacturers_image from ' . TABLE_MANUFACTURERS . ' where manufacturers_id = ' . (int)$mid);
        if (tep_db_num_rows($query) == 1) { // as long as manufacturer id is valid
          $mfg = tep_db_fetch_array($query);
          $source = DIR_FS_CATALOG_IMAGES_ORIG . $mfg['manufacturers_image'];
          if (is_file($source) && tep_get_web_image_type($source)) {
            if (tep_create_thumbnail($source, DIR_FS_CATALOG_IMAGES_MFG . $mfg['manufacturers_image'], SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT, true) >= 0) {
              $messageStack->add_session(TEXT_THUMBNAIL_SUCCESS, 'success');
            } else {
              $messageStack->add_session(TEXT_THUMBNAIL_FAILURE, 'error');
            }
          }
        }
        tep_redirect(tep_href_link('image-manager.php', 'action=mfg'));
        break;
      
      case 'mfg_save':
        $mid = intval($HTTP_POST_VARS['mid']);
        $query = tep_db_query('select manufacturers_image from ' . TABLE_MANUFACTURERS . ' where manufacturers_id = ' . (int)$mid);
        if (tep_db_num_rows($query) == 1) { // as long as manufacturer id is valid
          $manufacturers_image = new upload('image');
          $webimgtypes = array ('jpg', 'jpeg', 'gif', 'png');
          $manufacturers_image->set_extensions($webimgtypes);
          $manufacturers_image->set_destination(DIR_FS_CATALOG_IMAGES_TEMP);
          $manufacturers_image->set_output_messages('session');
          $manufacturers_image->set_no_file_warning(true);
          if ($manufacturers_image->parse() && $manufacturers_image->save()) {
            $source = DIR_FS_CATALOG_IMAGES_TEMP . $manufacturers_image->filename;
            if ($ext = tep_get_web_image_type($source)) {
              if ($ext != false) {
                $new_file_name = 'mfg' . $mid . '.' . $ext;
                $dest = DIR_FS_CATALOG_IMAGES_ORIG . $new_file_name;
                $success = (tep_create_thumbnail($source, $dest, MAX_ORIGINAL_IMAGE_WIDTH, MAX_ORIGINAL_IMAGE_HEIGHT) >= 0); // save unpadded original image
                if ($success) {
                  $messageStack->add_session(TEXT_ORIGINAL_SUCCESS, 'success');
                } else {
                  $messageStack->add_session(TEXT_ORIGINAL_FAILURE, 'error');
                }
                $dest = DIR_FS_CATALOG_IMAGES_MFG . $new_file_name;
                $success = (tep_create_thumbnail($source, $dest, SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT, true) >= 0); // create padded thumbnail image
                if ($success) {
                  tep_db_query("update " . TABLE_MANUFACTURERS . " set manufacturers_image = '" . tep_db_input($new_file_name) . "', last_modified = now() where manufacturers_id = '" . (int)$mid . "'");
                  $messageStack->add_session(TEXT_THUMBNAIL_SUCCESS, 'success');
                } else {
                  $messageStack->add_session(TEXT_THUMBNAIL_FAILURE, 'error');
                }
              } else {
                $messageStack->add_session(ERROR_FILE_NOT_SAVED, 'error');
              }
            }
            @unlink($source); // remove temporary file
          }
        }
        tep_redirect(tep_href_link('image-manager.php', 'action=mfg'));
        break;
      
      case 'mfg_copy_thumb':
        $mid = $HTTP_GET_VARS['mid'];
        $query = tep_db_query('select manufacturers_image from ' . TABLE_MANUFACTURERS . ' where manufacturers_id = ' . (int)$mid);
        if (tep_db_num_rows($query) == 1) {
          $mfg = tep_db_fetch_array($query);
          $source = DIR_FS_CATALOG_IMAGES_MFG . $mfg['manufacturers_image'];
          if (is_file($source) && tep_get_web_image_type($source)) {
            $result = tep_create_thumbnail($source, DIR_FS_CATALOG_IMAGES_ORIG . $mfg['manufacturers_image'], MAX_ORIGINAL_IMAGE_WIDTH, MAX_ORIGINAL_IMAGE_HEIGHT);
            if ($result >= 0) {
              $messageStack->add_session(TEXT_ORIGINAL_SUCCESS, 'success');
            } else {
              switch ($result) {
                case -1:
                  $reason = TEXT_THUMBNAIL_FAILURE1;
                  break;
                case -2:
                  $reason = TEXT_THUMBNAIL_FAILURE2;
                  break;
                case -3:
                  $reason = TEXT_THUMBNAIL_FAILURE3;
                  break;
                case -4:
                  $reason = TEXT_THUMBNAIL_FAILURE4;
                  break;
                case -7:
                  $reason = TEXT_THUMBNAIL_FAILURE7 . DIR_FS_CATALOG_IMAGES_ORIG;
                  break;
                default:
                  $reason = '';
              }
              $messageStack->add_session(TEXT_ORIGINAL_FAILURE . $reason, 'error');
            }
          } else {
            $messageStack->add_session(TEXT_ORIGINAL_FAILURE . TEXT_ERROR_INVALID_THUMB, 'error');
          }
        }
        tep_redirect(tep_href_link('image-manager.php', 'action=mfg'));
        break;
      
      case 'mfg_delimg_confirm':
        $mid = $HTTP_POST_VARS['mid'];
        $query = tep_db_query('select manufacturers_image from ' . TABLE_MANUFACTURERS . ' where manufacturers_id = ' . (int)$mid);
        if (tep_db_num_rows($query) == 1) {
          $mfg = tep_db_fetch_array($query);
          if (is_file(DIR_FS_CATALOG_IMAGES_MFG . $mfg['manufacturers_image']))
            @unlink(DIR_FS_CATALOG_IMAGES_MFG . $mfg['manufacturers_image']);
          if (is_file(DIR_FS_CATALOG_IMAGES_ORIG . $mfg['manufacturers_image']))
            @unlink(DIR_FS_CATALOG_IMAGES_ORIG . $mfg['manufacturers_image']);
          tep_db_query('update ' . TABLE_MANUFACTURERS . ' set manufacturers_image = null where manufacturers_id = ' . (int)$mid);
        }
        tep_redirect(tep_href_link('image-manager.php', 'action=mfg'));
        break;
      
      case 'copy_large_orig':
        $image = tep_db_prepare_input($HTTP_GET_VARS['image_file']);
        if (isset($HTTP_GET_VARS['src']) && ($HTTP_GET_VARS['src'] == 'thumb')) {
          $source = DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $image;
        } else {
          $source = DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'] . $image;
        }
        if (is_file($source) && !is_file(DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'] . $image))
          if (tep_get_web_image_type($source)) {
            $result = tep_create_thumbnail($source, DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'] . $image, MAX_ORIGINAL_IMAGE_WIDTH, MAX_ORIGINAL_IMAGE_HEIGHT);
            if ($result >= 0) {
              $messageStack->add_session(TEXT_ORIGINAL_SUCCESS, 'success');
              $messageStack->add_session(TEXT_REBUILD_SUGGESTED, 'warning');
            } else {
              switch ($result) {
                case -1:
                  $reason = TEXT_THUMBNAIL_FAILURE1;
                  break;
                case -2:
                  $reason = TEXT_THUMBNAIL_FAILURE2;
                  break;
                case -3:
                  $reason = TEXT_THUMBNAIL_FAILURE3;
                  break;
                case -4:
                  $reason = TEXT_THUMBNAIL_FAILURE4;
                  break;
                case -7:
                  $reason = TEXT_THUMBNAIL_FAILURE7 . DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'];
                  break;
                default:
                  $reason = '';
              }
              $messageStack->add_session(TEXT_ORIGINAL_FAILURE . $reason, 'error');
            }
          } else {
            $messageStack->add_session(TEXT_ORIGINAL_FAILURE . TEXT_ERROR_INVALID_LARGE, 'error');
          }
        tep_redirect(tep_href_link('image-manager.php', 'pid=' . $products_id));
        break;
        
      case 'db_add':
        $image = tep_db_prepare_input($HTTP_GET_VARS['image_file']);
        if (is_file(DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'] . $image))
          if (tep_get_web_image_type(DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'] . $image)) {
            $sql_data = array('image' => $image, 'products_id' => $products_id);
            tep_db_perform(TABLE_PRODUCTS_IMAGES, $sql_data);
          }
        tep_redirect(tep_href_link('image-manager.php', 'pid=' . $products_id));
        break;
        
      case 'delete_image_confirm':
        $image = tep_db_prepare_input($HTTP_POST_VARS['image_file']);
        if (isset($HTTP_POST_VARS['image_file']) && ($image != '')) {
          if (is_file(DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $image))
            @unlink(DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $image);
          if (is_file(DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'] . $image))
            @unlink(DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'] . $image);
          if (is_file(DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'] . $image))
            @unlink(DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'] . $image);
          tep_db_query('delete from ' . TABLE_PRODUCTS_IMAGES . ' where products_id = ' . (int)$products_id . ' and image = "' . tep_db_input($image) . '"');
          if ($image == $product_info['products_image']) { // deleted default image
            $new_default = 'null'; // new default will be null if no file found
            foreach ($image_table as $i) { // find the first non-deleted image from the image table
              if ($i['image'] != $image) {
                $new_default = $i['image'];
                break;
              }
            }
            $sql_data = array('products_image' => $new_default);
            tep_db_perform(TABLE_PRODUCTS, $sql_data, 'update', "products_id = '" . (int)$products_id . "'");
          }
        }
        tep_redirect(tep_href_link('image-manager.php', 'pid=' . $products_id));
        break;
        
      case 'insert_image':
        $sql_data_array = array('image_display' => tep_db_prepare_input($HTTP_POST_VARS['image_display']),
                                'products_last_modified' => 'now()');
        tep_db_perform(TABLE_PRODUCTS, $sql_data_array, 'update', "products_id = '" . (int)$products_id . "'");
        $set_default = (isset($HTTP_POST_VARS['set_default']) && ($HTTP_POST_VARS['set_default'] == 'yes'));
        $sort_order = intval(tep_db_prepare_input($HTTP_POST_VARS['sort_order']));
        $html = tep_db_prepare_input($HTTP_POST_VARS['htmlcontent']);
        if (!tep_not_null($html)) $html = 'null';

        $products_image = new upload('products_image');
        $webimgtypes = array ('jpg', 'jpeg', 'gif', 'png');
        $products_image->set_extensions($webimgtypes);
        $products_image->set_destination(DIR_FS_CATALOG_IMAGES_TEMP);
        $products_image->set_output_messages('session');
        if ($products_image->parse() && $products_image->save()) {
          $image = $products_image->filename;
          $source = DIR_FS_CATALOG_IMAGES_TEMP . $image;
          if (is_file($source)) {
            if ($HTTP_POST_VARS['image_display'] == 0) { // displaying images?
              if (tep_get_web_image_type($source)) { // valid image?
                $result = tep_create_thumbnail($source, DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'] . $image, MAX_ORIGINAL_IMAGE_WIDTH, MAX_ORIGINAL_IMAGE_HEIGHT);
                if ($result >= 0) {
                  $messageStack->add_session(TEXT_ORIGINAL_SUCCESS, 'success');
                } else {
                  switch ($result) {
                    case -1:
                      $reason = TEXT_THUMBNAIL_FAILURE1;
                      break;
                    case -2:
                      $reason = TEXT_THUMBNAIL_FAILURE2;
                      break;
                    case -3:
                      $reason = TEXT_THUMBNAIL_FAILURE3;
                      break;
                    case -4:
                      $reason = TEXT_THUMBNAIL_FAILURE4;
                      break;
                    case -7:
                      $reason = TEXT_THUMBNAIL_FAILURE7 . DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'];
                      break;
                    default:
                      $reason = '';
                  }
                  $messageStack->add_session(TEXT_ORIGINAL_FAILURE . $reason, 'error');
                }
                $result = tep_create_thumbnail($source, DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $image, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, true);
                if ($result >= 0) { // set image as default in database if thumbnail creation successful
                  if ($set_default || ($product_info['products_image'] == '')) tep_db_query('update ' . TABLE_PRODUCTS . ' set products_image = "' . tep_db_input($image) . '" where products_id = ' . (int)$products_id);
                  $messageStack->add_session(TEXT_THUMBNAIL_SUCCESS, 'success');
                } else {
                  switch ($result) {
                    case -1:
                      $reason = TEXT_THUMBNAIL_FAILURE1;
                      break;
                    case -2:
                      $reason = TEXT_THUMBNAIL_FAILURE2;
                      break;
                    case -3:
                      $reason = TEXT_THUMBNAIL_FAILURE3;
                      break;
                    case -4:
                      $reason = TEXT_THUMBNAIL_FAILURE4;
                      break;
                    case -7:
                      $reason = TEXT_THUMBNAIL_FAILURE7 . DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'];
                      break;
                    default:
                      $reason = '';
                  }
                  $messageStack->add_session(TEXT_THUMBNAIL_FAILURE . $reason, 'error');
                }
                $result = tep_create_thumbnail($source, DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'] . $image, LARGE_IMAGE_WIDTH, LARGE_IMAGE_HEIGHT, true);
                if ($result >= 0) { // save in database if large image creation succeeds
                  $messageStack->add_session(TEXT_LRGIMG_SUCCESS, 'success');
                  $sql_data_array = array('products_id' => (int)$products_id,
                                          'image' => $image,
                                          'htmlcontent' => $html,
                                          'sort_order' => $sort_order);
                  tep_db_perform(TABLE_PRODUCTS_IMAGES, $sql_data_array);
                } else {
                  switch ($result) {
                    case -1:
                      $reason = TEXT_THUMBNAIL_FAILURE1;
                      break;
                    case -2:
                      $reason = TEXT_THUMBNAIL_FAILURE2;
                      break;
                    case -3:
                      $reason = TEXT_THUMBNAIL_FAILURE3;
                      break;
                    case -4:
                      $reason = TEXT_THUMBNAIL_FAILURE4;
                      break;
                    case -7:
                      $reason = TEXT_THUMBNAIL_FAILURE7 . DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'];
                      break;
                    default:
                      $reason = '';
                  }
                  $messageStack->add_session(TEXT_LRGIMG_FAILURE . $reason, 'error');
                }
              } else { // unable to get uploaded image size
                $messageStack->add_session(TEXT_THUMBNAIL_FAILURE2, 'error');
              }
            } else { // image display is set for blank or "no_picture" image
              $messageStack->add_session(TEXT_IMAGE_IGNORED, 'error');
            }
            @unlink($source); // remove temporary image file
          } else { // temporary upload file not found
            $messageStack->add_session(TEXT_FILE_NOT_FOUND, 'error');
          }
        }

        tep_redirect(tep_href_link('image-manager.php', 'pid=' . $products_id));
        break;
      case 'make_default':
        if (isset($HTTP_GET_VARS['image_file']) && ($HTTP_GET_VARS['image_file'] != '')) {
          if (is_file(DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $HTTP_GET_VARS['image_file'])) {
            $sql_data = array('products_image' => tep_db_prepare_input($HTTP_GET_VARS['image_file']));
            tep_db_perform(TABLE_PRODUCTS, $sql_data, 'update', "products_id = '" . (int)$products_id . "'");
          }
        }
        tep_redirect(tep_href_link('image-manager.php', 'pid=' . $products_id));
        break;
      case 'rebuild_confirm':
        if (isset($HTTP_POST_VARS['rebuild_for']) && ($HTTP_POST_VARS['rebuild_for'] == 'all')) {
          $query = tep_db_query('select image_folder from ' . TABLE_PRODUCTS);
          while ($product = tep_db_fetch_array($query)) {
            if ($handle = opendir(DIR_FS_CATALOG_IMAGES_ORIG . $product['image_folder'])) {
              while ($file = readdir($handle)) {
                if (in_array(strtolower(substr($file, strrpos($file, '.')+1)), array('gif', 'png', 'jpg', 'jpeg'))) {
                  $result = tep_create_thumbnail(DIR_FS_CATALOG_IMAGES_ORIG . $product['image_folder'] . $file, DIR_FS_CATALOG_IMAGES_THUMBS . $product['image_folder'] . $file, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, true);
                  if ($result >= 0) {
                    $messageStack->add_session(DIR_FS_CATALOG_IMAGES_THUMBS . $product['image_folder'] . $file . ': ' . TEXT_THUMBNAIL_SUCCESS, 'success');
                  } else {
                    switch ($result) {
                      case -1:
                        $reason = TEXT_THUMBNAIL_FAILURE1;
                        break;
                      case -2:
                        $reason = TEXT_THUMBNAIL_FAILURE2;
                        break;
                      case -3:
                        $reason = TEXT_THUMBNAIL_FAILURE3;
                        break;
                      case -4:
                        $reason = TEXT_THUMBNAIL_FAILURE4;
                        break;
                      case -7:
                        $reason = TEXT_THUMBNAIL_FAILURE7 . DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'];
                        break;
                      default:
                        $reason = '';
                    }
                    $messageStack->add_session(DIR_FS_CATALOG_IMAGES_THUMBS . $product['image_folder'] . $file . ': ' . TEXT_THUMBNAIL_FAILURE . ' ' . $reason, 'error');
                  }
                  $result = tep_create_thumbnail(DIR_FS_CATALOG_IMAGES_ORIG . $product['image_folder'] . $file, DIR_FS_CATALOG_IMAGES_PROD . $product['image_folder'] . $file, LARGE_IMAGE_WIDTH, LARGE_IMAGE_HEIGHT, true);
                  if ($result >= 0) {
                    $messageStack->add_session(DIR_FS_CATALOG_IMAGES_PROD . $product['image_folder'] . $file . ': ' . TEXT_LRGIMG_SUCCESS, 'success');
                  } else {
                    switch ($result) {
                      case -1:
                        $reason = TEXT_THUMBNAIL_FAILURE1;
                        break;
                      case -2:
                        $reason = TEXT_THUMBNAIL_FAILURE2;
                        break;
                      case -3:
                        $reason = TEXT_THUMBNAIL_FAILURE3;
                        break;
                      case -4:
                        $reason = TEXT_THUMBNAIL_FAILURE4;
                        break;
                      case -7:
                        $reason = TEXT_THUMBNAIL_FAILURE7 . DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'];
                        break;
                      default:
                        $reason = '';
                    }
                    $messageStack->add_session(DIR_FS_CATALOG_IMAGES_PROD . $product['image_folder'] . $file . ': ' . TEXT_LRGIMG_FAILURE . $reason, 'error');
                  }
                }
              }
              closedir($handle);
            }
          }
        } else { // rebuild a single product's images
          if ($handle = opendir(DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'])) {
            while ($file = readdir($handle)) {
              if (in_array(strtolower(substr($file, strrpos($file, '.')+1)), array('gif', 'png', 'jpg', 'jpeg'))) {
                $result = tep_create_thumbnail(DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'] . $file, DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $file, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, true);
                if ($result >= 0) {
                  $messageStack->add_session($file . ': ' . TEXT_THUMBNAIL_SUCCESS, 'success');
                } else {
                  switch ($result) {
                    case -1:
                      $reason = TEXT_THUMBNAIL_FAILURE1;
                      break;
                    case -2:
                      $reason = TEXT_THUMBNAIL_FAILURE2;
                      break;
                    case -3:
                      $reason = TEXT_THUMBNAIL_FAILURE3;
                      break;
                    case -4:
                      $reason = TEXT_THUMBNAIL_FAILURE4;
                      break;
                    case -7:
                      $reason = TEXT_THUMBNAIL_FAILURE7 . DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'];
                      break;
                    default:
                      $reason = '';
                  }
                  $messageStack->add_session($file . ': ' . TEXT_THUMBNAIL_FAILURE . ' ' . $reason, 'error');
                }
                $result = tep_create_thumbnail(DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'] . $file, DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'] . $file, LARGE_IMAGE_WIDTH, LARGE_IMAGE_HEIGHT, true);
                if ($result >= 0) {
                  $messageStack->add_session($file . ': ' . TEXT_LRGIMG_SUCCESS, 'success');
                } else {
                  switch ($result) {
                    case -1:
                      $reason = TEXT_THUMBNAIL_FAILURE1;
                      break;
                    case -2:
                      $reason = TEXT_THUMBNAIL_FAILURE2;
                      break;
                    case -3:
                      $reason = TEXT_THUMBNAIL_FAILURE3;
                      break;
                    case -4:
                      $reason = TEXT_THUMBNAIL_FAILURE4;
                      break;
                    case -7:
                      $reason = TEXT_THUMBNAIL_FAILURE7 . DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'];
                      break;
                    default:
                      $reason = '';
                  }
                  $messageStack->add_session($file . ': ' . TEXT_LRGIMG_FAILURE . $reason, 'error');
                }
              }
            }
            closedir($handle);
          }
        }
        tep_redirect(tep_href_link('image-manager.php', 'pid=' . $products_id));
        break;
      case 'find':
        $keywords = (isset($HTTP_GET_VARS['keywords']) ? tep_db_prepare_input($HTTP_GET_VARS['keywords']) : '');
        $within = (isset($HTTP_GET_VARS['within']) ? $HTTP_GET_VARS['within'] : 'all');
        if (tep_not_null($keywords)) {
          if (!tep_parse_search_string($keywords, $search_keywords)) {
            $error = true;
            $messages[] = ERROR_INVALID_KEYWORDS;
            $action = "select_product";
            break;
          }
        }
        $raw_query = "select * from " . TABLE_PRODUCTS . " p left join " . TABLE_MANUFACTURERS . " m on p.manufacturers_id = m.manufacturers_id, " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_PRODUCTS_TO_CATEGORIES . " ptoc where p.products_id = pd.products_id and p.products_id = ptoc.products_id and pd.language_id =  " . (int)$languages_id;
        $where_str = '';
        if (isset($search_keywords) && (sizeof($search_keywords) > 0)) {
          $where_str .= " and (";
          for ($i=0, $n=sizeof($search_keywords); $i<$n; $i++ ) {
            switch ($search_keywords[$i]) {
              case '(':
              case ')':
              case 'and':
              case 'or':
                $where_str .= " " . $search_keywords[$i] . " ";
                break;
              default:
                $keyword = tep_db_prepare_input($search_keywords[$i]);
                $where_str .= "(pd.products_name like '%" . tep_db_input($keyword) . "%' or p.products_model like '%" . tep_db_input($keyword) . "%' or m.manufacturers_name like '%" . tep_db_input($keyword) . "%'";
                if ($within == 'all') $where_str .= " or pd.products_description like '%" . tep_db_input($keyword) . "%'";
                $where_str .= ')';
                break;
            }
          }
          $where_str .= " )";
        }
        $query = tep_db_query($raw_query . $where_str . ' group by p.products_id');
        if (tep_db_num_rows($query) == 0) {
          $action = "select_product";
          $messageStack->add(TEXT_NOT_FOUND, 'error');
          break;
        }
        if (tep_db_num_rows($query) == 1) {
          $product = tep_db_fetch_array($query);
          tep_redirect(tep_href_link('image-manager.php', 'pid=' . $product['products_id']));
        } else {
          $action = 'choose';
          $messageStack->add(TEXT_MULTIPLE_FOUND, 'warning');
        }
        break;
    }
  }

// check if the catalog image directory exists
  if (is_dir(DIR_FS_CATALOG_IMAGES_ORIG)) {
    if (!tep_is_writable(DIR_FS_CATALOG_IMAGES_ORIG)) $messageStack->add(ERROR_CATALOG_ORIG_IMAGE_DIRECTORY_NOT_WRITEABLE, 'error');
  } else {
    $messageStack->add(ERROR_CATALOG_ORIG_IMAGE_DIRECTORY_DOES_NOT_EXIST, 'error');
  }
  if (is_dir(DIR_FS_CATALOG_IMAGES_PROD)) {
    if (!tep_is_writable(DIR_FS_CATALOG_IMAGES_PROD)) $messageStack->add(ERROR_CATALOG_PRODUCT_IMAGE_DIRECTORY_NOT_WRITEABLE, 'error');
  } else {
    $messageStack->add(ERROR_CATALOG_PRODUCT_IMAGE_DIRECTORY_DOES_NOT_EXIST, 'error');
  }
  if (is_dir(DIR_FS_CATALOG_IMAGES_THUMBS)) {
    if (!tep_is_writable(DIR_FS_CATALOG_IMAGES_THUMBS)) $messageStack->add(ERROR_CATALOG_THUMB_IMAGE_DIRECTORY_NOT_WRITEABLE, 'error');
  } else {
    $messageStack->add(ERROR_CATALOG_THUMB_IMAGE_DIRECTORY_DOES_NOT_EXIST, 'error');
  }
  if (is_dir(DIR_FS_CATALOG_IMAGES_CAT)) {
    if (!tep_is_writable(DIR_FS_CATALOG_IMAGES_CAT)) $messageStack->add(ERROR_CATALOG_CATEGORY_IMAGE_DIRECTORY_NOT_WRITEABLE, 'error');
  } else {
    $messageStack->add(ERROR_CATALOG_CATEGORY_IMAGE_DIRECTORY_DOES_NOT_EXIST, 'error');
  }
  if (is_dir(DIR_FS_CATALOG_IMAGES_TEMP)) {
    if (!tep_is_writable(DIR_FS_CATALOG_IMAGES_TEMP)) $messageStack->add(ERROR_CATALOG_TEMP_IMAGE_DIRECTORY_NOT_WRITEABLE, 'error');
  } else {
    $messageStack->add(ERROR_CATALOG_TEMP_IMAGE_DIRECTORY_DOES_NOT_EXIST, 'error');
  }
  if (is_dir(DIR_FS_CATALOG_IMAGES_MFG)) {
    if (!tep_is_writable(DIR_FS_CATALOG_IMAGES_MFG)) $messageStack->add(ERROR_CATALOG_MFG_IMAGE_DIRECTORY_NOT_WRITEABLE, 'error');
  } else {
    $messageStack->add(ERROR_CATALOG_MFG_IMAGE_DIRECTORY_DOES_NOT_EXIST, 'error');
  }

  require(DIR_WS_INCLUDES . 'template_top.php');

  if ($action == 'new_image') {
    echo tep_draw_form('new_image', 'image-manager.php', 'pid=' . $products_id . '&action=insert_image', 'post', 'enctype="multipart/form-data"'); ?>
    <table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td class="pageHeading"><?php echo HEADING_TITLE . '<br />' . sprintf(TEXT_NEW_IMAGE, $product_info['products_name']); ?></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
      </tr>
      <tr>
        <td><table border="0" cellspacing="0" cellpadding="2">
          <tr>
            <td class="main"><?php echo TEXT_IMAGE_DISPLAY; ?></td>
            <td class="main"><?php echo tep_draw_radio_field('image_display', '2', false, $product_info['image_display']) . '&nbsp;' . TEXT_NO_IMAGE . '<br />' . tep_draw_radio_field('image_display', '1', false, $product_info['image_display']) . '&nbsp;' . TEXT_IMAGE_NOT_AVAILABLE . '<br />' . tep_draw_radio_field('image_display', '0', false, $product_info['image_display']) . '&nbsp;' . TEXT_USE_PRODUCT_IMAGE; ?></td>
          </tr>
          <tr>
            <td class="main"><?php echo TEXT_PRODUCTS_IMAGE; ?></td>
            <td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_file_field('products_image'); ?></td>
          </tr>
          <tr>
            <td class="main" align="right"><?php echo tep_draw_checkbox_field('set_default','yes'); ?></td>
            <td class="main"><?php echo ENTRY_SET_DEFAULT_IMAGE; ?></td>
          </tr>
          <tr>
            <td class="main" align="right"><?php echo ENTRY_SORT_ORDER; ?></td>
            <td class="main"><?php echo tep_draw_input_field('sort_order', '', 'size=5'); ?></td>
          </tr>
          <tr>
            <td class="main" align="right"><?php echo ENTRY_HTML; ?></td>
            <td class="main"><?php echo tep_draw_textarea_field('htmlcontent', 'soft', '70', '3'); ?></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
      </tr>
      <tr>
        <td class="main"><?php echo tep_draw_button(IMAGE_INSERT, 'disk', null, 'primary') . '&nbsp;&nbsp;' . tep_draw_button(IMAGE_CANCEL, 'cancel', tep_href_link('image-manager.php', 'pid=' . $products_id)); ?></td>
      </tr>
    </table></form>
      <?php } elseif ($action == 'select_product') { // choose a different product
        echo '<p class="pageHeading">' . HEADING_TITLE . '<br />' . HEADING_SELECT_PRODUCT . "</p>\n<p>";
        // original code
        //echo tep_draw_button(BUTTON_CHECK_CAT, 'check', tep_href_link('image-manager.php', 'action=cat')) . tep_draw_button(BUTTON_CHECK_MFG, 'check', tep_href_link('image-manager.php', 'action=mfg')) . tep_draw_button(BUTTON_ORPHAN_CHECK, 'circle-check', tep_href_link('image-manager.php', 'action=orphans')) . tep_draw_button(BUTTON_PRODUCT_ENTRY, 'arrowreturn-1-e', tep_href_link('categories.php')) . "</p>\n<p>";
        echo tep_draw_button(BUTTON_CHECK_CAT, 'check', tep_href_link('image-manager.php', 'action=cat')) . tep_draw_button(BUTTON_CHECK_MFG, 'check', tep_href_link('image-manager.php', 'action=mfg')) . tep_draw_button(BUTTON_PRODUCT_ENTRY, 'arrowreturn-1-e', tep_href_link('categories.php')) . "</p>\n<p>";
        if (isset($HTTP_GET_VARS['method']) && ($HTTP_GET_VARS['method'] == 'list')) {
          echo tep_draw_form('product_selection', 'image-manager.php', '', 'get') . "\n";
          echo tep_draw_products_pull_down('pid', 'style="font-size:10px"') . "\n";
          echo tep_draw_button(BUTTON_SELECT, 'refresh', null,'primary') . "</form>\n";
          echo '<p>' . tep_draw_button(BUTTON_SELECT_SEARCH, 'search', tep_href_link('image-manager.php', 'action=select_product&method=search')) . "\n";
        } else {
          echo tep_draw_form('product_selection', 'image-manager.php', 'action=find&method=search', 'get') . "\n";
          echo tep_draw_hidden_field('action', 'find') . tep_draw_hidden_field('method', 'search') . "\n";
          echo TEXT_ENTER_TERMS . "<br />\n";
          echo tep_draw_input_field('keywords', '', 'size=50') . tep_draw_button(BUTTON_SEARCH, 'search', null, 'primary') . "<br />\n";
          echo tep_draw_radio_field('within', 'name') . '&nbsp;' . TEXT_NAME_ONLY . '&nbsp;' . tep_draw_radio_field('within', 'all', 'all') . '&nbsp;' . TEXT_DESCRIPTIONS. "</form></p>\n<p>" .
tep_draw_button(BUTTON_SELECT_DROPDOWN, 'search', tep_href_link('image-manager.php', 'action=select_product&method=list'));
        }
        echo "</p></td>\n";
      } elseif ($action == 'choose') { /* search found more than one matching product */
        echo '<p class="pageHeading">' . HEADING_TITLE . '<br />' . HEADING_SELECT_PRODUCT . "</p>\n<p>";
        ?>
        <table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td valign="top"><table border="0" width="100%" cellspacing="0" cellpadding="2">
              <tr class="dataTableHeadingRow">
                <td class="dataTableHeadingContent"><?php echo TABLE_HEADING_MODEL; ?></td>
                <td class="dataTableHeadingContent"><?php echo TABLE_HEADING_NAME; ?></td>
                <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_PRODUCT_PRICE; ?></td>
                <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_ACTION; ?>&nbsp;</td>
              </tr>
<?php
$cid = (isset($HTTP_GET_VARS['cid']) ? $HTTP_GET_VARS['cid'] : '');
while ($info = tep_db_fetch_array($query)) { // list all matching products
  if ($cid == '') $cid = $info['products_id']; // if chosen id not set, set to first product found
  if ($info['products_id'] == $cid) {
    echo '              <tr id="defaultSelected" class="dataTableRowSelected" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link('image-manager.php', 'pid=' . $cid) . '\'">' . "\n";
    $selected = $info;
  } else {
    echo '              <tr class="dataTableRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link('image-manager.php', 'action=find&cid=' . $info['products_id'] . '&keywords=' . $keywords . '&within=' . $within) . '\'">' . "\n";
  }
?>
                <td class="dataTableContent"><?php echo $info['products_model']; ?></td>
                <td class="dataTableContent"><?php echo $info['products_name']; ?></td>
                <td class="dataTableContent" align="right"><?php echo $currencies->format($info['products_price']); ?></td>
                <td class="dataTableContent" align="right"><?php if ($info['products_id'] == $cid) { echo tep_image(DIR_WS_IMAGES . 'icon_arrow_right.gif'); } else { echo '<a href="' . tep_href_link('image-manager.php', 'action=find&cid=' . $info['products_id'] . '&keywords=' . $keywords . '&within=' . $within) . '">' . tep_image(DIR_WS_IMAGES . 'icon_info.gif', IMAGE_ICON_INFO) . '</a>'; } ?>&nbsp;</td>
              </tr>
<?php
    }
    echo '</table>';
  } elseif ($action == 'cat_add') { // add category image
    $cid = $HTTP_GET_VARS['cid'];
?>
    <table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td class="pageHeading"><?php echo HEADING_TITLE . '<br />' . sprintf(TEXT_NEW_IMAGE, tep_output_generated_category_path($cid)); ?></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
      </tr>
      <tr>
        <td>
<?php
    echo tep_draw_form('new_image', 'image-manager.php', 'action=cat_save', 'post', 'enctype="multipart/form-data"') . tep_draw_file_field('image') . tep_draw_hidden_field('cid', $cid);
    echo '<br />' . tep_draw_button(IMAGE_SAVE, 'disk', null, 'primary') . '&nbsp;&nbsp;' . tep_draw_button(IMAGE_CANCEL, 'cancel', tep_href_link('image-manager.php', 'action=cat')) . '</form>';
?>
        </td>
<?php
  } elseif (($action == 'cat') || ($action == 'cat_delimg')) { // category image check
 ?>
    <table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td class="pageHeading"><?php echo HEADING_TITLE . '<br />' . BUTTON_CHECK_CAT; ?></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
      </tr>
      <tr>
        <td>
<?php
    echo tep_draw_button(BUTTON_REBUILD_THUMBS, 'image', tep_href_link('image-manager.php', 'action=rebuild_cat_thumbs'));
    echo tep_draw_button(BUTTON_SELECT_DROPDOWN, 'script', tep_href_link('image-manager.php', 'action=select_product&method=list'));
    echo tep_draw_button(BUTTON_SELECT_SEARCH, 'search', tep_href_link('image-manager.php', 'action=select_product&method=search'));
    //echo tep_draw_button(BUTTON_CHECK_MFG, 'check', tep_href_link('image-manager.php', 'action=mfg')) . tep_draw_button(BUTTON_ORPHAN_CHECK, 'circle-check', tep_href_link('image-manager.php', 'action=orphans'));
    echo tep_draw_button(BUTTON_CHECK_MFG, 'check', tep_href_link('image-manager.php', 'action=mfg'));
    echo tep_draw_button(BUTTON_PRODUCT_ENTRY, 'arrowreturn-1-e', tep_href_link('categories.php')) . "\n";
    echo ' <table border="1" cellspacing="0" cellpadding="2">' . "\n";
    echo '   <tr><th>' . TABLE_HEADING_CATEGORY . '</th><th>' . TABLE_HEADING_IMAGE . '</th><th>' . TABLE_HEADING_ERRORS . '<th>' . TABLE_HEADING_ACTION . "</th></tr>\n";
    $categories = tep_get_category_tree(0, '', '0'); // show categories in tree order
    foreach ($categories as $cat) {
      $query = tep_db_query('select categories_image from ' . TABLE_CATEGORIES . ' where categories_id = ' . (int)$cat['id']);
      $img = tep_db_fetch_array($query);
      echo '<tr><td class="main">' . $cat['text'] . '</td><td class="main">' . tep_catalog_image(DIR_WS_CATALOG_IMAGES_ORIG . $img['categories_image'], $cat['text'], SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT, 'hspace="5" vspace="5" valign="middle"') . '<br />' . $img['categories_image'] . '</td><td class="main">';
      $error = $invalid = $noimg = false;
      if (tep_not_null($img['categories_image'])) {
        if (is_file(DIR_FS_CATALOG_IMAGES_ORIG . $img['categories_image'])) {
          if (!tep_get_web_image_type(DIR_FS_CATALOG_IMAGES_ORIG . $img['categories_image'])) {
            $invalid = true;
            echo TEXT_ERROR_INVALID_ORIG;
          }
        } else {
          $invalid = true;
          echo TEXT_ERROR_NO_ORIG;
        }
        if (is_file(DIR_FS_CATALOG_IMAGES_CAT . $img['categories_image'])) {
          if (tep_get_web_image_type(DIR_FS_CATALOG_IMAGES_CAT . $img['categories_image'])) {
            $size = getimagesize(DIR_FS_CATALOG_IMAGES_CAT . $img['categories_image']);
            if (($size[0] != SUBCATEGORY_IMAGE_WIDTH) || ($size[1] != SUBCATEGORY_IMAGE_HEIGHT)) {
              $error = true;
              echo TEXT_ERROR_THUMB_SIZE;
            }
          } else {
            $error = true;
            echo TEXT_ERROR_INVALID_THUMB;
          }
        } else {
          $error = true;
          echo TEXT_ERROR_NO_THUMB;
        }
      } else {
        $noimg = true;
        echo TEXT_NO_IMAGE_FILE;
      }
      if (!($error || $invalid)) echo TEXT_NO_ERRORS;
      echo '</td><td class="main">';
      if ($invalid && !$error) echo tep_draw_button(BUTTON_COPY_THUMB, 'copy', tep_href_link('image-manager.php', 'cid=' . $cat['id'] . '&action=cat_copy_thumb'));
      if ($invalid || $error) echo tep_draw_button(BUTTON_DELETE_IMAGE, 'trash', tep_href_link('image-manager.php', 'cid=' . $cat['id'] . '&action=cat_delimg'));
      if ($error && !$invalid) echo tep_draw_button(BUTTON_REBUILD_THUMB, 'image', tep_href_link('image-manager.php', 'cid=' . $cat['id'] . '&action=cat_fix_thumb'));
      if ($noimg) {
        echo tep_draw_button(BUTTON_ADD_IMG, 'plusthick', tep_href_link('image-manager.php', 'action=cat_add&cid=' . $cat['id']));
      } else {
        echo tep_draw_button(BUTTON_CHANGE_IMG, 'image', tep_href_link('image-manager.php', 'action=cat_add&cid=' . $cat['id']));
      }
      echo "</td>\n";
    }
?>
          </table>
        </td>
<?php
  } elseif ($action == 'mfg_add') { // add manufacturer image
    $mid = $HTTP_GET_VARS['mid'];
    $query = tep_db_query('select manufacturers_name from ' . TABLE_MANUFACTURERS . ' where manufacturers_id = ' . (int)$mid);
    $mfg = tep_db_fetch_array($query);
?>
    <table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td class="pageHeading"><?php echo HEADING_TITLE . '<br />' . sprintf(TEXT_NEW_IMAGE, $mfg['manufacturers_name']); ?></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
      </tr>
      <tr>
        <td>
<?php
    echo tep_draw_form('new_image', 'image-manager.php', 'action=mfg_save', 'post', 'enctype="multipart/form-data"') . tep_draw_file_field('image') . tep_draw_hidden_field('mid', $mid);
    echo '<br />' . tep_draw_button(IMAGE_SAVE, 'disk', null, 'primary') . '&nbsp;&nbsp;' . tep_draw_button(IMAGE_CANCEL, 'cancel', tep_href_link('image-manager.php', 'action=mfg')) . '</form>';
?>
        </td>
<?php
  } elseif (($action == 'mfg') || ($action == 'mfg_delimg')) { // manufacturer image check
?>
    <table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td class="pageHeading"><?php echo HEADING_TITLE . '<br />' . BUTTON_CHECK_MFG; ?></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
      </tr>
      <tr>
        <td>
<?php
    echo tep_draw_button(BUTTON_REBUILD_THUMBS, 'image', tep_href_link('image-manager.php', 'action=rebuild_mfg_thumbs'));
    echo tep_draw_button(BUTTON_SELECT_DROPDOWN, 'script', tep_href_link('image-manager.php', 'action=select_product&method=list'));
    echo tep_draw_button(BUTTON_SELECT_SEARCH, 'search', tep_href_link('image-manager.php', 'action=select_product&method=search'));
    // original code
    //echo tep_draw_button(BUTTON_CHECK_CAT, 'check', tep_href_link('image-manager.php', 'action=cat')) . tep_draw_button(BUTTON_ORPHAN_CHECK, 'circle-check', tep_href_link('image-manager.php', 'action=orphans'));
    echo tep_draw_button(BUTTON_CHECK_CAT, 'check', tep_href_link('image-manager.php', 'action=cat'));
    echo tep_draw_button(BUTTON_RETURN_MFG, 'arrowreturn-1-e', tep_href_link('manufacturers.php')) . "\n";
    echo ' <table border="1" cellspacing="0" cellpadding="2">' . "\n";
    echo '   <tr><th>' . TABLE_HEADING_MFG . '</th><th>' . TABLE_HEADING_IMAGE . '</th><th>' . TABLE_HEADING_ERRORS . '<th>' . TABLE_HEADING_ACTION . "</th></tr>\n";
    $query = tep_db_query('select * from ' . TABLE_MANUFACTURERS . ' order by manufacturers_name');
    while ($mfg = tep_db_fetch_array($query)) {
      echo '<tr><td class="main">' . $mfg['manufacturers_name'] . '</td><td class="main">' . tep_catalog_image(DIR_WS_CATALOG_IMAGES_ORIG . $mfg['manufacturers_image'], $mfg['manufacturers_name'], SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT, 'hspace="5" vspace="5" valign="middle"') . '<br />' . $mfg['manufacturers_image'] . '</td><td class="main">';
      $error = $invalid = $noimg = false;
      if (tep_not_null($mfg['manufacturers_image'])) {
        if (is_file(DIR_FS_CATALOG_IMAGES_ORIG . $mfg['manufacturers_image'])) {
          if (!tep_get_web_image_type(DIR_FS_CATALOG_IMAGES_ORIG . $mfg['manufacturers_image'])) {
            $invalid = true;
            echo TEXT_ERROR_INVALID_ORIG;
          }
        } else {
          $invalid = true;
          echo TEXT_ERROR_NO_ORIG;
        }
        if (is_file(DIR_FS_CATALOG_IMAGES_MFG . $mfg['manufacturers_image'])) {
          if (tep_get_web_image_type(DIR_FS_CATALOG_IMAGES_MFG . $mfg['manufacturers_image'])) {
            $size = getimagesize(DIR_FS_CATALOG_IMAGES_MFG . $mfg['manufacturers_image']);
            if (($size[0] != SUBCATEGORY_IMAGE_WIDTH) || ($size[1] != SUBCATEGORY_IMAGE_HEIGHT)) {
              $error = true;
              echo TEXT_ERROR_THUMB_SIZE;
            }
          } else {
            $error = true;
            echo TEXT_ERROR_INVALID_THUMB;
          }
        } else {
          $error = true;
          echo TEXT_ERROR_NO_THUMB;
        }
      } else {
        $noimg = true;
        echo TEXT_NO_IMAGE_FILE;
      }
      if (!($error || $invalid)) echo TEXT_NO_ERRORS;
      echo '</td><td class="main">';
      if ($invalid && !$error) echo tep_draw_button(BUTTON_COPY_THUMB, 'copy', tep_href_link('image-manager.php', 'mid=' . $mfg['manufacturers_id'] . '&action=mfg_copy_thumb'));
      if ($invalid || $error) echo tep_draw_button(BUTTON_DELETE_IMAGE, 'trash', tep_href_link('image-manager.php', 'mid=' . $mfg['manufacturers_id'] . '&action=mfg_delimg'));
      if ($error && !$invalid) echo tep_draw_button(BUTTON_REBUILD_THUMB, 'image', tep_href_link('image-manager.php', 'mid=' . $mfg['manufacturers_id'] . '&action=mfg_fix_thumb'));
      if ($noimg) {
        echo tep_draw_button(BUTTON_ADD_IMG, 'plusthick', tep_href_link('image-manager.php', 'action=mfg_add&mid=' . $mfg['manufacturers_id']));
      } else {
        echo tep_draw_button(BUTTON_CHANGE_IMG, 'image', tep_href_link('image-manager.php', 'action=mfg_add&mid=' . $mfg['manufacturers_id']));
      }
      echo "</td>\n";
    }
?>
          </table>
        </td>
<?php
  } elseif ($action == 'orphans') { // check for orphaned images
?>
    <table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td class="pageHeading"><?php echo HEADING_TITLE . '<br />' . BUTTON_ORPHAN_CHECK; ?></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
      </tr>
      <tr>
        <td class="main"><?php echo TEXT_ORPHAN_CHECK; ?></td>
      </tr>
    </table>
<?php
    echo tep_draw_form('orphans', 'image-manager.php', 'action=orphans_remove', 'post', 'enctype="multipart/form-data"') . "\n";
    $entry = 0;
    function show_orphaned_folder_contents($location, $source, $valid = array('.', '..'), $checkmark = false) {
      global $entry;
      if ($handle = opendir($location)) {
        while ($file = readdir($handle)) { // list files in folder
          if (!in_array($file, $valid)) { // skip valid files
            $loc = $location . '/' . $file;
            if (is_dir($loc)) {
              echo '<p class="smallText specialPrice">' . tep_draw_checkbox_field('entry[' . $entry . ']', $entry, false) . TEXT_TYPE_FOLDER . tep_draw_hidden_field('type[' . $entry . ']', 'folder') . $loc . tep_draw_hidden_field('location[' . $entry . ']', $loc) . TEXT_ORPHAN_SOURCE . $source . tep_draw_hidden_field('source[' . $entry . ']', $source) . "</p>\n";
              $entry++;
              show_orphaned_folder_contents($loc, $source);
            } else {
              $fsrc = tep_catalog_href_link(tep_output_string(substr($loc, strlen(DIR_FS_CATALOG))));
              echo '<p class="smallText' . ($checkmark ? '' : ' specialPrice') . '">' . tep_draw_checkbox_field('entry[' . $entry . ']', $entry, $checkmark) . TEXT_TYPE_FILE . tep_draw_hidden_field('type[' . $entry . ']', 'file') . $loc . tep_draw_hidden_field('location[' . $entry . ']', $loc) . ' <img src="' . $fsrc . '" width="30" height="30" style="vertical-align: middle;" onclick="javascript:document.getElementById(' . $entry . ').style.display = \'\'" /><img src="' . $fsrc . '" id="' . $entry . '" style="vertical-align: middle; display: none;" onclick="javascript:document.getElementById(' . $entry . ').style.display = \'none\'" />' .  TEXT_ORPHAN_SOURCE . $source . tep_draw_hidden_field('source[' . $entry . ']', $source) . "</p>\n";
              $entry++;
            }
          }
        }
        closedir($handle);
      }
    } // end function
    $product_folders = array('.', '..');
    $query = tep_db_query("select p.products_id, p.products_model, p.products_image, p.image_folder, p.manufacturers_id, pd.products_name from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_id = pd.products_id and pd.language_id = " . (int)$languages_id);
    // check the folders for individual products
    while ($prod = tep_db_fetch_array($query)) {
      $product_folders[] = rtrim($prod['image_folder'], '/');
      $mfg_query = tep_db_query('select manufacturers_name from ' . TABLE_MANUFACTURERS . ' where manufacturers_id = ' . (int)$prod['manufacturers_id']);
      $mfg = tep_db_fetch_array($mfg_query);
      $source = $mfg['manufacturers_name'] . ' ' . $prod['products_model'] . ': ' . $prod['products_name'] . ' ';
      $images = array('.', '..');
      if (tep_not_null($prod['products_image'])) $images[] = $prod['products_image'];
      $img_query = tep_db_query('select image from ' . TABLE_PRODUCTS_IMAGES . ' where products_id = ' . (int)$prod['products_id']);
      while ($img = tep_db_fetch_array($img_query)) $images[] = $img['image']; // build list of image files used
      $src = $source . TEXT_ORIGINALS_FOLDER;
      show_orphaned_folder_contents(rtrim(DIR_FS_CATALOG_IMAGES_ORIG . $prod['image_folder'], '/'), $source . TEXT_ORIGINALS_FOLDER, $images, true);  // check product's originals folder
      show_orphaned_folder_contents(rtrim(DIR_FS_CATALOG_IMAGES_PROD . $prod['image_folder'], '/'), $source . TEXT_LARGE_FOLDER, $images, true); // check large images folder
      show_orphaned_folder_contents(rtrim(DIR_FS_CATALOG_IMAGES_THUMBS . $prod['image_folder'], '/'), $source . TEXT_THUMBS_FOLDER, $images, true);// check thumbnails folder
    } // end of product check loop
    // check large images folder which should contain only product image folders
    show_orphaned_folder_contents(rtrim(DIR_FS_CATALOG_IMAGES_PROD, '/'), TEXT_LARGE_FOLDER, $product_folders, true);
    // check thumbnails folder which should contain only product image folders
    show_orphaned_folder_contents(rtrim(DIR_FS_CATALOG_IMAGES_THUMBS, '/'), TEXT_THUMBS_FOLDER, $product_folders, true);
    // check categories folder which should contain only category images
    $cat_images = array('.', '..');
    $query = tep_db_query('select categories_image from ' . TABLE_CATEGORIES);
    while ($cat = tep_db_fetch_array($query)) $cat_images[] = $cat['categories_image']; // build list of valid category images
    show_orphaned_folder_contents(rtrim(DIR_FS_CATALOG_IMAGES_CAT, '/'), TEXT_CAT_FOLDER, $cat_images, true);
    // check manufacturers folder which should contain only manufacturer images
    $mfg_images = array('.', '..');
    $query = tep_db_query('select manufacturers_image from ' . TABLE_MANUFACTURERS);
    while ($mfg = tep_db_fetch_array($query)) $mfg_images[] = $mfg['manufacturers_image']; // build list of valid manufacturer images
    show_orphaned_folder_contents(rtrim(DIR_FS_CATALOG_IMAGES_MFG, '/'), TEXT_MFG_FOLDER, $mfg_images, true);
    // check original images folder which should contain only category and manufacturer images and valid product folders
    $valid_files = array_merge($cat_images, $mfg_images, $product_folders);
    show_orphaned_folder_contents(rtrim(DIR_FS_CATALOG_IMAGES_ORIG, '/'), TEXT_ORIGINALS_FOLDER, $valid_files, true);
    // check temporary images folder which should be empty except during the processing of an image upload
    show_orphaned_folder_contents(rtrim(DIR_FS_CATALOG_IMAGES_TEMP, '/'), TEXT_TEMP_FOLDER, array('.', '..'), true);
    echo '<br />' . tep_draw_button(IMAGE_DELETE, 'trash', null, 'primary') . '&nbsp;&nbsp;' . tep_draw_button(IMAGE_CANCEL, 'cancel', tep_href_link('image-manager.php'));
?>
    </form>
    <table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td class="pageHeading"><?php echo TEXT_ORPHAN_COMPLETE; ?></td>
<?php
  } else { // product image list
?>
    <table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td class="pageHeading"><?php echo HEADING_TITLE . '<br />' . sprintf(TEXT_IMAGE_LIST, $product_info['products_name']); ?></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
      </tr>
      <tr>
        <td> <?php if ($product_info['image_display'] == 1) {
                echo tep_image(DIR_WS_LANGUAGES . $language . '/images/no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'hspace="5" vspace="5" valign="middle"');
                echo TEXT_DISPLAYS_NOIMG . '<br />';
                echo tep_draw_button(BUTTON_CHANGE_DISPLAY, 'wrench', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=new_image'));
                echo tep_draw_button(BUTTON_SELECT_DROPDOWN, 'script', tep_href_link('image-manager.php', 'action=select_product&method=list'));
                echo tep_draw_button(BUTTON_SELECT_SEARCH, 'search', tep_href_link('image-manager.php', 'action=select_product&method=search'));
                echo tep_draw_button(BUTTON_CHECK_CAT, 'check', tep_href_link('image-manager.php', 'action=cat'));
                //echo tep_draw_button(BUTTON_CHECK_MFG, 'check', tep_href_link('image-manager.php', 'action=mfg')) . tep_draw_button(BUTTON_ORPHAN_CHECK, 'circle-check', tep_href_link('image-manager.php', 'action=orphans'));
                echo tep_draw_button(BUTTON_CHECK_MFG, 'check', tep_href_link('image-manager.php', 'action=mfg'));
                echo tep_draw_button(BUTTON_PRODUCT_ENTRY, 'arrowreturn-1-e', tep_href_link('categories.php', 'cPath=' . $product_info['categories_id'] . '&pID=' . $products_id)) . "\n";
              } elseif ($product_info['image_display'] == 2) {
                echo TEXT_DISPLAYS_NOTHING . '<br />';
                echo tep_draw_button(BUTTON_CHANGE_DISPLAY, 'wrench', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=new_image'));
                echo tep_draw_button(BUTTON_SELECT_DROPDOWN, 'script', tep_href_link('image-manager.php', 'action=select_product&method=list'));
                echo tep_draw_button(BUTTON_SELECT_SEARCH, 'search', tep_href_link('image-manager.php', 'action=select_product&method=search'));
                echo tep_draw_button(BUTTON_CHECK_CAT, 'check', tep_href_link('image-manager.php', 'action=cat'));
                //echo tep_draw_button(BUTTON_CHECK_MFG, 'check', tep_href_link('image-manager.php', 'action=mfg')) . tep_draw_button(BUTTON_ORPHAN_CHECK, 'circle-check', tep_href_link('image-manager.php', 'action=orphans'));
                echo tep_draw_button(BUTTON_CHECK_MFG, 'check', tep_href_link('image-manager.php', 'action=mfg'));
                echo tep_draw_button(BUTTON_PRODUCT_ENTRY, 'arrowreturn-1-e', tep_href_link('categories.php', 'cPath=' . $product_info['categories_id'] . '&pID=' . $products_id)) . "\n";
              } else {
                echo tep_draw_button(BUTTON_ADD_IMAGE, 'plusthick', tep_href_link( 'image-manager.php', 'pid=' . $products_id . '&action=new_image'));
                echo tep_draw_button(BUTTON_REBUILD_THUMBS, 'image', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=rebuild_thumbs'));
                echo tep_draw_button(BUTTON_SELECT_DROPDOWN, 'script', tep_href_link('image-manager.php', 'action=select_product&method=list'));
                echo tep_draw_button(BUTTON_SELECT_SEARCH, 'search', tep_href_link('image-manager.php', 'action=select_product&method=search'));
                echo tep_draw_button(BUTTON_CHECK_CAT, 'check', tep_href_link('image-manager.php', 'action=cat'));
                //echo tep_draw_button(BUTTON_CHECK_MFG, 'check', tep_href_link('image-manager.php', 'action=mfg')) . tep_draw_button(BUTTON_ORPHAN_CHECK, 'circle-check', tep_href_link('image-manager.php', 'action=orphans'));
                echo tep_draw_button(BUTTON_CHECK_MFG, 'check', tep_href_link('image-manager.php', 'action=mfg'));
                echo tep_draw_button(BUTTON_PRODUCT_ENTRY, 'arrowreturn-1-e', tep_href_link('categories.php', 'cPath=' . $product_info['categories_id'] . '&pID=' . $products_id)) . "\n";
                echo'<br /><br />';

                echo ' <table border="1" cellspacing="0" cellpadding="2">' . "\n";
                echo '<tr><td colspan="4">' . TEXT_DEFAULT_IMG_NOTE . "</td></tr>\n";
                echo '   <tr><th>' . TABLE_HEADING_IMAGE . '</th><th>' . TABLE_HEADING_FNAME . '</th><th>' . TABLE_HEADING_ERRORS . '<th>' . TABLE_HEADING_ACTION . "</th></tr>\n";
                if (tep_not_null(DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'])) {
                  $orig_images = array();
                  if ($handle = opendir(DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'])) {
                    while ($file = readdir($handle)) { // build list of image files in product's original image directory
                      if (in_array(strtolower(substr($file, strrpos($file, '.')+1)), array('gif', 'png', 'jpg', 'jpeg'))) {
                        $orig_images[] = $file;
                        if ($file == $product_info['products_image']) {
                        	echo '    <tr><td>' . tep_catalog_image(DIR_WS_CATALOG_IMAGES_ORIG . $product_info['image_folder'] . $file, $product_info['products_name'], SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'hspace="5" vspace="5" valign="middle"') . "</td><td class='main'>" . $file . '</td>';
                        	echo '<td class="main">';
                        	$error = $nodb_error = $invalid = false;
                        	if (is_file(DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $file)) {
                          	if (!tep_get_web_image_type(DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $file)) {
                            	$error = true;
                            	echo TEXT_ERROR_INVALID_THUMB;
                          	}
                        	} else {
                          	$error = true;
                          	echo TEXT_ERROR_NO_THUMB;
                        	}

                        	if (is_file(DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'] . $file)) {
                          	if (!tep_get_web_image_type(DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'] . $file)) {
                            	$error = true;
                            	echo TEXT_ERROR_INVALID_LARGE;
                          	}
                        	} else {
                          	$error = true;
                          	echo TEXT_ERROR_NO_LARGE;
                        	}
                        	if (!tep_get_web_image_type(DIR_FS_CATALOG_IMAGES_ORIG . $product_info['image_folder'] . $file)) {
                          	$error = $invalid = true;
                          	echo TEXT_ERROR_INVALID_ORIG;
                        	}
                        	if (in_array($file, $product_images)) {
                          	foreach ($image_table as $i) {
                            	if ($i['image'] == $file) {
                              	if (tep_not_null($i['htmlcontent'])) {
                                	echo TEXT_HAS_HTML;
                              	} else {
                              	 	echo TEXT_NO_HTML;
                              	}
                              	break;
                            	}
                          	}
                        	} else {
                          	$error = $nodb_error = true;
                          	//echo TEXT_ERROR_NOT_DB;
                        	}
                        	if (!$error) echo TEXT_NO_ERRORS;
                        	echo '</td>';
                        	echo '<td class="main">' . tep_draw_button(BUTTON_DELETE_IMAGE, 'trash', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=delete_image&image_file=' . $file)) . ' ';
                        	if (!$invalid) {
                          	if ($file == $product_info['products_image']) {
                            	echo TEXT_THIS_DEFAULT;
                          	} else {
                            	echo tep_draw_button(BUTTON_DEFAULT, 'tag', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=make_default&image_file='. $file));
                          	}
                          	//if ($nodb_error) echo ' ' . tep_draw_button(BUTTON_ADD_DB, 'plus', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=db_add&image_file='. $file));
                        	}
                        	echo "</td></tr>\n";
                      	}
                      }
                    }
                    closedir($handle);
                  }
                  $large_images = array();
                  if ($handle = opendir(DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'])) {
                    while ($file = readdir($handle)) { // build list of image files in product's large image directory
                      if (in_array(strtolower(substr($file, strrpos($file, '.')+1)), array('gif', 'png', 'jpg', 'jpeg'))) {
                        if (!in_array($file, $orig_images)) { // list only those not found in the original images folder
                          $large_images[] = $file;
                          echo '    <tr><td>' . tep_catalog_image(DIR_WS_CATALOG_IMAGES_PROD . $product_info['image_folder'] . $file, $product_info['products_name'], SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'hspace="5" vspace="5"') . "</td><td class='main'>" . $file . '</td>';
                          echo '<td class="main">' . TEXT_ERROR_NO_ORIG;
                          $nodb_error = $invalid = false;
                          if (is_file(DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $file)) {
                            if (!tep_get_web_image_type(DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $file)) {
                              echo TEXT_ERROR_INVALID_THUMB;
                            }
                          } else {
                            echo TEXT_ERROR_NO_THUMB;
                          }
                          if (!tep_get_web_image_type(DIR_FS_CATALOG_IMAGES_PROD . $product_info['image_folder'] . $file)) {
                            $invalid = true;
                            echo TEXT_ERROR_INVALID_LARGE;
                          }
                          if (in_array($file, $product_images)) {
                            foreach ($image_table as $i) {
                              if ($i['image'] == $file) {
                                if (tep_not_null($i['htmlcontent'])) {
                                  echo TEXT_HAS_HTML;
                                } else {
                                  echo TEXT_NO_HTML;
                                }
                                break;
                              }
                            }
                          } else {
                            $nodb_error = true;
                            //echo TEXT_ERROR_NOT_DB;
                          }
                          echo '</td>';
                          echo '<td class="main">' . tep_draw_button(BUTTON_DELETE_IMAGE, 'trash', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=delete_image&image_file=' . $file)) . ' ';
                          if (!$invalid) {
                            echo tep_draw_button(BUTTON_ADD_ORIG, 'copy', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=copy_large_orig&image_file='. $file));
                            //if ($nodb_error) echo ' ' . tep_draw_button(BUTTON_ADD_DB, 'plus', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=db_add&image_file='. $file));
                          }
                          echo "</td></tr>\n";
                        }
                      }
                    }
                    closedir($handle);
                  }
                  $thumb_files = array();
                  if ($handle = opendir(DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'])) {
                    while ($file = readdir($handle)) { // now check product's thumbnail image directory
                      if (in_array(strtolower(substr($file, strrpos($file, '.')+1)), array('gif', 'png', 'jpg', 'jpeg'))) {
                        if (!in_array($file, $orig_images) && !in_array($file, $large_images)) { // list only those not found in the other image folders
                          echo '    <tr><td>' . tep_catalog_image(DIR_WS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $file, $product_info['products_name'], SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'hspace="5" vspace="5"') . "</td><td class='main'>" . $file . '</td><td class="main">' . TEXT_ERROR_NO_ORIG . TEXT_ERROR_NO_LARGE;
                          $thumb_files[] = $file;
                          $nodb_error = $invalid = false;
                          if (!tep_get_web_image_type(DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $file)) {
                            $invalid = true;
                            echo TEXT_ERROR_INVALID_THUMB;
                          }
                          if (in_array($file, $product_images)) {
                            foreach ($image_table as $i) {
                              if ($i['image'] == $file) {
                                if (tep_not_null($i['htmlcontent'])) {
                                  echo TEXT_HAS_HTML;
                                } else {
                                  echo TEXT_NO_HTML;
                                }
                                break;
                              }
                            }
                          } else {
                            $nodb_error = true;
                            //echo TEXT_ERROR_NOT_DB;
                          }
                          echo '</td><td class="main">' . tep_draw_button(BUTTON_DELETE_IMAGE, 'trash', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=delete_image&image_file=' . $file)) . ' ';
                          if (!$invalid) {
                            $size = getimagesize(DIR_FS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $file);
                            if (($size[0] >= (LARGE_IMAGE_WIDTH * 0.75)) && ($size[1] >= (LARGE_IMAGE_HEIGHT * 0.75))) { // only allow actions other than delete if image size is at least 75% of large image size
                              echo tep_draw_button(BUTTON_ADD_ORIG, 'copy', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=copy_large_orig&src=thumb&image_file='. $file));
                              //if ($nodb_error) echo ' ' . tep_draw_button(BUTTON_ADD_DB, 'plus', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=db_add&image_file='. $file));
                            }
                          }
                          echo "</td></tr>\n";
                        }
                      }
                    }
                    closedir($handle);
                  }
                  foreach ($product_images as $image) { // check database
                    if (!in_array($image, $orig_images) && !in_array($image, $large_images) && !in_array($image, $thumb_files)) {
                      echo "    <tr><td>" . TEXT_DB_ONLY . "</td><td class='main'>" . $image . '</td><td class="main">' . TEXT_ERROR_NO_ORIG . TEXT_ERROR_NO_LARGE . TEXT_ERROR_NO_THUMB;
                      foreach ($image_table as $i) {
                        if ($i['image'] == $image) {
                          if (tep_not_null($i['htmlcontent'])) {
                            echo TEXT_HAS_HTML;
                          } else {
                            echo TEXT_NO_HTML;
                          }
                          break;
                        }
                      }
                      echo '</td><td class="main">' . tep_draw_button(BUTTON_DB_REMOVE, 'minusthick', tep_href_link('image-manager.php', 'pid=' . $products_id . '&action=delete_image&image_file=' . $image)) . "</td></tr>\n";
                    }
                  }
                } else {
                  echo '<tr><th colspan="4">' . TEXT_ERROR_NO_IMG_FOLDER . "</th></tr>\n";
                }
                echo '</table>';
 
              }
 ?>
        </td>
<?php
  }
    $heading = array();
    $contents = array();
    switch ($action) { // create information box
      case 'choose':
        if (isset($selected)) {
          $heading[] = array('text' => $selected['products_name']);
          $contents[] = array('align' => 'center', 'text' => tep_draw_button(BUTTON_SELECT, 'check' . BUTTON_SELECT, tep_href_link('image-manager.php', 'pid=' . $selected['products_id']), 'primary'));
          $contents[] = array('align' => 'center', 'text' => tep_draw_button(BUTTON_RETRY, 'refresh', tep_href_link('image-manager.php', 'action=select_product&method=search&selected_box=catalog')));
          $contents[] = array('text' => TEXT_INFO_MANUFACTURER . $selected['manufacturers_name']);
          $contents[] = array('text' => TEXT_INFO_MODEL . $selected['products_model']);
          $contents[] = array('text' => TEXT_INFO_PRICE . $currencies->format($selected['products_price']));
        }
        break;
      case 'delete_image':
        $heading[] = array('text' => '<strong>' . TEXT_INFO_HEADING_DELETE_IMAGE . '</strong>');

        $contents = array('form' => tep_draw_form('products', 'image-manager.php', 'action=delete_image_confirm&selected_box=catalog&pid=' . $products_id) . tep_draw_hidden_field('image_file', $HTTP_GET_VARS['image_file']));
        $contents[] = array('text' => '<br /><strong>' . $product_info['products_name'] . '</strong>');
        $contents[] = array('align' => 'center', 'text' => '<br />' . tep_catalog_image(DIR_WS_CATALOG_IMAGES_THUMBS . $product_info['image_folder'] . $HTTP_GET_VARS['image_file'], $product_info['products_name'], SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT) . '<br />' . $HTTP_GET_VARS['image_file']);
        $contents[] = array('text' => '<br />' . TEXT_DELETE_IMAGE_INTRO);
        $contents[] = array('align' => 'center', 'text' => '<br />' . tep_draw_button(IMAGE_DELETE, 'trash', null, 'primary') . tep_draw_button(IMAGE_CANCEL, 'cancel', tep_href_link('image-manager.php', 'pid=' . $products_id)));
        break;
      case 'rebuild_thumbs':
        $heading[] = array('text' => '<strong>' . BUTTON_REBUILD_THUMBS . '</strong>');

        $contents = array('form' => tep_draw_form('products', 'image-manager.php', 'action=rebuild_confirm&selected_box=catalog&pid=' . $products_id));
        $contents[] = array('text' => '<br />' . TEXT_REBUILD_FOR);
        $contents[] = array('text' => tep_draw_radio_field('rebuild_for', 'this', true) . TEXT_THIS_PRODUCT);
        $contents[] = array('text' => tep_draw_radio_field('rebuild_for', 'all', false) . TEXT_ALL_PRODUCT);
        $contents[] = array('text' => '<br />' . TEXT_REBUILD_TIME);
        $contents[] = array('align' => 'center', 'text' => '<br />' . tep_draw_button(IMAGE_CONFIRM, 'refresh', null, 'primary') . tep_draw_button(IMAGE_CANCEL, 'cancel', tep_href_link('image-manager.php', 'pid=' . $products_id)));
        break;
      case 'mfg_delimg':
        $heading[] = array('text' => '<strong>' . TEXT_INFO_HEADING_DELETE_IMAGE . '</strong>');

        $contents = array('form' => tep_draw_form('products', 'image-manager.php', 'action=mfg_delimg_confirm&selected_box=catalog'));
        $query = tep_db_query('select * from ' . TABLE_MANUFACTURERS . ' where manufacturers_id = ' . (int)$HTTP_GET_VARS['mid']);
        $mfg = tep_db_fetch_array($query);
        $contents[] = array('text' => '<br /><strong>' . $mfg['manufacturers_name'] . '</strong>');
        $contents[] = array('align' => 'center', 'text' => '<br />' . tep_catalog_image(DIR_WS_CATALOG_IMAGES_MFG . $mfg['manufacturers_image'], $mfg['manufacturers_name'], SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT) . '<br />' . $mfg['manufacturers_image']);
        $contents[] = array('text' => '<br />' . TEXT_DELETE_IMAGE_INTRO . tep_draw_hidden_field('mid', $HTTP_GET_VARS['mid']));
        $contents[] = array('align' => 'center', 'text' => '<br />' . tep_draw_button(IMAGE_DELETE, 'trash', null, 'primary') . tep_draw_button(IMAGE_CANCEL, 'cancel', tep_href_link('image-manager.php', 'action=mfg')));
        break;
      case 'cat_delimg':
        $heading[] = array('text' => '<strong>' . TEXT_INFO_HEADING_DELETE_IMAGE . '</strong>');

        $contents = array('form' => tep_draw_form('products', 'image-manager.php', 'action=cat_delimg_confirm&selected_box=catalog'));
        $query = tep_db_query('select categories_image from ' . TABLE_CATEGORIES . ' where categories_id = ' . (int)$HTTP_GET_VARS['cid']);
        $cat = tep_db_fetch_array($query);
        $cname = tep_output_generated_category_path($HTTP_GET_VARS['cid']);
        $contents[] = array('text' => '<br /><strong>' . $cname . '</strong>');
        $contents[] = array('align' => 'center', 'text' => '<br />' . tep_catalog_image(DIR_WS_CATALOG_IMAGES_CAT . $cat['categories_image'], $cname, SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT) . '<br />' . $cat['categories_image']);
        $contents[] = array('text' => '<br />' . TEXT_DELETE_IMAGE_INTRO . tep_draw_hidden_field('cid', $HTTP_GET_VARS['cid']));
        $contents[] = array('align' => 'center', 'text' => '<br />' . tep_draw_button(IMAGE_DELETE, 'trash', null, 'primary') . tep_draw_button(IMAGE_CANCEL, 'cancel', tep_href_link('image-manager.php', 'action=cat')));
        break;
      default:
    }
    if ( (tep_not_null($heading)) && (tep_not_null($contents)) ) {
      echo '            <td width="25%" valign="top">' . "\n";

      $box = new box;
      echo $box->infoBox($heading, $contents);

      echo '            </td>' . "\n";
    }
?>
      </tr>
    </table>

<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
