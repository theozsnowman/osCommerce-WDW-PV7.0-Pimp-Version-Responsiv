<div class="modal fade" id="ModalMailchimp" tabindex="-1" role="dialog">
  <div class="modal-dialog<?php echo (MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_SIZE == 'Large') ? ' modal-lg' : ''; ?>">
    <div class="modal-content">
	  <div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"> &times; </button>
	    <h3 class="modal-title text-center"><strong><?php echo MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_HEADING_TITLE; ?></strong></h3>
	  </div> <!-- /.modal-header -->
	  <div class="login-login modal-body">
<?php
    echo $form;
    if (!empty(MODULES_HEADER_TAGS_MAILCHIMP_LIST_CUSTOMERS) && (MODULE_CONTENT_HEADER_MAILCHIMP_DISPLAY_NAME == 'True')) {
      echo tep_draw_input_field('firstname', NULL, 'id="fnamehd" placeholder="' . MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_OPTIONAL . ENTRY_FIRST_NAME . '"') . ' ';
      echo tep_draw_input_field('lastname', NULL, 'id="lnamehd" placeholder="' . MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_OPTIONAL . ENTRY_LAST_NAME . '"') . ' ';
      echo tep_draw_input_field('email', NULL, 'required aria-required="true" id="emailhd" placeholder="' . ENTRY_EMAIL_ADDRESS . '"', 'email') . ' ';
      echo tep_draw_button(MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_SUBMIT, 'fa fa-pencil-square-o', null, null, array('params' => 'id="SendButtonhd"'), 'btn-success btn-sm');
    } elseif (!empty(MODULES_HEADER_TAGS_MAILCHIMP_LIST_ANONYMOUS)) {
      echo tep_draw_input_field('email', NULL, 'required aria-required="true" id="emailhd" placeholder="' . ENTRY_EMAIL_ADDRESS . '"', 'email') . ' ';
      echo tep_draw_button(MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_SUBMIT, 'fa fa-pencil-square-o', null, null, array('params' => 'id="SendButtonhd"'), 'btn-success btn-sm') . tep_draw_hidden_field('anonymous', 'anonymous');
    }
    echo $endform;
    echo '<br><div class="message" id="messagehd"></div>';
    if (MODULE_CONTENT_HEADER_MAILCHIMP_DISPLAY_PRIVACY == 'True') {
      echo '<div class="text-right">' . tep_draw_button(MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_PRIVACY .  ' <i class="caret"></i>', 'fa fa-user', tep_href_link('#PrivacyText'), null, array('params' => 'aria-expanded="false" aria-controls="PrivacyText" data-toggle="collapse"'), 'btn-info btn-sm') . '</div>';
      echo '<br><div class="collapse" id="PrivacyText">
                  <div class="alert alert-info">' . 
                    TEXT_INFORMATION . 
           '      </div>
                </div>';  
    }
?>
	    </div> <!-- /.modal-body -->
    </div> <!-- /.modal-content -->
  </div> <!-- /.modal-dialog -->
</div> <!-- /.Modal Mailchimp -->
<?php
// only show the modal if conditions are fulfilled
if ( defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS') && MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS == 'True' && $mailchimp_page_count != 'fired' && 
   ((MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_CATEGORIES == 'True' && basename($PHP_SELF) == 'index.php' && $category_depth != 'top') || 
   (MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_PRODUCT_INFO == 'True' && basename($PHP_SELF) == 'product_info.php') || 
   $mailchimp_page_count == MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_PAGE_COUNT) ) {
?>
<script>
$(function() {
  $('#ModalMailchimp').modal('show');
});
</script>

<?php
  // register mailchimp modal as "fired" if it has been popped up once
  $mailchimp_page_count = 'fired';
  tep_session_register('mailchimp_page_count');
}
?>


