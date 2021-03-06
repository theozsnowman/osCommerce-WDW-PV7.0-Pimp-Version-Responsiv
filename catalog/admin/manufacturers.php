<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2013 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  $action = (isset($HTTP_GET_VARS['action']) ? $HTTP_GET_VARS['action'] : '');

  if (tep_not_null($action)) {
    switch ($action) {
      case 'insert':
      case 'save':
        if (isset($HTTP_GET_VARS['mID'])) $manufacturers_id = tep_db_prepare_input($HTTP_GET_VARS['mID']);
        $manufacturers_name = tep_db_prepare_input($HTTP_POST_VARS['manufacturers_name']);

        $sql_data_array = array('manufacturers_name' => $manufacturers_name);

        if ($action == 'insert') {
          $insert_sql_data = array('date_added' => 'now()');

          $sql_data_array = array_merge($sql_data_array, $insert_sql_data);

          tep_db_perform(TABLE_MANUFACTURERS, $sql_data_array);
          $manufacturers_id = tep_db_insert_id();
        } elseif ($action == 'save') {
          $update_sql_data = array('last_modified' => 'now()');

          $sql_data_array = array_merge($sql_data_array, $update_sql_data);

          tep_db_perform(TABLE_MANUFACTURERS, $sql_data_array, 'update', "manufacturers_id = '" . (int)$manufacturers_id . "'");
        }
        
        /* 
        // original code
        $manufacturers_image = new upload('manufacturers_image');
        $manufacturers_image->set_destination(DIR_FS_CATALOG_IMAGES);

        if ($manufacturers_image->parse() && $manufacturers_image->save()) {
          tep_db_query("update " . TABLE_MANUFACTURERS . " set manufacturers_image = '" . tep_db_input($manufacturers_image->filename) . "' where manufacturers_id = '" . (int)$manufacturers_id . "'");
        }
				*/
				$manufacturers_image = new upload('manufacturers_image');
        $webimgtypes = array ('jpg', 'jpeg', 'gif', 'png');
        $manufacturers_image->set_extensions($webimgtypes);
        $manufacturers_image->set_destination(DIR_FS_CATALOG_IMAGES_TEMP);
        $manufacturers_image->set_output_messages('session');
        $manufacturers_image->set_no_file_warning(true);
        if ($manufacturers_image->parse() && $manufacturers_image->save()) {
          $source = DIR_FS_CATALOG_IMAGES_TEMP . $manufacturers_image->filename;
          if ($ext = tep_get_web_image_type($source)) {
            if ($ext != false) {
              $new_file_name = 'mfg' . $manufacturers_id . '.' . $ext;
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
                tep_db_query("update " . TABLE_MANUFACTURERS . " set manufacturers_image = '" . tep_db_input($new_file_name) . "' where manufacturers_id = '" . (int)$manufacturers_id . "'");
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
        
        $languages = tep_get_languages();
        for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
          $manufacturers_url_array = $HTTP_POST_VARS['manufacturers_url'];
          $manufacturers_description_array = $HTTP_POST_VARS['manufacturers_description'];
          $manufacturers_seo_description_array = $HTTP_POST_VARS['manufacturers_seo_description'];
          $manufacturers_seo_keywords_array = $HTTP_POST_VARS['manufacturers_seo_keywords'];
          $manufacturers_seo_title_array = $HTTP_POST_VARS['manufacturers_seo_title'];
          $language_id = $languages[$i]['id'];

          $sql_data_array = array('manufacturers_url' => tep_db_prepare_input($manufacturers_url_array[$language_id]));
          $sql_data_array['manufacturers_description'] = tep_db_prepare_input($manufacturers_description_array[$language_id]);
          $sql_data_array['manufacturers_seo_description'] = tep_db_prepare_input($manufacturers_seo_description_array[$language_id]);
          $sql_data_array['manufacturers_seo_keywords'] = tep_db_prepare_input($manufacturers_seo_keywords_array[$language_id]);
          $sql_data_array['manufacturers_seo_title'] = tep_db_prepare_input($manufacturers_seo_title_array[$language_id]);

          if ($action == 'insert') {
            $insert_sql_data = array('manufacturers_id' => $manufacturers_id,
                                     'languages_id' => $language_id);

            $sql_data_array = array_merge($sql_data_array, $insert_sql_data);

            tep_db_perform(TABLE_MANUFACTURERS_INFO, $sql_data_array);
          } elseif ($action == 'save') {
            tep_db_perform(TABLE_MANUFACTURERS_INFO, $sql_data_array, 'update', "manufacturers_id = '" . (int)$manufacturers_id . "' and languages_id = '" . (int)$language_id . "'");
          }
        }

        if (USE_CACHE == 'true') {
          tep_reset_cache_block('manufacturers');
        }

        tep_redirect(tep_href_link('manufacturers.php', (isset($HTTP_GET_VARS['page']) ? 'page=' . $HTTP_GET_VARS['page'] . '&' : '') . 'mID=' . $manufacturers_id));
        break;
      case 'deleteconfirm':
        $manufacturers_id = tep_db_prepare_input($HTTP_GET_VARS['mID']);

        if (isset($HTTP_POST_VARS['delete_image']) && ($HTTP_POST_VARS['delete_image'] == 'on')) {
          $manufacturer_query = tep_db_query("select manufacturers_image from " . TABLE_MANUFACTURERS . " where manufacturers_id = '" . (int)$manufacturers_id . "'");
          $manufacturer = tep_db_fetch_array($manufacturer_query);
					
					/*
					// original code	
          $image_location = DIR_FS_DOCUMENT_ROOT . DIR_WS_CATALOG_IMAGES . $manufacturer['manufacturers_image'];
          if (file_exists($image_location)) @unlink($image_location);
          */
          if (tep_not_null($manufacturer['manufacturers_image'])) {
            $image_location = DIR_FS_CATALOG_IMAGES_MFG . $manufacturer['manufacturers_image'];
            if (file_exists($image_location))
              if (!unlink($image_location))
                $messageStack->add_session(sprintf(ERROR_FILE_NOT_REMOVED, $image_location), 'error');
            $image_location = DIR_FS_CATALOG_IMAGES_ORIG . $manufacturer['manufacturers_image'];
            
            if (file_exists($image_location))
              if (!unlink($image_location))
                $messageStack->add_session(sprintf(ERROR_FILE_NOT_REMOVED, $image_location), 'error');
          }
        }

        tep_db_query("delete from " . TABLE_MANUFACTURERS . " where manufacturers_id = '" . (int)$manufacturers_id . "'");
        tep_db_query("delete from " . TABLE_MANUFACTURERS_INFO . " where manufacturers_id = '" . (int)$manufacturers_id . "'");

        if (isset($HTTP_POST_VARS['delete_products']) && ($HTTP_POST_VARS['delete_products'] == 'on')) {
          $products_query = tep_db_query("select products_id from " . TABLE_PRODUCTS . " where manufacturers_id = '" . (int)$manufacturers_id . "'");
          while ($products = tep_db_fetch_array($products_query)) {
            tep_remove_product($products['products_id']);
          }
        } else {
          tep_db_query("update " . TABLE_PRODUCTS . " set manufacturers_id = '' where manufacturers_id = '" . (int)$manufacturers_id . "'");
        }

        if (USE_CACHE == 'true') {
          tep_reset_cache_block('manufacturers');
        }

        tep_redirect(tep_href_link('manufacturers.php', 'page=' . $HTTP_GET_VARS['page']));
        break;
    }
  }

  require('includes/template_top.php');
?>

    <table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td width="100%"><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td class="pageHeading"><?php echo HEADING_TITLE; ?></td>
            <td class="pageHeading" align="right"><?php echo tep_draw_separator('pixel_trans.gif', HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT); ?></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td valign="top"><table border="0" width="100%" cellspacing="0" cellpadding="2">
              <tr class="dataTableHeadingRow">
                <td class="dataTableHeadingContent"><?php echo TABLE_HEADING_MANUFACTURERS; ?></td>
                <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_ACTION; ?>&nbsp;</td>
              </tr>
<?php
  $manufacturers_query_raw = "select manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified from " . TABLE_MANUFACTURERS . " order by manufacturers_name";
  $manufacturers_split = new splitPageResults($HTTP_GET_VARS['page'], MAX_DISPLAY_SEARCH_RESULTS, $manufacturers_query_raw, $manufacturers_query_numrows);
  $manufacturers_query = tep_db_query($manufacturers_query_raw);
  while ($manufacturers = tep_db_fetch_array($manufacturers_query)) {
    if ((!isset($HTTP_GET_VARS['mID']) || (isset($HTTP_GET_VARS['mID']) && ($HTTP_GET_VARS['mID'] == $manufacturers['manufacturers_id']))) && !isset($mInfo) && (substr($action, 0, 3) != 'new')) {
      $manufacturer_products_query = tep_db_query("select count(*) as products_count from " . TABLE_PRODUCTS . " where manufacturers_id = '" . (int)$manufacturers['manufacturers_id'] . "'");
      $manufacturer_products = tep_db_fetch_array($manufacturer_products_query);

      $mInfo_array = array_merge($manufacturers, $manufacturer_products);
      $mInfo = new objectInfo($mInfo_array);
    }

    if (isset($mInfo) && is_object($mInfo) && ($manufacturers['manufacturers_id'] == $mInfo->manufacturers_id)) {
      echo '              <tr id="defaultSelected" class="dataTableRowSelected" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link('manufacturers.php', 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $manufacturers['manufacturers_id'] . '&action=edit') . '\'">' . "\n";
    } else {
      echo '              <tr class="dataTableRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link('manufacturers.php', 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $manufacturers['manufacturers_id']) . '\'">' . "\n";
    }
?>
                <td class="dataTableContent"><?php echo $manufacturers['manufacturers_name']; ?></td>
                <td class="dataTableContent" align="right"><?php if (isset($mInfo) && is_object($mInfo) && ($manufacturers['manufacturers_id'] == $mInfo->manufacturers_id)) { echo tep_image('images/icon_arrow_right.gif'); } else { echo '<a href="' . tep_href_link('manufacturers.php', 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $manufacturers['manufacturers_id']) . '">' . tep_image('images/icon_info.gif', IMAGE_ICON_INFO) . '</a>'; } ?>&nbsp;</td>
              </tr>
<?php
  }
?>
              <tr>
                <td colspan="2"><table border="0" width="100%" cellspacing="0" cellpadding="2">
                  <tr>
                    <td class="smallText" valign="top"><?php echo $manufacturers_split->display_count($manufacturers_query_numrows, MAX_DISPLAY_SEARCH_RESULTS, $HTTP_GET_VARS['page'], TEXT_DISPLAY_NUMBER_OF_MANUFACTURERS); ?></td>
                    <td class="smallText" align="right"><?php echo $manufacturers_split->display_links($manufacturers_query_numrows, MAX_DISPLAY_SEARCH_RESULTS, MAX_DISPLAY_PAGE_LINKS, $HTTP_GET_VARS['page']); ?></td>
                  </tr>
                </table></td>
              </tr>
<?php
  if (empty($action)) {
?>
              <tr>
                <td align="right" colspan="2" class="smallText"><?php echo tep_draw_button(IMAGE_INSERT, 'plus', tep_href_link('manufacturers.php', 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id . '&action=new')); ?></td>
              </tr>
<?php
  }
?>
            </table></td>
<?php
  $heading = array();
  $contents = array();

  switch ($action) {
    case 'new':
      $heading[] = array('text' => '<strong>' . TEXT_HEADING_NEW_MANUFACTURER . '</strong>');

      $contents = array('form' => tep_draw_form('manufacturers', 'manufacturers.php', 'action=insert', 'post', 'enctype="multipart/form-data"'));
      $contents[] = array('text' => TEXT_NEW_INTRO);
      $contents[] = array('text' => '<br />' . TEXT_MANUFACTURERS_NAME . '<br />' . tep_draw_input_field('manufacturers_name'));
      $contents[] = array('text' => '<br />' . TEXT_MANUFACTURERS_IMAGE . '<br />' . tep_draw_file_field('manufacturers_image'));

      $manufacturer_inputs_string = $manufacturer_description_string = $manufacturer_seo_description_string = $manufacturer_seo_keywords_string = $manufacturer_seo_title_string = '';

      $languages = tep_get_languages();
      for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
        // original code
        //$manufacturer_inputs_string .= '<br />' . tep_image(tep_catalog_href_link('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], '', 'SSL'), $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_url[' . $languages[$i]['id'] . ']');
        $manufacturer_inputs_string .= '<br />' . tep_catalog_image('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_url[' . $languages[$i]['id'] . ']', tep_get_manufacturer_url($mInfo->manufacturers_id, $languages[$i]['id']));
        $manufacturer_description_string .= '<br />' . tep_image(tep_catalog_href_link('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], '', 'SSL'), $languages[$i]['name'], '', '', 'style="vertical-align: top;"') . '&nbsp;' . tep_draw_textarea_field('manufacturers_description[' . $languages[$i]['id'] . ']', 'soft', '80', '10');
        $manufacturer_seo_description_string .= '<br />' . tep_image(tep_catalog_href_link('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], '', 'SSL'), $languages[$i]['name'], '', '', 'style="vertical-align: top;"') . '&nbsp;' . tep_draw_textarea_field('manufacturers_seo_description[' . $languages[$i]['id'] . ']', 'soft', '80', '10');
        $manufacturer_seo_keywords_string .= '<br />' . tep_image(tep_catalog_href_link('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], '', 'SSL'), $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_seo_keywords[' . $languages[$i]['id'] . ']', NULL, 'style="width: 300px;" placeholder="' . PLACEHOLDER_COMMA_SEPARATION . '"');
        $manufacturer_seo_title_string .= '<br />' . tep_image(tep_catalog_href_link('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], '', 'SSL'), $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_seo_title[' . $languages[$i]['id'] . ']', NULL, 'style="width: 300px;"');
      }

      $contents[] = array('text' => '<br />' . TEXT_MANUFACTURERS_URL . $manufacturer_inputs_string);
      $contents[] = array('text' => '<br />' . TEXT_MANUFACTURERS_SEO_TITLE . $manufacturer_seo_title_string);
      $contents[] = array('text' => '<br />' . TEXT_MANUFACTURERS_DESCRIPTION . $manufacturer_description_string);
      $contents[] = array('text' => '<br />' . TEXT_MANUFACTURERS_SEO_DESCRIPTION . $manufacturer_seo_description_string);
      $contents[] = array('text' => '<br />' . TEXT_MANUFACTURERS_SEO_KEYWORDS . $manufacturer_seo_keywords_string);
      $contents[] = array('align' => 'center', 'text' => '<br />' . tep_draw_button(IMAGE_SAVE, 'disk', null, 'primary') . tep_draw_button(IMAGE_CANCEL, 'close', tep_href_link('manufacturers.php', 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $HTTP_GET_VARS['mID'])));
      break;
    case 'edit':
      $heading[] = array('text' => '<strong>' . TEXT_HEADING_EDIT_MANUFACTURER . '</strong>');

      $contents = array('form' => tep_draw_form('manufacturers', 'manufacturers.php', 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id . '&action=save', 'post', 'enctype="multipart/form-data"'));
      $contents[] = array('text' => TEXT_EDIT_INTRO);
      $contents[] = array('text' => '<br />' . TEXT_MANUFACTURERS_NAME . '<br />' . tep_draw_input_field('manufacturers_name', $mInfo->manufacturers_name));
      $contents[] = array('text' => '<br />' . TEXT_MANUFACTURERS_IMAGE . '<br />' . tep_draw_file_field('manufacturers_image') . '<br />' . $mInfo->manufacturers_image);

      $manufacturer_inputs_string = $manufacturer_description_string = $manufacturer_seo_description_string = $manufacturer_seo_keywords_string = $manufacturer_seo_title_string = '';
      $languages = tep_get_languages();
      for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
        // original code
        //$manufacturer_inputs_string .= '<br />' . tep_image(tep_catalog_href_link('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], '', 'SSL'), $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_url[' . $languages[$i]['id'] . ']', tep_get_manufacturer_url($mInfo->manufacturers_id, $languages[$i]['id']));
        $manufacturer_inputs_string .= '<br />' . tep_catalog_image('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_url[' . $languages[$i]['id'] . ']');
        $manufacturer_seo_title_string .= '<br />' . tep_image(tep_catalog_href_link('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], '', 'SSL'), $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_seo_title[' . $languages[$i]['id'] . ']', tep_get_manufacturer_seo_title($mInfo->manufacturers_id, $languages[$i]['id']));
        $manufacturer_description_string .= '<br />' . tep_image(tep_catalog_href_link('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], '', 'SSL'), $languages[$i]['name'], '', '', 'style="vertical-align: top;"') . '&nbsp;' . tep_draw_textarea_field('manufacturers_description[' . $languages[$i]['id'] . ']', 'soft', '80', '10', tep_get_manufacturer_description($mInfo->manufacturers_id, $languages[$i]['id']));
        $manufacturer_seo_description_string .= '<br />' . tep_image(tep_catalog_href_link('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], '', 'SSL'), $languages[$i]['name'], '', '', 'style="vertical-align: top;"') . '&nbsp;' . tep_draw_textarea_field('manufacturers_seo_description[' . $languages[$i]['id'] . ']', 'soft', '80', '10', tep_get_manufacturer_seo_description($mInfo->manufacturers_id, $languages[$i]['id']));
        $manufacturer_seo_keywords_string .= '<br />' . tep_image(tep_catalog_href_link('includes/languages/' . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], '', 'SSL'), $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_seo_keywords[' . $languages[$i]['id'] . ']', tep_get_manufacturer_seo_keywords($mInfo->manufacturers_id, $languages[$i]['id']), 'style="width: 300px;" placeholder="' . PLACEHOLDER_COMMA_SEPARATION . '"');
      }

      $contents[] = array('text' => '<br />' . TEXT_MANUFACTURERS_URL . $manufacturer_inputs_string);
      $contents[] = array('text' => '<br />' . TEXT_EDIT_MANUFACTURERS_SEO_TITLE . $manufacturer_seo_title_string);
      $contents[] = array('text' => '<br />' . TEXT_EDIT_MANUFACTURERS_DESCRIPTION . $manufacturer_description_string);
      $contents[] = array('text' => '<br />' . TEXT_EDIT_MANUFACTURERS_SEO_DESCRIPTION . $manufacturer_seo_description_string);
      $contents[] = array('text' => '<br />' . TEXT_EDIT_MANUFACTURERS_SEO_KEYWORDS . $manufacturer_seo_keywords_string);
      $contents[] = array('align' => 'center', 'text' => '<br />' . tep_draw_button(IMAGE_SAVE, 'disk', null, 'primary') . tep_draw_button(IMAGE_CANCEL, 'close', tep_href_link('manufacturers.php', 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id)));
      break;
    case 'delete':
      $heading[] = array('text' => '<strong>' . TEXT_HEADING_DELETE_MANUFACTURER . '</strong>');

      $contents = array('form' => tep_draw_form('manufacturers', 'manufacturers.php', 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id . '&action=deleteconfirm'));
      $contents[] = array('text' => TEXT_DELETE_INTRO);
      $contents[] = array('text' => '<br /><strong>' . $mInfo->manufacturers_name . '</strong>');
      $contents[] = array('text' => '<br />' . tep_draw_checkbox_field('delete_image', '', true) . ' ' . TEXT_DELETE_IMAGE);

      if ($mInfo->products_count > 0) {
        $contents[] = array('text' => '<br />' . tep_draw_checkbox_field('delete_products') . ' ' . TEXT_DELETE_PRODUCTS);
        $contents[] = array('text' => '<br />' . sprintf(TEXT_DELETE_WARNING_PRODUCTS, $mInfo->products_count));
      }

      $contents[] = array('align' => 'center', 'text' => '<br />' . tep_draw_button(IMAGE_DELETE, 'trash', null, 'primary') . tep_draw_button(IMAGE_CANCEL, 'close', tep_href_link('manufacturers.php', 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id)));
      break;
    default:
      if (isset($mInfo) && is_object($mInfo)) {
        $heading[] = array('text' => '<strong>' . $mInfo->manufacturers_name . '</strong>');

        $contents[] = array('align' => 'center', 'text' => tep_draw_button(IMAGE_EDIT, 'document', tep_href_link('manufacturers.php', 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id . '&action=edit')) . tep_draw_button(IMAGE_DELETE, 'trash', tep_href_link('manufacturers.php', 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id . '&action=delete')));
        $contents[] = array('text' => '<br />' . TEXT_DATE_ADDED . ' ' . tep_date_short($mInfo->date_added));
        if (tep_not_null($mInfo->last_modified)) $contents[] = array('text' => TEXT_LAST_MODIFIED . ' ' . tep_date_short($mInfo->last_modified));
        
        // original code 
        //$contents[] = array('text' => '<br />' . tep_info_image($mInfo->manufacturers_image, $mInfo->manufacturers_name));
        $contents[] = array('text' => '<br />' . tep_info_image(substr(DIR_WS_CATALOG_IMAGES_MFG, strlen(DIR_WS_CATALOG_IMAGES)) . $mInfo->manufacturers_image, $mInfo->manufacturers_name));
        $contents[] = array('text' => '<br />' . TEXT_PRODUCTS . ' ' . $mInfo->products_count);
      }
      break;
  }

  if ( (tep_not_null($heading)) && (tep_not_null($contents)) ) {
    echo '            <td width="30%" valign="top">' . "\n";

    $box = new box;
    echo $box->infoBox($heading, $contents);

    echo '            </td>' . "\n";
  }
?>
          </tr>
        </table></td>
      </tr>
    </table>

<?php
  require('includes/template_bottom.php');
  require('includes/application_bottom.php');
?>
