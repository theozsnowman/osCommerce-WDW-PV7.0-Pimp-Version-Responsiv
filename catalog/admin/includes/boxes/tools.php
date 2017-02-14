<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  $cl_box_groups[] = array(
    'heading' => BOX_HEADING_TOOLS,
    'apps' => array(
      array(
        'code' => 'action_recorder.php',
        'title' => BOX_TOOLS_ACTION_RECORDER,
        'link' => tep_href_link('action_recorder.php?language=' . $_SESSION["wdw_language"])
      ),
      array(
        'code' => 'backup.php',
        'title' => BOX_TOOLS_BACKUP,
        'link' => tep_href_link('backup.php?language=' . $_SESSION["wdw_language"])
      ),
      array(
        'code' => 'banner_manager.php',
        'title' => BOX_TOOLS_BANNER_MANAGER,
        'link' => tep_href_link('banner_manager.php?language=' . $_SESSION["wdw_language"])
      ),
      array(
        'code' => 'cache.php',
        'title' => BOX_TOOLS_CACHE,
        'link' => tep_href_link('cache.php?language=' . $_SESSION["wdw_language"])
      ),
      array(
        'code' => 'define_language.php',
        'title' => BOX_TOOLS_DEFINE_LANGUAGE,
        'link' => tep_href_link('define_language.php?language=' . $_SESSION["wdw_language"])
      ),
      array(
        'code' => 'mail.php',
        'title' => BOX_TOOLS_MAIL,
        'link' => tep_href_link('mail.php?language=' . $_SESSION["wdw_language"])
      ),
      array(
        'code' => 'newsletters.php',
        'title' => BOX_TOOLS_NEWSLETTER_MANAGER,
        'link' => tep_href_link('newsletters.php?language=' . $_SESSION["wdw_language"])
      ),      
      array(
        'code' => 'sec_dir_permissions.php',
        'title' => BOX_TOOLS_SEC_DIR_PERMISSIONS,
        'link' => tep_href_link('sec_dir_permissions.php?language=' . $_SESSION["wdw_language"])
      ),
      array(
        'code' => 'server_info.php',
        'title' => BOX_TOOLS_SERVER_INFO,
        'link' => tep_href_link('server_info.php?language=' . $_SESSION["wdw_language"])
      ),
      array(
        'code' => 'version_check.php',
        'title' => BOX_TOOLS_VERSION_CHECK,
        'link' => tep_href_link('version_check.php?language=' . $_SESSION["wdw_language"])
      ),
      array(
        'code' => 'whos_online.php',
        'title' => BOX_TOOLS_WHOS_ONLINE,
        'link' => tep_href_link('whos_online.php?language=' . $_SESSION["wdw_language"])
      )
    )
  );
?>
