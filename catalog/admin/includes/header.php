<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2014 osCommerce

  Released under the GNU General Public License
*/

  if ($messageStack->size > 0) {
    echo $messageStack->output();
  }
?>

<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="2"><?php echo '<a href="' . tep_href_link('index.php') . '">' . tep_image('images/oscommerce.png', 'osCommerce Online Merchant v' . tep_get_version()) . '</a>'; ?></td>
  </tr>
  <tr class="headerBar">
    <td class="headerBarContent">&nbsp;&nbsp;<?php echo '<a id="admin" href="' . tep_href_link('index.php') . '" class="">' . HEADER_TITLE_ADMINISTRATION . '</a> <a target="_blank" id="shop" href="' . tep_catalog_href_link() . '" class="">' . HEADER_TITLE_ONLINE_CATALOG . '</a> <a id="show" class="wdw_ui-widget-header wdw_ui-widget-content wdw_ui-dialog-titlebar-close">' . BUTTON_SITEMAP_XML . '</a>'; ?></td>
    <td class="headerBarContent" align="right"><?php echo (tep_session_is_registered('admin') ? TEXT_LOG_IN_AS . $admin['username']  . ' <a id="logout" href="' . tep_href_link('login.php', 'action=logoff') . '" class="">' . TEXT_LOGOFF . '</a>' : ''); ?>&nbsp;&nbsp;</td>
  </tr>
</table>