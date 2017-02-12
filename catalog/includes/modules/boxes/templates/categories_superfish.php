<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2015 osCommerce

  Released under the GNU General Public License
*/
?>

  <!-- Superfish Categories Box BOF -->
    <div class="panel panel-default" style="float: left; width: 100%">
        
<?php if( strlen ( $title ) > 0 ) { ?>
      <div class="panel-heading"><?php echo $title; ?></div>
<?php } ?>

<?php echo $formatted_data; ?>

    </div>
    <div style="clear: both;"></div>
  <!-- Superfish Categories Box EOF -->
