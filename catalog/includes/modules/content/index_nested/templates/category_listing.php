<div class="col-sm-<?php echo $content_width; ?> category-listing">
  <div itemscope itemtype="http://schema.org/ItemList">
    <meta itemprop="itemListOrder" content="http://schema.org/ItemListUnordered" />
    <meta itemprop="name" content="<?php echo $category['categories_name']; ?>" />
    
    <?php
    while ($categories = tep_db_fetch_array($categories_query)) {
    	
    	$image = '';
    	if ((tep_not_null($categories['categories_image'])) {
    		$image = tep_image(DIR_WS_IMAGES_CAT . $categories['categories_image'], $categories['categories_name'], SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT);
    	} else {
    		$image = tep_image('includes/languages/' . $language . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT);
    	}
    	
      $cPath_new = tep_get_path($categories['categories_id']);
      echo '<div class="col-sm-' . $category_width . '">';
      echo '  <div class="text-center">';
      echo '    <a href="' . tep_href_link('index.php', $cPath_new) . '">' . $image . '</a>';
      echo '    <div class="caption text-center">';
      echo '      <h5><a href="' . tep_href_link('index.php', $cPath_new) . '"><span itemprop="itemListElement">' . $categories['categories_name'] . '</span></a></h5>';
      echo '    </div>';
      echo '  </div>';
      echo '</div>';
    }
    ?>    
  </div>    
</div>
