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

  class cm_footer_mailchimp {
    var $code;
    var $group;
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {

      $this->code = get_class($this);
      $this->group = basename(__DIR__);
      $this->title = MODULE_FOOTER_MAILCHIMP_TITLE;
      $this->description = MODULE_FOOTER_MAILCHIMP_DESCRIPTION;

      if ( !defined('MODULES_HEADER_TAGS_MAILCHIMP_STATUS') || (defined('MODULES_HEADER_TAGS_MAILCHIMP_STATUS') && MODULES_HEADER_TAGS_MAILCHIMP_STATUS != 'True' ) ) {
        $this->description .= '<div class="secWarning">' . 
                                MODULE_FOOTER_MAILCHIMP_HEADER_TAGS_MODULE_WARNING . '<br>
                                <a href="modules.php?set=header_tags&module=ht_mailchimp&action=install">' . MODULE_FOOTER_MAILCHIMP_HEADER_TAGS_MODULE_INSTALL_NOW . '</a>
                               </div>';
      }
        
        if ( defined('MODULE_FOOTER_MAILCHIMP_STATUS') ) {
        $this->sort_order = MODULE_FOOTER_MAILCHIMP_SORT_ORDER;
        $this->enabled = (MODULE_FOOTER_MAILCHIMP_STATUS == 'True');
      }
    }

    function execute() {
      global $oscTemplate, $language;

      $content_width = (int)MODULE_CONTENT_FOOTER_MAILCHIMP_CONTENT_WIDTH;

      require('includes/languages/'. $language . '/privacy.php');

      $data ='<!-- Boxe Mailchimp  start -->' . "\n";

      $form = tep_draw_form('form', '', 'post', 'id="signupft" class="form-horizontal"');
      $endform ='</form>';

      ob_start();
      include('includes/modules/content/' . $this->group . '/templates/footer_mailchimp.php');

      $data .= ob_get_clean();

      $data .='<!-- Boxe Mailchimp  end -->' . "\n";

      $oscTemplate->addContent($data, $this->group);
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_FOOTER_MAILCHIMP_STATUS');
    }

    function install() {
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Do you want to enable Mailchimp (anonymous newsletter) ?', 'MODULE_FOOTER_MAILCHIMP_STATUS', 'True', 'Do you want enable Mailchimp (anonymous newsletter) ?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_FOOTER_MAILCHIMP_CONTENT_WIDTH', '3', 'What width container should the content be shown in? (12 = full width, 6 = half width).', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Do you want to display name fields ?', 'MODULE_FOOTER_MAILCHIMP_DISPLAY_NAME', 'False', 'Display field with name and first name (required in header tag to fill the code til fill list customer)', '6', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Do you want to display privacy info?', 'MODULE_FOOTER_MAILCHIMP_DISPLAY_PRIVACY', 'True', 'Display colapsible with Privacy text.', '6', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_FOOTER_MAILCHIMP_SORT_ORDER', '15', 'Sort order of display. Lowest is displayed first.', '6', '6', now())");
    }

    function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_FOOTER_MAILCHIMP_STATUS',
                   'MODULE_CONTENT_FOOTER_MAILCHIMP_CONTENT_WIDTH',
                   'MODULE_FOOTER_MAILCHIMP_DISPLAY_NAME',
                   'MODULE_FOOTER_MAILCHIMP_DISPLAY_PRIVACY',
                   'MODULE_FOOTER_MAILCHIMP_SORT_ORDER'
                  );
    }
  }

?>
