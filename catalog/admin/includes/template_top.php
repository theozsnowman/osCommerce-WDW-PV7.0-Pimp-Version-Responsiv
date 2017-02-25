<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2014 osCommerce

  Released under the GNU General Public License
*/
?>
<!DOCTYPE html>
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<meta name="robots" content="noindex,nofollow">
<title><?php echo TITLE; ?></title>
<base href="<?php echo ($request_type == 'SSL') ? HTTPS_SERVER . DIR_WS_HTTPS_ADMIN : HTTP_SERVER . DIR_WS_ADMIN; ?>" />
<!--[if IE]><script type="text/javascript" src="<?php echo tep_catalog_href_link('ext/flot/excanvas.min.js', '', 'SSL'); ?>"></script><![endif]-->
<link rel="stylesheet" type="text/css" href="<?php echo tep_catalog_href_link('ext/jquery/ui/redmond/jquery-ui-1.10.4.min.css', '', 'SSL'); ?>">
<script type="text/javascript" src="<?php echo tep_catalog_href_link('ext/jquery/jquery-2.2.3.min.js', '', 'SSL'); ?>"></script>
<script type="text/javascript" src="<?php echo tep_catalog_href_link('ext/jquery/ui/jquery-ui-1.10.4.min.js', '', 'SSL'); ?>"></script>

<?php
  if (tep_not_null(JQUERY_DATEPICKER_I18N_CODE)) {
?>
<script type="text/javascript" src="<?php echo tep_catalog_href_link('ext/jquery/ui/i18n/jquery.ui.datepicker-' . JQUERY_DATEPICKER_I18N_CODE . '.js', '', 'SSL'); ?>"></script>
<script type="text/javascript">
$.datepicker.setDefaults($.datepicker.regional['<?php echo JQUERY_DATEPICKER_I18N_CODE; ?>']);
</script>
<?php
  }
?>

<script type="text/javascript" src="<?php echo tep_catalog_href_link('ext/flot/jquery.flot.min.js', '', 'SSL'); ?>"></script>
<script type="text/javascript" src="<?php echo tep_catalog_href_link('ext/flot/jquery.flot.time.min.js', '', 'SSL'); ?>"></script>
<link rel="stylesheet" type="text/css" href="includes/stylesheet.css">
<script type="text/javascript" src="includes/general.js"></script>
<?php if (($current_page == 'categories.php')) { ?>
<script type="text/javascript" src="<?php echo tep_catalog_href_link('ext/photoset-grid/jquery.photoset-grid.min.js', '', 'SSL'); ?>"></script>
<link rel="stylesheet" type="text/css" href="<?php echo tep_catalog_href_link('ext/colorbox/colorbox.css', '', 'SSL'); ?>" />
<script type="text/javascript" src="<?php echo tep_catalog_href_link('ext/colorbox/jquery.colorbox-min.js', '', 'SSL'); ?>"></script>
<?php } ?>

</head>
<body>

<?php require('includes/header.php'); ?>

<script language="javascript">	
	<!--	
	$( "#admin" ).button().click(function() { });
	$( "#shop" ).button().click(function() { });
	$( "#logout" ).button().click(function() { });
	
	$(function() {
		$( "#workXML" ).dialog({
			autoOpen: false,
			resizable: false,
			closeOnEscape: false,
			draggable: false,
			height: 'auto',
    	width: 340,
			modal: true,
			open: function () {
				$.ajax({
					type: "POST",
					url: "../usu5_sitemaps/work.php",
					data: "language=<?php echo $language; ?>",
					statusCode: {
						404: function() {
							alert( "page not found" );
    				}
  				}, 
					success: function(html){					
						$("#output").html(html);
					}
	  		});
      },
      buttons: {
    			"OK": function() {
    				$( this ).dialog( "close" );
    			}
			}
		});

		$( "#show" ).button().click(function() {
			$( "#workXML" ).dialog( "open" );
		});
  });
//-->
</script>

<div id="workXML" title="XML Sitemap">
	<div id="output" style="padding-left: 20px;"></div>
</div>

<?php
  if (tep_session_is_registered('admin')) {
    include('includes/column_left.php');
  } else {
?>

<style>
#contentText {
  margin-left: 0;
}
</style>

<?php
  }
?>

<div id="contentText">
