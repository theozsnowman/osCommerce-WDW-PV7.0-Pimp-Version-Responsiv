<?php
/*
  $Id: message.php, v1.1 19th Sept. 2016 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
 */
?>

  <div id="message" class="col-sm-<?php echo (int)MODULE_CONTENT_CATEGORY_MESSAGE_CONTENT_WIDTH; ?>">
    <?php echo $messageStack->output('product_action'); ?>
  </div>
