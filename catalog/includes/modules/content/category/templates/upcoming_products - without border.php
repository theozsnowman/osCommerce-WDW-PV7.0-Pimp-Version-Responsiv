<?php
/*
  $Id: upcoming_products.php, v1.1 19th Sept. 2016 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
 */

  // template without panel border
?>

<div id="upcoming_products" class="col-sm-<?php echo (int)MODULE_CONTENT_CATEGORY_UPCOMING_PRODUCTS_CONTENT_WIDTH; ?>">
  
  <table class="table table-striped table-condensed">
    <tbody>
      <tr>
        <th><?php echo MODULE_CONTENT_CATEGORY_UPCOMING_PRODUCTS_HEADING_PRODUCTS ?></th>
        <th class="text-right"><?php echo MODULE_CONTENT_CATEGORY_UPCOMING_PRODUCTS_HEADING_DATE_EXPECTED; ?></th>
      </tr>
      <?php
      while ($upcoming_products = tep_db_fetch_array($upcoming_products_query)) {
        echo '<tr>';
        echo '  <td><a href="' . tep_href_link('product_info.php', 'products_id=' . (int)$upcoming_products['products_id']) . '">' . $upcoming_products['products_name'] . '</a></td>';
        echo '  <td class="text-right">' . tep_date_short($upcoming_products['date_expected']) . '</td>';
        echo '</tr>';        
      }
      ?>
    </tbody>
  </table>
  
</div>
         
