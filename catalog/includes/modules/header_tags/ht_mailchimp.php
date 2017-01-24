<?php
/**
 * MailchimpEverywhereFor2.3.4BS_2.0 by @raiwa
 * info@oscaddons.com
 * www.oscaddons.com
 * and
 * Gyakutsuki
 * @copyright Portions Copyright 2015 osCommerce
 * @license GNU Public License GPL
 * @version $Id: 2.0
 */

  class ht_mailchimp {
    var $code;
    var $group;
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {
      $this->code = get_class($this);
      $this->group = basename(__DIR__);

      $this->title = MODULES_HEADER_TAGS_MAILCHIMP_TITLE;
      $this->description = MODULES_HEADER_TAGS_MAILCHIMP_DESCRIPTION;
      
      if ( (!defined('MODULE_FOOTER_MAILCHIMP_STATUS') || (defined('MODULE_FOOTER_MAILCHIMP_STATUS') && MODULE_FOOTER_MAILCHIMP_STATUS != 'True') &&
        !defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS') || (defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS') && MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS != 'True')) ||
        defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS') && MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS == 'True' && 
        (is_dir(DIR_FS_CATALOG . 'includes/modules/navbar_modules/') && is_file(DIR_FS_CATALOG . 'includes/modules/navbar_modules/nb_mailchimp_newsletter.php') && 
        !defined('MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS') || (defined('MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS') && MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS != 'True')) ) {
        $this->description .= '<div class="secWarning">' . 
                                MODULES_HEADER_TAGS_MAILCHIMP_MODULE_WARNING . '<br>'; 
      if ( !defined('MODULE_FOOTER_MAILCHIMP_STATUS') || (defined('MODULE_FOOTER_MAILCHIMP_STATUS') && MODULE_FOOTER_MAILCHIMP_STATUS != 'True') ) {
        $this->description .=   MODULES_HEADER_TAGS_MAILCHIMP_FOOTER_MODULE_WARNING . '<br>
                                <a href="modules_content.php?module=cm_footer_mailchimp&action=install">' . MODULES_HEADER_TAGS_MAILCHIMP_FOOTER_MODULE_INSTALL_NOW . '</a><br>';
      }
      if ( !defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS') || (defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS') && MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS != 'True') ) {
        $this->description .=   MODULES_HEADER_TAGS_MAILCHIMP_HEADER_MODULE_WARNING . '<br>
                                <a href="modules_content.php?module=cm_header_mailchimp_modal&action=install">' . MODULES_HEADER_TAGS_MAILCHIMP_HEADER_MODULE_INSTALL_NOW . '</a><br>';
      } elseif ( defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS') && MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS == 'True' && 
                 is_dir(DIR_FS_CATALOG . 'includes/modules/navbar_modules/') && is_file(DIR_FS_CATALOG . 'includes/modules/navbar_modules/nb_mailchimp_newsletter.php') && 
                 (!defined('MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS') || (defined('MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS') && MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS != 'True')) ) {
        $this->description .= MODULES_HEADER_TAGS_MAILCHIMP_NAVBAR_MODULE_WARNING . '<br>
                             <a href="modules.php?set=navbar_modules&module=nb_mailchimp_newsletter&action=install">' . MODULES_HEADER_TAGS_MAILCHIMP_NAVBAR_MODULE_INSTALL_NOW . '</a>';
      }
        $this->description .= '</div>';
      }      

      if ( defined('MODULES_HEADER_TAGS_MAILCHIMP_STATUS') ) {
        $this->sort_order = MODULES_HEADER_TAGS_MAILCHIMP_SORT_ORDER;
        $this->enabled = (MODULES_HEADER_TAGS_MAILCHIMP_STATUS == 'True');
      }
    }

    function execute() {
      global $oscTemplate;
      
      $footer ='<!-- Start Mailchimp -->' . "\n";

  if ( defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS') && MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS == 'True') {      
      $footer .= '
<script>
$(document).ready(function() {
  $(\'#signuphd\').submit(function() {
    $("#messagehd").html("<div class=\"alert alert-info\" style=\"padding:05px; margin-top:5px;\" role=\"alert\">' . MODULES_HEADER_TAGS_MAILCHIMP_SUBMIT_MESSAGE . '</div>");
    $.ajax({
      url: \'ext/api/mailchimp_v3/subscribe.php\', // proper url to your "store-address.php" file
      type: \'POST\', // <- IMPORTANT
      data: $(\'#signuphd\').serialize() + \'&ajax=true\',
      success: function(msg) {
      msg = msg.replace(/string\([0-9]*\) "/, \'\');
      msg = msg.replace(\'}"\', \'}\');
      var message = $.parseJSON(msg);
        resultmessage = \'\';
        if (message.status === \'' . MODULES_HEADER_TAGS_MAILCHIMP_STATUS_CHOICE . '\') { // success
          resultmessage = \'<div class="alert alert-success alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' . MODULES_HEADER_TAGS_MAILCHIMP_SUCCESS_MESSAGE . '</div>\'; // display the message
        } else if (message.status === 400) { // error e-mail exists
          resultmessage = \'<div class="alert alert-warning alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' . MODULES_HEADER_TAGS_MAILCHIMP_ERROR_EXISTS_MESSAGE . '</div>\'; // display the message
        } else { // undefined error
          resultmessage = \'<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' . MODULES_HEADER_TAGS_MAILCHIMP_ERROR_MESSAGE . '</div>\'; // display the message
        }
        $(\'#messagehd\').html(resultmessage); // display the message
        $(\'#fnamehd\').val(""); // reset input field
        $(\'#lnamehd\').val(""); // reset input field
        $(\'#emailhd\').val(""); // reset input field
      },
    });
    return false;
  });
});
</script>';
  }
  
  if ( defined('MODULE_FOOTER_MAILCHIMP_STATUS') && MODULE_FOOTER_MAILCHIMP_STATUS == 'True') {        
      $footer .= '
<script>
$(document).ready(function() {
  $(\'#signupft\').submit(function() {
    $("#messageft").html("<div class=\"alert alert-info\" style=\"padding:05px; margin-top:5px;\" role=\"alert\">' . MODULES_HEADER_TAGS_MAILCHIMP_SUBMIT_MESSAGE . '</div>");
    $.ajax({
      url: \'ext/api/mailchimp_v3/subscribe.php\', // proper url to your "store-address.php" file
      type: \'POST\', // <- IMPORTANT
      data: $(\'#signupft\').serialize() + \'&ajax=true\',
      success: function(msg) {
      msg = msg.replace(/string\([0-9]*\) "/, \'\');
      msg = msg.replace(\'}"\', \'}\');
      var message = JSON.parse(msg);
        resultmessage = \'\';
        if (message.status === \'' . MODULES_HEADER_TAGS_MAILCHIMP_STATUS_CHOICE . '\') { // success
          resultmessage = \'<div class="alert alert-success alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' . MODULES_HEADER_TAGS_MAILCHIMP_SUCCESS_MESSAGE . '</div>\'; // display the message
        } else if (message.status === 400) { // error e-mail exists
          resultmessage = \'<div class="alert alert-warning alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' . MODULES_HEADER_TAGS_MAILCHIMP_ERROR_EXISTS_MESSAGE . '</div>\'; // display the message
        } else { // undefined error
          resultmessage = \'<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' . MODULES_HEADER_TAGS_MAILCHIMP_ERROR_MESSAGE . '</div>\'; // display the message
        }
        $(\'#messageft\').html(resultmessage); // display the message
        $(\'#fnameft\').val(""); // reset input field
        $(\'#lnameft\').val(""); // reset input field
        $(\'#emailft\').val(""); // reset input field
      }
    });
    return false;
  });
});
</script>';
  }
      $footer .='<!-- End Mailchimp -->' . "\n";

      $oscTemplate->addBlock($footer, 'footer_scripts');

    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULES_HEADER_TAGS_MAILCHIMP_STATUS');
    }

    function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Do you want to enable this module ?', 'MODULES_HEADER_TAGS_MAILCHIMP_STATUS', 'True', 'Do you want to enable this module ?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Mailchimp API', 'MODULES_HEADER_TAGS_MAILCHIMP_API', '', 'Your API key given by Mailchimp.', '6', '3', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Anonymous List number by Mailchimp', 'MODULES_HEADER_TAGS_MAILCHIMP_LIST_ANONYMOUS', '', 'This is the code created in your Mailchimp account in the anonymous list configuration.', '6', '4', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Customer List number by Mailchimp', 'MODULES_HEADER_TAGS_MAILCHIMP_LIST_CUSTOMERS', '', 'This is the code created in your Mailchimp account in the customer list configuration.', '6', '4', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Choose your status to validate email ?', 'MODULES_HEADER_TAGS_MAILCHIMP_STATUS_CHOICE', 'subscribed', '- subscribed: the user is validated,<br />- pending: the user needs to be validated', '6', '1', 'tep_cfg_select_option(array(\'subscribed\', \'pending\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Do you want to enable the debug tool ?', 'MODULES_HEADER_TAGS_MAILCHIMP_DEBUG', 'False', 'Via the console you can see the response result. Set to false for production.', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULES_HEADER_TAGS_MAILCHIMP_SORT_ORDER', '900', 'Sort order of display. Lowest is displayed first.', '6', '3', now())");
    }

    function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULES_HEADER_TAGS_MAILCHIMP_STATUS',
                   'MODULES_HEADER_TAGS_MAILCHIMP_API',
                   'MODULES_HEADER_TAGS_MAILCHIMP_LIST_ANONYMOUS',
                   'MODULES_HEADER_TAGS_MAILCHIMP_LIST_CUSTOMERS',
                   'MODULES_HEADER_TAGS_MAILCHIMP_STATUS_CHOICE',
                   'MODULES_HEADER_TAGS_MAILCHIMP_DEBUG',
                   'MODULES_HEADER_TAGS_MAILCHIMP_SORT_ORDER'
                  );
    }
  }
