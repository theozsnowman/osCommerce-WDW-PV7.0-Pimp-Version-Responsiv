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

  class cm_header_mailchimp_modal {
    var $code;
    var $group;
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {
      $this->code = get_class($this);
      $this->group = basename(dirname(__FILE__));

      $this->title = MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_TITLE;
      $this->description = MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_DESCRIPTION;

      if ( (!defined('MODULES_HEADER_TAGS_MAILCHIMP_STATUS') || defined('MODULES_HEADER_TAGS_MAILCHIMP_STATUS') && MODULES_HEADER_TAGS_MAILCHIMP_STATUS != 'True' ) ) {
        $this->description .= '<div class="secWarning">' . 
                                MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_HEADER_TAGS_MODULE_WARNING . '<br>
                                <a href="modules.php?set=header_tags&module=ht_mailchimp&action=install">' . MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_HEADER_TAGS_MODULE_INSTALL_NOW . '</a>
                               </div>';
      }

      if ( is_dir(DIR_FS_CATALOG . 'includes/modules/navbar_modules/') && is_file(DIR_FS_CATALOG . 'includes/modules/navbar_modules/nb_mailchimp_newsletter.php') && 
           (!defined('MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS') || (defined('MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS') && MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS != 'True')) ) {
        $this->description .= '<div class="secWarning">' . 
                                MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_NAVBAR_MODULE_WARNING . '<br>
                                <a href="modules.php?set=navbar_modules&module=nb_mailchimp_newsletter&action=install">' . MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_HEADER_TAGS_MODULE_INSTALL_NOW . '</a>
                               </div>';
      }
      
      if ( defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS') ) {
        $this->sort_order = MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_SORT_ORDER;
        $this->enabled = (MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS == 'True');
      }
    }

    function execute() {
      global $oscTemplate, $language, $PHP_SELF, $mailchimp_page_count, $category_depth;

      require('includes/languages/'. $language . '/privacy.php');

      if ( !tep_session_is_registered('mailchimp_page_count') || ($mailchimp_page_count < MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_PAGE_COUNT) && $mailchimp_page_count != 'fired' ) {
        $mailchimp_page_count = $mailchimp_page_count+1;
        tep_session_register('mailchimp_page_count');
      }

      $data ='<!-- Modal Mailchimp  start -->' . "\n";

      $form = tep_draw_form('form', '', 'post', 'id="signuphd" class="form-horizontal"');
      $endform ='</form>';

        ob_start();
        include('includes/modules/content/' . $this->group . '/templates/mailchimp_modal.php');
        $template = ob_get_clean();
        
        $data .='<!-- Modal Mailchimp  end -->' . "\n";

        $oscTemplate->addContent($template, $this->group);
        
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS');
    }

    function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Mailchimp Modal', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS', 'True', 'Do you want to enable the Mailchimp Modal content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Mailchimp Modal on Product Page', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_PRODUCT_INFO', 'True', 'Do you want to open the Mailchimp Nesletter Modal Pop Up on the first Product Page visit?', '6', '2', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Mailchimp Modal on Categories', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_CATEGORIES', 'True', 'Do you want to open the Mailchimp Nesletter Modal Pop Up on the first Category visit?', '6', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Mailchimp Modal Page Count', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_PAGE_COUNT', '3', 'After how many visited pages should the Mailchimp Nesletter Modal Pop Up open?.', '6', '4', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Do you want to display name fields?', 'MODULE_CONTENT_HEADER_MAILCHIMP_DISPLAY_NAME', 'False', 'Display field with name and first name.', '6', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Do you want to display privacy info?', 'MODULE_CONTENT_HEADER_MAILCHIMP_DISPLAY_PRIVACY', 'True', 'Display colapsible with Privacy text.', '6', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Mailchimp Modal Size', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_SIZE', 'Normal', 'Select the preferred size for the Mailchimp Modal. (Applicable to medium to large screen sizes)', '6', '5', 'tep_cfg_select_option(array(\'Normal\', \'Large\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_SORT_ORDER', '0', 'Not important for this module.', '6', '6', now())");
    }

    function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_PRODUCT_INFO', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_CATEGORIES', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_PAGE_COUNT', 'MODULE_CONTENT_HEADER_MAILCHIMP_DISPLAY_NAME', 'MODULE_CONTENT_HEADER_MAILCHIMP_DISPLAY_PRIVACY', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_SIZE', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_SORT_ORDER');
    }
  }

