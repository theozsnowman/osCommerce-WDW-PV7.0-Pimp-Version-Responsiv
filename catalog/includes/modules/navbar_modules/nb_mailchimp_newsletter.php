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

  class nb_mailchimp_newsletter {
    var $code = 'nb_mailchimp_newsletter';
    var $group = 'navbar_modules_home';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;    
    
    function __construct() {
      $this->title = MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_TITLE;
      $this->description = MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_DESCRIPTION;

      if ( (!defined('MODULES_HEADER_TAGS_MAILCHIMP_STATUS') || defined('MODULES_HEADER_TAGS_MAILCHIMP_STATUS') && MODULES_HEADER_TAGS_MAILCHIMP_STATUS != 'True' ) ) {
        $this->description .= '<div class="secWarning">' . 
                                MODULE_NAVBAR_MAILCHIMP_HEADER_TAGS_MODULE_WARNING . '<br>
                                <a href="modules.php?set=header_tags&module=ht_mailchimp&action=install">' . MODULE_NAVBAR_MAILCHIMP_MODULE_INSTALL_NOW . '</a>
                               </div>';
      }

      if ( !defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS') || (defined('MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS') && MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS != 'True') ) {
        $this->description .= '<div class="secWarning">' . 
                                MODULE_NAVBAR_MAILCHIMP_MODAL_MODULE_WARNING . '<br>
                                <a href="modules_content.php?module=cm_header_mailchimp_modal&action=install">' . MODULE_NAVBAR_MAILCHIMP_MODULE_INSTALL_NOW . '</a>
                               </div>';
      }
      
      if ( defined('MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS') ) {
        $this->sort_order = MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_SORT_ORDER;
        $this->enabled = (MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS == 'True');
        
        switch (MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_CONTENT_PLACEMENT) {
          case 'Home':
          $this->group = 'navbar_modules_home';
          break;
          case 'Left':
          $this->group = 'navbar_modules_left';
          break;
          case 'Right':
          $this->group = 'navbar_modules_right';
          break;
        } 
      }
    }

    function getOutput() {
      global $oscTemplate;
      
      ob_start();
      require('includes/modules/navbar_modules/templates/mailchimp_newsletter.php');
      $data = ob_get_clean();

      $oscTemplate->addBlock($data, $this->group);
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS');
    }

    function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Reviews Module', 'MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_CONTENT_PLACEMENT', 'Left', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', '6', '1', 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_SORT_ORDER', '535', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
    }

    function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS', 'MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_CONTENT_PLACEMENT', 'MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_SORT_ORDER');
    }
  }
  