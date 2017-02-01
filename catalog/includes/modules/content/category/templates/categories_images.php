<?php
/*
  $Id: categories_images.php, v1.1 19th Sept. 2016 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
 */
?> 
<div id="category_images" class="col-sm-<?php echo MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_CONTENT_WIDTH; ?>">
  <div class="panel panel-info">
    <div class="panel-heading" data-toggle="collapse" href="#sub-cat" style="cursor: pointer;">
      <h5 class="panel-title">
        <i><?php echo MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_TITLE; ?></i>&nbsp;<span id="sub-cat-icon" class="fa fa-angle-double-down" style="font-size: 14px;"></span>

        <button type="button" class="close" data-target="#category_images" data-dismiss="alert">
          <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
        </button>

      </h5>
    </div>
    <div id="sub-cat" class="panel-collapse collapse">
      <div class="panel-body">
        <div class="row">

    			<div itemscope itemtype="http://schema.org/ItemList">
    				<meta itemprop="itemListOrder" content="http://schema.org/ItemListUnordered" />
    				<meta itemprop="name" content="<?php echo $category['categories_name']; ?>" />

    				<?php
    				while ($categories = tep_db_fetch_array($categories_query)) {
    					
    					$image = '';
    					if (tep_not_null($categories['categories_image'])) {
    						$image = tep_image(DIR_WS_IMAGES_CAT . $categories['categories_image'], $categories['categories_name'], SUBCATEGORY_IMAGE_WIDTH, SUBCATEGORY_IMAGE_HEIGHT);
    					} else {
    						$image = tep_image('includes/languages/' . $language . '/images/' . 'no_picture.gif', TEXT_NO_PICTURE, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT);
    					}
    					
      				$cPath_new = tep_get_path($categories['categories_id']);
      				echo '<div class="col-sm-' . MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_CONTENT_WIDTH_EACH . '">';
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
    	</div>
  	</div>
  </div>
</div>

<script>
$(document).ready(function(){
  $("#sub-cat").on("hide.bs.collapse", function(){
    $("#sub-cat-icon").removeClass('fa-angle-double-up').addClass('fa-angle-double-down');
  });
  $("#sub-cat").on("show.bs.collapse", function(){
    $("#sub-cat-icon").removeClass('fa-angle-double-down').addClass('fa-angle-double-up');
  });
});
</script>
