<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
*/
?>
<?php /*
<div class="col-sm-<?php echo $content_width; ?> text-main">
  <?php echo MODULE_CONTENT_TEXT_MAIN_TEXT; ?>
</div>
*/ ?>


<div class="col-sm-<?php echo $content_width; ?> text-main">
  <div class="panel panel-info">
    <div class="panel-heading collapsed" data-toggle="collapse" href="#cat-info" style="cursor: pointer;" aria-expanded="false">
      <h5 class="panel-title">
        <i><?php echo MODULE_CONTENT_TEXT_MAIN_TITLE; ?></i>&nbsp;<span id="cat-info-icon" class="fa fa-angle-double-down" style="font-size: 14px;"></span>

        <button type="button" class="close" data-target=".text-main" data-dismiss="alert">
          <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
        </button>

      </h5>
    </div>
    <div id="cat-info" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
      <div class="panel-body"><?php echo MODULE_CONTENT_TEXT_MAIN_TEXT; ?></div>
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