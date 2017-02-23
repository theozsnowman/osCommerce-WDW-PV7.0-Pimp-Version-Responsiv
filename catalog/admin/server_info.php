<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  require('includes/template_top.php');
  
	$info = tep_get_system_information();
  $server = parse_url(HTTP_SERVER);
?>

    <table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td class="pageHeading"><?php echo HEADING_TITLE; ?></td>
            <td class="pageHeading" align="right"><?php echo tep_draw_separator('pixel_trans.gif', HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT); ?></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="2">
          <tr>
            <td><table border="0" cellspacing="0" cellpadding="3">
              <tr>
                <td class="smallText"><strong><?php echo TITLE_SERVER_HOST; ?></strong></td>
                <td class="smallText"><?php echo $server['host'] . ' (' . gethostbyname($server['host']) . ')'; ?></td>
                <td class="smallText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><?php echo TITLE_DATABASE_HOST; ?></strong></td>
                <td class="smallText"><?php echo DB_SERVER . ' (' . gethostbyname(DB_SERVER) . ')'; ?></td>
              </tr>
              <tr>
                <td class="smallText"><strong><?php echo TITLE_SERVER_OS; ?></strong></td>
                <td class="smallText"><?php echo $info['system']['os'] . ' ' . $info['system']['kernel']; ?></td>
                <td class="smallText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><?php echo TITLE_DATABASE; ?></strong></td>
                <td class="smallText"><?php echo 'MySQL ' . $info['mysql']['version']; ?></td>
              </tr>
              <tr>
                <td class="smallText"><strong><?php echo TITLE_SERVER_DATE; ?></strong></td>
                <td class="smallText"><?php echo $info['system']['date']; ?></td>
                <td class="smallText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><?php echo TITLE_DATABASE_DATE; ?></strong></td>
                <td class="smallText"><?php echo $info['mysql']['date']; ?></td>
              </tr>
              <tr>
                <td class="smallText"><strong><?php echo TITLE_SERVER_UP_TIME; ?></strong></td>
                <td colspan="3" class="smallText"><?php echo $info['system']['uptime']; ?></td>
              </tr>
              <tr>
                <td colspan="4"><?php echo tep_draw_separator('pixel_trans.gif', '1', '5'); ?></td>
              </tr>
              <tr>
                <td class="smallText"><strong><?php echo TITLE_HTTP_SERVER; ?></strong></td>
                <td colspan="3" class="smallText"><?php echo $info['system']['http_server']; ?></td>
              </tr>
              <tr>
                <td class="smallText"><strong><?php echo TITLE_PHP_VERSION; ?></strong></td>
                <td colspan="3" class="smallText"><?php echo $info['php']['version'] . ' (' . TITLE_ZEND_VERSION . ' ' . $info['php']['zend'] . ')'; ?></td>
              </tr>
            </table></td>
          </tr>
         <tr>
        <td><iframe id="wdw_iframe" src="wdw_php_info.php" style="margin:0; width:100%; border:none; overflow:hidden;" scrolling="no" onload="AdjustIframeHeightOnLoad()"></iframe></td>
      </tr>       
        </table></td>
      </tr>

    </table>

<script type="text/javascript">
<!--
	function AdjustIframeHeightOnLoad() { document.getElementById("wdw_iframe").style.height = document.getElementById("wdw_iframe").contentWindow.document.body.scrollHeight + 40 + "px"; }
	function AdjustIframeHeight(i) { document.getElementById("wdw_iframe").style.height = parseInt(i) + "px"; }
//-->
</script>

<?php
  require('includes/template_bottom.php');
  require('includes/application_bottom.php');
?>
