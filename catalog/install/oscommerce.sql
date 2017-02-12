drop table if exists action_recorder;
create table action_recorder (
  id int(11) not null auto_increment,
  module varchar(255) not null ,
  user_id int(11) ,
  user_name varchar(255) ,
  identifier varchar(255) not null ,
  success char(1) ,
  date_added datetime not null ,
  PRIMARY KEY (id),
  KEY idx_action_recorder_module (module),
  KEY idx_action_recorder_user_id (user_id),
  KEY idx_action_recorder_identifier (identifier),
  KEY idx_action_recorder_date_added (date_added)
);

drop table if exists address_book;
create table address_book (
  address_book_id int(11) not null auto_increment,
  customers_id int(11) not null ,
  entry_gender char(1) ,
  entry_company varchar(255) ,
  entry_firstname varchar(255) not null ,
  entry_lastname varchar(255) not null ,
  entry_street_address varchar(255) not null ,
  entry_suburb varchar(255) ,
  entry_postcode varchar(255) not null ,
  entry_city varchar(255) not null ,
  entry_state varchar(255) ,
  entry_country_id int(11) default '0' not null ,
  entry_zone_id int(11) default '0' not null ,
  PRIMARY KEY (address_book_id),
  KEY idx_address_book_customers_id (customers_id)
);

drop table if exists address_format;
create table address_format (
  address_format_id int(11) not null auto_increment,
  address_format varchar(128) not null ,
  address_summary varchar(48) not null ,
  PRIMARY KEY (address_format_id)
);

insert into address_format (address_format_id, address_format, address_summary) values ('1', '$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country', '$city / $country');
insert into address_format (address_format_id, address_format, address_summary) values ('2', '$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country', '$city, $state / $country');
insert into address_format (address_format_id, address_format, address_summary) values ('3', '$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country', '$state / $country');
insert into address_format (address_format_id, address_format, address_summary) values ('4', '$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', '$postcode / $country');
insert into address_format (address_format_id, address_format, address_summary) values ('5', '$firstname $lastname$cr$streets$cr$postcode $city$cr$country', '$city / $country');
drop table if exists administrators;
create table administrators (
  id int(11) not null auto_increment,
  user_name varchar(255) not null ,
  user_password varchar(60) not null ,
  PRIMARY KEY (id)
);

drop table if exists banners;
create table banners (
  banners_id int(11) not null auto_increment,
  banners_title varchar(64) not null ,
  banners_url varchar(255) not null ,
  banners_image varchar(64) not null ,
  banners_group varchar(10) not null ,
  banners_html_text text ,
  expires_impressions int(7) default '0' ,
  expires_date datetime ,
  date_scheduled datetime ,
  date_added datetime not null ,
  date_status_change datetime ,
  status int(1) default '1' not null ,
  PRIMARY KEY (banners_id),
  KEY idx_banners_group (banners_group)
);

drop table if exists banners_history;
create table banners_history (
  banners_history_id int(11) not null auto_increment,
  banners_id int(11) not null ,
  banners_shown int(5) default '0' not null ,
  banners_clicked int(5) default '0' not null ,
  banners_history_date datetime not null ,
  PRIMARY KEY (banners_history_id),
  KEY idx_banners_history_banners_id (banners_id)
);

drop table if exists categories;
create table categories (
  categories_id int(11) not null auto_increment,
  categories_image varchar(64) ,
  parent_id int(11) default '0' not null ,
  sort_order int(3) ,
  date_added datetime ,
  last_modified datetime ,
  PRIMARY KEY (categories_id),
  KEY idx_categories_parent_id (parent_id)
);

insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('1', 'category_hardware.gif', '0', '1', '2017-01-24 11:09:54', '2017-01-26 10:23:14');
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('2', 'category_software.gif', '0', '2', '2017-01-24 11:09:54', '2017-01-26 15:27:37');
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('3', 'category_dvd_movies.gif', '0', '3', '2017-01-24 11:09:54', '2017-01-26 15:27:52');
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('4', 'subcategory_graphic_cards.gif', '1', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('5', 'subcategory_printers.gif', '1', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('6', 'subcategory_monitors.gif', '1', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('7', 'subcategory_speakers.gif', '1', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('8', 'subcategory_keyboards.gif', '1', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('9', 'subcategory_mice.gif', '1', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('10', 'subcategory_action.gif', '3', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('11', 'subcategory_science_fiction.gif', '3', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('12', 'subcategory_comedy.gif', '3', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('13', 'subcategory_cartoons.gif', '3', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('14', 'subcategory_thriller.gif', '3', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('15', 'subcategory_drama.gif', '3', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('16', 'subcategory_memory.gif', '1', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('17', 'subcategory_cdrom_drives.gif', '1', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('18', 'subcategory_simulation.gif', '2', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('19', 'subcategory_action_games.gif', '2', '0', '2017-01-24 11:09:54', NULL);
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('20', 'subcategory_strategy.gif', '2', '0', '2017-01-24 11:09:54', '2017-01-25 06:26:15');
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('21', 'category_gadgets.png', '0', '4', '2017-01-24 11:09:54', '2017-01-26 15:28:55');
insert into categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) values ('23', 'category_gadgets.png', '21', '0', '2017-01-26 15:32:36', '2017-01-26 15:34:02');
drop table if exists categories_description;
create table categories_description (
  categories_id int(11) default '0' not null ,
  language_id int(11) default '1' not null ,
  categories_name varchar(32) not null ,
  categories_description text ,
  categories_seo_description text ,
  categories_seo_keywords varchar(128) ,
  categories_seo_title varchar(128) ,
  PRIMARY KEY (categories_id, language_id),
  KEY idx_categories_name (categories_name)
);

insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('1', '1', 'Hardware', 'hardware test category description', '', '', '');
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('2', '1', 'Software', 'Software test category description', '', '', '');
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('3', '1', 'DVD Movies', 'DVD Movies test category description', '', '', '');
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('4', '1', 'Graphics Cards', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('5', '1', 'Printers', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('6', '1', 'Monitors', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('7', '1', 'Speakers', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('8', '1', 'Keyboards', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('9', '1', 'Mice', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('10', '1', 'Action', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('11', '1', 'Science Fiction', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('12', '1', 'Comedy', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('13', '1', 'Cartoons', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('14', '1', 'Thriller', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('15', '1', 'Drama', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('16', '1', 'Memory', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('17', '1', 'CDROM Drives', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('18', '1', 'Simulation', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('19', '1', 'Action', NULL, NULL, NULL, NULL);
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('20', '1', 'Strategy', 'Strategy Test Categorie description', '', '', '');
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('21', '1', 'Gadgets', 'Gadgets test category description', '', '', '');
insert into categories_description (categories_id, language_id, categories_name, categories_description, categories_seo_description, categories_seo_keywords, categories_seo_title) values ('23', '1', 'Tablets', 'Tablets test category description', '', '', '');
drop table if exists configuration;
create table configuration (
  configuration_id int(11) not null auto_increment,
  configuration_title varchar(255) not null ,
  configuration_key varchar(255) not null ,
  configuration_value text not null ,
  configuration_description varchar(255) not null ,
  configuration_group_id int(11) not null ,
  sort_order int(5) ,
  last_modified datetime ,
  date_added datetime not null ,
  use_function varchar(255) ,
  set_function varchar(255) ,
  PRIMARY KEY (configuration_id)
);

insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('1', 'Store Name', 'STORE_NAME', '', 'The name of my store', '1', '1', '2017-01-30 06:27:42', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('2', 'Store Owner', 'STORE_OWNER', '', 'The name of my store owner', '1', '2', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('3', 'E-Mail Address', 'STORE_OWNER_EMAIL_ADDRESS', '', 'The e-mail address of my store owner', '1', '3', '2017-01-24 14:09:17', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('4', 'E-Mail From', 'EMAIL_FROM', '', 'The e-mail address used in (sent) e-mails', '1', '4', '2017-01-24 14:09:52', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('5', 'Country', 'STORE_COUNTRY', '223', 'The country my store is located in <br /><br /><strong>Note: Please remember to update the store zone.</strong>', '1', '6', NULL, '2017-01-24 11:09:54', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('6', 'Zone', 'STORE_ZONE', '18', 'The zone my store is located in', '1', '7', NULL, '2017-01-24 11:09:54', 'tep_cfg_get_zone_name', 'tep_cfg_pull_down_zone_list(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('7', 'Switch To Default Language Currency', 'USE_DEFAULT_LANGUAGE_CURRENCY', 'false', 'Automatically switch to the language\'s currency when it is changed', '1', '10', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('8', 'Send Extra Order Emails To', 'SEND_EXTRA_ORDER_EMAILS_TO', '', 'Send extra order emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', '1', '11', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('9', 'Use Search-Engine Safe URLs', 'SEARCH_ENGINE_FRIENDLY_URLS', 'false', 'Use search-engine safe urls for all site links', '1', '12', '2017-01-24 15:54:13', '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('10', 'Display Cart After Adding Product', 'DISPLAY_CART', 'true', 'Display the shopping cart after adding a product (or return back to their origin)', '1', '14', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('11', 'Allow Guest To Tell A Friend', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 'false', 'Allow guests to tell a friend about a product', '1', '15', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('12', 'Default Search Operator', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 'and', 'Default search operators', '1', '17', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'and\', \'or\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('13', 'Store Address', 'STORE_ADDRESS', 'Address Line 1 Address Line 2 Country Phone', 'This is the Address of my store used on printable documents and displayed online', '1', '18', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_textarea(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('14', 'Store Phone', 'STORE_PHONE', '555-1234', 'This is the phone number of my store used on printable documents and displayed online', '1', '19', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_textarea(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('15', 'Tax Decimal Places', 'TAX_DECIMAL_PLACES', '2', 'Pad the tax value this amount of decimal places', '1', '20', '2017-01-30 10:01:15', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('16', 'Display Prices with Tax', 'DISPLAY_PRICE_WITH_TAX', 'true', 'Display prices with tax included (true) or add the tax at the end (false)', '1', '21', '2017-02-11 14:30:02', '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('17', 'First Name', 'ENTRY_FIRST_NAME_MIN_LENGTH', '2', 'Minimum length of first name', '2', '1', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('18', 'Last Name', 'ENTRY_LAST_NAME_MIN_LENGTH', '2', 'Minimum length of last name', '2', '2', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('19', 'Date of Birth', 'ENTRY_DOB_MIN_LENGTH', '10', 'Minimum length of date of birth', '2', '3', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('20', 'E-Mail Address', 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', '6', 'Minimum length of e-mail address', '2', '4', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('21', 'Street Address', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', '5', 'Minimum length of street address', '2', '5', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('22', 'Company', 'ENTRY_COMPANY_MIN_LENGTH', '2', 'Minimum length of company name', '2', '6', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('23', 'Post Code', 'ENTRY_POSTCODE_MIN_LENGTH', '4', 'Minimum length of post code', '2', '7', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('24', 'City', 'ENTRY_CITY_MIN_LENGTH', '3', 'Minimum length of city', '2', '8', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('25', 'State', 'ENTRY_STATE_MIN_LENGTH', '2', 'Minimum length of state', '2', '9', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('26', 'Telephone Number', 'ENTRY_TELEPHONE_MIN_LENGTH', '3', 'Minimum length of telephone number', '2', '10', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('27', 'Password', 'ENTRY_PASSWORD_MIN_LENGTH', '5', 'Minimum length of password', '2', '11', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('28', 'Credit Card Owner Name', 'CC_OWNER_MIN_LENGTH', '3', 'Minimum length of credit card owner name', '2', '12', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('29', 'Credit Card Number', 'CC_NUMBER_MIN_LENGTH', '10', 'Minimum length of credit card number', '2', '13', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('30', 'Review Text', 'REVIEW_TEXT_MIN_LENGTH', '50', 'Minimum length of review text', '2', '14', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('31', 'Best Sellers', 'MIN_DISPLAY_BESTSELLERS', '1', 'Minimum number of best sellers to display', '2', '15', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('32', 'Also Purchased', 'MIN_DISPLAY_ALSO_PURCHASED', '1', 'Minimum number of products to display in the \'This Customer Also Purchased\' box', '2', '16', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('33', 'Address Book Entries', 'MAX_ADDRESS_BOOK_ENTRIES', '5', 'Maximum address book entries a customer is allowed to have', '3', '1', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('34', 'Search Results', 'MAX_DISPLAY_SEARCH_RESULTS', '50', 'Amount of products to list', '3', '2', '2017-02-01 14:34:58', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('35', 'Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Number of \'number\' links use for page-sets', '3', '3', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('36', 'Special Products', 'MAX_DISPLAY_SPECIAL_PRODUCTS', '9', 'Maximum number of products on special to display', '3', '4', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('37', 'Manufacturers List', 'MAX_DISPLAY_MANUFACTURERS_IN_A_LIST', '0', 'Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list', '3', '7', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('38', 'Manufacturers Select Size', 'MAX_MANUFACTURERS_LIST', '1', 'Used in manufacturers box; when this value is \'1\' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.', '3', '7', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('39', 'Length of Manufacturers Name', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', '15', 'Used in manufacturers box; maximum length of manufacturers name to display', '3', '8', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('40', 'New Reviews', 'MAX_DISPLAY_NEW_REVIEWS', '6', 'Maximum number of new reviews to display', '3', '9', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('41', 'Selection of Random Reviews', 'MAX_RANDOM_SELECT_REVIEWS', '10', 'How many records to select from to choose one random product review', '3', '10', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('42', 'Selection of Random New Products', 'MAX_RANDOM_SELECT_NEW', '10', 'How many records to select from to choose one random new product to display', '3', '11', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('43', 'Selection of Products on Special', 'MAX_RANDOM_SELECT_SPECIALS', '10', 'How many records to select from to choose one random product special to display', '3', '12', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('44', 'Categories To List Per Row', 'MAX_DISPLAY_CATEGORIES_PER_ROW', '3', 'How many categories to list per row', '3', '13', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('45', 'New Products Listing', 'MAX_DISPLAY_PRODUCTS_NEW', '10', 'Maximum number of new products to display in new products page', '3', '14', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('46', 'Best Sellers', 'MAX_DISPLAY_BESTSELLERS', '10', 'Maximum number of best sellers to display', '3', '15', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('47', 'Also Purchased', 'MAX_DISPLAY_ALSO_PURCHASED', '6', 'Maximum number of products to display in the \'This Customer Also Purchased\' box', '3', '16', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('48', 'Customer Order History Box', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', '6', 'Maximum number of products to display in the customer order history box', '3', '17', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('49', 'Order History', 'MAX_DISPLAY_ORDER_HISTORY', '10', 'Maximum number of orders to display in the order history page', '3', '18', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('50', 'Product Quantities In Shopping Cart', 'MAX_QTY_IN_CART', '99', 'Maximum number of product quantities that can be added to the shopping cart (0 for no limit)', '3', '19', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('51', 'Small Image Width', 'SMALL_IMAGE_WIDTH', '320', 'The pixel width of small images', '4', '1', '2017-02-09 10:41:22', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('52', 'Small Image Height', 'SMALL_IMAGE_HEIGHT', '240', 'The pixel height of small images', '4', '2', '2017-02-09 10:41:30', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('53', 'Heading Image Width', 'HEADING_IMAGE_WIDTH', '57', 'The pixel width of heading images', '4', '3', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('54', 'Heading Image Height', 'HEADING_IMAGE_HEIGHT', '40', 'The pixel height of heading images', '4', '4', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('55', 'Subcategory Image Width', 'SUBCATEGORY_IMAGE_WIDTH', '100', 'The pixel width of subcategory images', '4', '5', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('56', 'Subcategory Image Height', 'SUBCATEGORY_IMAGE_HEIGHT', '57', 'The pixel height of subcategory images', '4', '6', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('57', 'Calculate Image Size', 'CONFIG_CALCULATE_IMAGE_SIZE', 'true', 'Calculate the size of images?', '4', '7', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('58', 'Image Required', 'IMAGE_REQUIRED', 'true', 'Enable to display broken images. Good for development.', '4', '8', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('59', 'Gender', 'ACCOUNT_GENDER', 'true', 'Display gender in the customers account', '5', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('60', 'Date of Birth', 'ACCOUNT_DOB', 'true', 'Display date of birth in the customers account', '5', '2', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('61', 'Company', 'ACCOUNT_COMPANY', 'true', 'Display company in the customers account', '5', '3', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('62', 'Suburb', 'ACCOUNT_SUBURB', 'true', 'Display suburb in the customers account', '5', '4', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('63', 'State', 'ACCOUNT_STATE', 'true', 'Display state in the customers account', '5', '5', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('64', 'Installed Modules', 'MODULE_PAYMENT_INSTALLED', 'cod.php;paypal_express.php', 'List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cod.php;paypal_express.php)', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('65', 'Installed Modules', 'MODULE_ORDER_TOTAL_INSTALLED', 'ot_subtotal.php;ot_shipping.php;ot_tax.php;ot_total.php', 'List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', '6', '0', '2017-02-10 08:41:38', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('66', 'Installed Modules', 'MODULE_SHIPPING_INSTALLED', 'flat.php', 'List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('67', 'Installed Modules', 'MODULE_ACTION_RECORDER_INSTALLED', 'ar_admin_login.php;ar_contact_us.php;ar_reset_password.php;ar_tell_a_friend.php', 'List of action recorder module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('68', 'Installed Modules', 'MODULE_SOCIAL_BOOKMARKS_INSTALLED', 'sb_email.php;sb_google_plus_share.php;sb_facebook.php;sb_twitter.php;sb_pinterest.php', 'List of social bookmark module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', '2017-02-10 08:41:42', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('69', 'Installed Modules', 'MODULE_CONTENT_NAVBAR_INSTALLED', 'nb_hamburger_button.php;nb_home.php;nb_new_products.php;nb_special_offers.php;nb_testimonials.php;nb_mailchimp_newsletter.php;nb_currencies.php;nb_account.php;nb_reviews.php;nb_shopping_cart.php', 'List of navbar module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', '2017-02-10 16:32:45', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('70', 'Enable Cash On Delivery Module', 'MODULE_PAYMENT_COD_STATUS', 'True', 'Do you want to accept Cash On Delevery payments?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('71', 'Payment Zone', 'MODULE_PAYMENT_COD_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', '6', '2', NULL, '2017-01-24 11:09:54', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('72', 'Sort order of display.', 'MODULE_PAYMENT_COD_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('73', 'Set Order Status', 'MODULE_PAYMENT_COD_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', '6', '0', NULL, '2017-01-24 11:09:54', 'tep_get_order_status_name', 'tep_cfg_pull_down_order_statuses(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('74', 'Enable Flat Shipping', 'MODULE_SHIPPING_FLAT_STATUS', 'True', 'Do you want to offer flat rate shipping?', '6', '0', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('75', 'Shipping Cost', 'MODULE_SHIPPING_FLAT_COST', '5.00', 'The shipping cost for all orders using this shipping method.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('76', 'Tax Class', 'MODULE_SHIPPING_FLAT_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', '6', '0', NULL, '2017-01-24 11:09:54', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('77', 'Shipping Zone', 'MODULE_SHIPPING_FLAT_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', '6', '0', NULL, '2017-01-24 11:09:54', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('78', 'Sort Order', 'MODULE_SHIPPING_FLAT_SORT_ORDER', '0', 'Sort order of display.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('79', 'Default Currency', 'DEFAULT_CURRENCY', 'USD', 'Default Currency', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('80', 'Default Language', 'DEFAULT_LANGUAGE', 'en', 'Default Language', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('81', 'Default Order Status For New Orders', 'DEFAULT_ORDERS_STATUS_ID', '1', 'When a new order is created, this order status will be assigned to it.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('82', 'Display Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 'true', 'Do you want to display the order shipping cost?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('83', 'Sort Order', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', '2', 'Sort order of display.', '6', '2', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('84', 'Allow Free Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', 'Do you want to allow free shipping?', '6', '3', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('85', 'Free Shipping For Orders Over', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '50', 'Provide free shipping for orders over the set amount.', '6', '4', NULL, '2017-01-24 11:09:54', 'currencies->format', NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('86', 'Provide Free Shipping For Orders Made', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', 'Provide free shipping for orders sent to the set destination.', '6', '5', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'national\', \'international\', \'both\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('87', 'Display Sub-Total', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 'true', 'Do you want to display the order sub-total cost?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('88', 'Sort Order', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', '1', 'Sort order of display.', '6', '2', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('89', 'Display Tax', 'MODULE_ORDER_TOTAL_TAX_STATUS', 'true', 'Do you want to display the order tax value?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('90', 'Sort Order', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', '3', 'Sort order of display.', '6', '2', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('91', 'Display Total', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 'true', 'Do you want to display the total order value?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('92', 'Sort Order', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', '4', 'Sort order of display.', '6', '2', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('93', 'Minimum Minutes Per E-Mail', 'MODULE_ACTION_RECORDER_CONTACT_US_EMAIL_MINUTES', '15', 'Minimum number of minutes to allow 1 e-mail to be sent (eg, 15 for 1 e-mail every 15 minutes)', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('94', 'Minimum Minutes Per E-Mail', 'MODULE_ACTION_RECORDER_TELL_A_FRIEND_EMAIL_MINUTES', '15', 'Minimum number of minutes to allow 1 e-mail to be sent (eg, 15 for 1 e-mail every 15 minutes)', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('95', 'Allowed Minutes', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_MINUTES', '5', 'Number of minutes to allow login attempts to occur.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('96', 'Allowed Attempts', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_ATTEMPTS', '3', 'Number of login attempts to allow within the specified period.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('97', 'Allowed Minutes', 'MODULE_ACTION_RECORDER_RESET_PASSWORD_MINUTES', '5', 'Number of minutes to allow password resets to occur.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('98', 'Allowed Attempts', 'MODULE_ACTION_RECORDER_RESET_PASSWORD_ATTEMPTS', '1', 'Number of password reset attempts to allow within the specified period.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('99', 'Enable E-Mail Module', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_STATUS', 'False', 'Do you want to allow products to be shared through e-mail?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('100', 'Sort Order', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('101', 'Enable Google+ Share Module', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_STATUS', 'True', 'Do you want to allow products to be shared through Google+?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('102', 'Annotation', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_ANNOTATION', 'None', 'The annotation to display next to the button.', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Inline\', \'Bubble\', \'Vertical-Bubble\', \'None\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('103', 'Width', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_WIDTH', '', 'The maximum width of the button.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('104', 'Height', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_HEIGHT', '15', 'Sets the height of the button.', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'15\', \'20\', \'24\', \'60\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('105', 'Alignment', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_ALIGN', 'Left', 'The alignment of the button assets.', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('106', 'Sort Order', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_SORT_ORDER', '20', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('107', 'Enable Facebook Module', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_STATUS', 'True', 'Do you want to allow products to be shared through Facebook?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('108', 'Sort Order', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_SORT_ORDER', '30', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('109', 'Enable Twitter Module', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_STATUS', 'True', 'Do you want to allow products to be shared through Twitter?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('110', 'Sort Order', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('111', 'Enable Pinterest Module', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_STATUS', 'True', 'Do you want to allow Pinterest Button?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('112', 'Layout Position', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_BUTTON_COUNT_POSITION', 'None', 'Horizontal or Vertical or None', '6', '2', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Horizontal\', \'Vertical\', \'None\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('113', 'Sort Order', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_SORT_ORDER', '50', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('114', 'Country of Origin', 'SHIPPING_ORIGIN_COUNTRY', '223', 'Select the country of origin to be used in shipping quotes.', '7', '1', NULL, '2017-01-24 11:09:54', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('115', 'Postal Code', 'SHIPPING_ORIGIN_ZIP', 'NONE', 'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.', '7', '2', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('116', 'Enter the Maximum Package Weight you will ship', 'SHIPPING_MAX_WEIGHT', '50', 'Carriers have a max weight limit for a single package. This is a common one for all.', '7', '3', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('117', 'Package Tare weight.', 'SHIPPING_BOX_WEIGHT', '3', 'What is the weight of typical packaging of small to medium packages?', '7', '4', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('118', 'Larger packages - percentage increase.', 'SHIPPING_BOX_PADDING', '10', 'For 10% enter 10', '7', '5', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('119', 'Allow Orders Not Matching Defined Shipping Zones ', 'SHIPPING_ALLOW_UNDEFINED_ZONES', 'False', 'Should orders be allowed to shipping addresses not matching defined shipping module shipping zones?', '7', '5', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('120', 'Display Product Image (0=disable; 1=enable)', 'PRODUCT_LIST_IMAGE', '1', 'Do you want to display the Product Image?', '8', '1', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('121', 'Display Product Manufacturer Name (0=disable; 1=enable)', 'PRODUCT_LIST_MANUFACTURER', '0', 'Do you want to display the Product Manufacturer Name?', '8', '2', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('122', 'Display Product Model (0=disable; 1=enable)', 'PRODUCT_LIST_MODEL', '0', 'Do you want to display the Product Model?', '8', '3', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('123', 'Display Product Name (0=disable; 1=enable)', 'PRODUCT_LIST_NAME', '1', 'Do you want to display the Product Name?', '8', '4', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('124', 'Display Product Price (0=disable; 1=enable)', 'PRODUCT_LIST_PRICE', '1', 'Do you want to display the Product Price', '8', '5', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('125', 'Display Product Quantity (0=disable; 1=enable)', 'PRODUCT_LIST_QUANTITY', '0', 'Do you want to display the Product Quantity?', '8', '6', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('126', 'Display Product Weight (0=disable; 1=enable)', 'PRODUCT_LIST_WEIGHT', '0', 'Do you want to display the Product Weight?', '8', '7', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('127', 'Display Buy Now column (0=disable; 1=enable)', 'PRODUCT_LIST_BUY_NOW', '1', 'Do you want to display the Buy Now column?', '8', '8', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('128', 'Display Category/Manufacturer Filter (0=disable; 1=enable)', 'PRODUCT_LIST_FILTER', '1', 'Do you want to display the Category/Manufacturer Filter?', '8', '9', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('129', 'Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 'PREV_NEXT_BAR_LOCATION', '2', 'Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', '8', '10', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('130', 'Check stock level', 'STOCK_CHECK', 'true', 'Check to see if sufficent stock is available', '9', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('131', 'Subtract stock', 'STOCK_LIMITED', 'true', 'Subtract product in stock by product orders', '9', '2', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('132', 'Allow Checkout', 'STOCK_ALLOW_CHECKOUT', 'true', 'Allow customer to checkout even if there is insufficient stock', '9', '3', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('133', 'Mark product out of stock', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '***', 'Display something on screen so customer can see which product has insufficient stock', '9', '4', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('134', 'Stock Re-order level', 'STOCK_REORDER_LEVEL', '5', 'Define when stock needs to be re-ordered', '9', '5', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('135', 'Store Page Parse Time', 'STORE_PAGE_PARSE_TIME', 'false', 'Store the time it takes to parse a page', '10', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('136', 'Log Destination', 'STORE_PAGE_PARSE_TIME_LOG', '/var/log/www/tep/page_parse_time.log', 'Directory and filename of the page parse time log', '10', '2', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('137', 'Log Date Format', 'STORE_PARSE_DATE_TIME_FORMAT', '%d/%m/%Y %H:%M:%S', 'The date format', '10', '3', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('138', 'Display The Page Parse Time', 'DISPLAY_PAGE_PARSE_TIME', 'true', 'Display the page parse time (store page parse time must be enabled)', '10', '4', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('139', 'Store Database Queries', 'STORE_DB_TRANSACTIONS', 'false', 'Store the database queries in the page parse time log', '10', '5', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('140', 'Use Cache', 'USE_CACHE', 'false', 'Use caching features', '11', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('141', 'Cache Directory', 'DIR_FS_CACHE', '', 'The directory where the cached files are saved', '11', '2', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('142', 'E-Mail Transport Method', 'EMAIL_TRANSPORT', 'sendmail', 'Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.', '12', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'sendmail\', \'smtp\'),');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('143', 'E-Mail Linefeeds', 'EMAIL_LINEFEED', 'LF', 'Defines the character sequence used to separate mail headers.', '12', '2', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'LF\', \'CRLF\'),');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('144', 'Use MIME HTML When Sending Emails', 'EMAIL_USE_HTML', 'true', 'Send e-mails in HTML format', '12', '3', '2017-02-11 10:21:12', '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'),');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('145', 'Verify E-Mail Addresses Through DNS', 'ENTRY_EMAIL_ADDRESS_CHECK', 'false', 'Verify e-mail address through a DNS server', '12', '4', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('146', 'Send E-Mails', 'SEND_EMAILS', 'true', 'Send out e-mails', '12', '5', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('147', 'Enable download', 'DOWNLOAD_ENABLED', 'false', 'Enable the products download functions.', '13', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('148', 'Download by redirect', 'DOWNLOAD_BY_REDIRECT', 'false', 'Use browser redirection for download. Disable on non-Unix systems.', '13', '2', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('149', 'Expiry delay (days)', 'DOWNLOAD_MAX_DAYS', '7', 'Set number of days before the download link expires. 0 means no limit.', '13', '3', NULL, '2017-01-24 11:09:54', NULL, '');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('150', 'Maximum number of downloads', 'DOWNLOAD_MAX_COUNT', '5', 'Set the maximum number of downloads. 0 means no download authorized.', '13', '4', NULL, '2017-01-24 11:09:54', NULL, '');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('151', 'Enable GZip Compression', 'GZIP_COMPRESSION', 'false', 'Enable HTTP GZip compression.', '14', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('152', 'Compression Level', 'GZIP_LEVEL', '5', 'Use this compression level 0-9 (0 = minimum, 9 = maximum).', '14', '2', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('153', 'Session Directory', 'SESSION_WRITE_DIRECTORY', '', 'If sessions are file based, store them in this directory.', '15', '1', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('154', 'Force Cookie Use', 'SESSION_FORCE_COOKIE_USE', 'False', 'Force the use of sessions when cookies are only enabled.', '15', '2', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('155', 'Check SSL Session ID', 'SESSION_CHECK_SSL_SESSION_ID', 'False', 'Validate the SSL_SESSION_ID on every secure HTTPS page request.', '15', '3', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('156', 'Check User Agent', 'SESSION_CHECK_USER_AGENT', 'False', 'Validate the clients browser user agent on every page request.', '15', '4', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('157', 'Check IP Address', 'SESSION_CHECK_IP_ADDRESS', 'False', 'Validate the clients IP address on every page request.', '15', '5', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('158', 'Prevent Spider Sessions', 'SESSION_BLOCK_SPIDERS', 'True', 'Prevent known spiders from starting a session.', '15', '6', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('159', 'Recreate Session', 'SESSION_RECREATE', 'True', 'Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).', '15', '7', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('160', 'Last Update Check Time', 'LAST_UPDATE_CHECK_TIME', '', 'Last time a check for new versions of osCommerce was run', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('161', 'Store Logo', 'STORE_LOGO', 'store_logo.png', 'This is the filename of your Store Logo.  This should be updated at admin > configuration > Store Logo', '6', '1000', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('162', 'Bootstrap Container', 'BOOTSTRAP_CONTAINER', 'container-fluid', 'What type of container should the page content be shown in? See http://getbootstrap.com/css/#overview-container', '16', '1', '2017-02-01 14:24:24', '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'container-fluid\', \'container\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('163', 'Bootstrap Content', 'BOOTSTRAP_CONTENT', '8', 'What width should the page content default to?  (8 = two thirds width, 6 = half width, 4 = one third width) Note that the Side Column(s) will adjust automatically.', '16', '2', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'8\', \'6\', \'4\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('182', 'Installed Modules', 'MODULE_HEADER_TAGS_INSTALLED', 'ht_div_equal_heights.php;ht_manufacturer_seo.php;ht_category_seo.php;ht_product_meta.php;ht_owl_carousel.php;ht_category_title.php;ht_product_title.php;ht_canonical.php;ht_robot_noindex.php;ht_datepicker_jquery.php;ht_grid_list_view.php;ht_manufacturer_title.php;ht_table_click_jquery.php;ht_product_colorbox.php;ht_noscript.php;ht_product_opengraph.php', 'List of header tag module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', '2017-02-12 09:49:30', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('183', 'Enable Category Title Module', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_STATUS', 'True', 'Do you want to allow category titles to be added to the page title?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('184', 'Sort Order', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('185', 'SEO Title Override?', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_SEO_TITLE_OVERRIDE', 'True', 'Do you want to allow category titles to be over-ridden by your SEO Titles (if set)?', '6', '0', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('186', 'SEO Breadcrumb Override?', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_SEO_BREADCRUMB_OVERRIDE', 'True', 'Do you want to allow category names in the breadcrumb to be over-ridden by your SEO Titles (if set)?', '6', '0', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('187', 'Enable Manufacturer Title Module', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_STATUS', 'True', 'Do you want to allow manufacturer titles to be added to the page title?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('188', 'Sort Order', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('189', 'SEO Title Override?', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_SEO_TITLE_OVERRIDE', 'True', 'Do you want to allow manufacturer names to be over-ridden by your SEO Titles (if set)?', '6', '0', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('190', 'SEO Breadcrumb Override?', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_SEO_BREADCRUMB_OVERRIDE', 'True', 'Do you want to allow manufacturer names in the breadcrumb to be over-ridden by your SEO Titles (if set)?', '6', '0', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('191', 'Enable Product Title Module', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_STATUS', 'True', 'Do you want to allow product titles to be added to the page title?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('192', 'Sort Order', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_SORT_ORDER', '300', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('193', 'SEO Title Override?', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_SEO_TITLE_OVERRIDE', 'True', 'Do you want to allow product titles to be over-ridden by your SEO Titles (if set)?', '6', '0', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('194', 'SEO Breadcrumb Override?', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_SEO_BREADCRUMB_OVERRIDE', 'True', 'Do you want to allow product names in the breadcrumb to be over-ridden by your SEO Titles (if set)?', '6', '0', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('195', 'Enable Canonical Module', 'MODULE_HEADER_TAGS_CANONICAL_STATUS', 'True', 'Do you want to enable the Canonical module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('196', 'Sort Order', 'MODULE_HEADER_TAGS_CANONICAL_SORT_ORDER', '400', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('197', 'Enable Robot NoIndex Module', 'MODULE_HEADER_TAGS_ROBOT_NOINDEX_STATUS', 'True', 'Do you want to enable the Robot NoIndex module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('198', 'Pages', 'MODULE_HEADER_TAGS_ROBOT_NOINDEX_PAGES', 'account.php;account_edit.php;account_history.php;account_history_info.php;account_newsletters.php;account_notifications.php;account_password.php;address_book.php;address_book_process.php;checkout_confirmation.php;checkout_payment.php;checkout_payment_address.php;checkout_process.php;checkout_shipping.php;checkout_shipping_address.php;checkout_success.php;cookie_usage.php;create_account.php;create_account_success.php;login.php;logoff.php;password_forgotten.php;password_reset.php;product_reviews_write.php;shopping_cart.php;ssl_check.php;tell_a_friend.php', 'The pages to add the meta robot noindex tag to.', '6', '0', NULL, '2017-01-24 11:09:54', 'ht_robot_noindex_show_pages', 'ht_robot_noindex_edit_pages(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('199', 'Sort Order', 'MODULE_HEADER_TAGS_ROBOT_NOINDEX_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('200', 'Enable No Script Module', 'MODULE_HEADER_TAGS_NOSCRIPT_STATUS', 'True', 'Add message for people with .js turned off?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('201', 'Sort Order', 'MODULE_HEADER_TAGS_NOSCRIPT_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('202', 'Enable Datepicker jQuery Module', 'MODULE_HEADER_TAGS_DATEPICKER_JQUERY_STATUS', 'True', 'Do you want to enable the Datepicker module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('203', 'Pages', 'MODULE_HEADER_TAGS_DATEPICKER_JQUERY_PAGES', 'advanced_search.php;account_edit.php;create_account.php', 'The pages to add the Datepicker jQuery Scripts to.', '6', '0', NULL, '2017-01-24 11:09:54', 'ht_datepicker_jquery_show_pages', 'ht_datepicker_jquery_edit_pages(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('204', 'Sort Order', 'MODULE_HEADER_TAGS_DATEPICKER_JQUERY_SORT_ORDER', '600', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('205', 'Enable Grid List javascript', 'MODULE_HEADER_TAGS_GRID_LIST_VIEW_STATUS', 'True', 'Do you want to enable the Grid/List Javascript module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('206', 'Pages', 'MODULE_HEADER_TAGS_GRID_LIST_VIEW_PAGES', 'advanced_search_result.php;index.php;products_new.php;specials.php', 'The pages to add the Grid List JS Scripts to.', '6', '0', NULL, '2017-01-24 11:09:54', 'ht_grid_list_view_show_pages', 'ht_grid_list_view_edit_pages(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('207', 'Sort Order', 'MODULE_HEADER_TAGS_GRID_LIST_VIEW_SORT_ORDER', '700', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('208', 'Enable Clickable Table Rows Module', 'MODULE_HEADER_TAGS_TABLE_CLICK_JQUERY_STATUS', 'True', 'Do you want to enable the Clickable Table Rows module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('209', 'Pages', 'MODULE_HEADER_TAGS_TABLE_CLICK_JQUERY_PAGES', 'checkout_payment.php;checkout_shipping.php', 'The pages to add the jQuery Scripts to.', '6', '0', NULL, '2017-01-24 11:09:54', 'ht_table_click_jquery_show_pages', 'ht_table_click_jquery_edit_pages(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('210', 'Sort Order', 'MODULE_HEADER_TAGS_TABLE_CLICK_JQUERY_SORT_ORDER', '800', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('211', 'Enable Colorbox Script', 'MODULE_HEADER_TAGS_PRODUCT_COLORBOX_STATUS', 'True', 'Do you want to enable the Colorbox Scripts?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('212', 'Pages', 'MODULE_HEADER_TAGS_PRODUCT_COLORBOX_PAGES', 'product_info.php', 'The pages to add the Colorbox Scripts to.', '6', '0', NULL, '2017-01-24 11:09:54', 'ht_product_colorbox_show_pages', 'ht_product_colorbox_edit_pages(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('213', 'Thumbnail Layout', 'MODULE_HEADER_TAGS_PRODUCT_COLORBOX_LAYOUT', '155', 'Layout of Thumbnails', '6', '0', NULL, '2017-01-24 11:09:54', 'ht_product_colorbox_thumbnail_number', NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('214', 'Sort Order', 'MODULE_HEADER_TAGS_PRODUCT_COLORBOX_SORT_ORDER', '900', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('215', 'Installed Modules', 'MODULE_ADMIN_DASHBOARD_INSTALLED', 'd_total_revenue.php;d_total_customers.php;d_orders.php;d_customers.php;d_admin_logins.php;d_security_checks.php;d_latest_news.php;d_latest_addons.php;d_partner_news.php;d_version_check.php;d_reviews.php;d_paypal_app.php', 'List of Administration Tool Dashboard module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('216', 'Enable Administrator Logins Module', 'MODULE_ADMIN_DASHBOARD_ADMIN_LOGINS_STATUS', 'True', 'Do you want to show the latest administrator logins on the dashboard?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('217', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_ADMIN_LOGINS_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('218', 'Enable Customers Module', 'MODULE_ADMIN_DASHBOARD_CUSTOMERS_STATUS', 'True', 'Do you want to show the newest customers on the dashboard?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('219', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_CUSTOMERS_SORT_ORDER', '400', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('220', 'Enable Latest Add-Ons Module', 'MODULE_ADMIN_DASHBOARD_LATEST_ADDONS_STATUS', 'False', 'Do you want to show the latest osCommerce Add-Ons on the dashboard?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('221', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_LATEST_ADDONS_SORT_ORDER', '800', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('222', 'Enable Latest News Module', 'MODULE_ADMIN_DASHBOARD_LATEST_NEWS_STATUS', 'False', 'Do you want to show the latest osCommerce News on the dashboard?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('223', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_LATEST_NEWS_SORT_ORDER', '700', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('224', 'Enable Orders Module', 'MODULE_ADMIN_DASHBOARD_ORDERS_STATUS', 'True', 'Do you want to show the latest orders on the dashboard?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('225', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_ORDERS_SORT_ORDER', '300', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('226', 'Enable Security Checks Module', 'MODULE_ADMIN_DASHBOARD_SECURITY_CHECKS_STATUS', 'True', 'Do you want to run the security checks for this installation?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('227', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_SECURITY_CHECKS_SORT_ORDER', '600', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('228', 'Enable Total Customers Module', 'MODULE_ADMIN_DASHBOARD_TOTAL_CUSTOMERS_STATUS', 'True', 'Do you want to show the total customers chart on the dashboard?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('229', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_TOTAL_CUSTOMERS_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('230', 'Enable Total Revenue Module', 'MODULE_ADMIN_DASHBOARD_TOTAL_REVENUE_STATUS', 'True', 'Do you want to show the total revenue chart on the dashboard?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('231', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_TOTAL_REVENUE_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('232', 'Enable Version Check Module', 'MODULE_ADMIN_DASHBOARD_VERSION_CHECK_STATUS', 'False', 'Do you want to show the version check results on the dashboard?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('233', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_VERSION_CHECK_SORT_ORDER', '900', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('234', 'Enable Latest Reviews Module', 'MODULE_ADMIN_DASHBOARD_REVIEWS_STATUS', 'True', 'Do you want to show the latest reviews on the dashboard?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('235', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_REVIEWS_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('236', 'Enable Partner News Module', 'MODULE_ADMIN_DASHBOARD_PARTNER_NEWS_STATUS', 'False', 'Do you want to show the latest osCommerce Partner News on the dashboard?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('237', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_PARTNER_NEWS_SORT_ORDER', '820', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('238', 'Installed Modules', 'MODULE_BOXES_INSTALLED', 'bm_categories_superfish.php;bm_whats_new.php;bm_specials.php;bm_manufacturers.php;bm_product_social_bookmarks.php;bm_best_sellers.php;bm_manufacturer_info.php;bm_card_acceptance.php;bm_order_history.php', 'List of box module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', '2017-02-12 10:23:03', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('239', 'Enable Best Sellers Module', 'MODULE_BOXES_BEST_SELLERS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('240', 'Content Placement', 'MODULE_BOXES_BEST_SELLERS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('241', 'Sort Order', 'MODULE_BOXES_BEST_SELLERS_SORT_ORDER', '1035', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('245', 'Enable Manufacturers Module', 'MODULE_BOXES_MANUFACTURERS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('246', 'Content Placement', 'MODULE_BOXES_MANUFACTURERS_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('247', 'Sort Order', 'MODULE_BOXES_MANUFACTURERS_SORT_ORDER', '1025', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('248', 'Enable Order History Module', 'MODULE_BOXES_ORDER_HISTORY_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('249', 'Content Placement', 'MODULE_BOXES_ORDER_HISTORY_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('250', 'Sort Order', 'MODULE_BOXES_ORDER_HISTORY_SORT_ORDER', '5020', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('251', 'Enable Card Acceptance Module', 'MODULE_BOXES_CARD_ACCEPTANCE_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('252', 'Logos', 'MODULE_BOXES_CARD_ACCEPTANCE_LOGOS', 'paypal_horizontal_large.png;visa.png;mastercard_transparent.png;american_express.png;maestro_transparent.png', 'The card acceptance logos to show.', '6', '0', NULL, '2017-01-24 11:09:54', 'bm_card_acceptance_show_logos', 'bm_card_acceptance_edit_logos(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('253', 'Content Placement', 'MODULE_BOXES_CARD_ACCEPTANCE_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('254', 'Sort Order', 'MODULE_BOXES_CARD_ACCEPTANCE_SORT_ORDER', '1060', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('255', 'Enable What\'s New Module', 'MODULE_BOXES_WHATS_NEW_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('256', 'Content Placement', 'MODULE_BOXES_WHATS_NEW_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('257', 'Sort Order', 'MODULE_BOXES_WHATS_NEW_SORT_ORDER', '1015', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('258', 'Installed Template Block Groups', 'TEMPLATE_BLOCK_GROUPS', 'boxes;header_tags;pdf_datasheet', 'This is automatically updated. No need to edit.', '6', '0', '2017-02-11 10:46:17', '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('259', 'Installed Modules', 'MODULE_CONTENT_INSTALLED', 'account/cm_account_set_password;category/cm_category_categories_description;category/cm_category_new_products_carousel;category/cm_category_popular_products_carousel;category/cm_category_categories_images;checkout_success/cm_cs_redirect_old_order;checkout_success/cm_cs_thank_you;checkout_success/cm_cs_product_notifications;checkout_success/cm_cs_downloads;footer/cm_footer_information_links;footer_suffix/cm_footer_extra_copyright;footer_suffix/cm_footer_extra_icons;header/cm_header_logo;header/cm_header_search;header/cm_header_messagestack;header/cm_header_breadcrumb;index/cm_i_text_main;login/cm_login_form;login/cm_create_account_link;navigation/cm_navbar', 'This is automatically updated. No need to edit.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('260', 'Enable Set Account Password', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_STATUS', 'True', 'Do you want to enable the Set Account Password module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('261', 'Allow Local Passwords', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_ALLOW_PASSWORD', 'True', 'Allow local account passwords to be set.', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('262', 'Sort Order', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('263', 'Enable Redirect Old Order Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_REDIRECT_OLD_ORDER_STATUS', 'True', 'Should customers be redirected when viewing old checkout success orders?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('264', 'Redirect Minutes', 'MODULE_CONTENT_CHECKOUT_SUCCESS_REDIRECT_OLD_ORDER_MINUTES', '60', 'Redirect customers to the My Account page after an order older than this amount is viewed.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('265', 'Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_REDIRECT_OLD_ORDER_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('266', 'Enable Thank You Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_STATUS', 'True', 'Should the thank you block be shown on the checkout success page?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('267', 'Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('268', 'Enable Product Notifications Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_PRODUCT_NOTIFICATIONS_STATUS', 'True', 'Should the product notifications block be shown on the checkout success page?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('269', 'Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_PRODUCT_NOTIFICATIONS_SORT_ORDER', '2000', 'Sort order of display. Lowest is displayed first.', '6', '3', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('270', 'Enable Product Downloads Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_DOWNLOADS_STATUS', 'True', 'Should ordered product download links be shown on the checkout success page?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('271', 'Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_DOWNLOADS_SORT_ORDER', '3000', 'Sort order of display. Lowest is displayed first.', '6', '3', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('272', 'Enable Login Form Module', 'MODULE_CONTENT_LOGIN_FORM_STATUS', 'True', 'Do you want to enable the login form module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('273', 'Content Width', 'MODULE_CONTENT_LOGIN_FORM_CONTENT_WIDTH', 'Half', 'Should the content be shown in a full or half width container?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Full\', \'Half\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('274', 'Sort Order', 'MODULE_CONTENT_LOGIN_FORM_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('275', 'Enable New User Module', 'MODULE_CONTENT_CREATE_ACCOUNT_LINK_STATUS', 'True', 'Do you want to enable the new user module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('276', 'Content Width', 'MODULE_CONTENT_CREATE_ACCOUNT_LINK_CONTENT_WIDTH', 'Half', 'Should the content be shown in a full or half width container?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Full\', \'Half\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('277', 'Sort Order', 'MODULE_CONTENT_CREATE_ACCOUNT_LINK_SORT_ORDER', '2000', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('278', 'Enable Hamburger Button Module', 'MODULE_NAVBAR_HAMBURGER_BUTTON_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('279', 'Content Placement', 'MODULE_NAVBAR_HAMBURGER_BUTTON_CONTENT_PLACEMENT', 'Home', 'This module must be placed in the Home area of the Navbar.', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Home\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('280', 'Sort Order', 'MODULE_NAVBAR_HAMBURGER_BUTTON_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('284', 'Enable Shopping Cart Module', 'MODULE_NAVBAR_SHOPPING_CART_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('285', 'Content Placement', 'MODULE_NAVBAR_SHOPPING_CART_CONTENT_PLACEMENT', 'Right', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('286', 'Sort Order', 'MODULE_NAVBAR_SHOPPING_CART_SORT_ORDER', '550', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('287', 'Enable Navbar Module', 'MODULE_CONTENT_NAVBAR_STATUS', 'True', 'Should the Navbar be shown? ', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('288', 'Navbar Style', 'MODULE_CONTENT_NAVBAR_STYLE', 'Inverse', 'What style should the Navbar have?  See http://getbootstrap.com/components/#navbar-inverted', '6', '0', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Default\', \'Inverse\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('289', 'Navbar Corners', 'MODULE_CONTENT_NAVBAR_CORNERS', 'No', 'Should the Navbar have Corners?', '6', '0', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Yes\', \'No\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('290', 'Navbar Margin', 'MODULE_CONTENT_NAVBAR_MARGIN', 'Yes', 'Should the Navbar have a bottom Margin?', '6', '0', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Yes\', \'No\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('291', 'Navbar Fixed Position', 'MODULE_CONTENT_NAVBAR_FIXED', 'Floating', 'Should the Navbar stay fixed on Top/Bottom of the page or Floating?', '6', '0', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Floating\', \'Top\', \'Bottom\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('292', 'Sort Order', 'MODULE_CONTENT_NAVBAR_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('293', 'Enable Header Logo Module', 'MODULE_CONTENT_HEADER_LOGO_STATUS', 'True', 'Do you want to enable the Logo content module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('294', 'Content Width', 'MODULE_CONTENT_HEADER_LOGO_CONTENT_WIDTH', '6', 'What width container should the content be shown in?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('295', 'Sort Order', 'MODULE_CONTENT_HEADER_LOGO_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('296', 'Enable Search Box Module', 'MODULE_CONTENT_HEADER_SEARCH_STATUS', 'True', 'Do you want to enable the Search Box content module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('297', 'Content Width', 'MODULE_CONTENT_HEADER_SEARCH_CONTENT_WIDTH', '6', 'What width container should the content be shown in?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('298', 'Sort Order', 'MODULE_CONTENT_HEADER_SEARCH_SORT_ORDER', '20', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('299', 'Enable Message Stack Notifications Module', 'MODULE_CONTENT_HEADER_MESSAGESTACK_STATUS', 'True', 'Should the Message Stack Notifications be shown in the header when needed? ', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('300', 'Sort Order', 'MODULE_CONTENT_HEADER_MESSAGESTACK_SORT_ORDER', '30', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('301', 'Enable Header Breadcrumb Module', 'MODULE_CONTENT_HEADER_BREADCRUMB_STATUS', 'True', 'Do you want to enable the Breadcrumb content module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('302', 'Content Width', 'MODULE_CONTENT_HEADER_BREADCRUMB_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('303', 'Sort Order', 'MODULE_CONTENT_HEADER_BREADCRUMB_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('304', 'Enable Information Links Footer Module', 'MODULE_CONTENT_FOOTER_INFORMATION_STATUS', 'True', 'Do you want to enable the Information Links content module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('305', 'Content Width', 'MODULE_CONTENT_FOOTER_INFORMATION_CONTENT_WIDTH', '3', 'What width container should the content be shown in? (12 = full width, 6 = half width).', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('306', 'Sort Order', 'MODULE_CONTENT_FOOTER_INFORMATION_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('307', 'Enable Copyright Details Footer Module', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_STATUS', 'True', 'Do you want to enable the Copyright content module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('308', 'Content Width', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_CONTENT_WIDTH', '6', 'What width container should the content be shown in? (12 = full width, 6 = half width).', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('309', 'Sort Order', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('310', 'Enable Payment Icons Footer Module', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_STATUS', 'True', 'Do you want to enable the Payment Icons content module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('311', 'Content Width', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_CONTENT_WIDTH', '6', 'What width container should the content be shown in? (12 = full width, 6 = half width).', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('312', 'Sort Order', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('316', 'Enable Main Text Module', 'MODULE_CONTENT_TEXT_MAIN_STATUS', 'True', 'Do you want to enable this module?', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('317', 'Content Width', 'MODULE_CONTENT_TEXT_MAIN_CONTENT_WIDTH', '12', 'What width container should the content be shown in? (12 = full width, 6 = half width).', '6', '1', NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('318', 'Sort Order', 'MODULE_CONTENT_TEXT_MAIN_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', '6', '4', NULL, '2017-01-24 11:09:54', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('342', 'Security Check Extended Last Run', 'MODULE_SECURITY_CHECK_EXTENDED_LAST_RUN_DATETIME', '1486743715', 'The date and time the last extended security check was performed.', '6', NULL, NULL, '2017-01-24 11:33:09', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('343', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_STATUS', '0', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('344', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LIVE_SELLER_EMAIL', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('345', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_ACCOUNT_OPTIONAL', '0', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('346', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_INSTANT_UPDATE', '1', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('347', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_CHECKOUT_IMAGE', '0', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('348', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_PAGE_STYLE', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('349', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_TRANSACTION_METHOD', '1', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('350', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_ORDER_STATUS_ID', '4', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('351', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_ZONE', '0', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('352', 'Sort Order', 'OSCOM_APP_PAYPAL_EC_SORT_ORDER', '0', 'Sort order of display (lowest to highest).', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('353', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_VERIFY_SSL', '1', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('354', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PROXY', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('355', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_DP_STATUS', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('356', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_HS_STATUS', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('357', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PS_STATUS', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('358', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LOGIN_STATUS', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('359', 'Sort Order', 'MODULE_ADMIN_DASHBOARD_PAYPAL_APP_SORT_ORDER', '5000', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:42:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('360', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_VERSION_CHECK', '12', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 11:42:18', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('361', 'Enable New Products Module', 'MODULE_NAVBAR_NEW_PRODUCTS_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', NULL, '2017-01-24 11:43:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('362', 'Content Placement', 'MODULE_NAVBAR_NEW_PRODUCTS_CONTENT_PLACEMENT', 'Left', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', '6', '1', NULL, '2017-01-24 11:43:11', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('363', 'Sort Order', 'MODULE_NAVBAR_NEW_PRODUCTS_SORT_ORDER', '525', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:43:11', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('364', 'Enable Special Offers Module', 'MODULE_NAVBAR_SPECIAL_OFFERS_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', NULL, '2017-01-24 11:43:20', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('365', 'Content Placement', 'MODULE_NAVBAR_SPECIAL_OFFERS_CONTENT_PLACEMENT', 'Left', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', '6', '1', NULL, '2017-01-24 11:43:20', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('366', 'Sort Order', 'MODULE_NAVBAR_SPECIAL_OFFERS_SORT_ORDER', '530', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 11:43:20', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('373', 'Enable Account Module', 'MODULE_NAVBAR_ACCOUNT_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', NULL, '2017-01-24 12:11:38', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('374', 'Content Placement', 'MODULE_NAVBAR_ACCOUNT_CONTENT_PLACEMENT', 'Right', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', '6', '1', NULL, '2017-01-24 12:11:38', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('375', 'Sort Order', 'MODULE_NAVBAR_ACCOUNT_SORT_ORDER', '540', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-24 12:11:38', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('399', 'Module Version', 'MODULE_HEADER_TAGS_DIV_EQUAL_HEIGHTS_VERSION', '1.0', 'The version of this module that you are running', '6', '0', NULL, '2017-01-24 13:12:10', NULL, 'tep_cfg_disabled(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('400', 'Enable New Equal Heights Module', 'MODULE_HEADER_TAGS_DIV_EQUAL_HEIGHTS_STATUS', 'True', 'Do you want to enable the New Equal Heights module?', '6', '1', NULL, '2017-01-24 13:12:10', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('401', 'Pages', 'MODULE_HEADER_TAGS_DIV_EQUAL_HEIGHTS_PAGES', 'advanced_search_result.php;index.php;products_new.php;specials.php', 'The pages to add the script to.', '6', '2', NULL, '2017-01-24 13:12:10', 'ht_div_equal_heights_show_pages', 'ht_div_equal_heights_edit_pages(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('402', 'Sort Order', 'MODULE_HEADER_TAGS_DIV_EQUAL_HEIGHTS_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '3', NULL, '2017-01-24 13:12:10', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('414', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_TRANSACTIONS_ORDER_STATUS_ID', '4', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:15', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('415', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_GATEWAY', '1', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:15', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('416', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LOG_TRANSACTIONS', '1', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:15', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('417', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_CHECKOUT_FLOW', '0', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:15', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('418', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LIVE_SELLER_EMAIL_PRIMARY', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('419', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LIVE_API_USERNAME', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('420', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LIVE_API_PASSWORD', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('421', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LIVE_API_SIGNATURE', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('422', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_SANDBOX_SELLER_EMAIL', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('423', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_SANDBOX_SELLER_EMAIL_PRIMARY', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('424', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_SANDBOX_API_USERNAME', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('425', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_SANDBOX_API_PASSWORD', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('426', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_SANDBOX_API_SIGNATURE', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('427', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_LIVE_PARTNER', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('428', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_LIVE_VENDOR', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('429', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_LIVE_USER', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('430', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_LIVE_PASSWORD', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('431', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_SANDBOX_PARTNER', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('432', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_SANDBOX_VENDOR', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('433', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_SANDBOX_USER', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('434', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_SANDBOX_PASSWORD', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-01-24 15:00:36', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('447', 'Enable Reviews Module', 'MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS', 'False', 'Do you want to add the module to your Navbar?', '6', '1', NULL, '2017-01-25 00:13:52', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('448', 'Content Placement', 'MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_CONTENT_PLACEMENT', 'Right', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', '6', '1', NULL, '2017-01-25 00:13:52', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('449', 'Sort Order', 'MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_SORT_ORDER', '535', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-25 00:13:52', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('471', 'Enable Home Module', 'MODULE_NAVBAR_HOME_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', NULL, '2017-01-26 07:55:25', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('472', 'Content Placement', 'MODULE_NAVBAR_HOME_CONTENT_PLACEMENT', 'Left', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', '6', '1', NULL, '2017-01-26 07:55:25', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('473', 'Sort Order', 'MODULE_NAVBAR_HOME_SORT_ORDER', '520', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-26 07:55:25', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('474', 'Enable Testimonials Module', 'MODULE_NAVBAR_TESTIMONIALS_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', NULL, '2017-01-26 07:56:40', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('475', 'Content Placement', 'MODULE_NAVBAR_TESTIMONIALS_CONTENT_PLACEMENT', 'Left', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', '6', '1', NULL, '2017-01-26 07:56:40', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('476', 'Sort Order', 'MODULE_NAVBAR_TESTIMONIALS_SORT_ORDER', '534', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-26 07:56:40', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('477', 'Enable Reviews Module', 'MODULE_NAVBAR_REVIEWS_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', NULL, '2017-01-26 07:57:00', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('478', 'Content Placement', 'MODULE_NAVBAR_REVIEWS_CONTENT_PLACEMENT', 'Left', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', '6', '1', NULL, '2017-01-26 07:57:00', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('479', 'Sort Order', 'MODULE_NAVBAR_REVIEWS_SORT_ORDER', '535', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-01-26 07:57:00', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('494', 'Owl Carousel Version', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_JAVASCRIPT_VERSION', '1.3.3', 'The version of this jQuery Owl Carousel.', '6', '1', NULL, '2017-01-26 08:59:40', NULL, 'tep_cfg_disabled(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('495', 'Enable jQuery Owl Carousel Module', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_STATUS', 'True', 'Do you want to add jQuery Owl Carousel Javascript to your shop? (Required for modules that need owl carousel to function i.e. New Products Carousel.)', '6', '2', NULL, '2017-01-26 08:59:40', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('496', 'Pages', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_VIEW_PAGES', 'index.php', 'The pages to add the script to.', '6', '3', NULL, '2017-01-26 08:59:40', 'ht_owl_carousel_show_pages', 'ht_owl_carousel_edit_pages(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('497', 'Sort Order', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_SORT_ORDER', '150', 'Sort order. Lowest is first.', '6', '4', NULL, '2017-01-26 08:59:40', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('592', 'Enable New Products Carousel Module', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_STATUS', 'True', 'Should the new products carousel be shown on the category pages? (Requires jQuery Owl Carousel v1.3.3 Javascript loaded.)', '6', '0', NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('593', 'Show on the Front Page', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_FRONT_PAGE', 'True', 'Should the new products carousel be shown on the front page?', '6', '1', NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('594', 'Show on Top Level Category Pages', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CAT_PAGE', 'True', 'Should the new products carousel be shown on the top level category pages?', '6', '2', NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('595', 'Show on Sub-Category Product Pages', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PROD_PAGE', 'True', 'Should the new products carousel be shown on the sub-category product pages?', '6', '3', NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('596', 'Allow Close', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CLOSE', 'False', 'Allow the panel box to be closed/hidden by displaying an X in the corner (except the front page).', '6', '4', NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('597', 'Max Products', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_MAX_DISPLAY_NEW_PRODUCTS', '20', 'Maximum number of new products to show in the new products carousel. (When inside a category, only new products for that category are shown)', '6', '5', NULL, '2017-01-26 10:14:13', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('598', 'Show Old Price', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SHOW_OLD_PRICE', 'True', 'When there is a special, do you want to show the old product price with the new special price in the new products carousel? Default: False (only show special price).', '6', '6', NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('599', 'Show Product Description', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SHOW_DESCRIPTION', 'False', 'Do you want to show the product description in the new products carousel?', '6', '7', NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('600', 'Maximum Word Length', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_WORD_LENGTH', '40', 'When show product description is set to true, set the maximum number of characters in a single word (Needed to prevent breaking box width). Default: 40.', '6', '8', NULL, '2017-01-26 10:14:13', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('601', 'Maximum Description Length', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_DESCRIPTION_LENGTH', '100', 'When show product description is set to true, set the number of characters (to the nearest word) of the description to display in the new products carousel. Default: 100.', '6', '9', NULL, '2017-01-26 10:14:13', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('602', 'Enable Auto Play', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_AUTOPLAY', 'True', 'Should the carousel play (slide) automatically?', '6', '10', NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('603', 'Auto Play Speed', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_AUTOPLAY_SPEED', '5000', 'When auto play is set to true, set the time delay between slides, in millisecs (ms). Lower number is faster, higher is slower. Default: 5000.', '6', '11', NULL, '2017-01-26 10:14:13', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('604', 'Navigation Slide Speed', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_NAV_SLIDE_SPEED', '700', 'Slide speed when using navigation buttons, in millisecs (ms). Lower number is faster, higher is slower. Default: 700.', '6', '12', NULL, '2017-01-26 10:14:13', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('605', 'Page Slide Speed', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PAGE_SLIDE_SPEED', '800', 'Page slide speed during auto play, in millisecs (ms). Lower number is faster, higher is slower. Default: 800.', '6', '13', NULL, '2017-01-26 10:14:13', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('606', 'Sort Order', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SORT_ORDER', '35', 'Sort order of display. Lowest is displayed first.', '6', '14', NULL, '2017-01-26 10:14:13', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('607', 'Enable Popular Products Carousel Module', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_STATUS', 'True', 'Should the popular products carousel be shown on the category pages? (Requires jQuery Owl Carousel v1.3.3 Javascript loaded.)', '6', '0', NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('608', 'Show on the Front Page', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_FRONT_PAGE', 'True', 'Should the popular products carousel be shown on the front page?', '6', '1', NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('609', 'Show on Top Level Category Pages', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_CAT_PAGE', 'True', 'Should the popular products carousel be shown on the top level category pages?', '6', '2', NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('610', 'Show on Sub-Category Product Pages', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_PROD_PAGE', 'True', 'Should the popular products carousel be shown on the sub-category product pages?', '6', '3', NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('611', 'Allow Close', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_CLOSE', 'False', 'Allow the panel box to be closed/hidden by displaying an X in the corner (except the front page).', '6', '4', NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('612', 'Max Products', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_MAX_DISPLAY_POPULAR_PRODUCTS', '20', 'Maximum number of popular products to show on the category pages. (When inside a category, only popular products for that category are shown). Default: 20', '6', '5', NULL, '2017-01-26 10:16:11', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('613', 'Show Old Price', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_SHOW_OLD_PRICE', 'True', 'When there is a special, do you want to show the old product price with the new special price in the popular products carousel? Default: False (only show special price).', '6', '6', NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('614', 'Show Product Description', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_SHOW_DESCRIPTION', 'False', 'Do you want to show the product description in the popular products carousel?', '6', '7', NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('615', 'Maximum Word Length', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_WORD_LENGTH', '40', 'When show product description is set to true, set the maximum number of characters in a single word (Needed to prevent breaking box width). Default: 40.', '6', '8', NULL, '2017-01-26 10:16:11', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('616', 'Maximum Description Length', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_DESCRIPTION_LENGTH', '100', 'When show product description is set to true, set the number of characters (to the nearest word) of the description to display in the popular products carousel. Default: 100.', '6', '9', NULL, '2017-01-26 10:16:11', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('617', 'Enable Auto Play', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_AUTOPLAY', 'False', 'Should the carousel play (slide) automatically?', '6', '10', NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('618', 'Auto Play Speed', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_AUTOPLAY_SPEED', '5000', 'When auto play is set to true, set the time delay between slides, in millisecs (ms). Lower number is faster, higher is slower. Default: 5000.', '6', '11', NULL, '2017-01-26 10:16:11', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('619', 'Navigation Slide Speed', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_NAV_SLIDE_SPEED', '700', 'Slide speed when using navigation buttons, in millisecs (ms). Lower number is faster, higher is slower. Default: 700.', '6', '12', NULL, '2017-01-26 10:16:11', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('620', 'Page Slide Speed', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_PAGE_SLIDE_SPEED', '800', 'Page slide speed during auto play, in millisecs (ms). Lower number is faster, higher is slower. Default: 800.', '6', '13', NULL, '2017-01-26 10:16:11', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('621', 'Show Hot Selling', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_HOT', 'False', 'Should the hot selling label show on items that reach the hot selling target?', '6', '14', NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('622', 'Hot Selling Target', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_HOT_TARGET', '50', 'When enable hot selling is set to true, set the target sales to reach for items to become hot selling. Default: 50.', '6', '15', NULL, '2017-01-26 10:16:11', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('623', 'Hot Selling Target Time Frame', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_HOT_TARGET_TIME', '1', 'When enable hot selling is set to true, set the time frame for the target sales to be reached for items to become hot selling, in months. Default: 1 month.', '6', '16', NULL, '2017-01-26 10:16:11', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('624', 'Sort Order', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', '6', '17', NULL, '2017-01-26 10:16:11', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('648', 'Module Version', 'MODULE_CONTENT_CATEGORY_CATEGORIES_DESCRIPTION_VERSION', '1.1', 'The version of this module that you are running.', '6', '0', NULL, '2017-01-26 12:36:58', NULL, 'tep_cfg_disabled(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('649', 'Enable Category Description Module', 'MODULE_CONTENT_CATEGORY_CATEGORIES_DESCRIPTION_STATUS', 'True', 'Should the category description be shown in the category?', '6', '1', NULL, '2017-01-26 12:36:58', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('650', 'Content Width', 'MODULE_CONTENT_CATEGORY_CATEGORIES_DESCRIPTION_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', '6', '2', NULL, '2017-01-26 12:36:58', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('651', 'Sort Order', 'MODULE_CONTENT_CATEGORY_CATEGORIES_DESCRIPTION_SORT_ORDER', '30', 'Sort order of display. Lowest is displayed first.', '6', '3', NULL, '2017-01-26 12:36:58', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('652', 'Module Version', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_VERSION', '1.1', 'The version of this module that you are running', '6', '0', NULL, '2017-01-26 12:37:15', NULL, 'tep_cfg_disabled(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('653', 'Enable Category Sub-categories Listing Module', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_STATUS', 'True', 'Should the category sub-categories listing be shown in the category?', '6', '1', NULL, '2017-01-26 12:37:15', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('654', 'Content Width', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', '6', '2', NULL, '2017-01-26 12:37:15', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('655', 'Category Width', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_CONTENT_WIDTH_EACH', '4', 'What width container should each Category be shown in?', '6', '3', NULL, '2017-01-26 12:37:15', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('656', 'Sort Order', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_SORT_ORDER', '50', 'Sort order of display. Lowest is displayed first.', '6', '4', NULL, '2017-01-26 12:37:15', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('659', 'Product Image Width', 'LARGE_IMAGE_WIDTH', '800', 'The pixel width for product images on the product info page', '4', '101', '2017-02-08 06:01:23', '2017-01-30 13:47:57', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('660', 'Product Image Height', 'LARGE_IMAGE_HEIGHT', '600', 'The pixel height for product images on the product info page', '4', '102', '2017-02-08 06:01:33', '2017-01-30 13:47:57', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('661', 'Maximum Image Width', 'MAX_ORIGINAL_IMAGE_WIDTH', '1200', 'The maximum pixel width allowed for original images', '4', '103', '2017-02-08 05:58:55', '2017-01-30 13:47:57', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('662', 'Maximum Image Height', 'MAX_ORIGINAL_IMAGE_HEIGHT', '1000', 'The maximum pixel height allowed for original images', '4', '104', '2017-02-08 05:59:05', '2017-01-30 13:47:57', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('663', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_START_MERCHANT_ID', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-02-01 14:28:46', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('664', 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_START_SECRET', '', 'A parameter for the PayPal Application.', '6', '0', NULL, '2017-02-01 14:28:46', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('665', 'Enable Specials Module', 'MODULE_BOXES_SPECIALS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', NULL, '2017-02-02 05:51:32', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('666', 'Content Placement', 'MODULE_BOXES_SPECIALS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', NULL, '2017-02-02 05:51:32', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('667', 'Sort Order', 'MODULE_BOXES_SPECIALS_SORT_ORDER', '1020', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-02-02 05:51:32', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('668', 'Enable Manufacturer Info Module', 'MODULE_BOXES_MANUFACTURER_INFO_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', NULL, '2017-02-02 05:59:16', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('669', 'Content Placement', 'MODULE_BOXES_MANUFACTURER_INFO_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', NULL, '2017-02-02 05:59:16', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('670', 'Sort Order', 'MODULE_BOXES_MANUFACTURER_INFO_SORT_ORDER', '1040', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-02-02 05:59:16', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('672', 'Display Overlay Images Sales', 'DISPLAY_OVERLAY_IMAGES_SALES', 'true', 'Display Overlay Images Sales (true) or Don\'t display Overlay Images Sales (false)', '1', '21', '2017-02-10 16:17:26', '2017-02-02 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('673', 'Enable Product Social Bookmarks Module', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', NULL, '2017-02-10 16:24:21', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('674', 'Content Placement', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', NULL, '2017-02-10 16:24:21', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('675', 'Sort Order', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_SORT_ORDER', '1030', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-02-10 16:24:21', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('676', 'Enable Currencies Module', 'MODULE_NAVBAR_CURRENCIES_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', NULL, '2017-02-10 16:26:39', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('677', 'Content Placement', 'MODULE_NAVBAR_CURRENCIES_CONTENT_PLACEMENT', 'Right', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', '6', '1', NULL, '2017-02-10 16:26:39', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('678', 'Sort Order', 'MODULE_NAVBAR_CURRENCIES_SORT_ORDER', '538', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-02-10 16:26:39', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('679', 'Installed Modules', 'MODULE_PDF_DATASHEET_INSTALLED', 'pd_initialize.php;pd_header.php;pd_fonts.php;pd_title.php;pd_description.php;pd_file_name.php', 'This is automatically updated. No need to edit.', '6', '0', '2017-02-11 14:24:14', '2017-02-11 10:46:17', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('680', 'Enable the Module', 'MODULE_PDF_DATASHEET_INITIALIZE_STATUS', 'True', 'Do you want to add the product link to the Google feed? (Note: Required field.)', '6', '1', NULL, '2017-02-11 11:03:01', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('681', 'Sort Order', 'MODULE_PDF_DATASHEET_INITIALIZE_SORT_ORDER', '9000', 'Sort order of display. Lowest is displayed first.', '6', '2', NULL, '2017-02-11 11:03:01', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('682', 'PDF Creator', 'MODULE_PDF_DATASHEET_INITIALIZE_PDF_CREATOR', 'WDW-PV7.0', 'Enter the name of the Creator (Leave blank for Config value).', '6', '6', NULL, '2017-02-11 11:03:01', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('683', 'Author', 'MODULE_PDF_DATASHEET_INITIALIZE_AUTHOR', '', 'Enter the name of the Author (Leave blank for Store Owner).', '6', '7', NULL, '2017-02-11 11:03:01', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('684', 'English Title', 'MODULE_PDF_DATASHEET_INITIALIZE_TITLE_ENGLISH', '', 'Enter the title that you want for your PDF in english', '6', '12', NULL, '2017-02-11 11:03:01', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('685', 'English Subject', 'MODULE_PDF_DATASHEET_INITIALIZE_SUBJECT_ENGLISH', '', 'Enter the subject that you want for your PDF in english', '6', '13', NULL, '2017-02-11 11:03:01', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('686', 'English Keywords', 'MODULE_PDF_DATASHEET_INITIALIZE_KEYWORDS_ENGLISH', '', 'Enter the keywords that you want for your PDF in english', '6', '14', NULL, '2017-02-11 11:03:01', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('687', 'Enable the Module', 'MODULE_PDF_DATASHEET_FONTS_STATUS', 'True', 'Set the default fonts and margins for the PDF datasheet? (Note: Required settings.)', '6', '1', NULL, '2017-02-11 11:03:07', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('688', 'Sort Order', 'MODULE_PDF_DATASHEET_FONTS_SORT_ORDER', '9002', 'Sort order of display. Lowest is displayed first.', '6', '2', NULL, '2017-02-11 11:03:07', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('689', 'Header Font', 'MODULE_PDF_DATASHEET_FONTS_HEADER_FONT_NAME', 'helvetica', 'Select the font used in the header.', '6', '3', NULL, '2017-02-11 11:03:07', NULL, 'tep_cfg_pull_down_fonts(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('690', 'Header Font Size', 'MODULE_PDF_DATASHEET_FONTS_HEADER_FONT_SIZE', '10', 'Select the font size used in the header.', '6', '4', NULL, '2017-02-11 11:03:07', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('691', 'Footer Font', 'MODULE_PDF_DATASHEET_FONTS_FOOTER_FONT_NAME', 'helvetica', 'Select the font used in the footer.', '6', '5', NULL, '2017-02-11 11:03:07', NULL, 'tep_cfg_pull_down_fonts(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('692', 'Footer Font Size', 'MODULE_PDF_DATASHEET_FONTS_FOOTER_FONT_SIZE', '10', 'Select the font size used in the footer.', '6', '6', NULL, '2017-02-11 11:03:07', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('693', 'Proportional Font', 'MODULE_PDF_DATASHEET_FONTS_FONT_NAME', 'dejavusans', 'Select the default proportionally spaced font.', '6', '7', NULL, '2017-02-11 11:03:07', NULL, 'tep_cfg_pull_down_fonts(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('694', 'Proportional Font Size', 'MODULE_PDF_DATASHEET_FONTS_FONT_SIZE', '10', 'Select the default proportionally spaced font size.', '6', '8', NULL, '2017-02-11 11:03:07', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('695', 'Monospace Font', 'MODULE_PDF_DATASHEET_FONTS_MONOSPACE_FONT_NAME', 'courier', 'Select the default monospaced font.', '6', '9', NULL, '2017-02-11 11:03:07', NULL, 'tep_cfg_pull_down_fonts(');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('696', 'Top Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_TOP', '27', 'Set the top margin in mm.', '6', '10', NULL, '2017-02-11 11:03:07', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('697', 'Bottom Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_BOTTOM', '25', 'Set the bottom margin in mm.', '6', '11', NULL, '2017-02-11 11:03:07', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('698', 'Left Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_LEFT', '15', 'Set the left margin in mm.', '6', '12', NULL, '2017-02-11 11:03:07', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('699', 'Right Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_RIGHT', '15', 'Set the right margin in mm.', '6', '13', NULL, '2017-02-11 11:03:07', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('700', 'Header Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_HEADER', '5', 'Set the header margin in mm.', '6', '14', NULL, '2017-02-11 11:03:07', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('701', 'Footer Margin', 'MODULE_PDF_DATASHEET_FONTS_MARGIN_FOOTER', '10', 'Set the footer margin in mm.', '6', '15', NULL, '2017-02-11 11:03:07', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('702', 'Image Ratio', 'MODULE_PDF_DATASHEET_FONTS_IMAGE_RATIO', '1.25', 'Set the image scale ratio.', '6', '16', NULL, '2017-02-11 11:03:07', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('703', 'Font Subsetting', 'MODULE_PDF_DATASHEET_FONTS_SUBSETTING', 'True', 'Allow font subsetting? (Reduces file size.)', '6', '17', NULL, '2017-02-11 11:03:07', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('704', 'Enable the Module', 'MODULE_PDF_DATASHEET_HEADER_STATUS', 'True', 'Do you want to add the product link to the Google feed? (Note: Required field.)', '6', '1', NULL, '2017-02-11 11:03:18', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('705', 'Sort Order', 'MODULE_PDF_DATASHEET_HEADER_SORT_ORDER', '9001', 'Sort order of display. Lowest is displayed first.', '6', '2', NULL, '2017-02-11 11:03:18', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('706', 'Image Name', 'MODULE_PDF_DATASHEET_HEADER_IMAGE_NAME', '', 'If yor header image is not the standard header image, put your iamge name here.', '6', '3', NULL, '2017-02-11 11:03:18', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('707', 'Image Multiplier', 'MODULE_PDF_DATASHEET_HEADER_IMAGE_MULTIPLIER', '1.0', 'Multiply the image size by this number.', '6', '3', NULL, '2017-02-11 11:03:18', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('708', 'Show Store Owner', 'MODULE_PDF_DATASHEET_HEADER_STORE_OWNER', 'False', 'Show the Store Owner in the header?', '6', '4', NULL, '2017-02-11 11:03:18', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('709', 'Show Store Address', 'MODULE_PDF_DATASHEET_HEADER_STORE_NAME_ADDRESS', 'True', 'Show the Store Address in the header?', '6', '5', NULL, '2017-02-11 11:03:18', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('710', 'English Additional Text', 'MODULE_PDF_DATASHEET_HEADER_TEXT_ENGLISH', '', 'Enter the additional text that you want in your header in english', '6', '14', NULL, '2017-02-11 11:03:18', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('711', 'Enable the Module', 'MODULE_PDF_DATASHEET_TITLE_STATUS', 'True', 'Do you want to add the product link to the Google feed? (Note: Required field.)', '6', '1', NULL, '2017-02-11 11:03:24', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('712', 'Sort Order', 'MODULE_PDF_DATASHEET_TITLE_SORT_ORDER', '9010', 'Sort order of display. Lowest is displayed first.', '6', '2', NULL, '2017-02-11 11:03:24', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('713', 'Show Model', 'MODULE_PDF_DATASHEET_TITLE_MODEL', 'True', 'Add the model number below the title.', '6', '3', NULL, '2017-02-11 11:03:24', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('714', 'Show Price', 'MODULE_PDF_DATASHEET_TITLE_PRICE', 'True', 'Add the price to the right of the product name.', '6', '4', NULL, '2017-02-11 11:03:24', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('715', 'Enable the Module', 'MODULE_PDF_DATASHEET_DESCRIPTION_STATUS', 'True', 'Do you want to add the product description/image to the PDF datasheet?', '6', '1', NULL, '2017-02-11 11:03:35', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('716', 'Sort Order', 'MODULE_PDF_DATASHEET_DESCRIPTION_SORT_ORDER', '9050', 'Sort order of display. Lowest is displayed first.', '6', '2', NULL, '2017-02-11 11:03:35', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('717', 'Show Image', 'MODULE_PDF_DATASHEET_DESCRIPTION_SHOW_IMAGE', 'True', 'Show the image next to the description.', '6', '3', NULL, '2017-02-11 11:03:35', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('718', 'Image Width', 'MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_WIDTH', '320', 'Width of the image im pixels.', '6', '4', NULL, '2017-02-11 11:03:35', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('719', 'Image Location', 'MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_LOCATION', 'left', 'Locate the image on the left or right side of the page.', '6', '5', NULL, '2017-02-11 11:03:35', NULL, 'tep_cfg_select_option(array(\'left\', \'right\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('720', 'Image Padding', 'MODULE_PDF_DATASHEET_DESCRIPTION_IMAGE_PADDING', '2', 'White space around the image in user units.', '6', '6', NULL, '2017-02-11 11:03:35', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('721', 'Top Padding', 'MODULE_PDF_DATASHEET_DESCRIPTION_PADDING', '2', 'Add space above the text/image in user units.', '6', '7', NULL, '2017-02-11 11:03:35', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('726', 'Enable the Module', 'MODULE_PDF_DATASHEET_FILE_NAME_STATUS', 'True', 'Do you want to add the product link to the Google feed? (Note: Required field.)', '6', '1', NULL, '2017-02-11 13:55:38', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('727', 'Sort Order', 'MODULE_PDF_DATASHEET_FILE_NAME_SORT_ORDER', '9999', 'Sort order of display. Lowest is displayed first.', '6', '2', NULL, '2017-02-11 13:55:38', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('728', 'Add Store Name', 'MODULE_PDF_DATASHEET_FILE_NAME_STORE_NAME', 'True', 'Add the store name to the file name.', '6', '3', NULL, '2017-02-11 13:55:38', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('729', 'English Text', 'MODULE_PDF_DATASHEET_FILE_NAME_TEXT_ENGLISH', '', 'Add text in english to the PDF file name', '6', '14', NULL, '2017-02-11 13:55:38', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('730', 'Enable SEO URLs 5?', 'USU5_ENABLED', 'true', 'Turn Seo Urls 5 on', '17', '1', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('731', 'Enable the cache?', 'USU5_CACHE_ON', 'true', 'Turn the cache system on', '17', '2', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('732', 'Enable multi language support?', 'USU5_MULTI_LANGUAGE_SEO_SUPPORT', 'true', 'Enable the multi language functionality', '17', '3', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('733', 'Output W3C valid URLs?', 'USU5_USE_W3C_VALID', 'true', 'This setting will output W3C valid URLs.', '17', '4', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('734', 'Select your chosen cache system?', 'USU5_CACHE_SYSTEM', 'mysql', 'Choose from the 4 available caching strategies.', '17', '5', '2017-02-12 09:47:41', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'mysql\', \'file\',\'sqlite - supported\',\'memcache - NOT supported on this system\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('735', 'Set the number of days to store the cache.', 'USU5_CACHE_DAYS', '7', 'Set the number of days you wish to retain cached data, after this the cache will auto reset.', '17', '6', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('736', 'Choose the uri format', 'USU5_URLS_TYPE', 'rewrite', '<b>Choose USU5 URL format:</b>', '17', '7', '2017-02-12 09:47:30', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'standard\',\'path_standard\',\'rewrite\',\'path_rewrite\',), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('737', 'Choose how your product link text is made up', 'USU5_PRODUCTS_LINK_TEXT_ORDER', 'p', 'Product link text can be made up of:<br /><b>p</b> = product name<br /><b>c</b> = category name<br /><b>b</b> = manufacturer (brand)<br /><b>m</b> = model<br />e.g. <b>bp</b> (brand/product)', '17', '8', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('738', 'Filter Short Words', 'USU5_FILTER_SHORT_WORDS', '2', '<b>This setting will filter words.</b><br>1 = Remove words of 1 letter<br>2 = Remove words of 2 letters or less<br>3 = Remove words of 3 letters or less<br>', '17', '9', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'1\',\'2\',\'3\',), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('739', 'Add category parent to beginning of category uris?', 'USU5_ADD_CAT_PARENT', 'true', 'This setting will add the category parent name to the beginning of the category URLs (i.e. - parent-category-c-1.html).', '17', '10', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('740', 'Remove all non-alphanumeric characters?', 'USU5_REMOVE_ALL_SPEC_CHARS', 'true', 'This will remove all non-letters and non-numbers. If your language has special characters then you will need to use the character conversion system.', '17', '11', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('741', 'Add cPath to product URLs?', 'USU5_ADD_CPATH_TO_PRODUCT_URLS', 'false', 'This setting will append the cPath to the end of product URLs (i.e. - some-product-p-1.html?cPath=xx).', '17', '12', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('742', 'Enter special character conversions. <b>(Better to use the file based character conversions)</b>', 'USU5_CHAR_CONVERT_SET', '', 'This setting will convert characters.<br><br>The format <b>MUST</b> be in the form: <b>char=>conv,char2=>conv2</b>', '17', '13', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('743', 'Turn performance reporting on true/false.', 'USU5_OUPUT_PERFORMANCE', 'false', '<span style=\"color: red;\">Performance reporting should not be set to ON on a live site</span><br>It is for reporting re: performance and queries and shows at the bottom of your site.', '17', '14', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('744', 'Turn variable reporting on true/false.', 'USU5_DEBUG_OUPUT_VARS', 'false', '<span style=\"color: red;\">Variable reporting should not be set to ON on a live site</span><br>It is for reporting the contents of USU classes and shows unformatted at the bottom of your site.', '17', '15', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('745', 'Force www.mysite.com/ when www.mysite.com/index.php', 'USU5_HOME_PAGE_REDIRECT', 'false', 'Force a redirect to www.mysite.com/ when www.mysite.com/index.php', '17', '16', '2017-02-12 15:45:20', '2017-02-12 15:45:20', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('746', 'Reset USU5 Cache', 'USU5_RESET_CACHE', 'false', 'This will reset the cache data for USU5', '17', '17', '2017-02-12 15:45:20', '2017-02-12 15:45:20', 'tep_reset_cache_data_usu5', 'tep_cfg_select_option(array(\'reset\', \'false\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('747', 'Enable Product OpenGraph Module', 'MODULE_HEADER_TAGS_PRODUCT_OPENGRAPH_STATUS', 'True', 'Do you want to allow Open Graph Meta Tags (good for Facebook and Pinterest and other sites) to be added to your product page?  Note that your product thumbnails MUST be at least 200px by 200px.', '6', '1', NULL, '2017-02-12 09:48:21', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('748', 'Sort Order', 'MODULE_HEADER_TAGS_PRODUCT_OPENGRAPH_SORT_ORDER', '900', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-02-12 09:48:21', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('749', 'Enable Category Meta Module', 'MODULE_HEADER_TAGS_CATEGORY_SEO_STATUS', 'True', 'Do you want to allow Category Meta Tags to be added to the page header?', '6', '1', NULL, '2017-02-12 09:48:27', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('750', 'Display Category Meta Description', 'MODULE_HEADER_TAGS_CATEGORY_SEO_DESCRIPTION_STATUS', 'True', 'These help your site and your sites visitors.', '6', '0', NULL, '2017-02-12 09:48:27', NULL, 'tep_cfg_select_option(array(\'True\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('751', 'Display Category Meta Keywords', 'MODULE_HEADER_TAGS_CATEGORY_SEO_KEYWORDS_STATUS', 'False', 'These are almost pointless.  If you are into the Chinese Market select True (for Baidu Search Engine) otherwise select False.', '6', '0', NULL, '2017-02-12 09:48:27', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('752', 'Sort Order', 'MODULE_HEADER_TAGS_CATEGORY_SEO_SORT_ORDER', '120', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-02-12 09:48:27', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('753', 'Enable Manufacturer Meta Module', 'MODULE_HEADER_TAGS_MANUFACTURERS_SEO_STATUS', 'True', 'Do you want to allow Manufacturer meta tags to be added to the page header?', '6', '1', NULL, '2017-02-12 09:48:46', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('754', 'Display Manufacturer Meta Description', 'MODULE_HEADER_TAGS_MANUFACTURERS_SEO_DESCRIPTION_STATUS', 'True', 'Manufacturer Descriptions help your site and your sites visitors.', '6', '1', NULL, '2017-02-12 09:48:46', NULL, 'tep_cfg_select_option(array(\'True\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('755', 'Display Manufacturer Meta Keywords', 'MODULE_HEADER_TAGS_MANUFACTURERS_SEO_KEYWORDS_STATUS', 'False', 'Manufacturer Keywords are almost pointless.  If you are into the Chinese Market select True (for Baidu Search Engine) otherwise select False.', '6', '1', NULL, '2017-02-12 09:48:46', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('756', 'Sort Order', 'MODULE_HEADER_TAGS_MANUFACTURERS_SEO_SORT_ORDER', '110', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-02-12 09:48:46', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('757', 'Enable Product Meta Module', 'MODULE_HEADER_TAGS_PRODUCT_META_STATUS', 'True', 'Do you want to allow product meta tags to be added to the page header?', '6', '1', NULL, '2017-02-12 09:48:58', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('758', 'Enable Product Meta Module - Keywords', 'MODULE_HEADER_TAGS_PRODUCT_META_KEYWORDS_STATUS', 'Search', 'Keywords can be used for META, for SEARCH, or for BOTH.  If you are into the Chinese Market select Both (for Baidu Search Engine) otherwise select Search.', '6', '1', NULL, '2017-02-12 09:48:58', NULL, 'tep_cfg_select_option(array(\'Meta\', \'Search\', \'Both\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('759', 'Sort Order', 'MODULE_HEADER_TAGS_PRODUCT_META_SORT_ORDER', '130', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-02-12 09:48:58', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('760', 'Sort Order', 'MODULE_BOXES_CATEGORIES_SUPERFISH_SORT_ORDER', '1002', 'Sort order of display. Lowest is displayed first.', '6', '0', NULL, '2017-02-12 10:23:02', NULL, NULL);
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('761', 'Enable Superfish Categories Box', 'MODULE_BOXES_CATEGORIES_SUPERFISH_STATUS', 'True', 'Do you want to show the Superfish Categories box?', '6', '1', NULL, '2017-02-12 10:23:02', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('762', 'Content Placement', 'MODULE_BOXES_CATEGORIES_SUPERFISH_CONTENT_PLACEMENT', 'Left Column', 'Where should the module be loaded?', '6', '2', NULL, '2017-02-12 10:23:02', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ');
insert into configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) values ('763', 'English Title', 'MODULE_BOXES_CATEGORIES_SUPERFISH_FRONT_TITLE_ENGLISH', '', 'Enter the title that you want in the header in english. Leave this blank for no header or title.', '6', '10', NULL, '2017-02-12 10:23:02', NULL, NULL);
drop table if exists configuration_group;
create table configuration_group (
  configuration_group_id int(11) not null auto_increment,
  configuration_group_title varchar(64) not null ,
  configuration_group_description varchar(255) not null ,
  sort_order int(5) ,
  visible int(1) default '1' ,
  PRIMARY KEY (configuration_group_id)
);

insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('1', 'My Store', 'General information about my store', '1', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('2', 'Minimum Values', 'The minimum values for functions / data', '2', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('3', 'Maximum Values', 'The maximum values for functions / data', '3', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('4', 'Images', 'Image parameters', '4', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('5', 'Customer Details', 'Customer account configuration', '5', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('6', 'Module Options', 'Hidden from configuration', '6', '0');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('7', 'Shipping/Packaging', 'Shipping options available at my store', '7', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('8', 'Product Listing', 'Product Listing    configuration options', '8', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('9', 'Stock', 'Stock configuration options', '9', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('10', 'Logging', 'Logging configuration options', '10', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('11', 'Cache', 'Caching configuration options', '11', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('12', 'E-Mail Options', 'General setting for E-Mail transport and HTML E-Mails', '12', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('13', 'Download', 'Downloadable products options', '13', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('14', 'GZip Compression', 'GZip compression options', '14', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('15', 'Sessions', 'Session options', '15', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('16', 'Bootstrap Setup', 'Basic Bootstrap Options', '16', '1');
insert into configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) values ('17', 'Seo Urls 5', 'Options for ULTIMATE Seo Urls 5 by FWR Media', '17', '1');
drop table if exists countries;
create table countries (
  countries_id int(11) not null auto_increment,
  countries_name varchar(255) not null ,
  countries_iso_code_2 char(2) not null ,
  countries_iso_code_3 char(3) not null ,
  address_format_id int(11) not null ,
  PRIMARY KEY (countries_id),
  KEY IDX_COUNTRIES_NAME (countries_name)
);

insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('1', 'Afghanistan', 'AF', 'AFG', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('2', 'Albania', 'AL', 'ALB', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('3', 'Algeria', 'DZ', 'DZA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('4', 'American Samoa', 'AS', 'ASM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('5', 'Andorra', 'AD', 'AND', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('6', 'Angola', 'AO', 'AGO', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('7', 'Anguilla', 'AI', 'AIA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('8', 'Antarctica', 'AQ', 'ATA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('9', 'Antigua and Barbuda', 'AG', 'ATG', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('10', 'Argentina', 'AR', 'ARG', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('11', 'Armenia', 'AM', 'ARM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('12', 'Aruba', 'AW', 'ABW', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('13', 'Australia', 'AU', 'AUS', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('14', 'Austria', 'AT', 'AUT', '5');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('15', 'Azerbaijan', 'AZ', 'AZE', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('16', 'Bahamas', 'BS', 'BHS', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('17', 'Bahrain', 'BH', 'BHR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('18', 'Bangladesh', 'BD', 'BGD', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('19', 'Barbados', 'BB', 'BRB', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('20', 'Belarus', 'BY', 'BLR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('21', 'Belgium', 'BE', 'BEL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('22', 'Belize', 'BZ', 'BLZ', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('23', 'Benin', 'BJ', 'BEN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('24', 'Bermuda', 'BM', 'BMU', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('25', 'Bhutan', 'BT', 'BTN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('26', 'Bolivia', 'BO', 'BOL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('27', 'Bosnia and Herzegowina', 'BA', 'BIH', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('28', 'Botswana', 'BW', 'BWA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('29', 'Bouvet Island', 'BV', 'BVT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('30', 'Brazil', 'BR', 'BRA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('31', 'British Indian Ocean Territory', 'IO', 'IOT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('32', 'Brunei Darussalam', 'BN', 'BRN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('33', 'Bulgaria', 'BG', 'BGR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('34', 'Burkina Faso', 'BF', 'BFA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('35', 'Burundi', 'BI', 'BDI', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('36', 'Cambodia', 'KH', 'KHM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('37', 'Cameroon', 'CM', 'CMR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('38', 'Canada', 'CA', 'CAN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('39', 'Cape Verde', 'CV', 'CPV', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('40', 'Cayman Islands', 'KY', 'CYM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('41', 'Central African Republic', 'CF', 'CAF', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('42', 'Chad', 'TD', 'TCD', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('43', 'Chile', 'CL', 'CHL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('44', 'China', 'CN', 'CHN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('45', 'Christmas Island', 'CX', 'CXR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('46', 'Cocos (Keeling) Islands', 'CC', 'CCK', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('47', 'Colombia', 'CO', 'COL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('48', 'Comoros', 'KM', 'COM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('49', 'Congo', 'CG', 'COG', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('50', 'Cook Islands', 'CK', 'COK', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('51', 'Costa Rica', 'CR', 'CRI', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('52', 'Cote D\'Ivoire', 'CI', 'CIV', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('53', 'Croatia', 'HR', 'HRV', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('54', 'Cuba', 'CU', 'CUB', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('55', 'Cyprus', 'CY', 'CYP', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('56', 'Czech Republic', 'CZ', 'CZE', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('57', 'Denmark', 'DK', 'DNK', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('58', 'Djibouti', 'DJ', 'DJI', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('59', 'Dominica', 'DM', 'DMA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('60', 'Dominican Republic', 'DO', 'DOM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('61', 'East Timor', 'TP', 'TMP', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('62', 'Ecuador', 'EC', 'ECU', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('63', 'Egypt', 'EG', 'EGY', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('64', 'El Salvador', 'SV', 'SLV', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('65', 'Equatorial Guinea', 'GQ', 'GNQ', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('66', 'Eritrea', 'ER', 'ERI', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('67', 'Estonia', 'EE', 'EST', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('68', 'Ethiopia', 'ET', 'ETH', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('69', 'Falkland Islands (Malvinas)', 'FK', 'FLK', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('70', 'Faroe Islands', 'FO', 'FRO', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('71', 'Fiji', 'FJ', 'FJI', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('72', 'Finland', 'FI', 'FIN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('73', 'France', 'FR', 'FRA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('74', 'France, Metropolitan', 'FX', 'FXX', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('75', 'French Guiana', 'GF', 'GUF', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('76', 'French Polynesia', 'PF', 'PYF', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('77', 'French Southern Territories', 'TF', 'ATF', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('78', 'Gabon', 'GA', 'GAB', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('79', 'Gambia', 'GM', 'GMB', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('80', 'Georgia', 'GE', 'GEO', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('81', 'Germany', 'DE', 'DEU', '5');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('82', 'Ghana', 'GH', 'GHA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('83', 'Gibraltar', 'GI', 'GIB', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('84', 'Greece', 'GR', 'GRC', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('85', 'Greenland', 'GL', 'GRL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('86', 'Grenada', 'GD', 'GRD', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('87', 'Guadeloupe', 'GP', 'GLP', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('88', 'Guam', 'GU', 'GUM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('89', 'Guatemala', 'GT', 'GTM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('90', 'Guinea', 'GN', 'GIN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('91', 'Guinea-bissau', 'GW', 'GNB', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('92', 'Guyana', 'GY', 'GUY', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('93', 'Haiti', 'HT', 'HTI', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('94', 'Heard and Mc Donald Islands', 'HM', 'HMD', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('95', 'Honduras', 'HN', 'HND', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('96', 'Hong Kong', 'HK', 'HKG', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('97', 'Hungary', 'HU', 'HUN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('98', 'Iceland', 'IS', 'ISL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('99', 'India', 'IN', 'IND', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('100', 'Indonesia', 'ID', 'IDN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('101', 'Iran (Islamic Republic of)', 'IR', 'IRN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('102', 'Iraq', 'IQ', 'IRQ', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('103', 'Ireland', 'IE', 'IRL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('104', 'Israel', 'IL', 'ISR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('105', 'Italy', 'IT', 'ITA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('106', 'Jamaica', 'JM', 'JAM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('107', 'Japan', 'JP', 'JPN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('108', 'Jordan', 'JO', 'JOR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('109', 'Kazakhstan', 'KZ', 'KAZ', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('110', 'Kenya', 'KE', 'KEN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('111', 'Kiribati', 'KI', 'KIR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('112', 'Korea, Democratic People\'s Republic of', 'KP', 'PRK', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('113', 'Korea, Republic of', 'KR', 'KOR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('114', 'Kuwait', 'KW', 'KWT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('115', 'Kyrgyzstan', 'KG', 'KGZ', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('116', 'Lao People\'s Democratic Republic', 'LA', 'LAO', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('117', 'Latvia', 'LV', 'LVA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('118', 'Lebanon', 'LB', 'LBN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('119', 'Lesotho', 'LS', 'LSO', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('120', 'Liberia', 'LR', 'LBR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('121', 'Libyan Arab Jamahiriya', 'LY', 'LBY', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('122', 'Liechtenstein', 'LI', 'LIE', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('123', 'Lithuania', 'LT', 'LTU', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('124', 'Luxembourg', 'LU', 'LUX', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('125', 'Macau', 'MO', 'MAC', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('126', 'Macedonia, The Former Yugoslav Republic of', 'MK', 'MKD', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('127', 'Madagascar', 'MG', 'MDG', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('128', 'Malawi', 'MW', 'MWI', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('129', 'Malaysia', 'MY', 'MYS', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('130', 'Maldives', 'MV', 'MDV', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('131', 'Mali', 'ML', 'MLI', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('132', 'Malta', 'MT', 'MLT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('133', 'Marshall Islands', 'MH', 'MHL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('134', 'Martinique', 'MQ', 'MTQ', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('135', 'Mauritania', 'MR', 'MRT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('136', 'Mauritius', 'MU', 'MUS', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('137', 'Mayotte', 'YT', 'MYT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('138', 'Mexico', 'MX', 'MEX', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('139', 'Micronesia, Federated States of', 'FM', 'FSM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('140', 'Moldova, Republic of', 'MD', 'MDA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('141', 'Monaco', 'MC', 'MCO', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('142', 'Mongolia', 'MN', 'MNG', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('143', 'Montserrat', 'MS', 'MSR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('144', 'Morocco', 'MA', 'MAR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('145', 'Mozambique', 'MZ', 'MOZ', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('146', 'Myanmar', 'MM', 'MMR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('147', 'Namibia', 'NA', 'NAM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('148', 'Nauru', 'NR', 'NRU', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('149', 'Nepal', 'NP', 'NPL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('150', 'Netherlands', 'NL', 'NLD', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('151', 'Netherlands Antilles', 'AN', 'ANT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('152', 'New Caledonia', 'NC', 'NCL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('153', 'New Zealand', 'NZ', 'NZL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('154', 'Nicaragua', 'NI', 'NIC', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('155', 'Niger', 'NE', 'NER', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('156', 'Nigeria', 'NG', 'NGA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('157', 'Niue', 'NU', 'NIU', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('158', 'Norfolk Island', 'NF', 'NFK', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('159', 'Northern Mariana Islands', 'MP', 'MNP', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('160', 'Norway', 'NO', 'NOR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('161', 'Oman', 'OM', 'OMN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('162', 'Pakistan', 'PK', 'PAK', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('163', 'Palau', 'PW', 'PLW', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('164', 'Panama', 'PA', 'PAN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('165', 'Papua New Guinea', 'PG', 'PNG', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('166', 'Paraguay', 'PY', 'PRY', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('167', 'Peru', 'PE', 'PER', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('168', 'Philippines', 'PH', 'PHL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('169', 'Pitcairn', 'PN', 'PCN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('170', 'Poland', 'PL', 'POL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('171', 'Portugal', 'PT', 'PRT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('172', 'Puerto Rico', 'PR', 'PRI', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('173', 'Qatar', 'QA', 'QAT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('174', 'Reunion', 'RE', 'REU', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('175', 'Romania', 'RO', 'ROM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('176', 'Russian Federation', 'RU', 'RUS', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('177', 'Rwanda', 'RW', 'RWA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('178', 'Saint Kitts and Nevis', 'KN', 'KNA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('179', 'Saint Lucia', 'LC', 'LCA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('180', 'Saint Vincent and the Grenadines', 'VC', 'VCT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('181', 'Samoa', 'WS', 'WSM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('182', 'San Marino', 'SM', 'SMR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('183', 'Sao Tome and Principe', 'ST', 'STP', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('184', 'Saudi Arabia', 'SA', 'SAU', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('185', 'Senegal', 'SN', 'SEN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('186', 'Seychelles', 'SC', 'SYC', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('187', 'Sierra Leone', 'SL', 'SLE', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('188', 'Singapore', 'SG', 'SGP', '4');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('189', 'Slovakia (Slovak Republic)', 'SK', 'SVK', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('190', 'Slovenia', 'SI', 'SVN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('191', 'Solomon Islands', 'SB', 'SLB', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('192', 'Somalia', 'SO', 'SOM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('193', 'South Africa', 'ZA', 'ZAF', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('194', 'South Georgia and the South Sandwich Islands', 'GS', 'SGS', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('195', 'Spain', 'ES', 'ESP', '3');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('196', 'Sri Lanka', 'LK', 'LKA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('197', 'St. Helena', 'SH', 'SHN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('198', 'St. Pierre and Miquelon', 'PM', 'SPM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('199', 'Sudan', 'SD', 'SDN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('200', 'Suriname', 'SR', 'SUR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('201', 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('202', 'Swaziland', 'SZ', 'SWZ', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('203', 'Sweden', 'SE', 'SWE', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('204', 'Switzerland', 'CH', 'CHE', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('205', 'Syrian Arab Republic', 'SY', 'SYR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('206', 'Taiwan', 'TW', 'TWN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('207', 'Tajikistan', 'TJ', 'TJK', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('208', 'Tanzania, United Republic of', 'TZ', 'TZA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('209', 'Thailand', 'TH', 'THA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('210', 'Togo', 'TG', 'TGO', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('211', 'Tokelau', 'TK', 'TKL', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('212', 'Tonga', 'TO', 'TON', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('213', 'Trinidad and Tobago', 'TT', 'TTO', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('214', 'Tunisia', 'TN', 'TUN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('215', 'Turkey', 'TR', 'TUR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('216', 'Turkmenistan', 'TM', 'TKM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('217', 'Turks and Caicos Islands', 'TC', 'TCA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('218', 'Tuvalu', 'TV', 'TUV', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('219', 'Uganda', 'UG', 'UGA', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('220', 'Ukraine', 'UA', 'UKR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('221', 'United Arab Emirates', 'AE', 'ARE', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('222', 'United Kingdom', 'GB', 'GBR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('223', 'United States', 'US', 'USA', '2');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('224', 'United States Minor Outlying Islands', 'UM', 'UMI', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('225', 'Uruguay', 'UY', 'URY', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('226', 'Uzbekistan', 'UZ', 'UZB', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('227', 'Vanuatu', 'VU', 'VUT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('228', 'Vatican City State (Holy See)', 'VA', 'VAT', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('229', 'Venezuela', 'VE', 'VEN', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('230', 'Viet Nam', 'VN', 'VNM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('231', 'Virgin Islands (British)', 'VG', 'VGB', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('232', 'Virgin Islands (U.S.)', 'VI', 'VIR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('233', 'Wallis and Futuna Islands', 'WF', 'WLF', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('234', 'Western Sahara', 'EH', 'ESH', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('235', 'Yemen', 'YE', 'YEM', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('236', 'Yugoslavia', 'YU', 'YUG', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('237', 'Zaire', 'ZR', 'ZAR', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('238', 'Zambia', 'ZM', 'ZMB', '1');
insert into countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id) values ('239', 'Zimbabwe', 'ZW', 'ZWE', '1');
drop table if exists currencies;
create table currencies (
  currencies_id int(11) not null auto_increment,
  title varchar(32) not null ,
  code char(3) not null ,
  symbol_left varchar(12) ,
  symbol_right varchar(12) ,
  decimal_point char(1) ,
  thousands_point char(1) ,
  decimal_places char(1) ,
  value float(13,8) ,
  last_updated datetime ,
  PRIMARY KEY (currencies_id),
  KEY idx_currencies_code (code)
);

insert into currencies (currencies_id, title, code, symbol_left, symbol_right, decimal_point, thousands_point, decimal_places, value, last_updated) values ('1', 'U.S. Dollar', 'USD', '$', '', '.', ',', '2', '1.04999995', '2017-01-24 11:09:54');
insert into currencies (currencies_id, title, code, symbol_left, symbol_right, decimal_point, thousands_point, decimal_places, value, last_updated) values ('2', 'Euro', 'EUR', '€', '', '.', ',', '2', '1.00000000', '2017-01-24 11:09:54');
drop table if exists customers;
create table customers (
  customers_id int(11) not null auto_increment,
  customers_gender char(1) ,
  customers_firstname varchar(255) not null ,
  customers_lastname varchar(255) not null ,
  customers_dob datetime default '1970-01-01 00:00:01' not null ,
  customers_email_address varchar(255) not null ,
  customers_default_address_id int(11) ,
  customers_telephone varchar(255) not null ,
  customers_fax varchar(255) ,
  customers_password varchar(60) not null ,
  customers_newsletter char(1) ,
  PRIMARY KEY (customers_id),
  KEY idx_customers_email_address (customers_email_address)
);

drop table if exists customers_basket;
create table customers_basket (
  customers_basket_id int(11) not null auto_increment,
  customers_id int(11) not null ,
  products_id tinytext not null ,
  customers_basket_quantity int(2) not null ,
  final_price decimal(15,4) ,
  customers_basket_date_added char(8) ,
  PRIMARY KEY (customers_basket_id),
  KEY idx_customers_basket_customers_id (customers_id)
);

drop table if exists customers_basket_attributes;
create table customers_basket_attributes (
  customers_basket_attributes_id int(11) not null auto_increment,
  customers_id int(11) not null ,
  products_id tinytext not null ,
  products_options_id int(11) not null ,
  products_options_value_id int(11) not null ,
  PRIMARY KEY (customers_basket_attributes_id),
  KEY idx_customers_basket_att_customers_id (customers_id)
);

drop table if exists customers_info;
create table customers_info (
  customers_info_id int(11) not null ,
  customers_info_date_of_last_logon datetime ,
  customers_info_number_of_logons int(5) ,
  customers_info_date_account_created datetime ,
  customers_info_date_account_last_modified datetime ,
  global_product_notifications int(1) default '0' ,
  password_reset_key char(40) ,
  password_reset_date datetime ,
  PRIMARY KEY (customers_info_id)
);

drop table if exists geo_zones;
create table geo_zones (
  geo_zone_id int(11) not null auto_increment,
  geo_zone_name varchar(32) not null ,
  geo_zone_description varchar(255) not null ,
  last_modified datetime ,
  date_added datetime not null ,
  PRIMARY KEY (geo_zone_id)
);

insert into geo_zones (geo_zone_id, geo_zone_name, geo_zone_description, last_modified, date_added) values ('1', 'All', 'Florida local sales tax zone', '2017-01-26 07:05:34', '2017-01-24 11:09:54');
drop table if exists headertags;
create table headertags (
  page_name varchar(64) not null ,
  page_title varchar(120) not null ,
  page_description varchar(255) not null ,
  page_keywords varchar(255) not null ,
  page_logo varchar(255) not null ,
  page_logo_1 varchar(255) not null ,
  page_logo_2 varchar(255) not null ,
  page_logo_3 varchar(255) not null ,
  page_logo_4 varchar(255) not null ,
  append_default_title tinyint(1) default '0' not null ,
  append_default_description tinyint(1) default '0' not null ,
  append_default_keywords tinyint(1) default '0' not null ,
  append_default_logo tinyint(1) default '0' not null ,
  append_category tinyint(1) default '0' not null ,
  append_manufacturer tinyint(1) default '0' not null ,
  append_model tinyint(1) default '0' not null ,
  append_product tinyint(1) default '1' not null ,
  append_root tinyint(1) default '1' not null ,
  sortorder_title tinyint(2) default '0' not null ,
  sortorder_description tinyint(2) default '0' not null ,
  sortorder_keywords tinyint(2) default '0' not null ,
  sortorder_logo tinyint(2) default '0' not null ,
  sortorder_logo_1 tinyint(2) default '0' not null ,
  sortorder_logo_2 tinyint(2) default '0' not null ,
  sortorder_logo_3 tinyint(2) default '0' not null ,
  sortorder_logo_4 tinyint(2) default '0' not null ,
  sortorder_category tinyint(2) default '0' not null ,
  sortorder_manufacturer tinyint(2) default '0' not null ,
  sortorder_model tinyint(2) default '0' not null ,
  sortorder_product tinyint(2) default '10' not null ,
  sortorder_root tinyint(2) default '1' not null ,
  sortorder_root_1 tinyint(2) default '1' not null ,
  sortorder_root_2 tinyint(2) default '1' not null ,
  sortorder_root_3 tinyint(2) default '1' not null ,
  sortorder_root_4 tinyint(2) default '1' not null ,
  language_id int(11) default '1' not null ,
  KEY idx_page_name (page_name),
  KEY idx_page_description (page_description),
  KEY idx_page_keywords (page_keywords)
);

insert into headertags (page_name, page_title, page_description, page_keywords, page_logo, page_logo_1, page_logo_2, page_logo_3, page_logo_4, append_default_title, append_default_description, append_default_keywords, append_default_logo, append_category, append_manufacturer, append_model, append_product, append_root, sortorder_title, sortorder_description, sortorder_keywords, sortorder_logo, sortorder_logo_1, sortorder_logo_2, sortorder_logo_3, sortorder_logo_4, sortorder_category, sortorder_manufacturer, sortorder_model, sortorder_product, sortorder_root, sortorder_root_1, sortorder_root_2, sortorder_root_3, sortorder_root_4, language_id) values ('index.php', 'Replace me in Page Control under index.php - oscommerce-solution.com', 'Replace me in Page Control under index.php - oscommerce-solution.com', 'Replace me in Page Control under index.php - oscommerce-solution.com', 'Replace me in Page Control under index.php - oscommerce-solution.com', '', '', '', '', '0', '0', '0', '0', '1', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2', '0', '0', '10', '0', '1', '1', '1', '1', '1');
insert into headertags (page_name, page_title, page_description, page_keywords, page_logo, page_logo_1, page_logo_2, page_logo_3, page_logo_4, append_default_title, append_default_description, append_default_keywords, append_default_logo, append_category, append_manufacturer, append_model, append_product, append_root, sortorder_title, sortorder_description, sortorder_keywords, sortorder_logo, sortorder_logo_1, sortorder_logo_2, sortorder_logo_3, sortorder_logo_4, sortorder_category, sortorder_manufacturer, sortorder_model, sortorder_product, sortorder_root, sortorder_root_1, sortorder_root_2, sortorder_root_3, sortorder_root_4, language_id) values ('product_info.php', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '1', '1', '1', '1', '1', '1');
insert into headertags (page_name, page_title, page_description, page_keywords, page_logo, page_logo_1, page_logo_2, page_logo_3, page_logo_4, append_default_title, append_default_description, append_default_keywords, append_default_logo, append_category, append_manufacturer, append_model, append_product, append_root, sortorder_title, sortorder_description, sortorder_keywords, sortorder_logo, sortorder_logo_1, sortorder_logo_2, sortorder_logo_3, sortorder_logo_4, sortorder_category, sortorder_manufacturer, sortorder_model, sortorder_product, sortorder_root, sortorder_root_1, sortorder_root_2, sortorder_root_3, sortorder_root_4, language_id) values ('product_reviews.php', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '1', '1', '1', '1', '1', '1');
insert into headertags (page_name, page_title, page_description, page_keywords, page_logo, page_logo_1, page_logo_2, page_logo_3, page_logo_4, append_default_title, append_default_description, append_default_keywords, append_default_logo, append_category, append_manufacturer, append_model, append_product, append_root, sortorder_title, sortorder_description, sortorder_keywords, sortorder_logo, sortorder_logo_1, sortorder_logo_2, sortorder_logo_3, sortorder_logo_4, sortorder_category, sortorder_manufacturer, sortorder_model, sortorder_product, sortorder_root, sortorder_root_1, sortorder_root_2, sortorder_root_3, sortorder_root_4, language_id) values ('product_reviews_info.php', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '1', '1', '1', '1', '1', '1');
insert into headertags (page_name, page_title, page_description, page_keywords, page_logo, page_logo_1, page_logo_2, page_logo_3, page_logo_4, append_default_title, append_default_description, append_default_keywords, append_default_logo, append_category, append_manufacturer, append_model, append_product, append_root, sortorder_title, sortorder_description, sortorder_keywords, sortorder_logo, sortorder_logo_1, sortorder_logo_2, sortorder_logo_3, sortorder_logo_4, sortorder_category, sortorder_manufacturer, sortorder_model, sortorder_product, sortorder_root, sortorder_root_1, sortorder_root_2, sortorder_root_3, sortorder_root_4, language_id) values ('product_reviews_write.php', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '1', '1', '1', '1', '1', '1');
insert into headertags (page_name, page_title, page_description, page_keywords, page_logo, page_logo_1, page_logo_2, page_logo_3, page_logo_4, append_default_title, append_default_description, append_default_keywords, append_default_logo, append_category, append_manufacturer, append_model, append_product, append_root, sortorder_title, sortorder_description, sortorder_keywords, sortorder_logo, sortorder_logo_1, sortorder_logo_2, sortorder_logo_3, sortorder_logo_4, sortorder_category, sortorder_manufacturer, sortorder_model, sortorder_product, sortorder_root, sortorder_root_1, sortorder_root_2, sortorder_root_3, sortorder_root_4, language_id) values ('specials.php', 'specials', 'specials', 'specials', 'Specials', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '1', '1', '1', '1', '1', '1');
drop table if exists headertags_cache;
create table headertags_cache (
  title text ,
  data text 
);

drop table if exists headertags_default;
create table headertags_default (
  default_title varchar(64) not null ,
  default_description varchar(120) not null ,
  default_keywords varchar(255) not null ,
  default_logo_text varchar(255) not null ,
  home_page_text text not null ,
  default_logo_append_group tinyint(1) default '1' not null ,
  default_logo_append_category tinyint(1) default '1' not null ,
  default_logo_append_manufacturer tinyint(1) default '1' not null ,
  default_logo_append_product tinyint(1) default '1' not null ,
  meta_google tinyint(1) default '0' not null ,
  meta_language tinyint(1) default '0' not null ,
  meta_noodp tinyint(1) default '1' not null ,
  meta_noydir tinyint(1) default '1' not null ,
  meta_replyto tinyint(1) default '0' not null ,
  meta_revisit tinyint(1) default '0' not null ,
  meta_robots tinyint(1) default '0' not null ,
  meta_unspam tinyint(1) default '0' not null ,
  meta_canonical tinyint(1) default '1' not null ,
  meta_og tinyint(1) default '1' not null ,
  language_id int(11) default '1' not null ,
  PRIMARY KEY (default_title, language_id)
);

insert into headertags_default (default_title, default_description, default_keywords, default_logo_text, home_page_text, default_logo_append_group, default_logo_append_category, default_logo_append_manufacturer, default_logo_append_product, meta_google, meta_language, meta_noodp, meta_noydir, meta_replyto, meta_revisit, meta_robots, meta_unspam, meta_canonical, meta_og, language_id) values ('Default title', 'Default description', 'Default Keywords', 'Default Logo Text', '', '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '0', '0', '1', '1', '1');
drop table if exists headertags_keywords;
create table headertags_keywords (
  id int(11) not null auto_increment,
  keyword varchar(120) not null ,
  counter int(11) default '1' not null ,
  last_search datetime default '0000-00-00 00:00:00' not null ,
  google_last_position tinyint(4) not null ,
  google_date_position_check datetime default '0000-00-00 00:00:00' not null ,
  found tinyint(1) default '0' not null ,
  language_id int(11) default '1' not null ,
  PRIMARY KEY (id),
  KEY keyword (keyword),
  KEY found (found)
);

drop table if exists headertags_search;
create table headertags_search (
  product_id int(11) not null ,
  keyword varchar(64) not null ,
  language_id int(11) not null ,
  KEY keyword (keyword)
);

drop table if exists headertags_silo;
create table headertags_silo (
  category_id int(11) default '0' not null ,
  box_heading varchar(60) not null ,
  is_disabled tinyint(1) default '0' not null ,
  max_links int(11) default '6' not null ,
  sorton tinyint(2) default '0' not null ,
  language_id int(11) default '1' not null ,
  PRIMARY KEY (category_id, language_id)
);

drop table if exists headertags_social;
create table headertags_social (
  unique_id int(4) not null auto_increment,
  section varchar(48) not null ,
  groupname varchar(24) not null ,
  url varchar(255) not null ,
  data text not null ,
  PRIMARY KEY (unique_id),
  KEY idx_section (section)
);

insert into headertags_social (unique_id, section, groupname, url, data) values ('1', 'socialicons', 'digg', 'http://digg.com/submit?phase=2&url=URL&TITLE', '16x16');
insert into headertags_social (unique_id, section, groupname, url, data) values ('2', 'socialicons', 'facebook', 'http://www.facebook.com/share.php?u=URL&TITLE', '16x16');
insert into headertags_social (unique_id, section, groupname, url, data) values ('3', 'socialicons', 'google', 'http://www.google.com/bookmarks/mark?op=edit&bkmk=URL&TITLE', '16x16');
insert into headertags_social (unique_id, section, groupname, url, data) values ('4', 'socialicons', 'pintrest', 'http://pinterest.com/pin/create/button/?url=URL&TITLE', '16x16');
insert into headertags_social (unique_id, section, groupname, url, data) values ('5', 'socialicons', 'reddit', 'http://reddit.com/submit?url=URL&TITLE', '16x16');
insert into headertags_social (unique_id, section, groupname, url, data) values ('6', 'socialicons', 'google+', 'https://plus.google.com/share?url=URL&TITLE', '16x16');
insert into headertags_social (unique_id, section, groupname, url, data) values ('7', 'socialicons', 'linkedin', 'http://www.linkedin.com/shareArticle?mini=true&url=&title=TITLE=&source=URL', '16x16');
insert into headertags_social (unique_id, section, groupname, url, data) values ('8', 'socialicons', 'newsvine', 'http://www.newsvine.com/_tools/seed&amp;save?u=URL&h=TITLE', '16x16');
insert into headertags_social (unique_id, section, groupname, url, data) values ('9', 'socialicons', 'stumbleupon', 'http://www.stumbleupon.com/submit?url=URL&TITLE', '16x16');
insert into headertags_social (unique_id, section, groupname, url, data) values ('10', 'socialicons', 'twitter', 'http://twitter.com/home?status=URL&TITLE', '16x16');
drop table if exists languages;
create table languages (
  languages_id int(11) not null auto_increment,
  name varchar(32) not null ,
  code char(2) not null ,
  image varchar(64) ,
  directory varchar(32) ,
  sort_order int(3) ,
  PRIMARY KEY (languages_id),
  KEY IDX_LANGUAGES_NAME (name)
);

insert into languages (languages_id, name, code, image, directory, sort_order) values ('1', 'English', 'en', 'icon.gif', 'english', '1');
drop table if exists manufacturers;
create table manufacturers (
  manufacturers_id int(11) not null auto_increment,
  manufacturers_name varchar(32) not null ,
  manufacturers_image varchar(64) ,
  date_added datetime ,
  last_modified datetime ,
  PRIMARY KEY (manufacturers_id),
  KEY IDX_MANUFACTURERS_NAME (manufacturers_name)
);

insert into manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) values ('1', 'Matrox', 'manufacturer_matrox.gif', '2017-01-24 11:09:54', NULL);
insert into manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) values ('2', 'Microsoft', 'manufacturer_microsoft.gif', '2017-01-24 11:09:54', NULL);
insert into manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) values ('3', 'Warner', 'manufacturer_warner.gif', '2017-01-24 11:09:54', NULL);
insert into manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) values ('4', 'Fox', 'manufacturer_fox.gif', '2017-01-24 11:09:54', NULL);
insert into manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) values ('5', 'Logitech', 'manufacturer_logitech.gif', '2017-01-24 11:09:54', NULL);
insert into manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) values ('6', 'Canon', 'manufacturer_canon.gif', '2017-01-24 11:09:54', NULL);
insert into manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) values ('7', 'Sierra', 'manufacturer_sierra.gif', '2017-01-24 11:09:54', NULL);
insert into manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) values ('8', 'GT Interactive', 'manufacturer_gt_interactive.gif', '2017-01-24 11:09:54', NULL);
insert into manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) values ('9', 'Hewlett Packard', 'manufacturer_hewlett_packard.gif', '2017-01-24 11:09:54', NULL);
insert into manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) values ('10', 'Samsung', 'manufacturer_samsung.png', '2017-01-24 11:09:54', NULL);
drop table if exists manufacturers_info;
create table manufacturers_info (
  manufacturers_id int(11) not null ,
  languages_id int(11) not null ,
  manufacturers_url varchar(255) not null ,
  url_clicked int(5) default '0' not null ,
  date_last_click datetime ,
  manufacturers_description text ,
  manufacturers_seo_description text ,
  manufacturers_seo_keywords varchar(128) ,
  manufacturers_seo_title varchar(128) ,
  PRIMARY KEY (manufacturers_id, languages_id)
);

insert into manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click, manufacturers_description, manufacturers_seo_description, manufacturers_seo_keywords, manufacturers_seo_title) values ('1', '1', 'http://www.matrox.com', '0', NULL, NULL, NULL, NULL, NULL);
insert into manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click, manufacturers_description, manufacturers_seo_description, manufacturers_seo_keywords, manufacturers_seo_title) values ('2', '1', 'http://www.microsoft.com', '0', NULL, NULL, NULL, NULL, NULL);
insert into manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click, manufacturers_description, manufacturers_seo_description, manufacturers_seo_keywords, manufacturers_seo_title) values ('3', '1', 'http://www.warner.com', '0', NULL, NULL, NULL, NULL, NULL);
insert into manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click, manufacturers_description, manufacturers_seo_description, manufacturers_seo_keywords, manufacturers_seo_title) values ('4', '1', 'http://www.fox.com', '0', NULL, NULL, NULL, NULL, NULL);
insert into manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click, manufacturers_description, manufacturers_seo_description, manufacturers_seo_keywords, manufacturers_seo_title) values ('5', '1', 'http://www.logitech.com', '0', NULL, NULL, NULL, NULL, NULL);
insert into manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click, manufacturers_description, manufacturers_seo_description, manufacturers_seo_keywords, manufacturers_seo_title) values ('6', '1', 'http://www.canon.com', '0', NULL, NULL, NULL, NULL, NULL);
insert into manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click, manufacturers_description, manufacturers_seo_description, manufacturers_seo_keywords, manufacturers_seo_title) values ('7', '1', 'http://www.sierra.com', '1', '2017-02-03 10:06:26', NULL, NULL, NULL, NULL);
insert into manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click, manufacturers_description, manufacturers_seo_description, manufacturers_seo_keywords, manufacturers_seo_title) values ('8', '1', 'http://www.infogrames.com', '0', NULL, NULL, NULL, NULL, NULL);
insert into manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click, manufacturers_description, manufacturers_seo_description, manufacturers_seo_keywords, manufacturers_seo_title) values ('9', '1', 'http://www.hewlettpackard.com', '0', NULL, NULL, NULL, NULL, NULL);
insert into manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click, manufacturers_description, manufacturers_seo_description, manufacturers_seo_keywords, manufacturers_seo_title) values ('10', '1', 'http://www.samsung.com', '1', '2017-02-02 06:02:49', NULL, NULL, NULL, NULL);
drop table if exists newsletters;
create table newsletters (
  newsletters_id int(11) not null auto_increment,
  title varchar(255) not null ,
  content text not null ,
  module varchar(255) not null ,
  date_added datetime not null ,
  date_sent datetime ,
  status int(1) ,
  locked int(1) default '0' ,
  PRIMARY KEY (newsletters_id)
);

drop table if exists orders;
create table orders (
  orders_id int(11) not null auto_increment,
  customers_id int(11) not null ,
  customers_name varchar(255) not null ,
  customers_company varchar(255) ,
  customers_street_address varchar(255) not null ,
  customers_suburb varchar(255) ,
  customers_city varchar(255) not null ,
  customers_postcode varchar(255) not null ,
  customers_state varchar(255) ,
  customers_country varchar(255) not null ,
  customers_telephone varchar(255) not null ,
  customers_email_address varchar(255) not null ,
  customers_address_format_id int(5) not null ,
  delivery_name varchar(255) not null ,
  delivery_company varchar(255) ,
  delivery_street_address varchar(255) not null ,
  delivery_suburb varchar(255) ,
  delivery_city varchar(255) not null ,
  delivery_postcode varchar(255) not null ,
  delivery_state varchar(255) ,
  delivery_country varchar(255) not null ,
  delivery_address_format_id int(5) not null ,
  billing_name varchar(255) not null ,
  billing_company varchar(255) ,
  billing_street_address varchar(255) not null ,
  billing_suburb varchar(255) ,
  billing_city varchar(255) not null ,
  billing_postcode varchar(255) not null ,
  billing_state varchar(255) ,
  billing_country varchar(255) not null ,
  billing_address_format_id int(5) not null ,
  payment_method varchar(255) not null ,
  cc_type varchar(20) ,
  cc_owner varchar(255) ,
  cc_number varchar(32) ,
  cc_expires varchar(4) ,
  last_modified datetime ,
  date_purchased datetime ,
  orders_status int(5) not null ,
  orders_date_finished datetime ,
  currency char(3) ,
  currency_value decimal(14,6) ,
  PRIMARY KEY (orders_id),
  KEY idx_orders_customers_id (customers_id)
);

drop table if exists orders_products;
create table orders_products (
  orders_products_id int(11) not null auto_increment,
  orders_id int(11) not null ,
  products_id int(11) not null ,
  products_model varchar(64) ,
  products_name varchar(128) not null ,
  products_price decimal(15,4) not null ,
  final_price decimal(15,4) not null ,
  products_tax decimal(7,4) not null ,
  products_quantity int(2) not null ,
  PRIMARY KEY (orders_products_id),
  KEY idx_orders_products_orders_id (orders_id),
  KEY idx_orders_products_products_id (products_id)
);

drop table if exists orders_products_attributes;
create table orders_products_attributes (
  orders_products_attributes_id int(11) not null auto_increment,
  orders_id int(11) not null ,
  orders_products_id int(11) not null ,
  products_options varchar(32) not null ,
  products_options_values varchar(32) not null ,
  options_values_price decimal(15,4) not null ,
  price_prefix char(1) not null ,
  PRIMARY KEY (orders_products_attributes_id),
  KEY idx_orders_products_att_orders_id (orders_id)
);

insert into orders_products_attributes (orders_products_attributes_id, orders_id, orders_products_id, products_options, products_options_values, options_values_price, price_prefix) values ('1', '2', '2', 'Memory', '4 mb', '0.0000', '+');
insert into orders_products_attributes (orders_products_attributes_id, orders_id, orders_products_id, products_options, products_options_values, options_values_price, price_prefix) values ('2', '2', '2', 'Model', 'Value', '0.0000', '+');
drop table if exists orders_products_download;
create table orders_products_download (
  orders_products_download_id int(11) not null auto_increment,
  orders_id int(11) default '0' not null ,
  orders_products_id int(11) default '0' not null ,
  orders_products_filename varchar(255) not null ,
  download_maxdays int(2) default '0' not null ,
  download_count int(2) default '0' not null ,
  PRIMARY KEY (orders_products_download_id),
  KEY idx_orders_products_download_orders_id (orders_id)
);

drop table if exists orders_status;
create table orders_status (
  orders_status_id int(11) default '0' not null ,
  language_id int(11) default '1' not null ,
  orders_status_name varchar(32) not null ,
  public_flag int(11) default '1' ,
  downloads_flag int(11) default '0' ,
  PRIMARY KEY (orders_status_id, language_id),
  KEY idx_orders_status_name (orders_status_name)
);

insert into orders_status (orders_status_id, language_id, orders_status_name, public_flag, downloads_flag) values ('1', '1', 'Pending', '1', '0');
insert into orders_status (orders_status_id, language_id, orders_status_name, public_flag, downloads_flag) values ('2', '1', 'Processing', '1', '1');
insert into orders_status (orders_status_id, language_id, orders_status_name, public_flag, downloads_flag) values ('3', '1', 'Delivered', '1', '1');
insert into orders_status (orders_status_id, language_id, orders_status_name, public_flag, downloads_flag) values ('4', '1', 'PayPal [Transactions]', '0', '0');
insert into orders_status (orders_status_id, language_id, orders_status_name, public_flag, downloads_flag) values ('5', '1', 'Authorize.net [Transactions]', '0', '0');
drop table if exists orders_status_history;
create table orders_status_history (
  orders_status_history_id int(11) not null auto_increment,
  orders_id int(11) not null ,
  orders_status_id int(5) not null ,
  date_added datetime not null ,
  customer_notified int(1) default '0' ,
  comments text ,
  PRIMARY KEY (orders_status_history_id),
  KEY idx_orders_status_history_orders_id (orders_id)
);

drop table if exists orders_total;
create table orders_total (
  orders_total_id int(10) unsigned not null auto_increment,
  orders_id int(11) not null ,
  title varchar(255) not null ,
  text varchar(255) not null ,
  value decimal(15,4) not null ,
  class varchar(32) not null ,
  sort_order int(11) not null ,
  PRIMARY KEY (orders_total_id),
  KEY idx_orders_total_orders_id (orders_id)
);

drop table if exists oscom_app_paypal_log;
create table oscom_app_paypal_log (
  id int(10) unsigned not null ,
  customers_id int(11) not null ,
  module varchar(8) not null ,
  action varchar(255) not null ,
  result tinyint(4) not null ,
  server tinyint(4) not null ,
  request text not null ,
  response text not null ,
  ip_address int(10) unsigned ,
  date_added datetime 
);

drop table if exists products;
create table products (
  products_id int(11) not null auto_increment,
  products_quantity int(4) not null ,
  products_model varchar(64) ,
  products_image varchar(64) ,
  image_folder varchar(64) ,
  image_display varchar(64) ,
  products_price decimal(15,4) not null ,
  products_date_added datetime not null ,
  products_last_modified datetime ,
  products_date_available datetime ,
  products_weight decimal(5,2) not null ,
  products_status tinyint(1) not null ,
  products_tax_class_id int(11) not null ,
  manufacturers_id int(11) ,
  products_ordered int(11) default '0' not null ,
  products_gtin char(14) ,
  PRIMARY KEY (products_id),
  KEY idx_products_model (products_model),
  KEY idx_products_date_added (products_date_added)
);

insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('1', '31', 'MG200MMS', 'mg200mms_01.jpg', NULL, '0', '299.9900', '2017-01-24 11:09:54', '2017-02-11 09:26:48', NULL, '23.00', '1', '1', '1', '1', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('2', '32', 'MG400-32MB', 'mg400-32mb_01.jpg', NULL, '0', '499.9900', '2017-01-24 11:09:54', '2017-02-11 09:25:16', NULL, '23.00', '1', '1', '1', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('3', '2', 'MSIMPRO', 'msimpro.jpg', NULL, '0', '49.9900', '2017-01-24 11:09:54', '2017-02-09 10:50:23', NULL, '7.00', '1', '1', '2', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('4', '13', 'DVD-RPMK', 'replacement_killers.jpg', NULL, '0', '42.0000', '2017-01-24 11:09:54', '2017-02-11 08:52:20', NULL, '23.00', '1', '1', '4', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('5', '16', 'DVD-BLDRNDC', 'blade_runner.jpg', NULL, '0', '35.9900', '2017-01-24 11:09:54', '2017-02-09 14:02:17', NULL, '7.00', '1', '1', '3', '1', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('6', '10', 'DVD-MATR', 'the_matrix.jpg', NULL, '0', '39.9900', '2017-01-24 11:09:54', '2017-02-09 13:26:32', NULL, '7.00', '1', '1', '3', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('7', '9', 'DVD-YGEM', 'youve_got_mail.jpg', NULL, '0', '34.9900', '2017-01-24 11:09:54', '2017-02-09 13:52:13', NULL, '7.00', '1', '1', '3', '1', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('8', '9', 'DVD-ABUG', 'a_bugs_life.jpg', NULL, '0', '35.9900', '2017-01-24 11:09:54', '2017-02-09 13:40:58', NULL, '7.00', '1', '1', '3', '1', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('9', '10', 'DVD-UNSG', 'under_siege.jpg', NULL, '0', '29.9900', '2017-01-24 11:09:54', '2017-02-09 13:36:10', NULL, '7.00', '1', '1', '3', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('10', '10', 'DVD-UNSG2', 'under_siege_2.jpg', NULL, '0', '29.9900', '2017-01-24 11:09:54', '2017-02-09 13:37:10', NULL, '7.00', '1', '1', '3', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('11', '10', 'DVD-FDBL', 'fire_down_below.jpg', NULL, '0', '29.9900', '2017-01-24 11:09:54', '2017-02-09 13:15:49', NULL, '7.00', '1', '1', '3', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('12', '10', 'DVD-DHWV', 'die_hard_3.jpg', NULL, '0', '39.9900', '2017-01-24 11:09:54', '2017-02-09 13:13:18', NULL, '7.00', '1', '1', '4', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('13', '10', 'DVD-LTWP', 'lethal_weapon.jpg', NULL, '0', '34.9900', '2017-01-24 11:09:54', '2017-02-09 13:19:16', NULL, '7.00', '1', '1', '3', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('14', '9', 'DVD-REDC', 'red_corner.jpg', NULL, '0', '32.0000', '2017-01-24 11:09:54', '2017-02-09 13:59:24', NULL, '7.00', '1', '1', '3', '1', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('15', '9', 'DVD-FRAN', 'frantic.jpg', NULL, '0', '35.0000', '2017-01-24 11:09:54', '2017-02-09 14:05:24', NULL, '7.00', '1', '1', '3', '1', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('16', '9', 'DVD-CUFI', 'courage_under_fire.jpg', NULL, '0', '38.9900', '2017-01-24 11:09:54', '2017-02-09 13:56:55', NULL, '7.00', '1', '1', '4', '1', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('17', '9', 'DVD-SPEED', 'speed.jpg', NULL, '0', '39.9900', '2017-01-24 11:09:54', '2017-02-09 13:21:22', NULL, '7.00', '1', '1', '4', '1', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('18', '10', 'DVD-SPEED2', 'speed_2.jpg', NULL, '0', '42.0000', '2017-01-24 11:09:54', '2017-02-09 13:24:33', NULL, '7.00', '1', '1', '4', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('19', '10', 'DVD-TSAB', 'theres_something_about_mary.jpg', NULL, '0', '49.9900', '2017-01-24 11:09:54', '2017-02-09 13:46:10', NULL, '7.00', '1', '1', '4', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('20', '9', 'DVD-BELOVED', 'beloved.jpg', NULL, '0', '54.9900', '2017-01-24 11:09:54', '2017-02-09 13:54:16', NULL, '7.00', '1', '1', '3', '1', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('21', '16', 'PC-SWAT3', 'swat_3.jpg', NULL, '0', '79.9900', '2017-01-24 11:09:54', '2017-02-09 12:58:27', NULL, '7.00', '1', '1', '7', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('22', '13', 'PC-UNTM', 'unreal_tournament.jpg', NULL, '0', '89.9900', '2017-01-24 11:09:54', '2017-02-09 12:54:23', NULL, '7.00', '1', '1', '8', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('23', '15', 'PC-TWOF', 'wheel_of_time.jpg', NULL, '0', '99.9900', '2017-01-24 11:09:54', '2017-02-09 13:05:08', NULL, '10.00', '1', '1', '8', '1', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('24', '17', 'PC-DISC', 'disciples.jpg', NULL, '0', '90.0000', '2017-01-24 11:09:54', '2017-02-09 13:01:29', NULL, '8.00', '1', '1', '8', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('25', '16', 'MSINTKB', 'intkeyboardps2.jpg', NULL, '0', '69.9900', '2017-01-24 11:09:54', '2017-02-09 12:44:50', NULL, '8.00', '1', '1', '2', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('26', '10', 'MSIMEXP', 'imexplorer.jpg', NULL, '0', '64.9500', '2017-01-24 11:09:54', '2017-02-09 12:47:40', NULL, '8.00', '1', '1', '2', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('27', '8', 'HPLJ1100XI', 'lj1100xi.jpg', NULL, '0', '499.9900', '2017-01-24 11:09:54', '2017-02-09 12:50:39', NULL, '45.00', '1', '1', '9', '0', NULL);
insert into products (products_id, products_quantity, products_model, products_image, image_folder, image_display, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_gtin) values ('28', '99', 'GT-P1000', 'galaxy_tab.jpg', NULL, '0', '749.9900', '2017-01-24 11:09:54', '2017-02-09 14:18:49', NULL, '1.00', '1', '1', '10', '1', NULL);
drop table if exists products_attributes;
create table products_attributes (
  products_attributes_id int(11) not null auto_increment,
  products_id int(11) not null ,
  options_id int(11) not null ,
  options_values_id int(11) not null ,
  options_values_price decimal(15,4) not null ,
  price_prefix char(1) not null ,
  PRIMARY KEY (products_attributes_id),
  KEY idx_products_attributes_products_id (products_id)
);

insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('1', '1', '4', '1', '0.0000', '+');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('2', '1', '4', '2', '50.0000', '+');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('3', '1', '4', '3', '70.0000', '+');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('4', '1', '3', '5', '0.0000', '+');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('5', '1', '3', '6', '100.0000', '+');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('6', '2', '4', '3', '10.0000', '-');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('7', '2', '4', '4', '0.0000', '+');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('8', '2', '3', '6', '0.0000', '+');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('9', '2', '3', '7', '120.0000', '+');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('10', '26', '3', '8', '0.0000', '+');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('11', '26', '3', '9', '6.0000', '+');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('26', '22', '5', '10', '0.0000', '+');
insert into products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) values ('27', '22', '5', '13', '0.0000', '+');
drop table if exists products_attributes_download;
create table products_attributes_download (
  products_attributes_id int(11) not null ,
  products_attributes_filename varchar(255) not null ,
  products_attributes_maxdays int(2) default '0' ,
  products_attributes_maxcount int(2) default '0' ,
  PRIMARY KEY (products_attributes_id)
);

insert into products_attributes_download (products_attributes_id, products_attributes_filename, products_attributes_maxdays, products_attributes_maxcount) values ('26', 'unreal.zip', '7', '3');
drop table if exists products_description;
create table products_description (
  products_id int(11) not null auto_increment,
  language_id int(11) default '1' not null ,
  products_name varchar(128) not null ,
  products_description text ,
  products_url varchar(255) ,
  products_viewed int(5) default '0' ,
  products_seo_description text ,
  products_seo_keywords varchar(128) ,
  products_seo_title varchar(128) ,
  PRIMARY KEY (products_id, language_id),
  KEY products_name (products_name)
);

insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('1', '1', 'Matrox G200 MMS', 'Reinforcing its position as a multi-monitor trailblazer, Matrox Graphics Inc. has once again developed the most flexible and highly advanced solution in the industry. Introducing the new Matrox G200 Multi-Monitor Series; the first graphics card ever to support up to four DVI digital flat panel displays on a single 8&quot; PCI board.<br />
<br />
With continuing demand for digital flat panels in the financial workplace, the Matrox G200 MMS is the ultimate in flexible solutions. The Matrox G200 MMS also supports the new digital video interface (DVI) created by the Digital Display Working Group (DDWG) designed to ease the adoption of digital flat panels. Other configurations include composite video capture ability and onboard TV tuner, making the Matrox G200 MMS the complete solution for business needs.<br />
<br />
Based on the award-winning MGA-G200 graphics chip, the Matrox G200 Multi-Monitor Series provides superior 2D/3D graphics acceleration to meet the demanding needs of business applications such as real-time stock quotes (Versus), live video feeds (Reuters &amp; Bloombergs), multiple windows applications, word processing, spreadsheets and CAD.', 'www.matrox.com/mga/products/g200_mms/home.cfm', '447', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('2', '1', 'Matrox G400 32MB', '<strong>Dramatically Different High Performance Graphics</strong><br />
<br />
Introducing the Millennium G400 Series - a dramatically different, high performance graphics experience. Armed with the industry&#39;s fastest graphics chip, the Millennium G400 Series takes explosive acceleration two steps further by adding unprecedented image quality, along with the most versatile display options for all your 3D, 2D and DVD applications. As the most powerful and innovative tools in your PC&#39;s arsenal, the Millennium G400 Series will not only change the way you see graphics, but will revolutionize the way you use your computer.<br />
<br />
<strong>Key features:</strong>
<ul>
	<li>New Matrox G400 256-bit DualBus graphics chip</li>
	<li>Explosive 3D, 2D and DVD performance</li>
	<li>DualHead Display</li>
	<li>Superior DVD and TV output</li>
	<li>3D Environment-Mapped Bump Mapping</li>
	<li>Vibrant Color Quality rendering</li>
	<li>UltraSharp DAC of up to 360 MHz</li>
	<li>3D Rendering Array Processor</li>
	<li>Support for 16 or 32 MB of memory</li>
</ul>', 'www.matrox.com/mga/products/mill_g400/home.htm', '243', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('3', '1', 'Microsoft IntelliMouse Pro', 'Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft&#39;s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.', 'www.microsoft.com/hardware/mouse/intellimouse.asp', '103', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('4', '1', 'The Replacement Killers', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 80 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'www.replacement-killers.com', '29', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('5', '1', 'Blade Runner - Director\'s Cut', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 112 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'www.bladerunner.com', '76', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('6', '1', 'The Matrix', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch.<br />
Audio: Dolby Surround.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 131 minutes.<br />
Other: Interactive Menus, Chapter Selection, Making Of.', 'www.thematrix.com', '26', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('7', '1', 'You\'ve Got Mail', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch, Spanish.<br />
Subtitles: English, Deutsch, Spanish, French, Nordic, Polish.<br />
Audio: Dolby Digital 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 115 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'www.youvegotmail.com', '27', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('8', '1', 'A Bug\'s Life', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Digital 5.1 / Dobly Surround Stereo.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 91 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'www.abugslife.com', '90', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('9', '1', 'Under Siege', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 98 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '47', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('10', '1', 'Under Siege 2 - Dark Territory', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 98 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '25', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('11', '1', 'Fire Down Below', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 100 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '24', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('12', '1', 'Die Hard With A Vengeance', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 122 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '34', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('13', '1', 'Lethal Weapon', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 100 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '29', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('14', '1', 'Red Corner', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 117 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '28', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('15', '1', 'Frantic', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 115 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '27', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('16', '1', 'Courage Under Fire', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 112 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '33', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('17', '1', 'Speed', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 112 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '26', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('18', '1', 'Speed 2: Cruise Control', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 120 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '22', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('19', '1', 'There\'s Something About Mary', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 114 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '29', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('20', '1', 'Beloved', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />
Languages: English, Deutsch.<br />
Subtitles: English, Deutsch, Spanish.<br />
Audio: Dolby Surround 5.1.<br />
Picture Format: 16:9 Wide-Screen.<br />
Length: (approx) 164 minutes.<br />
Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', '59', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('21', '1', 'SWAT 3: Close Quarters Battle', '<strong>Windows 95/98</strong><br />
<br />
211 in progress with shots fired. Officer down. Armed suspects with hostages. Respond Code 3! Los Angles, 2005, In the next seven days, representatives from every nation around the world will converge on Las Angles to witness the signing of the United Nations Nuclear Abolishment Treaty. The protection of these dignitaries falls on the shoulders of one organization, LAPD SWAT. As part of this elite tactical organization, you and your team have the weapons and all the training necessary to protect, to serve, and &quot;When needed&quot; to use deadly force to keep the peace. It takes more than weapons to make it through each mission. Your arsenal includes C2 charges, flashbangs, tactical grenades. opti-Wand mini-video cameras, and other devices critical to meeting your objectives and keeping your men free of injury. Uncompromised Duty, Honor and Valor!', 'www.swat3.com', '34', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('22', '1', 'Unreal Tournament', 'From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br />
<br />
This stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It&#39;s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of &#39;bots&#39; (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.', 'www.unrealtournament.net', '87', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('23', '1', 'The Wheel Of Time', 'The world in which The Wheel of Time takes place is lifted directly out of Jordan&#39;s pages; it&#39;s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you&#39;re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter&#39;angreal, Portal Stones, and the Ways. However you move around, though, you&#39;ll quickly discover that means of locomotion can easily become the least of the your worries...<br />
<br />
During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time&#39;s main characters. Some of these places are ripped directly from the pages of Jordan&#39;s books, made flesh with Legend&#39;s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you&#39;ll have this year.', 'www.wheeloftime.com', '41', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('24', '1', 'Disciples: Sacred Lands', 'A new age is dawning...<br />
<br />
Enter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br />
<br />
The day of reckoning has come... and only the chosen will survive.', '', '51', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('25', '1', 'Microsoft Internet Keyboard PS/2', 'The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!', '', '65', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('26', '1', 'Microsoft IntelliMouse Explorer', 'Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!', 'www.microsoft.com/hardware/mouse/explorer.asp', '40', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('27', '1', 'Hewlett Packard LaserJet 1100Xi', 'HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP&#39;s Resolution Enhancement technology (REt) makes every document more professional.<br />
<br />
Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br />
<br />
HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).', 'www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100', '48', '', '', '');
insert into products_description (products_id, language_id, products_name, products_description, products_url, products_viewed, products_seo_description, products_seo_keywords, products_seo_title) values ('28', '1', 'Samsung Galaxy Tab', '<p>Powered by a Cortex A8 1.0GHz application processor, the Samsung GALAXY Tab is designed to deliver high performance whenever and wherever you are. At the same time, HD video contents are supported by a wide range of multimedia formats (DivX, XviD, MPEG4, H.263, H.264 and more), which maximizes the joy of entertainment.</p>

<p>With 3G HSPA connectivity, 802.11n Wi-Fi, and Bluetooth 3.0, the Samsung GALAXY Tab enhances users&#39; mobile communication on a whole new level. Video conferencing and push email on the large 7-inch display make communication more smooth and efficient. For voice telephony, the Samsung GALAXY Tab turns out to be a perfect speakerphone on the desk, or a mobile phone on the move via Bluetooth headset.</p>', 'http://galaxytab.samsungmobile.com', '89', '', '', '');
drop table if exists products_images;
create table products_images (
  id int(11) not null auto_increment,
  products_id int(11) not null ,
  image varchar(64) ,
  htmlcontent text ,
  sort_order int(11) not null ,
  PRIMARY KEY (id),
  KEY products_images_prodid (products_id)
);

insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('18', '7', 'youve_got_mail.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('29', '1', 'mg200mms_01.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('30', '1', 'mg200mms.jpg', '', '2');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('31', '2', 'mg400-32mb_01.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('32', '2', 'mg400-32mb.jpg', '', '2');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('33', '3', 'msimpro.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('37', '25', 'intkeyboardps2.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('38', '26', 'imexplorer.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('39', '27', 'lj1100xi.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('40', '22', 'unreal_tournament.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('41', '21', 'swat_3.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('42', '24', 'disciples.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('43', '23', 'wheel_of_time.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('46', '12', 'die_hard_3.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('47', '11', 'fire_down_below.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('48', '13', 'lethal_weapon.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('49', '17', 'speed.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('50', '18', 'speed_2.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('51', '6', 'the_matrix.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('52', '4', 'replacement_killers.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('54', '9', 'under_siege.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('55', '10', 'under_siege_2.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('56', '8', 'a_bugs_life.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('58', '19', 'theres_something_about_mary.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('59', '20', 'beloved.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('60', '16', 'courage_under_fire.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('61', '14', 'red_corner.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('62', '5', 'blade_runner.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('63', '15', 'frantic.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('64', '28', 'galaxy_tab.jpg', '', '1');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('65', '28', 'galaxy_tab_01.jpg', '', '3');
insert into products_images (id, products_id, image, htmlcontent, sort_order) values ('67', '28', 'galaxy_tab_02.jpg', '', '2');
drop table if exists products_notifications;
create table products_notifications (
  products_id int(11) not null ,
  customers_id int(11) not null ,
  date_added datetime not null ,
  PRIMARY KEY (products_id, customers_id)
);

drop table if exists products_options;
create table products_options (
  products_options_id int(11) default '0' not null ,
  language_id int(11) default '1' not null ,
  products_options_name varchar(32) not null ,
  PRIMARY KEY (products_options_id, language_id)
);

insert into products_options (products_options_id, language_id, products_options_name) values ('1', '1', 'Color');
insert into products_options (products_options_id, language_id, products_options_name) values ('2', '1', 'Size');
insert into products_options (products_options_id, language_id, products_options_name) values ('3', '1', 'Model');
insert into products_options (products_options_id, language_id, products_options_name) values ('4', '1', 'Memory');
insert into products_options (products_options_id, language_id, products_options_name) values ('5', '1', 'Version');
drop table if exists products_options_values;
create table products_options_values (
  products_options_values_id int(11) default '0' not null ,
  language_id int(11) default '1' not null ,
  products_options_values_name varchar(64) not null ,
  PRIMARY KEY (products_options_values_id, language_id)
);

insert into products_options_values (products_options_values_id, language_id, products_options_values_name) values ('1', '1', '4 mb');
insert into products_options_values (products_options_values_id, language_id, products_options_values_name) values ('2', '1', '8 mb');
insert into products_options_values (products_options_values_id, language_id, products_options_values_name) values ('3', '1', '16 mb');
insert into products_options_values (products_options_values_id, language_id, products_options_values_name) values ('4', '1', '32 mb');
insert into products_options_values (products_options_values_id, language_id, products_options_values_name) values ('5', '1', 'Value');
insert into products_options_values (products_options_values_id, language_id, products_options_values_name) values ('6', '1', 'Premium');
insert into products_options_values (products_options_values_id, language_id, products_options_values_name) values ('7', '1', 'Deluxe');
insert into products_options_values (products_options_values_id, language_id, products_options_values_name) values ('8', '1', 'PS/2');
insert into products_options_values (products_options_values_id, language_id, products_options_values_name) values ('9', '1', 'USB');
insert into products_options_values (products_options_values_id, language_id, products_options_values_name) values ('10', '1', 'Download: Windows - English');
insert into products_options_values (products_options_values_id, language_id, products_options_values_name) values ('13', '1', 'Box: Windows - English');
drop table if exists products_options_values_to_products_options;
create table products_options_values_to_products_options (
  products_options_values_to_products_options_id int(11) not null auto_increment,
  products_options_id int(11) not null ,
  products_options_values_id int(11) not null ,
  PRIMARY KEY (products_options_values_to_products_options_id)
);

insert into products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) values ('1', '4', '1');
insert into products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) values ('2', '4', '2');
insert into products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) values ('3', '4', '3');
insert into products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) values ('4', '4', '4');
insert into products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) values ('5', '3', '5');
insert into products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) values ('6', '3', '6');
insert into products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) values ('7', '3', '7');
insert into products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) values ('8', '3', '8');
insert into products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) values ('9', '3', '9');
insert into products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) values ('10', '5', '10');
insert into products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) values ('13', '5', '13');
drop table if exists products_to_categories;
create table products_to_categories (
  products_id int(11) not null ,
  categories_id int(11) not null ,
  PRIMARY KEY (products_id, categories_id)
);

insert into products_to_categories (products_id, categories_id) values ('1', '4');
insert into products_to_categories (products_id, categories_id) values ('2', '4');
insert into products_to_categories (products_id, categories_id) values ('3', '9');
insert into products_to_categories (products_id, categories_id) values ('4', '10');
insert into products_to_categories (products_id, categories_id) values ('5', '11');
insert into products_to_categories (products_id, categories_id) values ('6', '10');
insert into products_to_categories (products_id, categories_id) values ('7', '12');
insert into products_to_categories (products_id, categories_id) values ('8', '13');
insert into products_to_categories (products_id, categories_id) values ('9', '10');
insert into products_to_categories (products_id, categories_id) values ('10', '10');
insert into products_to_categories (products_id, categories_id) values ('11', '10');
insert into products_to_categories (products_id, categories_id) values ('12', '10');
insert into products_to_categories (products_id, categories_id) values ('13', '10');
insert into products_to_categories (products_id, categories_id) values ('14', '15');
insert into products_to_categories (products_id, categories_id) values ('15', '14');
insert into products_to_categories (products_id, categories_id) values ('16', '15');
insert into products_to_categories (products_id, categories_id) values ('17', '10');
insert into products_to_categories (products_id, categories_id) values ('18', '10');
insert into products_to_categories (products_id, categories_id) values ('19', '12');
insert into products_to_categories (products_id, categories_id) values ('20', '15');
insert into products_to_categories (products_id, categories_id) values ('21', '18');
insert into products_to_categories (products_id, categories_id) values ('22', '19');
insert into products_to_categories (products_id, categories_id) values ('23', '20');
insert into products_to_categories (products_id, categories_id) values ('24', '20');
insert into products_to_categories (products_id, categories_id) values ('25', '8');
insert into products_to_categories (products_id, categories_id) values ('26', '9');
insert into products_to_categories (products_id, categories_id) values ('27', '5');
insert into products_to_categories (products_id, categories_id) values ('28', '23');
drop table if exists reviews;
create table reviews (
  reviews_id int(11) not null auto_increment,
  products_id int(11) not null ,
  customers_id int(11) ,
  customers_name varchar(255) not null ,
  reviews_rating int(1) ,
  date_added datetime ,
  last_modified datetime ,
  reviews_status tinyint(1) default '0' not null ,
  reviews_read int(5) default '0' not null ,
  PRIMARY KEY (reviews_id),
  KEY idx_reviews_products_id (products_id),
  KEY idx_reviews_customers_id (customers_id)
);

insert into reviews (reviews_id, products_id, customers_id, customers_name, reviews_rating, date_added, last_modified, reviews_status, reviews_read) values ('1', '19', '0', 'John Doe', '5', '2017-01-24 11:09:54', '2017-01-26 08:29:51', '1', '0');
drop table if exists reviews_description;
create table reviews_description (
  reviews_id int(11) not null ,
  languages_id int(11) not null ,
  reviews_text text not null ,
  PRIMARY KEY (reviews_id, languages_id)
);

insert into reviews_description (reviews_id, languages_id, reviews_text) values ('1', '1', 'This has to be one of the funniest movies released for 1999!');
drop table if exists sec_directory_whitelist;
create table sec_directory_whitelist (
  id int(11) not null auto_increment,
  directory varchar(255) not null ,
  PRIMARY KEY (id)
);

insert into sec_directory_whitelist (id, directory) values ('1', 'admin/backups');
insert into sec_directory_whitelist (id, directory) values ('2', 'admin/images/graphs');
insert into sec_directory_whitelist (id, directory) values ('3', 'images');
insert into sec_directory_whitelist (id, directory) values ('4', 'images/banners');
insert into sec_directory_whitelist (id, directory) values ('5', 'images/dvd');
insert into sec_directory_whitelist (id, directory) values ('6', 'images/gt_interactive');
insert into sec_directory_whitelist (id, directory) values ('7', 'images/hewlett_packard');
insert into sec_directory_whitelist (id, directory) values ('8', 'images/matrox');
insert into sec_directory_whitelist (id, directory) values ('9', 'images/microsoft');
insert into sec_directory_whitelist (id, directory) values ('10', 'images/samsung');
insert into sec_directory_whitelist (id, directory) values ('11', 'images/sierra');
insert into sec_directory_whitelist (id, directory) values ('12', 'includes/work');
insert into sec_directory_whitelist (id, directory) values ('13', 'pub');
drop table if exists sessions;
create table sessions (
  sesskey varchar(128) not null ,
  expiry int(11) unsigned not null ,
  value text not null ,
  PRIMARY KEY (sesskey)
);

drop table if exists specials;
create table specials (
  specials_id int(11) not null auto_increment,
  products_id int(11) not null ,
  specials_new_products_price decimal(15,4) not null ,
  specials_date_added datetime ,
  specials_last_modified datetime ,
  expires_date datetime ,
  date_status_change datetime ,
  status int(1) default '1' not null ,
  PRIMARY KEY (specials_id),
  KEY idx_specials_products_id (products_id)
);

insert into specials (specials_id, products_id, specials_new_products_price, specials_date_added, specials_last_modified, expires_date, date_status_change, status) values ('1', '3', '39.9900', '2017-01-24 11:09:54', NULL, NULL, NULL, '1');
insert into specials (specials_id, products_id, specials_new_products_price, specials_date_added, specials_last_modified, expires_date, date_status_change, status) values ('2', '5', '30.0000', '2017-01-24 11:09:54', NULL, NULL, NULL, '1');
insert into specials (specials_id, products_id, specials_new_products_price, specials_date_added, specials_last_modified, expires_date, date_status_change, status) values ('3', '6', '30.0000', '2017-01-24 11:09:54', NULL, NULL, NULL, '1');
insert into specials (specials_id, products_id, specials_new_products_price, specials_date_added, specials_last_modified, expires_date, date_status_change, status) values ('4', '16', '29.9900', '2017-01-24 11:09:54', NULL, NULL, NULL, '1');
insert into specials (specials_id, products_id, specials_new_products_price, specials_date_added, specials_last_modified, expires_date, date_status_change, status) values ('5', '2', '399.9900', '2017-01-30 08:04:24', NULL, NULL, NULL, '1');
insert into specials (specials_id, products_id, specials_new_products_price, specials_date_added, specials_last_modified, expires_date, date_status_change, status) values ('6', '8', '22.0000', '2017-01-30 08:04:43', '2017-02-01 14:08:38', NULL, NULL, '1');
insert into specials (specials_id, products_id, specials_new_products_price, specials_date_added, specials_last_modified, expires_date, date_status_change, status) values ('7', '20', '35.0000', '2017-02-02 05:14:37', NULL, NULL, NULL, '1');
insert into specials (specials_id, products_id, specials_new_products_price, specials_date_added, specials_last_modified, expires_date, date_status_change, status) values ('8', '1', '150.0000', '2017-02-02 10:59:53', NULL, NULL, NULL, '1');
drop table if exists tax_class;
create table tax_class (
  tax_class_id int(11) not null auto_increment,
  tax_class_title varchar(32) not null ,
  tax_class_description varchar(255) not null ,
  last_modified datetime ,
  date_added datetime not null ,
  PRIMARY KEY (tax_class_id)
);

insert into tax_class (tax_class_id, tax_class_title, tax_class_description, last_modified, date_added) values ('1', 'Taxable Goods', 'The following types of products are included non-food, services, etc', '2017-01-24 11:09:54', '2017-01-24 11:09:54');
drop table if exists tax_rates;
create table tax_rates (
  tax_rates_id int(11) not null auto_increment,
  tax_zone_id int(11) not null ,
  tax_class_id int(11) not null ,
  tax_priority int(5) default '1' ,
  tax_rate decimal(7,4) not null ,
  tax_description varchar(255) not null ,
  last_modified datetime ,
  date_added datetime not null ,
  PRIMARY KEY (tax_rates_id)
);

insert into tax_rates (tax_rates_id, tax_zone_id, tax_class_id, tax_priority, tax_rate, tax_description, last_modified, date_added) values ('1', '1', '1', '1', '7.0000', 'FL TAX 7.0%', '2017-01-24 11:09:54', '2017-01-24 11:09:54');
drop table if exists testimonials;
create table testimonials (
  testimonials_id int(11) not null auto_increment,
  customers_name varchar(255) not null ,
  date_added datetime ,
  last_modified datetime ,
  testimonials_status tinyint(1) default '1' not null ,
  PRIMARY KEY (testimonials_id)
);

insert into testimonials (testimonials_id, customers_name, date_added, last_modified, testimonials_status) values ('2', 'Simon', '2017-01-26 10:55:23', NULL, '1');
insert into testimonials (testimonials_id, customers_name, date_added, last_modified, testimonials_status) values ('3', 'Picky', '2017-01-26 10:56:00', NULL, '1');
insert into testimonials (testimonials_id, customers_name, date_added, last_modified, testimonials_status) values ('5', 'Frank', '2017-01-26 13:42:51', '2017-01-26 13:42:57', '1');
insert into testimonials (testimonials_id, customers_name, date_added, last_modified, testimonials_status) values ('6', 'Georg', '2017-01-26 13:43:49', NULL, '1');
drop table if exists testimonials_description;
create table testimonials_description (
  testimonials_id int(11) not null ,
  languages_id int(11) not null ,
  testimonials_text text not null ,
  PRIMARY KEY (testimonials_id, languages_id)
);

insert into testimonials_description (testimonials_id, languages_id, testimonials_text) values ('2', '1', 'The products and service here is fantastic. I will definitely purchase from this store again.');
insert into testimonials_description (testimonials_id, languages_id, testimonials_text) values ('3', '1', 'Thanks for the great response for my orders, the delivery is always in time.

Kids just love it, thanks again.');
insert into testimonials_description (testimonials_id, languages_id, testimonials_text) values ('5', '1', 'Best purchase ever. These guys know how to provide a good service.

Thank you so much.');
insert into testimonials_description (testimonials_id, languages_id, testimonials_text) values ('6', '1', 'Will come back again!');
drop table if exists usu_cache;
create table usu_cache (
  cache_name varchar(64) not null ,
  cache_data mediumtext not null ,
  cache_date datetime not null ,
  UNIQUE cache_name (cache_name)
);

drop table if exists whos_online;
create table whos_online (
  customer_id int(11) ,
  full_name varchar(255) not null ,
  session_id varchar(128) not null ,
  ip_address varchar(15) not null ,
  time_entry varchar(14) not null ,
  time_last_click varchar(14) not null ,
  last_page_url text not null ,
  KEY idx_whos_online_session_id (session_id)
);

drop table if exists zones;
create table zones (
  zone_id int(11) not null auto_increment,
  zone_country_id int(11) not null ,
  zone_code varchar(32) not null ,
  zone_name varchar(255) not null ,
  PRIMARY KEY (zone_id),
  KEY idx_zones_country_id (zone_country_id)
);

insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('1', '223', 'AL', 'Alabama');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('2', '223', 'AK', 'Alaska');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('3', '223', 'AS', 'American Samoa');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('4', '223', 'AZ', 'Arizona');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('5', '223', 'AR', 'Arkansas');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('6', '223', 'AF', 'Armed Forces Africa');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('7', '223', 'AA', 'Armed Forces Americas');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('8', '223', 'AC', 'Armed Forces Canada');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('9', '223', 'AE', 'Armed Forces Europe');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('10', '223', 'AM', 'Armed Forces Middle East');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('11', '223', 'AP', 'Armed Forces Pacific');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('12', '223', 'CA', 'California');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('13', '223', 'CO', 'Colorado');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('14', '223', 'CT', 'Connecticut');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('15', '223', 'DE', 'Delaware');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('16', '223', 'DC', 'District of Columbia');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('17', '223', 'FM', 'Federated States Of Micronesia');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('18', '223', 'FL', 'Florida');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('19', '223', 'GA', 'Georgia');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('20', '223', 'GU', 'Guam');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('21', '223', 'HI', 'Hawaii');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('22', '223', 'ID', 'Idaho');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('23', '223', 'IL', 'Illinois');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('24', '223', 'IN', 'Indiana');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('25', '223', 'IA', 'Iowa');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('26', '223', 'KS', 'Kansas');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('27', '223', 'KY', 'Kentucky');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('28', '223', 'LA', 'Louisiana');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('29', '223', 'ME', 'Maine');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('30', '223', 'MH', 'Marshall Islands');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('31', '223', 'MD', 'Maryland');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('32', '223', 'MA', 'Massachusetts');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('33', '223', 'MI', 'Michigan');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('34', '223', 'MN', 'Minnesota');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('35', '223', 'MS', 'Mississippi');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('36', '223', 'MO', 'Missouri');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('37', '223', 'MT', 'Montana');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('38', '223', 'NE', 'Nebraska');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('39', '223', 'NV', 'Nevada');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('40', '223', 'NH', 'New Hampshire');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('41', '223', 'NJ', 'New Jersey');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('42', '223', 'NM', 'New Mexico');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('43', '223', 'NY', 'New York');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('44', '223', 'NC', 'North Carolina');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('45', '223', 'ND', 'North Dakota');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('46', '223', 'MP', 'Northern Mariana Islands');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('47', '223', 'OH', 'Ohio');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('48', '223', 'OK', 'Oklahoma');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('49', '223', 'OR', 'Oregon');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('50', '223', 'PW', 'Palau');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('51', '223', 'PA', 'Pennsylvania');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('52', '223', 'PR', 'Puerto Rico');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('53', '223', 'RI', 'Rhode Island');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('54', '223', 'SC', 'South Carolina');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('55', '223', 'SD', 'South Dakota');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('56', '223', 'TN', 'Tennessee');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('57', '223', 'TX', 'Texas');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('58', '223', 'UT', 'Utah');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('59', '223', 'VT', 'Vermont');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('60', '223', 'VI', 'Virgin Islands');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('61', '223', 'VA', 'Virginia');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('62', '223', 'WA', 'Washington');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('63', '223', 'WV', 'West Virginia');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('64', '223', 'WI', 'Wisconsin');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('65', '223', 'WY', 'Wyoming');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('66', '38', 'AB', 'Alberta');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('67', '38', 'BC', 'British Columbia');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('68', '38', 'MB', 'Manitoba');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('69', '38', 'NF', 'Newfoundland');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('70', '38', 'NB', 'New Brunswick');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('71', '38', 'NS', 'Nova Scotia');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('72', '38', 'NT', 'Northwest Territories');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('73', '38', 'NU', 'Nunavut');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('74', '38', 'ON', 'Ontario');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('75', '38', 'PE', 'Prince Edward Island');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('76', '38', 'QC', 'Quebec');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('77', '38', 'SK', 'Saskatchewan');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('78', '38', 'YT', 'Yukon Territory');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('79', '81', 'NDS', 'Niedersachsen');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('80', '81', 'BAW', 'Baden-Württemberg');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('81', '81', 'BAY', 'Bayern');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('82', '81', 'BER', 'Berlin');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('83', '81', 'BRG', 'Brandenburg');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('84', '81', 'BRE', 'Bremen');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('85', '81', 'HAM', 'Hamburg');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('86', '81', 'HES', 'Hessen');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('87', '81', 'MEC', 'Mecklenburg-Vorpommern');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('88', '81', 'NRW', 'Nordrhein-Westfalen');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('89', '81', 'RHE', 'Rheinland-Pfalz');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('90', '81', 'SAR', 'Saarland');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('91', '81', 'SAS', 'Sachsen');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('92', '81', 'SAC', 'Sachsen-Anhalt');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('93', '81', 'SCN', 'Schleswig-Holstein');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('94', '81', 'THE', 'Thüringen');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('95', '14', 'WI', 'Wien');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('96', '14', 'NO', 'Niederösterreich');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('97', '14', 'OO', 'Oberösterreich');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('98', '14', 'SB', 'Salzburg');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('99', '14', 'KN', 'Kärnten');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('100', '14', 'ST', 'Steiermark');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('101', '14', 'TI', 'Tirol');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('102', '14', 'BL', 'Burgenland');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('103', '14', 'VB', 'Voralberg');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('104', '204', 'AG', 'Aargau');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('105', '204', 'AI', 'Appenzell Innerrhoden');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('106', '204', 'AR', 'Appenzell Ausserrhoden');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('107', '204', 'BE', 'Bern');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('108', '204', 'BL', 'Basel-Landschaft');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('109', '204', 'BS', 'Basel-Stadt');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('110', '204', 'FR', 'Freiburg');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('111', '204', 'GE', 'Genf');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('112', '204', 'GL', 'Glarus');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('113', '204', 'JU', 'Graubünden');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('114', '204', 'JU', 'Jura');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('115', '204', 'LU', 'Luzern');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('116', '204', 'NE', 'Neuenburg');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('117', '204', 'NW', 'Nidwalden');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('118', '204', 'OW', 'Obwalden');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('119', '204', 'SG', 'St. Gallen');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('120', '204', 'SH', 'Schaffhausen');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('121', '204', 'SO', 'Solothurn');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('122', '204', 'SZ', 'Schwyz');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('123', '204', 'TG', 'Thurgau');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('124', '204', 'TI', 'Tessin');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('125', '204', 'UR', 'Uri');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('126', '204', 'VD', 'Waadt');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('127', '204', 'VS', 'Wallis');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('128', '204', 'ZG', 'Zug');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('129', '204', 'ZH', 'Zürich');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('130', '195', 'A Coruña', 'A Coruña');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('131', '195', 'Alava', 'Alava');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('132', '195', 'Albacete', 'Albacete');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('133', '195', 'Alicante', 'Alicante');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('134', '195', 'Almeria', 'Almeria');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('135', '195', 'Asturias', 'Asturias');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('136', '195', 'Avila', 'Avila');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('137', '195', 'Badajoz', 'Badajoz');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('138', '195', 'Baleares', 'Baleares');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('139', '195', 'Barcelona', 'Barcelona');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('140', '195', 'Burgos', 'Burgos');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('141', '195', 'Caceres', 'Caceres');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('142', '195', 'Cadiz', 'Cadiz');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('143', '195', 'Cantabria', 'Cantabria');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('144', '195', 'Castellon', 'Castellon');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('145', '195', 'Ceuta', 'Ceuta');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('146', '195', 'Ciudad Real', 'Ciudad Real');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('147', '195', 'Cordoba', 'Cordoba');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('148', '195', 'Cuenca', 'Cuenca');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('149', '195', 'Girona', 'Girona');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('150', '195', 'Granada', 'Granada');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('151', '195', 'Guadalajara', 'Guadalajara');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('152', '195', 'Guipuzcoa', 'Guipuzcoa');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('153', '195', 'Huelva', 'Huelva');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('154', '195', 'Huesca', 'Huesca');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('155', '195', 'Jaen', 'Jaen');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('156', '195', 'La Rioja', 'La Rioja');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('157', '195', 'Las Palmas', 'Las Palmas');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('158', '195', 'Leon', 'Leon');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('159', '195', 'Lleida', 'Lleida');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('160', '195', 'Lugo', 'Lugo');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('161', '195', 'Madrid', 'Madrid');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('162', '195', 'Malaga', 'Malaga');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('163', '195', 'Melilla', 'Melilla');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('164', '195', 'Murcia', 'Murcia');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('165', '195', 'Navarra', 'Navarra');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('166', '195', 'Ourense', 'Ourense');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('167', '195', 'Palencia', 'Palencia');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('168', '195', 'Pontevedra', 'Pontevedra');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('169', '195', 'Salamanca', 'Salamanca');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('170', '195', 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('171', '195', 'Segovia', 'Segovia');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('172', '195', 'Sevilla', 'Sevilla');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('173', '195', 'Soria', 'Soria');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('174', '195', 'Tarragona', 'Tarragona');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('175', '195', 'Teruel', 'Teruel');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('176', '195', 'Toledo', 'Toledo');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('177', '195', 'Valencia', 'Valencia');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('178', '195', 'Valladolid', 'Valladolid');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('179', '195', 'Vizcaya', 'Vizcaya');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('180', '195', 'Zamora', 'Zamora');
insert into zones (zone_id, zone_country_id, zone_code, zone_name) values ('181', '195', 'Zaragoza', 'Zaragoza');
drop table if exists zones_to_geo_zones;
create table zones_to_geo_zones (
  association_id int(11) not null auto_increment,
  zone_country_id int(11) not null ,
  zone_id int(11) ,
  geo_zone_id int(11) ,
  last_modified datetime ,
  date_added datetime not null ,
  PRIMARY KEY (association_id),
  KEY idx_zones_to_geo_zones_country_id (zone_country_id)
);

insert into zones_to_geo_zones (association_id, zone_country_id, zone_id, geo_zone_id, last_modified, date_added) values ('1', '0', NULL, '1', '2017-01-26 07:03:43', '2017-01-24 11:09:54');
