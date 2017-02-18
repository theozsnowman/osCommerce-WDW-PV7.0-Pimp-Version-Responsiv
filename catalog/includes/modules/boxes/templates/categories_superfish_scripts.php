<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2015 osCommerce

  Released under the GNU General Public License
*/
?>

  <script type="text/javascript" src="ext/jquery/superfish/js/jquery.hoverIntent.minified.js"></script>
  <script type="text/javascript" src="ext/jquery/superfish/js/superfish.js"></script>
  <script type="text/javascript" src="ext/jquery/superfish/js/supersubs.js"></script>
  <link rel="stylesheet" media="screen" href="ext/jquery/superfish/css/superfish.css" />
  <link rel="stylesheet" media="screen" href="ext/jquery/superfish/css/superfish-vertical.css">
  <script type="text/javascript">
    jQuery(document).ready(function(){
      jQuery('ul.sf-menu').superfish({
        animation: {height:'show'},   // slide-down effect without fade-in
        delay:     1000               // 1.0 second delay on mouseout
      });
    });
  </script>
