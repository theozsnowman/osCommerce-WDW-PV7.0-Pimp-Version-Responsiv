<?php
/*
  $Id: upcoming_products.php, v1.1 19th Sept. 2016 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
 */

  // template with panel border
?>

  <div id="upcoming_products" class="col-sm-<?php echo (int)MODULE_CONTENT_CATEGORY_UPCOMING_PRODUCTS_CONTENT_WIDTH; ?>">
    <div class="panel panel-info">
      <div class="panel-heading">
        <div class="pull-left">
          <?php echo MODULE_CONTENT_CATEGORY_UPCOMING_PRODUCTS_HEADING_PRODUCTS; ?>
        </div>
        <div class="pull-right">
          <?php echo MODULE_CONTENT_CATEGORY_UPCOMING_PRODUCTS_HEADING_DATE_EXPECTED; ?>
        </div>
        <div class="clearfix"></div>
      </div>

      <div class="panel-body">
<?php
    while ($upcoming_products = tep_db_fetch_array($upcoming_products_query)) {
?>
        <div class="pull-left"><a href="<?php echo tep_href_link('product_info.php', 'products_id=' . $upcoming_products['products_id']); ?>"><?php echo $upcoming_products['products_name']; ?></a></div>
        <div class="pull-right"><?php echo tep_date_short($upcoming_products['date_expected']); ?></div>
        <div class="clearfix"></div>
<?php
    }
?>
      </div>
    </div>
  </div>
