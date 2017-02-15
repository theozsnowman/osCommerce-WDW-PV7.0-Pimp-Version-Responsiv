<?php
/*
  $Id: categories_description.php, v1.1 19th Sept. 2016 auzStar$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
 */

/*
<div class="col-sm-<?php echo $content_width; ?> category-description">
  <div class="well well-sm">
    <?php echo $category['categories_description']; ?>
  </div>
</div>
*/
?>
<?php /*
  <div id="categories_description" class="col-sm-<?php echo (int)MODULE_CONTENT_CATEGORY_CATEGORIES_DESCRIPTION_CONTENT_WIDTH; ?>">
    <div class="well well-sm">
      <?php echo $category['categories_description']; ?>
    </div>
  </div>
*/ ?>
    
<div id="categories_description" class="col-sm-<?php echo (int)MODULE_CONTENT_CATEGORY_CATEGORIES_DESCRIPTION_CONTENT_WIDTH; ?> wdw_close">
  <div class="panel panel-info">
    <div class="panel-heading collapsed" data-toggle="collapse" href="#cat-info" style="cursor: pointer;" aria-expanded="false">
      <h5 class="panel-title">
        <i><?php echo MODULE_CONTENT_CATEGORY_CATEGORIES_DESCRIPTION_TITLE; ?></i>&nbsp;<span id="cat-info-icon" class="fa fa-angle-double-down" style="font-size: 14px;"></span>

        <button type="button" class="close" data-target=".wdw_close" data-dismiss="alert">
          <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
        </button>

      </h5>
    </div>
    <div id="cat-info" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
      <div class="panel-body"><?php echo $category['categories_description']; ?></div>
    </div>
  </div>
</div>

<script>
$(document).ready(function(){
  $("#cat-info").on("hide.bs.collapse", function(){
    $("#cat-info-icon").removeClass('fa-angle-double-up').addClass('fa-angle-double-down');
  });
  $("#cat-info").on("show.bs.collapse", function(){
    $("#cat-info-icon").removeClass('fa-angle-double-down').addClass('fa-angle-double-up');
  });
});
</script>
