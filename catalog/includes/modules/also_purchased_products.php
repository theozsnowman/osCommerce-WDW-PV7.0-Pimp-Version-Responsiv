<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  if (isset($_GET['products_id'])) {
    $orders_query = tep_db_query("select p.products_id, p.products_image, p.image_folder, p.image_display, pd.products_name, o.date_purchased from " . TABLE_ORDERS_PRODUCTS . " opa, " . TABLE_ORDERS_PRODUCTS . " opb, " . TABLE_ORDERS . " o, " . TABLE_PRODUCTS . " p LEFT JOIN " . TABLE_PRODUCTS_DESCRIPTION . " pd on p.products_id = pd.products_id where opa.products_id = '" . (int)$_GET['products_id'] . "' and opa.orders_id = opb.orders_id and opb.products_id != '" . (int)$_GET['products_id'] . "' and opb.products_id = p.products_id and opb.orders_id = o.orders_id and p.products_status = '1' and pd.language_id = '" . (int)$languages_id . "' group by p.products_id, o.date_purchased order by o.date_purchased desc limit " . MAX_DISPLAY_ALSO_PURCHASED);
    $num_products_ordered = tep_db_num_rows($orders_query);
    if ($num_products_ordered >= MIN_DISPLAY_ALSO_PURCHASED) {

      $also_pur_prods_content = NULL;

      while ($orders = tep_db_fetch_array($orders_query)) {
      	
      	$image ='';
  			if ($orders['image_display'] == 1) {
    			$image = tep_image('includes/languages/' . $language . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'hspace="5" vspace="5"');
  			} elseif (($orders['image_display'] != 2) && tep_not_null($orders['products_image'])) {
    			$image = tep_image(DIR_WS_IMAGES_THUMBS .  $orders['image_folder'] . $orders['products_image'], $orders['products_name'], SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT);
  			}
      	
        $also_pur_prods_content .= '<div class="col-sm-6 col-md-4">';
        $also_pur_prods_content .= '  <div class="thumbnail">';
        $also_pur_prods_content .= '    <a href="' . tep_href_link('product_info.php', 'products_id=' . $orders['products_id']) . '">' . $image . '</a>';
        $also_pur_prods_content .= '    <div class="caption">';
        $also_pur_prods_content .= '      <h5 class="text-center"><a href="' . tep_href_link('product_info.php', 'products_id=' . $orders['products_id']) . '"><span itemprop="itemListElement">' . $orders['products_name'] . '</span></a></h5>';
        $also_pur_prods_content .= '    </div>';
        $also_pur_prods_content .= '  </div>';
        $also_pur_prods_content .= '</div>';
      }

?>

  <br />
  <div itemscope itemtype="http://schema.org/ItemList">
    <meta itemprop="itemListOrder" content="http://schema.org/ItemListUnordered" />
    <meta itemprop="numberOfItems" content="<?php echo (int)$num_products_ordered; ?>" />

    <h3 itemprop="name"><?php echo TEXT_ALSO_PURCHASED_PRODUCTS; ?></h3>

    <div class="row">
      <?php echo $also_pur_prods_content; ?>
    </div>
    
  </div>

<?php
    }
  }
?>
