<div class="col-sm-<?php echo $content_width; ?>">
  <div class="footerbox mailchimp">
    <h2><?php echo MODULE_FOOTER_MAILCHIMP_TEXT; ?></h2>
<?php
    echo $form;
    if (!empty(MODULES_HEADER_TAGS_MAILCHIMP_LIST_CUSTOMERS) && (MODULE_FOOTER_MAILCHIMP_DISPLAY_NAME == 'True')) {
      echo tep_draw_input_field('firstname', NULL, 'id="fnamehd" placeholder="' . MODULE_FOOTER_MAILCHIMP_OPTIONAL . ENTRY_FIRST_NAME . '"') . ' ';
      echo tep_draw_input_field('lastname', NULL, 'id="lnamehd" placeholder="' . MODULE_FOOTER_MAILCHIMP_OPTIONAL . ENTRY_LAST_NAME . '"') . ' ';
      echo tep_draw_input_field('email', NULL, 'required aria-required="true" id="emailft" placeholder="' . ENTRY_EMAIL_ADDRESS . '"', 'email') . ' ';
      echo tep_draw_button(MODULE_FOOTER_MAILCHIMP_SUBMIT, 'fa fa-pencil-square-o', null, null, array('params' => 'id="SendButtonft"'), 'btn-success btn-sm');
    } elseif (!empty(MODULES_HEADER_TAGS_MAILCHIMP_LIST_ANONYMOUS)) {
      echo tep_draw_input_field('email', NULL, 'required aria-required="true" id="emailft" placeholder="' . ENTRY_EMAIL_ADDRESS . '"', 'email') . ' ';
      echo tep_draw_button(MODULE_FOOTER_MAILCHIMP_SUBMIT, 'fa fa-pencil-square-o', null, null, array('params' => 'id="SendButtonft"'), 'btn-success btn-sm') . tep_draw_hidden_field('anonymous', 'anonymous');
    }
    if (MODULE_FOOTER_MAILCHIMP_DISPLAY_PRIVACY == 'True') {
      echo tep_draw_button(MODULE_FOOTER_MAILCHIMP_PRIVACY, 'fa fa-user', tep_href_link('privacy.php'), null, null, 'btn-info btn-xs pull-right');
    }
    echo $endform;
    echo '<br><div class="message" id="messageft"></div>';
?>
  </div>
</div>
