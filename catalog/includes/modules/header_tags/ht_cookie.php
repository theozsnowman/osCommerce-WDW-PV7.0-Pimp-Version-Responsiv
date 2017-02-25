<?php
/**
  * osCommerce Online Merchant
  *
  * @copyright (c) 2016 osCommerce; https://www.oscommerce.com
  * @license MIT; https://www.oscommerce.com/license/mit.txt
  */

  class ht_cookie {
    var $code = 'ht_cookie';
    var $group = 'header_tags';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function __construct() {
      $this->title = MODULE_HEADER_TAGS_COOKIE_TITLE;
      $this->description = MODULE_HEADER_TAGS_COOKIE_DESCRIPTION;

      if ( defined('MODULE_HEADER_TAGS_COOKIE_STATUS') ) {
        $this->sort_order = MODULE_HEADER_TAGS_COOKIE_SORT_ORDER;
        $this->enabled = (MODULE_HEADER_TAGS_COOKIE_STATUS == 'True');
      }
    }

    function execute() {
      global $oscTemplate;

      $message = MODULE_HEADER_TAGS_COOKIE_MESSAGE_TEXT;
      $dismiss = MODULE_HEADER_TAGS_COOKIE_DISMISS_TEXT;
      $more    = MODULE_HEADER_TAGS_COOKIE_MORE_TEXT;
      $link    = tep_href_link(MODULE_HEADER_TAGS_COOKIE_PAGE);
      $theme   = tep_href_link('ext/cookielaw/' . MODULE_HEADER_TAGS_COOKIE_THEME . '.css');

      $script_src = tep_href_link('ext/cookielaw/cookielaw.min.js');

      $output  = <<<EOD
<script>window.cookieconsent_options = {"message":"{$message}", "dismiss":"{$dismiss}", "learnMore":"{$more}", "link":"{$link}", "theme":"{$theme}"};</script>
<script src="{$script_src}"></script>
EOD;

      $oscTemplate->addBlock($output . "\n", $this->group);
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_HEADER_TAGS_COOKIE_STATUS');
    }

    function install() {
    	tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Cookie Compliance Module', 'MODULE_HEADER_TAGS_COOKIE_STATUS', 'True', 'Do you want to enable this module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
	  	tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Theme', 'MODULE_HEADER_TAGS_COOKIE_THEME', 'dark-top', 'Select Theme.', '6', '1', 'tep_cfg_select_option(array(\'dark-top\', \'dark-floating\', \'dark-bottom\', \'light-floating\', \'light-top\', \'light-bottom\'), ', now())");
	  	tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Cookie Policy Page', 'MODULE_HEADER_TAGS_COOKIE_PAGE', 'privacy.php', 'The Page on your site that has details of your Cookie Policy.', '6', '0', now())");
	  	tep_db_query("insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_COOKIE_SORT_ORDER', '900', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
    }

    function remove() {
      tep_db_query("delete from configuration where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_HEADER_TAGS_COOKIE_STATUS', 'MODULE_HEADER_TAGS_COOKIE_THEME', 'MODULE_HEADER_TAGS_COOKIE_PAGE', 'MODULE_HEADER_TAGS_COOKIE_SORT_ORDER');
    }
  }
