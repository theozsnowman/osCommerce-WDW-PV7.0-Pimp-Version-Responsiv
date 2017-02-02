SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

DROP TABLE IF EXISTS `action_recorder`;
CREATE TABLE `action_recorder` (
  `id` int(11) NOT NULL,
  `module` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `success` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book` (
  `address_book_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `entry_gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_firstname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entry_lastname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entry_street_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entry_suburb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_postcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entry_city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entry_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_country_id` int(11) NOT NULL DEFAULT '0',
  `entry_zone_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `address_format`;
CREATE TABLE `address_format` (
  `address_format_id` int(11) NOT NULL,
  `address_format` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `address_summary` varchar(48) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `address_format` (`address_format_id`, `address_format`, `address_summary`) VALUES
(1, '$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country', '$city / $country'),
(2, '$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country', '$city, $state / $country'),
(3, '$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country', '$state / $country'),
(4, '$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', '$postcode / $country'),
(5, '$firstname $lastname$cr$streets$cr$postcode $city$cr$country', '$city / $country');

DROP TABLE IF EXISTS `administrators`;
CREATE TABLE `administrators` (
  `id` int(11) NOT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_password` varchar(60) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners` (
  `banners_id` int(11) NOT NULL,
  `banners_title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `banners_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `banners_image` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `banners_group` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `banners_html_text` text COLLATE utf8_unicode_ci,
  `expires_impressions` int(7) DEFAULT '0',
  `expires_date` datetime DEFAULT NULL,
  `date_scheduled` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `date_status_change` datetime DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `banners_history`;
CREATE TABLE `banners_history` (
  `banners_history_id` int(11) NOT NULL,
  `banners_id` int(11) NOT NULL,
  `banners_shown` int(5) NOT NULL DEFAULT '0',
  `banners_clicked` int(5) NOT NULL DEFAULT '0',
  `banners_history_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `categories_id` int(11) NOT NULL,
  `categories_image` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(3) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `categories` (`categories_id`, `categories_image`, `parent_id`, `sort_order`, `date_added`, `last_modified`) VALUES
(1, 'category_hardware.gif', 0, 1, '2017-01-24 11:09:54', '2017-01-26 10:23:14'),
(2, 'category_software.gif', 0, 2, '2017-01-24 11:09:54', '2017-01-26 15:27:37'),
(3, 'category_dvd_movies.gif', 0, 3, '2017-01-24 11:09:54', '2017-01-26 15:27:52'),
(4, 'subcategory_graphic_cards.gif', 1, 0, '2017-01-24 11:09:54', NULL),
(5, 'subcategory_printers.gif', 1, 0, '2017-01-24 11:09:54', NULL),
(6, 'subcategory_monitors.gif', 1, 0, '2017-01-24 11:09:54', NULL),
(7, 'subcategory_speakers.gif', 1, 0, '2017-01-24 11:09:54', NULL),
(8, 'subcategory_keyboards.gif', 1, 0, '2017-01-24 11:09:54', NULL),
(9, 'subcategory_mice.gif', 1, 0, '2017-01-24 11:09:54', NULL),
(10, 'subcategory_action.gif', 3, 0, '2017-01-24 11:09:54', NULL),
(11, 'subcategory_science_fiction.gif', 3, 0, '2017-01-24 11:09:54', NULL),
(12, 'subcategory_comedy.gif', 3, 0, '2017-01-24 11:09:54', NULL),
(13, 'subcategory_cartoons.gif', 3, 0, '2017-01-24 11:09:54', NULL),
(14, 'subcategory_thriller.gif', 3, 0, '2017-01-24 11:09:54', NULL),
(15, 'subcategory_drama.gif', 3, 0, '2017-01-24 11:09:54', NULL),
(16, 'subcategory_memory.gif', 1, 0, '2017-01-24 11:09:54', NULL),
(17, 'subcategory_cdrom_drives.gif', 1, 0, '2017-01-24 11:09:54', NULL),
(18, 'subcategory_simulation.gif', 2, 0, '2017-01-24 11:09:54', NULL),
(19, 'subcategory_action_games.gif', 2, 0, '2017-01-24 11:09:54', NULL),
(20, 'subcategory_strategy.gif', 2, 0, '2017-01-24 11:09:54', '2017-01-25 06:26:15'),
(21, 'category_gadgets.png', 0, 4, '2017-01-24 11:09:54', '2017-01-26 15:28:55'),
(23, 'category_gadgets.png', 21, 0, '2017-01-26 15:32:36', '2017-01-26 15:34:02');

DROP TABLE IF EXISTS `categories_description`;
CREATE TABLE `categories_description` (
  `categories_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `categories_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `categories_description` text COLLATE utf8_unicode_ci,
  `categories_seo_description` text COLLATE utf8_unicode_ci,
  `categories_seo_keywords` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `categories_seo_title` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `categories_description` (`categories_id`, `language_id`, `categories_name`, `categories_description`, `categories_seo_description`, `categories_seo_keywords`, `categories_seo_title`) VALUES
(1, 1, 'Hardware', 'hardware test category description', '', '', ''),
(2, 1, 'Software', 'Software test category description', '', '', ''),
(3, 1, 'DVD Movies', 'DVD Movies test category description', '', '', ''),
(4, 1, 'Graphics Cards', NULL, NULL, NULL, NULL),
(5, 1, 'Printers', NULL, NULL, NULL, NULL),
(6, 1, 'Monitors', NULL, NULL, NULL, NULL),
(7, 1, 'Speakers', NULL, NULL, NULL, NULL),
(8, 1, 'Keyboards', NULL, NULL, NULL, NULL),
(9, 1, 'Mice', NULL, NULL, NULL, NULL),
(10, 1, 'Action', NULL, NULL, NULL, NULL),
(11, 1, 'Science Fiction', NULL, NULL, NULL, NULL),
(12, 1, 'Comedy', NULL, NULL, NULL, NULL),
(13, 1, 'Cartoons', NULL, NULL, NULL, NULL),
(14, 1, 'Thriller', NULL, NULL, NULL, NULL),
(15, 1, 'Drama', NULL, NULL, NULL, NULL),
(16, 1, 'Memory', NULL, NULL, NULL, NULL),
(17, 1, 'CDROM Drives', NULL, NULL, NULL, NULL),
(18, 1, 'Simulation', NULL, NULL, NULL, NULL),
(19, 1, 'Action', NULL, NULL, NULL, NULL),
(20, 1, 'Strategy', 'Strategy Test Categorie description', '', '', ''),
(21, 1, 'Gadgets', 'Gadgets test category description', '', '', ''),
(23, 1, 'Tablets', 'Tablets test category description', '', '', '');

DROP TABLE IF EXISTS `configuration`;
CREATE TABLE `configuration` (
  `configuration_id` int(11) NOT NULL,
  `configuration_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `configuration_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `configuration_value` text COLLATE utf8_unicode_ci NOT NULL,
  `configuration_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `configuration_group_id` int(11) NOT NULL,
  `sort_order` int(5) DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `use_function` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `set_function` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `configuration` (`configuration_id`, `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES
(1, 'Store Name', 'STORE_NAME', '', 'The name of my store', 1, 1, '2017-01-30 06:27:42', '2017-01-24 11:09:54', NULL, NULL),
(2, 'Store Owner', 'STORE_OWNER', '', 'The name of my store owner', 1, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(3, 'E-Mail Address', 'STORE_OWNER_EMAIL_ADDRESS', '', 'The e-mail address of my store owner', 1, 3, '2017-01-24 14:09:17', '2017-01-24 11:09:54', NULL, NULL),
(4, 'E-Mail From', 'EMAIL_FROM', '', 'The e-mail address used in (sent) e-mails', 1, 4, '2017-01-24 14:09:52', '2017-01-24 11:09:54', NULL, NULL),
(5, 'Country', 'STORE_COUNTRY', '223', 'The country my store is located in <br /><br /><strong>Note: Please remember to update the store zone.</strong>', 1, 6, NULL, '2017-01-24 11:09:54', 'tep_get_country_name', 'tep_cfg_pull_down_country_list('),
(6, 'Zone', 'STORE_ZONE', '18', 'The zone my store is located in', 1, 7, NULL, '2017-01-24 11:09:54', 'tep_cfg_get_zone_name', 'tep_cfg_pull_down_zone_list('),
(7, 'Switch To Default Language Currency', 'USE_DEFAULT_LANGUAGE_CURRENCY', 'false', 'Automatically switch to the language\'s currency when it is changed', 1, 10, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(8, 'Send Extra Order Emails To', 'SEND_EXTRA_ORDER_EMAILS_TO', '', 'Send extra order emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 1, 11, NULL, '2017-01-24 11:09:54', NULL, NULL),
(9, 'Use Search-Engine Safe URLs', 'SEARCH_ENGINE_FRIENDLY_URLS', 'false', 'Use search-engine safe urls for all site links', 1, 12, '2017-01-24 15:54:13', '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(10, 'Display Cart After Adding Product', 'DISPLAY_CART', 'true', 'Display the shopping cart after adding a product (or return back to their origin)', 1, 14, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(11, 'Allow Guest To Tell A Friend', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 'false', 'Allow guests to tell a friend about a product', 1, 15, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(12, 'Default Search Operator', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 'and', 'Default search operators', 1, 17, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'and\', \'or\'), '),
(13, 'Store Address', 'STORE_ADDRESS', 'Address Line 1\nAddress Line 2\nCountry\nPhone', 'This is the Address of my store used on printable documents and displayed online', 1, 18, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_textarea('),
(14, 'Store Phone', 'STORE_PHONE', '555-1234', 'This is the phone number of my store used on printable documents and displayed online', 1, 19, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_textarea('),
(15, 'Tax Decimal Places', 'TAX_DECIMAL_PLACES', '2', 'Pad the tax value this amount of decimal places', 1, 20, '2017-01-30 10:01:15', '2017-01-24 11:09:54', NULL, NULL),
(16, 'Display Prices with Tax', 'DISPLAY_PRICE_WITH_TAX', 'true', 'Display prices with tax included (true) or add the tax at the end (false)', 1, 21, '2017-02-01 14:10:29', '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(17, 'First Name', 'ENTRY_FIRST_NAME_MIN_LENGTH', '2', 'Minimum length of first name', 2, 1, NULL, '2017-01-24 11:09:54', NULL, NULL),
(18, 'Last Name', 'ENTRY_LAST_NAME_MIN_LENGTH', '2', 'Minimum length of last name', 2, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(19, 'Date of Birth', 'ENTRY_DOB_MIN_LENGTH', '10', 'Minimum length of date of birth', 2, 3, NULL, '2017-01-24 11:09:54', NULL, NULL),
(20, 'E-Mail Address', 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', '6', 'Minimum length of e-mail address', 2, 4, NULL, '2017-01-24 11:09:54', NULL, NULL),
(21, 'Street Address', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', '5', 'Minimum length of street address', 2, 5, NULL, '2017-01-24 11:09:54', NULL, NULL),
(22, 'Company', 'ENTRY_COMPANY_MIN_LENGTH', '2', 'Minimum length of company name', 2, 6, NULL, '2017-01-24 11:09:54', NULL, NULL),
(23, 'Post Code', 'ENTRY_POSTCODE_MIN_LENGTH', '4', 'Minimum length of post code', 2, 7, NULL, '2017-01-24 11:09:54', NULL, NULL),
(24, 'City', 'ENTRY_CITY_MIN_LENGTH', '3', 'Minimum length of city', 2, 8, NULL, '2017-01-24 11:09:54', NULL, NULL),
(25, 'State', 'ENTRY_STATE_MIN_LENGTH', '2', 'Minimum length of state', 2, 9, NULL, '2017-01-24 11:09:54', NULL, NULL),
(26, 'Telephone Number', 'ENTRY_TELEPHONE_MIN_LENGTH', '3', 'Minimum length of telephone number', 2, 10, NULL, '2017-01-24 11:09:54', NULL, NULL),
(27, 'Password', 'ENTRY_PASSWORD_MIN_LENGTH', '5', 'Minimum length of password', 2, 11, NULL, '2017-01-24 11:09:54', NULL, NULL),
(28, 'Credit Card Owner Name', 'CC_OWNER_MIN_LENGTH', '3', 'Minimum length of credit card owner name', 2, 12, NULL, '2017-01-24 11:09:54', NULL, NULL),
(29, 'Credit Card Number', 'CC_NUMBER_MIN_LENGTH', '10', 'Minimum length of credit card number', 2, 13, NULL, '2017-01-24 11:09:54', NULL, NULL),
(30, 'Review Text', 'REVIEW_TEXT_MIN_LENGTH', '50', 'Minimum length of review text', 2, 14, NULL, '2017-01-24 11:09:54', NULL, NULL),
(31, 'Best Sellers', 'MIN_DISPLAY_BESTSELLERS', '1', 'Minimum number of best sellers to display', 2, 15, NULL, '2017-01-24 11:09:54', NULL, NULL),
(32, 'Also Purchased', 'MIN_DISPLAY_ALSO_PURCHASED', '1', 'Minimum number of products to display in the \'This Customer Also Purchased\' box', 2, 16, NULL, '2017-01-24 11:09:54', NULL, NULL),
(33, 'Address Book Entries', 'MAX_ADDRESS_BOOK_ENTRIES', '5', 'Maximum address book entries a customer is allowed to have', 3, 1, NULL, '2017-01-24 11:09:54', NULL, NULL),
(34, 'Search Results', 'MAX_DISPLAY_SEARCH_RESULTS', '50', 'Amount of products to list', 3, 2, '2017-02-01 14:34:58', '2017-01-24 11:09:54', NULL, NULL),
(35, 'Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Number of \'number\' links use for page-sets', 3, 3, NULL, '2017-01-24 11:09:54', NULL, NULL),
(36, 'Special Products', 'MAX_DISPLAY_SPECIAL_PRODUCTS', '9', 'Maximum number of products on special to display', 3, 4, NULL, '2017-01-24 11:09:54', NULL, NULL),
(37, 'Manufacturers List', 'MAX_DISPLAY_MANUFACTURERS_IN_A_LIST', '0', 'Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list', 3, 7, NULL, '2017-01-24 11:09:54', NULL, NULL),
(38, 'Manufacturers Select Size', 'MAX_MANUFACTURERS_LIST', '1', 'Used in manufacturers box; when this value is \'1\' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.', 3, 7, NULL, '2017-01-24 11:09:54', NULL, NULL),
(39, 'Length of Manufacturers Name', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', '15', 'Used in manufacturers box; maximum length of manufacturers name to display', 3, 8, NULL, '2017-01-24 11:09:54', NULL, NULL),
(40, 'New Reviews', 'MAX_DISPLAY_NEW_REVIEWS', '6', 'Maximum number of new reviews to display', 3, 9, NULL, '2017-01-24 11:09:54', NULL, NULL),
(41, 'Selection of Random Reviews', 'MAX_RANDOM_SELECT_REVIEWS', '10', 'How many records to select from to choose one random product review', 3, 10, NULL, '2017-01-24 11:09:54', NULL, NULL),
(42, 'Selection of Random New Products', 'MAX_RANDOM_SELECT_NEW', '10', 'How many records to select from to choose one random new product to display', 3, 11, NULL, '2017-01-24 11:09:54', NULL, NULL),
(43, 'Selection of Products on Special', 'MAX_RANDOM_SELECT_SPECIALS', '10', 'How many records to select from to choose one random product special to display', 3, 12, NULL, '2017-01-24 11:09:54', NULL, NULL),
(44, 'Categories To List Per Row', 'MAX_DISPLAY_CATEGORIES_PER_ROW', '3', 'How many categories to list per row', 3, 13, NULL, '2017-01-24 11:09:54', NULL, NULL),
(45, 'New Products Listing', 'MAX_DISPLAY_PRODUCTS_NEW', '10', 'Maximum number of new products to display in new products page', 3, 14, NULL, '2017-01-24 11:09:54', NULL, NULL),
(46, 'Best Sellers', 'MAX_DISPLAY_BESTSELLERS', '10', 'Maximum number of best sellers to display', 3, 15, NULL, '2017-01-24 11:09:54', NULL, NULL),
(47, 'Also Purchased', 'MAX_DISPLAY_ALSO_PURCHASED', '6', 'Maximum number of products to display in the \'This Customer Also Purchased\' box', 3, 16, NULL, '2017-01-24 11:09:54', NULL, NULL),
(48, 'Customer Order History Box', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', '6', 'Maximum number of products to display in the customer order history box', 3, 17, NULL, '2017-01-24 11:09:54', NULL, NULL),
(49, 'Order History', 'MAX_DISPLAY_ORDER_HISTORY', '10', 'Maximum number of orders to display in the order history page', 3, 18, NULL, '2017-01-24 11:09:54', NULL, NULL),
(50, 'Product Quantities In Shopping Cart', 'MAX_QTY_IN_CART', '99', 'Maximum number of product quantities that can be added to the shopping cart (0 for no limit)', 3, 19, NULL, '2017-01-24 11:09:54', NULL, NULL),
(51, 'Small Image Width', 'SMALL_IMAGE_WIDTH', '100', 'The pixel width of small images', 4, 1, NULL, '2017-01-24 11:09:54', NULL, NULL),
(52, 'Small Image Height', 'SMALL_IMAGE_HEIGHT', '80', 'The pixel height of small images', 4, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(53, 'Heading Image Width', 'HEADING_IMAGE_WIDTH', '57', 'The pixel width of heading images', 4, 3, NULL, '2017-01-24 11:09:54', NULL, NULL),
(54, 'Heading Image Height', 'HEADING_IMAGE_HEIGHT', '40', 'The pixel height of heading images', 4, 4, NULL, '2017-01-24 11:09:54', NULL, NULL),
(55, 'Subcategory Image Width', 'SUBCATEGORY_IMAGE_WIDTH', '100', 'The pixel width of subcategory images', 4, 5, NULL, '2017-01-24 11:09:54', NULL, NULL),
(56, 'Subcategory Image Height', 'SUBCATEGORY_IMAGE_HEIGHT', '57', 'The pixel height of subcategory images', 4, 6, NULL, '2017-01-24 11:09:54', NULL, NULL),
(57, 'Calculate Image Size', 'CONFIG_CALCULATE_IMAGE_SIZE', 'true', 'Calculate the size of images?', 4, 7, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(58, 'Image Required', 'IMAGE_REQUIRED', 'true', 'Enable to display broken images. Good for development.', 4, 8, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(59, 'Gender', 'ACCOUNT_GENDER', 'true', 'Display gender in the customers account', 5, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(60, 'Date of Birth', 'ACCOUNT_DOB', 'true', 'Display date of birth in the customers account', 5, 2, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(61, 'Company', 'ACCOUNT_COMPANY', 'true', 'Display company in the customers account', 5, 3, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(62, 'Suburb', 'ACCOUNT_SUBURB', 'true', 'Display suburb in the customers account', 5, 4, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(63, 'State', 'ACCOUNT_STATE', 'true', 'Display state in the customers account', 5, 5, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(64, 'Installed Modules', 'MODULE_PAYMENT_INSTALLED', 'cod.php;paypal_express.php', 'List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cod.php;paypal_express.php)', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(65, 'Installed Modules', 'MODULE_ORDER_TOTAL_INSTALLED', 'ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php', 'List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(66, 'Installed Modules', 'MODULE_SHIPPING_INSTALLED', 'flat.php', 'List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(67, 'Installed Modules', 'MODULE_ACTION_RECORDER_INSTALLED', 'ar_admin_login.php;ar_contact_us.php;ar_reset_password.php;ar_tell_a_friend.php', 'List of action recorder module filenames separated by a semi-colon. This is automatically updated. No need to edit.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(68, 'Installed Modules', 'MODULE_SOCIAL_BOOKMARKS_INSTALLED', 'sb_email.php;sb_facebook.php;sb_google_plus_share.php;sb_pinterest.php;sb_twitter.php', 'List of social bookmark module filenames separated by a semi-colon. This is automatically updated. No need to edit.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(69, 'Installed Modules', 'MODULE_CONTENT_NAVBAR_INSTALLED', 'nb_hamburger_button.php;nb_home.php;nb_new_products.php;nb_special_offers.php;nb_testimonials.php;nb_mailchimp_newsletter.php;nb_account.php;nb_reviews.php;nb_shopping_cart.php', 'List of navbar module filenames separated by a semi-colon. This is automatically updated. No need to edit.', 6, 0, '2017-01-26 07:57:23', '2017-01-24 11:09:54', NULL, NULL),
(70, 'Enable Cash On Delivery Module', 'MODULE_PAYMENT_COD_STATUS', 'True', 'Do you want to accept Cash On Delevery payments?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(71, 'Payment Zone', 'MODULE_PAYMENT_COD_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', 6, 2, NULL, '2017-01-24 11:09:54', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes('),
(72, 'Sort order of display.', 'MODULE_PAYMENT_COD_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(73, 'Set Order Status', 'MODULE_PAYMENT_COD_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', 6, 0, NULL, '2017-01-24 11:09:54', 'tep_get_order_status_name', 'tep_cfg_pull_down_order_statuses('),
(74, 'Enable Flat Shipping', 'MODULE_SHIPPING_FLAT_STATUS', 'True', 'Do you want to offer flat rate shipping?', 6, 0, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(75, 'Shipping Cost', 'MODULE_SHIPPING_FLAT_COST', '5.00', 'The shipping cost for all orders using this shipping method.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(76, 'Tax Class', 'MODULE_SHIPPING_FLAT_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', 6, 0, NULL, '2017-01-24 11:09:54', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes('),
(77, 'Shipping Zone', 'MODULE_SHIPPING_FLAT_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', 6, 0, NULL, '2017-01-24 11:09:54', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes('),
(78, 'Sort Order', 'MODULE_SHIPPING_FLAT_SORT_ORDER', '0', 'Sort order of display.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(79, 'Default Currency', 'DEFAULT_CURRENCY', 'USD', 'Default Currency', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(80, 'Default Language', 'DEFAULT_LANGUAGE', 'en', 'Default Language', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(81, 'Default Order Status For New Orders', 'DEFAULT_ORDERS_STATUS_ID', '1', 'When a new order is created, this order status will be assigned to it.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(82, 'Display Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 'true', 'Do you want to display the order shipping cost?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(83, 'Sort Order', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', '2', 'Sort order of display.', 6, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(84, 'Allow Free Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', 'Do you want to allow free shipping?', 6, 3, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(85, 'Free Shipping For Orders Over', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '50', 'Provide free shipping for orders over the set amount.', 6, 4, NULL, '2017-01-24 11:09:54', 'currencies->format', NULL),
(86, 'Provide Free Shipping For Orders Made', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', 'Provide free shipping for orders sent to the set destination.', 6, 5, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'national\', \'international\', \'both\'), '),
(87, 'Display Sub-Total', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 'true', 'Do you want to display the order sub-total cost?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(88, 'Sort Order', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', '1', 'Sort order of display.', 6, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(89, 'Display Tax', 'MODULE_ORDER_TOTAL_TAX_STATUS', 'true', 'Do you want to display the order tax value?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(90, 'Sort Order', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', '3', 'Sort order of display.', 6, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(91, 'Display Total', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 'true', 'Do you want to display the total order value?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(92, 'Sort Order', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', '4', 'Sort order of display.', 6, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(93, 'Minimum Minutes Per E-Mail', 'MODULE_ACTION_RECORDER_CONTACT_US_EMAIL_MINUTES', '15', 'Minimum number of minutes to allow 1 e-mail to be sent (eg, 15 for 1 e-mail every 15 minutes)', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(94, 'Minimum Minutes Per E-Mail', 'MODULE_ACTION_RECORDER_TELL_A_FRIEND_EMAIL_MINUTES', '15', 'Minimum number of minutes to allow 1 e-mail to be sent (eg, 15 for 1 e-mail every 15 minutes)', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(95, 'Allowed Minutes', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_MINUTES', '5', 'Number of minutes to allow login attempts to occur.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(96, 'Allowed Attempts', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_ATTEMPTS', '3', 'Number of login attempts to allow within the specified period.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(97, 'Allowed Minutes', 'MODULE_ACTION_RECORDER_RESET_PASSWORD_MINUTES', '5', 'Number of minutes to allow password resets to occur.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(98, 'Allowed Attempts', 'MODULE_ACTION_RECORDER_RESET_PASSWORD_ATTEMPTS', '1', 'Number of password reset attempts to allow within the specified period.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(99, 'Enable E-Mail Module', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_STATUS', 'True', 'Do you want to allow products to be shared through e-mail?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(100, 'Sort Order', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(101, 'Enable Google+ Share Module', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_STATUS', 'True', 'Do you want to allow products to be shared through Google+?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(102, 'Annotation', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_ANNOTATION', 'None', 'The annotation to display next to the button.', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Inline\', \'Bubble\', \'Vertical-Bubble\', \'None\'), '),
(103, 'Width', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_WIDTH', '', 'The maximum width of the button.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(104, 'Height', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_HEIGHT', '15', 'Sets the height of the button.', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'15\', \'20\', \'24\', \'60\'), '),
(105, 'Alignment', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_ALIGN', 'Left', 'The alignment of the button assets.', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\'), '),
(106, 'Sort Order', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_SORT_ORDER', '20', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(107, 'Enable Facebook Module', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_STATUS', 'True', 'Do you want to allow products to be shared through Facebook?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(108, 'Sort Order', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_SORT_ORDER', '30', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(109, 'Enable Twitter Module', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_STATUS', 'True', 'Do you want to allow products to be shared through Twitter?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(110, 'Sort Order', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(111, 'Enable Pinterest Module', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_STATUS', 'True', 'Do you want to allow Pinterest Button?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(112, 'Layout Position', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_BUTTON_COUNT_POSITION', 'None', 'Horizontal or Vertical or None', 6, 2, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Horizontal\', \'Vertical\', \'None\'), '),
(113, 'Sort Order', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_SORT_ORDER', '50', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(114, 'Country of Origin', 'SHIPPING_ORIGIN_COUNTRY', '223', 'Select the country of origin to be used in shipping quotes.', 7, 1, NULL, '2017-01-24 11:09:54', 'tep_get_country_name', 'tep_cfg_pull_down_country_list('),
(115, 'Postal Code', 'SHIPPING_ORIGIN_ZIP', 'NONE', 'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.', 7, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(116, 'Enter the Maximum Package Weight you will ship', 'SHIPPING_MAX_WEIGHT', '50', 'Carriers have a max weight limit for a single package. This is a common one for all.', 7, 3, NULL, '2017-01-24 11:09:54', NULL, NULL),
(117, 'Package Tare weight.', 'SHIPPING_BOX_WEIGHT', '3', 'What is the weight of typical packaging of small to medium packages?', 7, 4, NULL, '2017-01-24 11:09:54', NULL, NULL),
(118, 'Larger packages - percentage increase.', 'SHIPPING_BOX_PADDING', '10', 'For 10% enter 10', 7, 5, NULL, '2017-01-24 11:09:54', NULL, NULL),
(119, 'Allow Orders Not Matching Defined Shipping Zones ', 'SHIPPING_ALLOW_UNDEFINED_ZONES', 'False', 'Should orders be allowed to shipping addresses not matching defined shipping module shipping zones?', 7, 5, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(120, 'Display Product Image (0=disable; 1=enable)', 'PRODUCT_LIST_IMAGE', '1', 'Do you want to display the Product Image?', 8, 1, NULL, '2017-01-24 11:09:54', NULL, NULL),
(121, 'Display Product Manufacturer Name (0=disable; 1=enable)', 'PRODUCT_LIST_MANUFACTURER', '0', 'Do you want to display the Product Manufacturer Name?', 8, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(122, 'Display Product Model (0=disable; 1=enable)', 'PRODUCT_LIST_MODEL', '0', 'Do you want to display the Product Model?', 8, 3, NULL, '2017-01-24 11:09:54', NULL, NULL),
(123, 'Display Product Name (0=disable; 1=enable)', 'PRODUCT_LIST_NAME', '1', 'Do you want to display the Product Name?', 8, 4, NULL, '2017-01-24 11:09:54', NULL, NULL),
(124, 'Display Product Price (0=disable; 1=enable)', 'PRODUCT_LIST_PRICE', '1', 'Do you want to display the Product Price', 8, 5, NULL, '2017-01-24 11:09:54', NULL, NULL),
(125, 'Display Product Quantity (0=disable; 1=enable)', 'PRODUCT_LIST_QUANTITY', '0', 'Do you want to display the Product Quantity?', 8, 6, NULL, '2017-01-24 11:09:54', NULL, NULL),
(126, 'Display Product Weight (0=disable; 1=enable)', 'PRODUCT_LIST_WEIGHT', '0', 'Do you want to display the Product Weight?', 8, 7, NULL, '2017-01-24 11:09:54', NULL, NULL),
(127, 'Display Buy Now column (0=disable; 1=enable)', 'PRODUCT_LIST_BUY_NOW', '1', 'Do you want to display the Buy Now column?', 8, 8, NULL, '2017-01-24 11:09:54', NULL, NULL),
(128, 'Display Category/Manufacturer Filter (0=disable; 1=enable)', 'PRODUCT_LIST_FILTER', '1', 'Do you want to display the Category/Manufacturer Filter?', 8, 9, NULL, '2017-01-24 11:09:54', NULL, NULL),
(129, 'Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 'PREV_NEXT_BAR_LOCATION', '2', 'Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 8, 10, NULL, '2017-01-24 11:09:54', NULL, NULL),
(130, 'Check stock level', 'STOCK_CHECK', 'true', 'Check to see if sufficent stock is available', 9, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(131, 'Subtract stock', 'STOCK_LIMITED', 'true', 'Subtract product in stock by product orders', 9, 2, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(132, 'Allow Checkout', 'STOCK_ALLOW_CHECKOUT', 'true', 'Allow customer to checkout even if there is insufficient stock', 9, 3, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(133, 'Mark product out of stock', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '***', 'Display something on screen so customer can see which product has insufficient stock', 9, 4, NULL, '2017-01-24 11:09:54', NULL, NULL),
(134, 'Stock Re-order level', 'STOCK_REORDER_LEVEL', '5', 'Define when stock needs to be re-ordered', 9, 5, NULL, '2017-01-24 11:09:54', NULL, NULL),
(135, 'Store Page Parse Time', 'STORE_PAGE_PARSE_TIME', 'false', 'Store the time it takes to parse a page', 10, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(136, 'Log Destination', 'STORE_PAGE_PARSE_TIME_LOG', '/var/log/www/tep/page_parse_time.log', 'Directory and filename of the page parse time log', 10, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(137, 'Log Date Format', 'STORE_PARSE_DATE_TIME_FORMAT', '%d/%m/%Y %H:%M:%S', 'The date format', 10, 3, NULL, '2017-01-24 11:09:54', NULL, NULL),
(138, 'Display The Page Parse Time', 'DISPLAY_PAGE_PARSE_TIME', 'true', 'Display the page parse time (store page parse time must be enabled)', 10, 4, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(139, 'Store Database Queries', 'STORE_DB_TRANSACTIONS', 'false', 'Store the database queries in the page parse time log', 10, 5, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(140, 'Use Cache', 'USE_CACHE', 'false', 'Use caching features', 11, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(141, 'Cache Directory', 'DIR_FS_CACHE', '', 'The directory where the cached files are saved', 11, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(142, 'E-Mail Transport Method', 'EMAIL_TRANSPORT', 'sendmail', 'Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.', 12, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'sendmail\', \'smtp\'),'),
(143, 'E-Mail Linefeeds', 'EMAIL_LINEFEED', 'LF', 'Defines the character sequence used to separate mail headers.', 12, 2, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'LF\', \'CRLF\'),'),
(144, 'Use MIME HTML When Sending Emails', 'EMAIL_USE_HTML', 'false', 'Send e-mails in HTML format', 12, 3, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'),'),
(145, 'Verify E-Mail Addresses Through DNS', 'ENTRY_EMAIL_ADDRESS_CHECK', 'false', 'Verify e-mail address through a DNS server', 12, 4, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(146, 'Send E-Mails', 'SEND_EMAILS', 'true', 'Send out e-mails', 12, 5, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(147, 'Enable download', 'DOWNLOAD_ENABLED', 'false', 'Enable the products download functions.', 13, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(148, 'Download by redirect', 'DOWNLOAD_BY_REDIRECT', 'false', 'Use browser redirection for download. Disable on non-Unix systems.', 13, 2, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(149, 'Expiry delay (days)', 'DOWNLOAD_MAX_DAYS', '7', 'Set number of days before the download link expires. 0 means no limit.', 13, 3, NULL, '2017-01-24 11:09:54', NULL, ''),
(150, 'Maximum number of downloads', 'DOWNLOAD_MAX_COUNT', '5', 'Set the maximum number of downloads. 0 means no download authorized.', 13, 4, NULL, '2017-01-24 11:09:54', NULL, ''),
(151, 'Enable GZip Compression', 'GZIP_COMPRESSION', 'false', 'Enable HTTP GZip compression.', 14, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(152, 'Compression Level', 'GZIP_LEVEL', '5', 'Use this compression level 0-9 (0 = minimum, 9 = maximum).', 14, 2, NULL, '2017-01-24 11:09:54', NULL, NULL),
(153, 'Session Directory', 'SESSION_WRITE_DIRECTORY', '', 'If sessions are file based, store them in this directory.', 15, 1, NULL, '2017-01-24 11:09:54', NULL, NULL),
(154, 'Force Cookie Use', 'SESSION_FORCE_COOKIE_USE', 'False', 'Force the use of sessions when cookies are only enabled.', 15, 2, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(155, 'Check SSL Session ID', 'SESSION_CHECK_SSL_SESSION_ID', 'False', 'Validate the SSL_SESSION_ID on every secure HTTPS page request.', 15, 3, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(156, 'Check User Agent', 'SESSION_CHECK_USER_AGENT', 'False', 'Validate the clients browser user agent on every page request.', 15, 4, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(157, 'Check IP Address', 'SESSION_CHECK_IP_ADDRESS', 'False', 'Validate the clients IP address on every page request.', 15, 5, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(158, 'Prevent Spider Sessions', 'SESSION_BLOCK_SPIDERS', 'True', 'Prevent known spiders from starting a session.', 15, 6, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(159, 'Recreate Session', 'SESSION_RECREATE', 'True', 'Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).', 15, 7, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(160, 'Last Update Check Time', 'LAST_UPDATE_CHECK_TIME', '', 'Last time a check for new versions of osCommerce was run', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(161, 'Store Logo', 'STORE_LOGO', 'store_logo.png', 'This is the filename of your Store Logo.  This should be updated at admin > configuration > Store Logo', 6, 1000, NULL, '2017-01-24 11:09:54', NULL, NULL),
(162, 'Bootstrap Container', 'BOOTSTRAP_CONTAINER', 'container-fluid', 'What type of container should the page content be shown in? See http://getbootstrap.com/css/#overview-container', 16, 1, '2017-02-01 14:24:24', '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'container-fluid\', \'container\'), '),
(163, 'Bootstrap Content', 'BOOTSTRAP_CONTENT', '8', 'What width should the page content default to?  (8 = two thirds width, 6 = half width, 4 = one third width) Note that the Side Column(s) will adjust automatically.', 16, 2, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'8\', \'6\', \'4\'), '),
(182, 'Installed Modules', 'MODULE_HEADER_TAGS_INSTALLED', 'ht_div_equal_heights.php;ht_owl_carousel.php;ht_category_title.php;ht_product_title.php;ht_canonical.php;ht_robot_noindex.php;ht_datepicker_jquery.php;ht_grid_list_view.php;ht_table_click_jquery.php;ht_mailchimp.php;ht_manufacturer_title.php;ht_noscript.php;ht_product_colorbox.php', 'List of header tag module filenames separated by a semi-colon. This is automatically updated. No need to edit.', 6, 0, '2017-01-26 09:00:01', '2017-01-24 11:09:54', NULL, NULL),
(183, 'Enable Category Title Module', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_STATUS', 'True', 'Do you want to allow category titles to be added to the page title?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(184, 'Sort Order', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(185, 'SEO Title Override?', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_SEO_TITLE_OVERRIDE', 'True', 'Do you want to allow category titles to be over-ridden by your SEO Titles (if set)?', 6, 0, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(186, 'SEO Breadcrumb Override?', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_SEO_BREADCRUMB_OVERRIDE', 'True', 'Do you want to allow category names in the breadcrumb to be over-ridden by your SEO Titles (if set)?', 6, 0, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(187, 'Enable Manufacturer Title Module', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_STATUS', 'True', 'Do you want to allow manufacturer titles to be added to the page title?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(188, 'Sort Order', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(189, 'SEO Title Override?', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_SEO_TITLE_OVERRIDE', 'True', 'Do you want to allow manufacturer names to be over-ridden by your SEO Titles (if set)?', 6, 0, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(190, 'SEO Breadcrumb Override?', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_SEO_BREADCRUMB_OVERRIDE', 'True', 'Do you want to allow manufacturer names in the breadcrumb to be over-ridden by your SEO Titles (if set)?', 6, 0, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(191, 'Enable Product Title Module', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_STATUS', 'True', 'Do you want to allow product titles to be added to the page title?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(192, 'Sort Order', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_SORT_ORDER', '300', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(193, 'SEO Title Override?', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_SEO_TITLE_OVERRIDE', 'True', 'Do you want to allow product titles to be over-ridden by your SEO Titles (if set)?', 6, 0, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(194, 'SEO Breadcrumb Override?', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_SEO_BREADCRUMB_OVERRIDE', 'True', 'Do you want to allow product names in the breadcrumb to be over-ridden by your SEO Titles (if set)?', 6, 0, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(195, 'Enable Canonical Module', 'MODULE_HEADER_TAGS_CANONICAL_STATUS', 'True', 'Do you want to enable the Canonical module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(196, 'Sort Order', 'MODULE_HEADER_TAGS_CANONICAL_SORT_ORDER', '400', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(197, 'Enable Robot NoIndex Module', 'MODULE_HEADER_TAGS_ROBOT_NOINDEX_STATUS', 'True', 'Do you want to enable the Robot NoIndex module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(198, 'Pages', 'MODULE_HEADER_TAGS_ROBOT_NOINDEX_PAGES', 'account.php;account_edit.php;account_history.php;account_history_info.php;account_newsletters.php;account_notifications.php;account_password.php;address_book.php;address_book_process.php;checkout_confirmation.php;checkout_payment.php;checkout_payment_address.php;checkout_process.php;checkout_shipping.php;checkout_shipping_address.php;checkout_success.php;cookie_usage.php;create_account.php;create_account_success.php;login.php;logoff.php;password_forgotten.php;password_reset.php;product_reviews_write.php;shopping_cart.php;ssl_check.php;tell_a_friend.php', 'The pages to add the meta robot noindex tag to.', 6, 0, NULL, '2017-01-24 11:09:54', 'ht_robot_noindex_show_pages', 'ht_robot_noindex_edit_pages('),
(199, 'Sort Order', 'MODULE_HEADER_TAGS_ROBOT_NOINDEX_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(200, 'Enable No Script Module', 'MODULE_HEADER_TAGS_NOSCRIPT_STATUS', 'True', 'Add message for people with .js turned off?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(201, 'Sort Order', 'MODULE_HEADER_TAGS_NOSCRIPT_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(202, 'Enable Datepicker jQuery Module', 'MODULE_HEADER_TAGS_DATEPICKER_JQUERY_STATUS', 'True', 'Do you want to enable the Datepicker module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(203, 'Pages', 'MODULE_HEADER_TAGS_DATEPICKER_JQUERY_PAGES', 'advanced_search.php;account_edit.php;create_account.php', 'The pages to add the Datepicker jQuery Scripts to.', 6, 0, NULL, '2017-01-24 11:09:54', 'ht_datepicker_jquery_show_pages', 'ht_datepicker_jquery_edit_pages('),
(204, 'Sort Order', 'MODULE_HEADER_TAGS_DATEPICKER_JQUERY_SORT_ORDER', '600', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(205, 'Enable Grid List javascript', 'MODULE_HEADER_TAGS_GRID_LIST_VIEW_STATUS', 'True', 'Do you want to enable the Grid/List Javascript module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(206, 'Pages', 'MODULE_HEADER_TAGS_GRID_LIST_VIEW_PAGES', 'advanced_search_result.php;index.php;products_new.php;specials.php', 'The pages to add the Grid List JS Scripts to.', 6, 0, NULL, '2017-01-24 11:09:54', 'ht_grid_list_view_show_pages', 'ht_grid_list_view_edit_pages('),
(207, 'Sort Order', 'MODULE_HEADER_TAGS_GRID_LIST_VIEW_SORT_ORDER', '700', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(208, 'Enable Clickable Table Rows Module', 'MODULE_HEADER_TAGS_TABLE_CLICK_JQUERY_STATUS', 'True', 'Do you want to enable the Clickable Table Rows module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(209, 'Pages', 'MODULE_HEADER_TAGS_TABLE_CLICK_JQUERY_PAGES', 'checkout_payment.php;checkout_shipping.php', 'The pages to add the jQuery Scripts to.', 6, 0, NULL, '2017-01-24 11:09:54', 'ht_table_click_jquery_show_pages', 'ht_table_click_jquery_edit_pages('),
(210, 'Sort Order', 'MODULE_HEADER_TAGS_TABLE_CLICK_JQUERY_SORT_ORDER', '800', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(211, 'Enable Colorbox Script', 'MODULE_HEADER_TAGS_PRODUCT_COLORBOX_STATUS', 'True', 'Do you want to enable the Colorbox Scripts?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(212, 'Pages', 'MODULE_HEADER_TAGS_PRODUCT_COLORBOX_PAGES', 'product_info.php', 'The pages to add the Colorbox Scripts to.', 6, 0, NULL, '2017-01-24 11:09:54', 'ht_product_colorbox_show_pages', 'ht_product_colorbox_edit_pages('),
(213, 'Thumbnail Layout', 'MODULE_HEADER_TAGS_PRODUCT_COLORBOX_LAYOUT', '155', 'Layout of Thumbnails', 6, 0, NULL, '2017-01-24 11:09:54', 'ht_product_colorbox_thumbnail_number', NULL),
(214, 'Sort Order', 'MODULE_HEADER_TAGS_PRODUCT_COLORBOX_SORT_ORDER', '900', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(215, 'Installed Modules', 'MODULE_ADMIN_DASHBOARD_INSTALLED', 'd_total_revenue.php;d_total_customers.php;d_orders.php;d_customers.php;d_admin_logins.php;d_security_checks.php;d_latest_news.php;d_latest_addons.php;d_partner_news.php;d_version_check.php;d_reviews.php;d_paypal_app.php', 'List of Administration Tool Dashboard module filenames separated by a semi-colon. This is automatically updated. No need to edit.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(216, 'Enable Administrator Logins Module', 'MODULE_ADMIN_DASHBOARD_ADMIN_LOGINS_STATUS', 'True', 'Do you want to show the latest administrator logins on the dashboard?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(217, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_ADMIN_LOGINS_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(218, 'Enable Customers Module', 'MODULE_ADMIN_DASHBOARD_CUSTOMERS_STATUS', 'True', 'Do you want to show the newest customers on the dashboard?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(219, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_CUSTOMERS_SORT_ORDER', '400', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(220, 'Enable Latest Add-Ons Module', 'MODULE_ADMIN_DASHBOARD_LATEST_ADDONS_STATUS', 'False', 'Do you want to show the latest osCommerce Add-Ons on the dashboard?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(221, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_LATEST_ADDONS_SORT_ORDER', '800', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(222, 'Enable Latest News Module', 'MODULE_ADMIN_DASHBOARD_LATEST_NEWS_STATUS', 'False', 'Do you want to show the latest osCommerce News on the dashboard?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(223, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_LATEST_NEWS_SORT_ORDER', '700', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(224, 'Enable Orders Module', 'MODULE_ADMIN_DASHBOARD_ORDERS_STATUS', 'True', 'Do you want to show the latest orders on the dashboard?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(225, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_ORDERS_SORT_ORDER', '300', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(226, 'Enable Security Checks Module', 'MODULE_ADMIN_DASHBOARD_SECURITY_CHECKS_STATUS', 'True', 'Do you want to run the security checks for this installation?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(227, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_SECURITY_CHECKS_SORT_ORDER', '600', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(228, 'Enable Total Customers Module', 'MODULE_ADMIN_DASHBOARD_TOTAL_CUSTOMERS_STATUS', 'True', 'Do you want to show the total customers chart on the dashboard?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(229, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_TOTAL_CUSTOMERS_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(230, 'Enable Total Revenue Module', 'MODULE_ADMIN_DASHBOARD_TOTAL_REVENUE_STATUS', 'True', 'Do you want to show the total revenue chart on the dashboard?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(231, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_TOTAL_REVENUE_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(232, 'Enable Version Check Module', 'MODULE_ADMIN_DASHBOARD_VERSION_CHECK_STATUS', 'True', 'Do you want to show the version check results on the dashboard?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(233, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_VERSION_CHECK_SORT_ORDER', '900', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(234, 'Enable Latest Reviews Module', 'MODULE_ADMIN_DASHBOARD_REVIEWS_STATUS', 'True', 'Do you want to show the latest reviews on the dashboard?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(235, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_REVIEWS_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(236, 'Enable Partner News Module', 'MODULE_ADMIN_DASHBOARD_PARTNER_NEWS_STATUS', 'False', 'Do you want to show the latest osCommerce Partner News on the dashboard?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(237, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_PARTNER_NEWS_SORT_ORDER', '820', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(238, 'Installed Modules', 'MODULE_BOXES_INSTALLED', 'bm_categories.php;bm_whats_new.php;bm_manufacturers.php;bm_specials.php;bm_manufacturer_info.php;bm_card_acceptance.php;bm_order_history.php;bm_best_sellers.php', 'List of box module filenames separated by a semi-colon. This is automatically updated. No need to edit.', 6, 0, '2017-02-02 06:07:49', '2017-01-24 11:09:54', NULL, NULL),
(239, 'Enable Best Sellers Module', 'MODULE_BOXES_BEST_SELLERS_STATUS', 'True', 'Do you want to add the module to your shop?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(240, 'Content Placement', 'MODULE_BOXES_BEST_SELLERS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), '),
(241, 'Sort Order', 'MODULE_BOXES_BEST_SELLERS_SORT_ORDER', '5030', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(242, 'Enable Categories Module', 'MODULE_BOXES_CATEGORIES_STATUS', 'True', 'Do you want to add the module to your shop?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(243, 'Content Placement', 'MODULE_BOXES_CATEGORIES_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), '),
(244, 'Sort Order', 'MODULE_BOXES_CATEGORIES_SORT_ORDER', '1010', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(245, 'Enable Manufacturers Module', 'MODULE_BOXES_MANUFACTURERS_STATUS', 'True', 'Do you want to add the module to your shop?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(246, 'Content Placement', 'MODULE_BOXES_MANUFACTURERS_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), '),
(247, 'Sort Order', 'MODULE_BOXES_MANUFACTURERS_SORT_ORDER', '1025', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(248, 'Enable Order History Module', 'MODULE_BOXES_ORDER_HISTORY_STATUS', 'True', 'Do you want to add the module to your shop?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(249, 'Content Placement', 'MODULE_BOXES_ORDER_HISTORY_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), '),
(250, 'Sort Order', 'MODULE_BOXES_ORDER_HISTORY_SORT_ORDER', '5020', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(251, 'Enable Card Acceptance Module', 'MODULE_BOXES_CARD_ACCEPTANCE_STATUS', 'True', 'Do you want to add the module to your shop?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(252, 'Logos', 'MODULE_BOXES_CARD_ACCEPTANCE_LOGOS', 'paypal_horizontal_large.png;visa.png;mastercard_transparent.png;american_express.png;maestro_transparent.png', 'The card acceptance logos to show.', 6, 0, NULL, '2017-01-24 11:09:54', 'bm_card_acceptance_show_logos', 'bm_card_acceptance_edit_logos('),
(253, 'Content Placement', 'MODULE_BOXES_CARD_ACCEPTANCE_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), '),
(254, 'Sort Order', 'MODULE_BOXES_CARD_ACCEPTANCE_SORT_ORDER', '1060', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(255, 'Enable What\'s New Module', 'MODULE_BOXES_WHATS_NEW_STATUS', 'True', 'Do you want to add the module to your shop?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), ');
INSERT INTO `configuration` (`configuration_id`, `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES
(256, 'Content Placement', 'MODULE_BOXES_WHATS_NEW_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), '),
(257, 'Sort Order', 'MODULE_BOXES_WHATS_NEW_SORT_ORDER', '1015', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(258, 'Installed Template Block Groups', 'TEMPLATE_BLOCK_GROUPS', 'boxes;header_tags', 'This is automatically updated. No need to edit.', 6, 0, '2017-01-26 06:27:34', '2017-01-24 11:09:54', NULL, NULL),
(259, 'Installed Modules', 'MODULE_CONTENT_INSTALLED', 'account/cm_account_set_password;category/cm_category_categories_description;category/cm_category_new_products_carousel;category/cm_category_popular_products_carousel;category/cm_category_categories_images;checkout_success/cm_cs_redirect_old_order;checkout_success/cm_cs_thank_you;checkout_success/cm_cs_product_notifications;checkout_success/cm_cs_downloads;footer/cm_footer_information_links;footer/cm_footer_mailchimp;footer_suffix/cm_footer_extra_copyright;footer_suffix/cm_footer_extra_icons;header/cm_header_mailchimp_modal;header/cm_header_logo;header/cm_header_search;header/cm_header_messagestack;header/cm_header_breadcrumb;index/cm_i_text_main;index/cm_i_new_products;login/cm_login_form;login/cm_create_account_link;navigation/cm_navbar', 'This is automatically updated. No need to edit.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(260, 'Enable Set Account Password', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_STATUS', 'True', 'Do you want to enable the Set Account Password module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(261, 'Allow Local Passwords', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_ALLOW_PASSWORD', 'True', 'Allow local account passwords to be set.', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(262, 'Sort Order', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(263, 'Enable Redirect Old Order Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_REDIRECT_OLD_ORDER_STATUS', 'True', 'Should customers be redirected when viewing old checkout success orders?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(264, 'Redirect Minutes', 'MODULE_CONTENT_CHECKOUT_SUCCESS_REDIRECT_OLD_ORDER_MINUTES', '60', 'Redirect customers to the My Account page after an order older than this amount is viewed.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(265, 'Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_REDIRECT_OLD_ORDER_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(266, 'Enable Thank You Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_STATUS', 'True', 'Should the thank you block be shown on the checkout success page?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(267, 'Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(268, 'Enable Product Notifications Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_PRODUCT_NOTIFICATIONS_STATUS', 'True', 'Should the product notifications block be shown on the checkout success page?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(269, 'Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_PRODUCT_NOTIFICATIONS_SORT_ORDER', '2000', 'Sort order of display. Lowest is displayed first.', 6, 3, NULL, '2017-01-24 11:09:54', NULL, NULL),
(270, 'Enable Product Downloads Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_DOWNLOADS_STATUS', 'True', 'Should ordered product download links be shown on the checkout success page?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(271, 'Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_DOWNLOADS_SORT_ORDER', '3000', 'Sort order of display. Lowest is displayed first.', 6, 3, NULL, '2017-01-24 11:09:54', NULL, NULL),
(272, 'Enable Login Form Module', 'MODULE_CONTENT_LOGIN_FORM_STATUS', 'True', 'Do you want to enable the login form module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(273, 'Content Width', 'MODULE_CONTENT_LOGIN_FORM_CONTENT_WIDTH', 'Half', 'Should the content be shown in a full or half width container?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Full\', \'Half\'), '),
(274, 'Sort Order', 'MODULE_CONTENT_LOGIN_FORM_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(275, 'Enable New User Module', 'MODULE_CONTENT_CREATE_ACCOUNT_LINK_STATUS', 'True', 'Do you want to enable the new user module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(276, 'Content Width', 'MODULE_CONTENT_CREATE_ACCOUNT_LINK_CONTENT_WIDTH', 'Half', 'Should the content be shown in a full or half width container?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Full\', \'Half\'), '),
(277, 'Sort Order', 'MODULE_CONTENT_CREATE_ACCOUNT_LINK_SORT_ORDER', '2000', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(278, 'Enable Hamburger Button Module', 'MODULE_NAVBAR_HAMBURGER_BUTTON_STATUS', 'True', 'Do you want to add the module to your Navbar?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(279, 'Content Placement', 'MODULE_NAVBAR_HAMBURGER_BUTTON_CONTENT_PLACEMENT', 'Home', 'This module must be placed in the Home area of the Navbar.', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Home\'), '),
(280, 'Sort Order', 'MODULE_NAVBAR_HAMBURGER_BUTTON_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(284, 'Enable Shopping Cart Module', 'MODULE_NAVBAR_SHOPPING_CART_STATUS', 'True', 'Do you want to add the module to your Navbar?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(285, 'Content Placement', 'MODULE_NAVBAR_SHOPPING_CART_CONTENT_PLACEMENT', 'Right', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), '),
(286, 'Sort Order', 'MODULE_NAVBAR_SHOPPING_CART_SORT_ORDER', '550', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(287, 'Enable Navbar Module', 'MODULE_CONTENT_NAVBAR_STATUS', 'True', 'Should the Navbar be shown? ', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(288, 'Navbar Style', 'MODULE_CONTENT_NAVBAR_STYLE', 'Inverse', 'What style should the Navbar have?  See http://getbootstrap.com/components/#navbar-inverted', 6, 0, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Default\', \'Inverse\'), '),
(289, 'Navbar Corners', 'MODULE_CONTENT_NAVBAR_CORNERS', 'No', 'Should the Navbar have Corners?', 6, 0, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Yes\', \'No\'), '),
(290, 'Navbar Margin', 'MODULE_CONTENT_NAVBAR_MARGIN', 'Yes', 'Should the Navbar have a bottom Margin?', 6, 0, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Yes\', \'No\'), '),
(291, 'Navbar Fixed Position', 'MODULE_CONTENT_NAVBAR_FIXED', 'Floating', 'Should the Navbar stay fixed on Top/Bottom of the page or Floating?', 6, 0, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'Floating\', \'Top\', \'Bottom\'), '),
(292, 'Sort Order', 'MODULE_CONTENT_NAVBAR_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(293, 'Enable Header Logo Module', 'MODULE_CONTENT_HEADER_LOGO_STATUS', 'True', 'Do you want to enable the Logo content module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(294, 'Content Width', 'MODULE_CONTENT_HEADER_LOGO_CONTENT_WIDTH', '6', 'What width container should the content be shown in?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(295, 'Sort Order', 'MODULE_CONTENT_HEADER_LOGO_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(296, 'Enable Search Box Module', 'MODULE_CONTENT_HEADER_SEARCH_STATUS', 'True', 'Do you want to enable the Search Box content module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(297, 'Content Width', 'MODULE_CONTENT_HEADER_SEARCH_CONTENT_WIDTH', '6', 'What width container should the content be shown in?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(298, 'Sort Order', 'MODULE_CONTENT_HEADER_SEARCH_SORT_ORDER', '20', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(299, 'Enable Message Stack Notifications Module', 'MODULE_CONTENT_HEADER_MESSAGESTACK_STATUS', 'True', 'Should the Message Stack Notifications be shown in the header when needed? ', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(300, 'Sort Order', 'MODULE_CONTENT_HEADER_MESSAGESTACK_SORT_ORDER', '30', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(301, 'Enable Header Breadcrumb Module', 'MODULE_CONTENT_HEADER_BREADCRUMB_STATUS', 'True', 'Do you want to enable the Breadcrumb content module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(302, 'Content Width', 'MODULE_CONTENT_HEADER_BREADCRUMB_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(303, 'Sort Order', 'MODULE_CONTENT_HEADER_BREADCRUMB_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(304, 'Enable Information Links Footer Module', 'MODULE_CONTENT_FOOTER_INFORMATION_STATUS', 'True', 'Do you want to enable the Information Links content module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(305, 'Content Width', 'MODULE_CONTENT_FOOTER_INFORMATION_CONTENT_WIDTH', '3', 'What width container should the content be shown in? (12 = full width, 6 = half width).', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(306, 'Sort Order', 'MODULE_CONTENT_FOOTER_INFORMATION_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(307, 'Enable Copyright Details Footer Module', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_STATUS', 'True', 'Do you want to enable the Copyright content module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(308, 'Content Width', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_CONTENT_WIDTH', '6', 'What width container should the content be shown in? (12 = full width, 6 = half width).', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(309, 'Sort Order', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(310, 'Enable Payment Icons Footer Module', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_STATUS', 'True', 'Do you want to enable the Payment Icons content module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(311, 'Content Width', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_CONTENT_WIDTH', '6', 'What width container should the content be shown in? (12 = full width, 6 = half width).', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(312, 'Sort Order', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:09:54', NULL, NULL),
(316, 'Enable Main Text Module', 'MODULE_CONTENT_TEXT_MAIN_STATUS', 'True', 'Do you want to enable this module?', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(317, 'Content Width', 'MODULE_CONTENT_TEXT_MAIN_CONTENT_WIDTH', '12', 'What width container should the content be shown in? (12 = full width, 6 = half width).', 6, 1, NULL, '2017-01-24 11:09:54', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(318, 'Sort Order', 'MODULE_CONTENT_TEXT_MAIN_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', 6, 4, NULL, '2017-01-24 11:09:54', NULL, NULL),
(342, 'Security Check Extended Last Run', 'MODULE_SECURITY_CHECK_EXTENDED_LAST_RUN_DATETIME', '1485954235', 'The date and time the last extended security check was performed.', 6, NULL, NULL, '2017-01-24 11:33:09', NULL, NULL),
(343, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_STATUS', '0', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(344, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LIVE_SELLER_EMAIL', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(345, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_ACCOUNT_OPTIONAL', '0', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(346, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_INSTANT_UPDATE', '1', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(347, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_CHECKOUT_IMAGE', '0', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(348, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_PAGE_STYLE', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(349, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_TRANSACTION_METHOD', '1', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(350, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_ORDER_STATUS_ID', '4', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(351, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_ZONE', '0', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(352, 'Sort Order', 'OSCOM_APP_PAYPAL_EC_SORT_ORDER', '0', 'Sort order of display (lowest to highest).', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(353, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_VERIFY_SSL', '1', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(354, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PROXY', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(355, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_DP_STATUS', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(356, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_HS_STATUS', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(357, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PS_STATUS', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(358, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LOGIN_STATUS', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(359, 'Sort Order', 'MODULE_ADMIN_DASHBOARD_PAYPAL_APP_SORT_ORDER', '5000', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:42:17', NULL, NULL),
(360, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_VERSION_CHECK', '2', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 11:42:18', NULL, NULL),
(361, 'Enable New Products Module', 'MODULE_NAVBAR_NEW_PRODUCTS_STATUS', 'True', 'Do you want to add the module to your Navbar?', 6, 1, NULL, '2017-01-24 11:43:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(362, 'Content Placement', 'MODULE_NAVBAR_NEW_PRODUCTS_CONTENT_PLACEMENT', 'Left', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', 6, 1, NULL, '2017-01-24 11:43:11', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), '),
(363, 'Sort Order', 'MODULE_NAVBAR_NEW_PRODUCTS_SORT_ORDER', '525', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:43:11', NULL, NULL),
(364, 'Enable Special Offers Module', 'MODULE_NAVBAR_SPECIAL_OFFERS_STATUS', 'True', 'Do you want to add the module to your Navbar?', 6, 1, NULL, '2017-01-24 11:43:20', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(365, 'Content Placement', 'MODULE_NAVBAR_SPECIAL_OFFERS_CONTENT_PLACEMENT', 'Left', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', 6, 1, NULL, '2017-01-24 11:43:20', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), '),
(366, 'Sort Order', 'MODULE_NAVBAR_SPECIAL_OFFERS_SORT_ORDER', '530', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 11:43:20', NULL, NULL),
(373, 'Enable Account Module', 'MODULE_NAVBAR_ACCOUNT_STATUS', 'True', 'Do you want to add the module to your Navbar?', 6, 1, NULL, '2017-01-24 12:11:38', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(374, 'Content Placement', 'MODULE_NAVBAR_ACCOUNT_CONTENT_PLACEMENT', 'Right', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', 6, 1, NULL, '2017-01-24 12:11:38', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), '),
(375, 'Sort Order', 'MODULE_NAVBAR_ACCOUNT_SORT_ORDER', '540', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-24 12:11:38', NULL, NULL),
(399, 'Module Version', 'MODULE_HEADER_TAGS_DIV_EQUAL_HEIGHTS_VERSION', '1.0', 'The version of this module that you are running', 6, 0, NULL, '2017-01-24 13:12:10', NULL, 'tep_cfg_disabled('),
(400, 'Enable New Equal Heights Module', 'MODULE_HEADER_TAGS_DIV_EQUAL_HEIGHTS_STATUS', 'True', 'Do you want to enable the New Equal Heights module?', 6, 1, NULL, '2017-01-24 13:12:10', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(401, 'Pages', 'MODULE_HEADER_TAGS_DIV_EQUAL_HEIGHTS_PAGES', 'advanced_search_result.php;index.php;products_new.php;specials.php', 'The pages to add the script to.', 6, 2, NULL, '2017-01-24 13:12:10', 'ht_div_equal_heights_show_pages', 'ht_div_equal_heights_edit_pages('),
(402, 'Sort Order', 'MODULE_HEADER_TAGS_DIV_EQUAL_HEIGHTS_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', 6, 3, NULL, '2017-01-24 13:12:10', NULL, NULL),
(414, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_TRANSACTIONS_ORDER_STATUS_ID', '4', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:15', NULL, NULL),
(415, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_GATEWAY', '1', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:15', NULL, NULL),
(416, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LOG_TRANSACTIONS', '1', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:15', NULL, NULL),
(417, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_EC_CHECKOUT_FLOW', '0', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:15', NULL, NULL),
(418, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LIVE_SELLER_EMAIL_PRIMARY', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(419, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LIVE_API_USERNAME', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(420, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LIVE_API_PASSWORD', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(421, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_LIVE_API_SIGNATURE', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(422, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_SANDBOX_SELLER_EMAIL', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(423, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_SANDBOX_SELLER_EMAIL_PRIMARY', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(424, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_SANDBOX_API_USERNAME', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(425, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_SANDBOX_API_PASSWORD', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(426, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_SANDBOX_API_SIGNATURE', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(427, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_LIVE_PARTNER', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(428, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_LIVE_VENDOR', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(429, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_LIVE_USER', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(430, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_LIVE_PASSWORD', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(431, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_SANDBOX_PARTNER', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(432, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_SANDBOX_VENDOR', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(433, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_SANDBOX_USER', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(434, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_PF_SANDBOX_PASSWORD', '', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-01-24 15:00:36', NULL, NULL),
(435, 'Do you want to enable this module ?', 'MODULES_HEADER_TAGS_MAILCHIMP_STATUS', 'True', 'Do you want to enable this module ?', 6, 1, NULL, '2017-01-24 22:58:08', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(436, 'Mailchimp API', 'MODULES_HEADER_TAGS_MAILCHIMP_API', '8cafae9459aa74460b61115fdd635701-us15', 'Your API key given by Mailchimp.', 6, 3, NULL, '2017-01-24 22:58:08', NULL, NULL),
(437, 'Anonymous List number by Mailchimp', 'MODULES_HEADER_TAGS_MAILCHIMP_LIST_ANONYMOUS', '8cafae9459aa74460b61115fdd635701-us15', 'This is the code created in your Mailchimp account in the anonymous list configuration.', 6, 4, NULL, '2017-01-24 22:58:08', NULL, NULL),
(438, 'Customer List number by Mailchimp', 'MODULES_HEADER_TAGS_MAILCHIMP_LIST_CUSTOMERS', '', 'This is the code created in your Mailchimp account in the customer list configuration.', 6, 4, NULL, '2017-01-24 22:58:08', NULL, NULL),
(439, 'Choose your status to validate email ?', 'MODULES_HEADER_TAGS_MAILCHIMP_STATUS_CHOICE', 'pending', '- subscribed: the user is validated,<br />- pending: the user needs to be validated', 6, 1, NULL, '2017-01-24 22:58:08', NULL, 'tep_cfg_select_option(array(\'subscribed\', \'pending\'), '),
(440, 'Do you want to enable the debug tool ?', 'MODULES_HEADER_TAGS_MAILCHIMP_DEBUG', 'False', 'Via the console you can see the response result. Set to false for production.', 6, 1, NULL, '2017-01-24 22:58:08', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(441, 'Sort Order', 'MODULES_HEADER_TAGS_MAILCHIMP_SORT_ORDER', '900', 'Sort order of display. Lowest is displayed first.', 6, 3, NULL, '2017-01-24 22:58:08', NULL, NULL),
(442, 'Do you want to enable Mailchimp (anonymous newsletter) ?', 'MODULE_FOOTER_MAILCHIMP_STATUS', 'False', 'Do you want enable Mailchimp (anonymous newsletter) ?', 6, 1, NULL, '2017-01-24 22:58:25', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(443, 'Content Width', 'MODULE_CONTENT_FOOTER_MAILCHIMP_CONTENT_WIDTH', '3', 'What width container should the content be shown in? (12 = full width, 6 = half width).', 6, 1, NULL, '2017-01-24 22:58:25', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(444, 'Do you want to display name fields ?', 'MODULE_FOOTER_MAILCHIMP_DISPLAY_NAME', 'True', 'Display field with name and first name (required in header tag to fill the code til fill list customer)', 6, 3, NULL, '2017-01-24 22:58:25', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(445, 'Do you want to display privacy info?', 'MODULE_FOOTER_MAILCHIMP_DISPLAY_PRIVACY', 'True', 'Display colapsible with Privacy text.', 6, 3, NULL, '2017-01-24 22:58:25', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(446, 'Sort Order', 'MODULE_FOOTER_MAILCHIMP_SORT_ORDER', '15', 'Sort order of display. Lowest is displayed first.', 6, 6, NULL, '2017-01-24 22:58:25', NULL, NULL),
(447, 'Enable Reviews Module', 'MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_STATUS', 'False', 'Do you want to add the module to your Navbar?', 6, 1, NULL, '2017-01-25 00:13:52', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(448, 'Content Placement', 'MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_CONTENT_PLACEMENT', 'Right', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', 6, 1, NULL, '2017-01-25 00:13:52', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), '),
(449, 'Sort Order', 'MODULE_NAVBAR_MAILCHIMP_NEWSLETTER_SORT_ORDER', '535', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-25 00:13:52', NULL, NULL),
(450, 'Enable Mailchimp Modal', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_STATUS', 'False', 'Do you want to enable the Mailchimp Modal content module?', 6, 1, NULL, '2017-01-25 00:15:22', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(451, 'Mailchimp Modal on Product Page', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_PRODUCT_INFO', 'True', 'Do you want to open the Mailchimp Nesletter Modal Pop Up on the first Product Page visit?', 6, 2, NULL, '2017-01-25 00:15:22', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(452, 'Mailchimp Modal on Categories', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_CATEGORIES', 'True', 'Do you want to open the Mailchimp Nesletter Modal Pop Up on the first Category visit?', 6, 3, NULL, '2017-01-25 00:15:22', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(453, 'Mailchimp Modal Page Count', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_PAGE_COUNT', '3', 'After how many visited pages should the Mailchimp Nesletter Modal Pop Up open?.', 6, 4, NULL, '2017-01-25 00:15:22', NULL, NULL),
(454, 'Do you want to display name fields?', 'MODULE_CONTENT_HEADER_MAILCHIMP_DISPLAY_NAME', 'False', 'Display field with name and first name.', 6, 3, NULL, '2017-01-25 00:15:22', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(455, 'Do you want to display privacy info?', 'MODULE_CONTENT_HEADER_MAILCHIMP_DISPLAY_PRIVACY', 'True', 'Display colapsible with Privacy text.', 6, 3, NULL, '2017-01-25 00:15:22', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(456, 'Mailchimp Modal Size', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_SIZE', 'Normal', 'Select the preferred size for the Mailchimp Modal. (Applicable to medium to large screen sizes)', 6, 5, NULL, '2017-01-25 00:15:22', NULL, 'tep_cfg_select_option(array(\'Normal\', \'Large\'), '),
(457, 'Sort Order', 'MODULE_CONTENT_HEADER_MAILCHIMP_MODAL_SORT_ORDER', '0', 'Not important for this module.', 6, 6, NULL, '2017-01-25 00:15:22', NULL, NULL),
(471, 'Enable Home Module', 'MODULE_NAVBAR_HOME_STATUS', 'True', 'Do you want to add the module to your Navbar?', 6, 1, NULL, '2017-01-26 07:55:25', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(472, 'Content Placement', 'MODULE_NAVBAR_HOME_CONTENT_PLACEMENT', 'Left', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', 6, 1, NULL, '2017-01-26 07:55:25', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), '),
(473, 'Sort Order', 'MODULE_NAVBAR_HOME_SORT_ORDER', '520', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-26 07:55:25', NULL, NULL),
(474, 'Enable Testimonials Module', 'MODULE_NAVBAR_TESTIMONIALS_STATUS', 'True', 'Do you want to add the module to your Navbar?', 6, 1, NULL, '2017-01-26 07:56:40', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(475, 'Content Placement', 'MODULE_NAVBAR_TESTIMONIALS_CONTENT_PLACEMENT', 'Left', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', 6, 1, NULL, '2017-01-26 07:56:40', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), '),
(476, 'Sort Order', 'MODULE_NAVBAR_TESTIMONIALS_SORT_ORDER', '534', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-26 07:56:40', NULL, NULL),
(477, 'Enable Reviews Module', 'MODULE_NAVBAR_REVIEWS_STATUS', 'True', 'Do you want to add the module to your Navbar?', 6, 1, NULL, '2017-01-26 07:57:00', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(478, 'Content Placement', 'MODULE_NAVBAR_REVIEWS_CONTENT_PLACEMENT', 'Left', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', 6, 1, NULL, '2017-01-26 07:57:00', NULL, 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), '),
(479, 'Sort Order', 'MODULE_NAVBAR_REVIEWS_SORT_ORDER', '535', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-01-26 07:57:00', NULL, NULL),
(494, 'Owl Carousel Version', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_JAVASCRIPT_VERSION', '1.3.3', 'The version of this jQuery Owl Carousel.', 6, 1, NULL, '2017-01-26 08:59:40', NULL, 'tep_cfg_disabled('),
(495, 'Enable jQuery Owl Carousel Module', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_STATUS', 'True', 'Do you want to add jQuery Owl Carousel Javascript to your shop? (Required for modules that need owl carousel to function i.e. New Products Carousel.)', 6, 2, NULL, '2017-01-26 08:59:40', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(496, 'Pages', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_VIEW_PAGES', 'index.php', 'The pages to add the script to.', 6, 3, NULL, '2017-01-26 08:59:40', 'ht_owl_carousel_show_pages', 'ht_owl_carousel_edit_pages('),
(497, 'Sort Order', 'MODULE_HEADER_TAGS_OWL_CAROUSEL_SORT_ORDER', '150', 'Sort order. Lowest is first.', 6, 4, NULL, '2017-01-26 08:59:40', NULL, NULL),
(592, 'Enable New Products Carousel Module', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_STATUS', 'True', 'Should the new products carousel be shown on the category pages? (Requires jQuery Owl Carousel v1.3.3 Javascript loaded.)', 6, 0, NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(593, 'Show on the Front Page', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_FRONT_PAGE', 'True', 'Should the new products carousel be shown on the front page?', 6, 1, NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(594, 'Show on Top Level Category Pages', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CAT_PAGE', 'True', 'Should the new products carousel be shown on the top level category pages?', 6, 2, NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(595, 'Show on Sub-Category Product Pages', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PROD_PAGE', 'True', 'Should the new products carousel be shown on the sub-category product pages?', 6, 3, NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(596, 'Allow Close', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_CLOSE', 'True', 'Allow the panel box to be closed/hidden by displaying an X in the corner (except the front page).', 6, 4, NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(597, 'Max Products', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_MAX_DISPLAY_NEW_PRODUCTS', '20', 'Maximum number of new products to show in the new products carousel. (When inside a category, only new products for that category are shown)', 6, 5, NULL, '2017-01-26 10:14:13', NULL, NULL),
(598, 'Show Old Price', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SHOW_OLD_PRICE', 'True', 'When there is a special, do you want to show the old product price with the new special price in the new products carousel? Default: False (only show special price).', 6, 6, NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(599, 'Show Product Description', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SHOW_DESCRIPTION', 'False', 'Do you want to show the product description in the new products carousel?', 6, 7, NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(600, 'Maximum Word Length', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_WORD_LENGTH', '40', 'When show product description is set to true, set the maximum number of characters in a single word (Needed to prevent breaking box width). Default: 40.', 6, 8, NULL, '2017-01-26 10:14:13', NULL, NULL),
(601, 'Maximum Description Length', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_DESCRIPTION_LENGTH', '100', 'When show product description is set to true, set the number of characters (to the nearest word) of the description to display in the new products carousel. Default: 100.', 6, 9, NULL, '2017-01-26 10:14:13', NULL, NULL),
(602, 'Enable Auto Play', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_AUTOPLAY', 'True', 'Should the carousel play (slide) automatically?', 6, 10, NULL, '2017-01-26 10:14:13', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(603, 'Auto Play Speed', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_AUTOPLAY_SPEED', '5000', 'When auto play is set to true, set the time delay between slides, in millisecs (ms). Lower number is faster, higher is slower. Default: 5000.', 6, 11, NULL, '2017-01-26 10:14:13', NULL, NULL),
(604, 'Navigation Slide Speed', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_NAV_SLIDE_SPEED', '700', 'Slide speed when using navigation buttons, in millisecs (ms). Lower number is faster, higher is slower. Default: 700.', 6, 12, NULL, '2017-01-26 10:14:13', NULL, NULL),
(605, 'Page Slide Speed', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_PAGE_SLIDE_SPEED', '800', 'Page slide speed during auto play, in millisecs (ms). Lower number is faster, higher is slower. Default: 800.', 6, 13, NULL, '2017-01-26 10:14:13', NULL, NULL),
(606, 'Sort Order', 'MODULE_CONTENT_CATEGORY_NEW_PRODUCTS_CAROUSEL_SORT_ORDER', '35', 'Sort order of display. Lowest is displayed first.', 6, 14, NULL, '2017-01-26 10:14:13', NULL, NULL),
(607, 'Enable Popular Products Carousel Module', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_STATUS', 'True', 'Should the popular products carousel be shown on the category pages? (Requires jQuery Owl Carousel v1.3.3 Javascript loaded.)', 6, 0, NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(608, 'Show on the Front Page', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_FRONT_PAGE', 'True', 'Should the popular products carousel be shown on the front page?', 6, 1, NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(609, 'Show on Top Level Category Pages', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_CAT_PAGE', 'True', 'Should the popular products carousel be shown on the top level category pages?', 6, 2, NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(610, 'Show on Sub-Category Product Pages', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_PROD_PAGE', 'True', 'Should the popular products carousel be shown on the sub-category product pages?', 6, 3, NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(611, 'Allow Close', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_CLOSE', 'True', 'Allow the panel box to be closed/hidden by displaying an X in the corner (except the front page).', 6, 4, NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(612, 'Max Products', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_MAX_DISPLAY_POPULAR_PRODUCTS', '20', 'Maximum number of popular products to show on the category pages. (When inside a category, only popular products for that category are shown). Default: 20', 6, 5, NULL, '2017-01-26 10:16:11', NULL, NULL),
(613, 'Show Old Price', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_SHOW_OLD_PRICE', 'True', 'When there is a special, do you want to show the old product price with the new special price in the popular products carousel? Default: False (only show special price).', 6, 6, NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(614, 'Show Product Description', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_SHOW_DESCRIPTION', 'False', 'Do you want to show the product description in the popular products carousel?', 6, 7, NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(615, 'Maximum Word Length', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_WORD_LENGTH', '40', 'When show product description is set to true, set the maximum number of characters in a single word (Needed to prevent breaking box width). Default: 40.', 6, 8, NULL, '2017-01-26 10:16:11', NULL, NULL),
(616, 'Maximum Description Length', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_DESCRIPTION_LENGTH', '100', 'When show product description is set to true, set the number of characters (to the nearest word) of the description to display in the popular products carousel. Default: 100.', 6, 9, NULL, '2017-01-26 10:16:11', NULL, NULL),
(617, 'Enable Auto Play', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_AUTOPLAY', 'False', 'Should the carousel play (slide) automatically?', 6, 10, NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(618, 'Auto Play Speed', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_AUTOPLAY_SPEED', '5000', 'When auto play is set to true, set the time delay between slides, in millisecs (ms). Lower number is faster, higher is slower. Default: 5000.', 6, 11, NULL, '2017-01-26 10:16:11', NULL, NULL),
(619, 'Navigation Slide Speed', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_NAV_SLIDE_SPEED', '700', 'Slide speed when using navigation buttons, in millisecs (ms). Lower number is faster, higher is slower. Default: 700.', 6, 12, NULL, '2017-01-26 10:16:11', NULL, NULL),
(620, 'Page Slide Speed', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_PAGE_SLIDE_SPEED', '800', 'Page slide speed during auto play, in millisecs (ms). Lower number is faster, higher is slower. Default: 800.', 6, 13, NULL, '2017-01-26 10:16:11', NULL, NULL),
(621, 'Show Hot Selling', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_HOT', 'False', 'Should the hot selling label show on items that reach the hot selling target?', 6, 14, NULL, '2017-01-26 10:16:11', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(622, 'Hot Selling Target', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_HOT_TARGET', '50', 'When enable hot selling is set to true, set the target sales to reach for items to become hot selling. Default: 50.', 6, 15, NULL, '2017-01-26 10:16:11', NULL, NULL),
(623, 'Hot Selling Target Time Frame', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_HOT_TARGET_TIME', '1', 'When enable hot selling is set to true, set the time frame for the target sales to be reached for items to become hot selling, in months. Default: 1 month.', 6, 16, NULL, '2017-01-26 10:16:11', NULL, NULL),
(624, 'Sort Order', 'MODULE_CONTENT_CATEGORY_POPULAR_PRODUCTS_CAROUSEL_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', 6, 17, NULL, '2017-01-26 10:16:11', NULL, NULL),
(648, 'Module Version', 'MODULE_CONTENT_CATEGORY_CATEGORIES_DESCRIPTION_VERSION', '1.1', 'The version of this module that you are running.', 6, 0, NULL, '2017-01-26 12:36:58', NULL, 'tep_cfg_disabled('),
(649, 'Enable Category Description Module', 'MODULE_CONTENT_CATEGORY_CATEGORIES_DESCRIPTION_STATUS', 'True', 'Should the category description be shown in the category?', 6, 1, NULL, '2017-01-26 12:36:58', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(650, 'Content Width', 'MODULE_CONTENT_CATEGORY_CATEGORIES_DESCRIPTION_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', 6, 2, NULL, '2017-01-26 12:36:58', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(651, 'Sort Order', 'MODULE_CONTENT_CATEGORY_CATEGORIES_DESCRIPTION_SORT_ORDER', '30', 'Sort order of display. Lowest is displayed first.', 6, 3, NULL, '2017-01-26 12:36:58', NULL, NULL),
(652, 'Module Version', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_VERSION', '1.1', 'The version of this module that you are running', 6, 0, NULL, '2017-01-26 12:37:15', NULL, 'tep_cfg_disabled('),
(653, 'Enable Category Sub-categories Listing Module', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_STATUS', 'True', 'Should the category sub-categories listing be shown in the category?', 6, 1, NULL, '2017-01-26 12:37:15', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(654, 'Content Width', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', 6, 2, NULL, '2017-01-26 12:37:15', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(655, 'Category Width', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_CONTENT_WIDTH_EACH', '4', 'What width container should each Category be shown in?', 6, 3, NULL, '2017-01-26 12:37:15', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(656, 'Sort Order', 'MODULE_CONTENT_CATEGORY_CATEGORIES_IMAGES_SORT_ORDER', '50', 'Sort order of display. Lowest is displayed first.', 6, 4, NULL, '2017-01-26 12:37:15', NULL, NULL),
(659, 'Product Image Width', 'LARGE_IMAGE_WIDTH', '800', 'The pixel width for product images on the product info page', 4, 101, NULL, '2017-01-30 13:47:57', NULL, NULL),
(660, 'Product Image Height', 'LARGE_IMAGE_HEIGHT', '600', 'The pixel height for product images on the product info page', 4, 102, NULL, '2017-01-30 13:47:57', NULL, NULL),
(661, 'Maximum Image Width', 'MAX_ORIGINAL_IMAGE_WIDTH', '4000', 'The maximum pixel width allowed for original images', 4, 103, NULL, '2017-01-30 13:47:57', NULL, NULL),
(662, 'Maximum Image Height', 'MAX_ORIGINAL_IMAGE_HEIGHT', '4000', 'The maximum pixel height allowed for original images', 4, 104, NULL, '2017-01-30 13:47:57', NULL, NULL),
(663, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_START_MERCHANT_ID', 'Lw0m4dPrwoD8jeDImofgROjygfyYYn1Q', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-02-01 14:28:46', NULL, NULL),
(664, 'PayPal App Parameter', 'OSCOM_APP_PAYPAL_START_SECRET', '685fb257b2ebd8fef19679f37c1a69beadf13a2a', 'A parameter for the PayPal Application.', 6, 0, NULL, '2017-02-01 14:28:46', NULL, NULL),
(665, 'Enable Specials Module', 'MODULE_BOXES_SPECIALS_STATUS', 'True', 'Do you want to add the module to your shop?', 6, 1, NULL, '2017-02-02 05:51:32', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(666, 'Content Placement', 'MODULE_BOXES_SPECIALS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', 6, 1, NULL, '2017-02-02 05:51:32', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), '),
(667, 'Sort Order', 'MODULE_BOXES_SPECIALS_SORT_ORDER', '1030', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-02-02 05:51:32', NULL, NULL),
(668, 'Enable Manufacturer Info Module', 'MODULE_BOXES_MANUFACTURER_INFO_STATUS', 'True', 'Do you want to add the module to your shop?', 6, 1, NULL, '2017-02-02 05:59:16', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(669, 'Content Placement', 'MODULE_BOXES_MANUFACTURER_INFO_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', 6, 1, NULL, '2017-02-02 05:59:16', NULL, 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), '),
(670, 'Sort Order', 'MODULE_BOXES_MANUFACTURER_INFO_SORT_ORDER', '1040', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2017-02-02 05:59:16', NULL, NULL),
(672, 'Display Overlay Images Sales', 'DISPLAY_OVERLAY_IMAGES_SALES', 'true', 'Display Overlay Images Sales (true) or Don\'t display Overlay Images Sales (false)', 1, 21, '2017-02-02 15:25:56', '2017-02-02 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(674, 'Display Overlay Images New', 'DISPLAY_OVERLAY_IMAGES_NEW', 'true', 'Display Overlay Images New (true) or Don\'t display Overlay Images New (false)', 1, 21, '2017-02-02 15:26:02', '2017-02-02 11:09:54', NULL, 'tep_cfg_select_option(array(\'true\', \'false\'), '),
(675, 'Enable New Products Module', 'MODULE_CONTENT_NEW_PRODUCTS_STATUS', 'False', 'Do you want to enable this module?', 6, 1, NULL, '2017-02-02 13:42:48', NULL, 'tep_cfg_select_option(array(\'True\', \'False\'), '),
(676, 'Content Width', 'MODULE_CONTENT_NEW_PRODUCTS_CONTENT_WIDTH', '12', 'What width container should the content be shown in? (12 = full width, 6 = half width).', 6, 2, NULL, '2017-02-02 13:42:48', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(677, 'Maximum Display', 'MODULE_CONTENT_NEW_PRODUCTS_MAX_DISPLAY', '20', 'Maximum Number of products that should show in this module?', 6, 3, NULL, '2017-02-02 13:42:48', NULL, NULL),
(678, 'Product Width', 'MODULE_CONTENT_NEW_PRODUCTS_DISPLAY_EACH', '3', 'What width container should each product be shown in? (12 = full width, 6 = half width).', 6, 4, NULL, '2017-02-02 13:42:48', NULL, 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), '),
(679, 'Sort Order', 'MODULE_CONTENT_NEW_PRODUCTS_SORT_ORDER', '300', 'Sort order of display. Lowest is displayed first.', 6, 5, NULL, '2017-02-02 13:42:48', NULL, NULL);

DROP TABLE IF EXISTS `configuration_group`;
CREATE TABLE `configuration_group` (
  `configuration_group_id` int(11) NOT NULL,
  `configuration_group_title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `configuration_group_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(5) DEFAULT NULL,
  `visible` int(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `configuration_group` (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES
(1, 'My Store', 'General information about my store', 1, 1),
(2, 'Minimum Values', 'The minimum values for functions / data', 2, 1),
(3, 'Maximum Values', 'The maximum values for functions / data', 3, 1),
(4, 'Images', 'Image parameters', 4, 1),
(5, 'Customer Details', 'Customer account configuration', 5, 1),
(6, 'Module Options', 'Hidden from configuration', 6, 0),
(7, 'Shipping/Packaging', 'Shipping options available at my store', 7, 1),
(8, 'Product Listing', 'Product Listing    configuration options', 8, 1),
(9, 'Stock', 'Stock configuration options', 9, 1),
(10, 'Logging', 'Logging configuration options', 10, 1),
(11, 'Cache', 'Caching configuration options', 11, 1),
(12, 'E-Mail Options', 'General setting for E-Mail transport and HTML E-Mails', 12, 1),
(13, 'Download', 'Downloadable products options', 13, 1),
(14, 'GZip Compression', 'GZip compression options', 14, 1),
(15, 'Sessions', 'Session options', 15, 1),
(16, 'Bootstrap Setup', 'Basic Bootstrap Options', 16, 1);

DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `countries_id` int(11) NOT NULL,
  `countries_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `countries_iso_code_2` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `countries_iso_code_3` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `address_format_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `countries` (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES
(1, 'Afghanistan', 'AF', 'AFG', 1),
(2, 'Albania', 'AL', 'ALB', 1),
(3, 'Algeria', 'DZ', 'DZA', 1),
(4, 'American Samoa', 'AS', 'ASM', 1),
(5, 'Andorra', 'AD', 'AND', 1),
(6, 'Angola', 'AO', 'AGO', 1),
(7, 'Anguilla', 'AI', 'AIA', 1),
(8, 'Antarctica', 'AQ', 'ATA', 1),
(9, 'Antigua and Barbuda', 'AG', 'ATG', 1),
(10, 'Argentina', 'AR', 'ARG', 1),
(11, 'Armenia', 'AM', 'ARM', 1),
(12, 'Aruba', 'AW', 'ABW', 1),
(13, 'Australia', 'AU', 'AUS', 1),
(14, 'Austria', 'AT', 'AUT', 5),
(15, 'Azerbaijan', 'AZ', 'AZE', 1),
(16, 'Bahamas', 'BS', 'BHS', 1),
(17, 'Bahrain', 'BH', 'BHR', 1),
(18, 'Bangladesh', 'BD', 'BGD', 1),
(19, 'Barbados', 'BB', 'BRB', 1),
(20, 'Belarus', 'BY', 'BLR', 1),
(21, 'Belgium', 'BE', 'BEL', 1),
(22, 'Belize', 'BZ', 'BLZ', 1),
(23, 'Benin', 'BJ', 'BEN', 1),
(24, 'Bermuda', 'BM', 'BMU', 1),
(25, 'Bhutan', 'BT', 'BTN', 1),
(26, 'Bolivia', 'BO', 'BOL', 1),
(27, 'Bosnia and Herzegowina', 'BA', 'BIH', 1),
(28, 'Botswana', 'BW', 'BWA', 1),
(29, 'Bouvet Island', 'BV', 'BVT', 1),
(30, 'Brazil', 'BR', 'BRA', 1),
(31, 'British Indian Ocean Territory', 'IO', 'IOT', 1),
(32, 'Brunei Darussalam', 'BN', 'BRN', 1),
(33, 'Bulgaria', 'BG', 'BGR', 1),
(34, 'Burkina Faso', 'BF', 'BFA', 1),
(35, 'Burundi', 'BI', 'BDI', 1),
(36, 'Cambodia', 'KH', 'KHM', 1),
(37, 'Cameroon', 'CM', 'CMR', 1),
(38, 'Canada', 'CA', 'CAN', 1),
(39, 'Cape Verde', 'CV', 'CPV', 1),
(40, 'Cayman Islands', 'KY', 'CYM', 1),
(41, 'Central African Republic', 'CF', 'CAF', 1),
(42, 'Chad', 'TD', 'TCD', 1),
(43, 'Chile', 'CL', 'CHL', 1),
(44, 'China', 'CN', 'CHN', 1),
(45, 'Christmas Island', 'CX', 'CXR', 1),
(46, 'Cocos (Keeling) Islands', 'CC', 'CCK', 1),
(47, 'Colombia', 'CO', 'COL', 1),
(48, 'Comoros', 'KM', 'COM', 1),
(49, 'Congo', 'CG', 'COG', 1),
(50, 'Cook Islands', 'CK', 'COK', 1),
(51, 'Costa Rica', 'CR', 'CRI', 1),
(52, 'Cote D\'Ivoire', 'CI', 'CIV', 1),
(53, 'Croatia', 'HR', 'HRV', 1),
(54, 'Cuba', 'CU', 'CUB', 1),
(55, 'Cyprus', 'CY', 'CYP', 1),
(56, 'Czech Republic', 'CZ', 'CZE', 1),
(57, 'Denmark', 'DK', 'DNK', 1),
(58, 'Djibouti', 'DJ', 'DJI', 1),
(59, 'Dominica', 'DM', 'DMA', 1),
(60, 'Dominican Republic', 'DO', 'DOM', 1),
(61, 'East Timor', 'TP', 'TMP', 1),
(62, 'Ecuador', 'EC', 'ECU', 1),
(63, 'Egypt', 'EG', 'EGY', 1),
(64, 'El Salvador', 'SV', 'SLV', 1),
(65, 'Equatorial Guinea', 'GQ', 'GNQ', 1),
(66, 'Eritrea', 'ER', 'ERI', 1),
(67, 'Estonia', 'EE', 'EST', 1),
(68, 'Ethiopia', 'ET', 'ETH', 1),
(69, 'Falkland Islands (Malvinas)', 'FK', 'FLK', 1),
(70, 'Faroe Islands', 'FO', 'FRO', 1),
(71, 'Fiji', 'FJ', 'FJI', 1),
(72, 'Finland', 'FI', 'FIN', 1),
(73, 'France', 'FR', 'FRA', 1),
(74, 'France, Metropolitan', 'FX', 'FXX', 1),
(75, 'French Guiana', 'GF', 'GUF', 1),
(76, 'French Polynesia', 'PF', 'PYF', 1),
(77, 'French Southern Territories', 'TF', 'ATF', 1),
(78, 'Gabon', 'GA', 'GAB', 1),
(79, 'Gambia', 'GM', 'GMB', 1),
(80, 'Georgia', 'GE', 'GEO', 1),
(81, 'Germany', 'DE', 'DEU', 5),
(82, 'Ghana', 'GH', 'GHA', 1),
(83, 'Gibraltar', 'GI', 'GIB', 1),
(84, 'Greece', 'GR', 'GRC', 1),
(85, 'Greenland', 'GL', 'GRL', 1),
(86, 'Grenada', 'GD', 'GRD', 1),
(87, 'Guadeloupe', 'GP', 'GLP', 1),
(88, 'Guam', 'GU', 'GUM', 1),
(89, 'Guatemala', 'GT', 'GTM', 1),
(90, 'Guinea', 'GN', 'GIN', 1),
(91, 'Guinea-bissau', 'GW', 'GNB', 1),
(92, 'Guyana', 'GY', 'GUY', 1),
(93, 'Haiti', 'HT', 'HTI', 1),
(94, 'Heard and Mc Donald Islands', 'HM', 'HMD', 1),
(95, 'Honduras', 'HN', 'HND', 1),
(96, 'Hong Kong', 'HK', 'HKG', 1),
(97, 'Hungary', 'HU', 'HUN', 1),
(98, 'Iceland', 'IS', 'ISL', 1),
(99, 'India', 'IN', 'IND', 1),
(100, 'Indonesia', 'ID', 'IDN', 1),
(101, 'Iran (Islamic Republic of)', 'IR', 'IRN', 1),
(102, 'Iraq', 'IQ', 'IRQ', 1),
(103, 'Ireland', 'IE', 'IRL', 1),
(104, 'Israel', 'IL', 'ISR', 1),
(105, 'Italy', 'IT', 'ITA', 1),
(106, 'Jamaica', 'JM', 'JAM', 1),
(107, 'Japan', 'JP', 'JPN', 1),
(108, 'Jordan', 'JO', 'JOR', 1),
(109, 'Kazakhstan', 'KZ', 'KAZ', 1),
(110, 'Kenya', 'KE', 'KEN', 1),
(111, 'Kiribati', 'KI', 'KIR', 1),
(112, 'Korea, Democratic People\'s Republic of', 'KP', 'PRK', 1),
(113, 'Korea, Republic of', 'KR', 'KOR', 1),
(114, 'Kuwait', 'KW', 'KWT', 1),
(115, 'Kyrgyzstan', 'KG', 'KGZ', 1),
(116, 'Lao People\'s Democratic Republic', 'LA', 'LAO', 1),
(117, 'Latvia', 'LV', 'LVA', 1),
(118, 'Lebanon', 'LB', 'LBN', 1),
(119, 'Lesotho', 'LS', 'LSO', 1),
(120, 'Liberia', 'LR', 'LBR', 1),
(121, 'Libyan Arab Jamahiriya', 'LY', 'LBY', 1),
(122, 'Liechtenstein', 'LI', 'LIE', 1),
(123, 'Lithuania', 'LT', 'LTU', 1),
(124, 'Luxembourg', 'LU', 'LUX', 1),
(125, 'Macau', 'MO', 'MAC', 1),
(126, 'Macedonia, The Former Yugoslav Republic of', 'MK', 'MKD', 1),
(127, 'Madagascar', 'MG', 'MDG', 1),
(128, 'Malawi', 'MW', 'MWI', 1),
(129, 'Malaysia', 'MY', 'MYS', 1),
(130, 'Maldives', 'MV', 'MDV', 1),
(131, 'Mali', 'ML', 'MLI', 1),
(132, 'Malta', 'MT', 'MLT', 1),
(133, 'Marshall Islands', 'MH', 'MHL', 1),
(134, 'Martinique', 'MQ', 'MTQ', 1),
(135, 'Mauritania', 'MR', 'MRT', 1),
(136, 'Mauritius', 'MU', 'MUS', 1),
(137, 'Mayotte', 'YT', 'MYT', 1),
(138, 'Mexico', 'MX', 'MEX', 1),
(139, 'Micronesia, Federated States of', 'FM', 'FSM', 1),
(140, 'Moldova, Republic of', 'MD', 'MDA', 1),
(141, 'Monaco', 'MC', 'MCO', 1),
(142, 'Mongolia', 'MN', 'MNG', 1),
(143, 'Montserrat', 'MS', 'MSR', 1),
(144, 'Morocco', 'MA', 'MAR', 1),
(145, 'Mozambique', 'MZ', 'MOZ', 1),
(146, 'Myanmar', 'MM', 'MMR', 1),
(147, 'Namibia', 'NA', 'NAM', 1),
(148, 'Nauru', 'NR', 'NRU', 1),
(149, 'Nepal', 'NP', 'NPL', 1),
(150, 'Netherlands', 'NL', 'NLD', 1),
(151, 'Netherlands Antilles', 'AN', 'ANT', 1),
(152, 'New Caledonia', 'NC', 'NCL', 1),
(153, 'New Zealand', 'NZ', 'NZL', 1),
(154, 'Nicaragua', 'NI', 'NIC', 1),
(155, 'Niger', 'NE', 'NER', 1),
(156, 'Nigeria', 'NG', 'NGA', 1),
(157, 'Niue', 'NU', 'NIU', 1),
(158, 'Norfolk Island', 'NF', 'NFK', 1),
(159, 'Northern Mariana Islands', 'MP', 'MNP', 1),
(160, 'Norway', 'NO', 'NOR', 1),
(161, 'Oman', 'OM', 'OMN', 1),
(162, 'Pakistan', 'PK', 'PAK', 1),
(163, 'Palau', 'PW', 'PLW', 1),
(164, 'Panama', 'PA', 'PAN', 1),
(165, 'Papua New Guinea', 'PG', 'PNG', 1),
(166, 'Paraguay', 'PY', 'PRY', 1),
(167, 'Peru', 'PE', 'PER', 1),
(168, 'Philippines', 'PH', 'PHL', 1),
(169, 'Pitcairn', 'PN', 'PCN', 1),
(170, 'Poland', 'PL', 'POL', 1),
(171, 'Portugal', 'PT', 'PRT', 1),
(172, 'Puerto Rico', 'PR', 'PRI', 1),
(173, 'Qatar', 'QA', 'QAT', 1),
(174, 'Reunion', 'RE', 'REU', 1),
(175, 'Romania', 'RO', 'ROM', 1),
(176, 'Russian Federation', 'RU', 'RUS', 1),
(177, 'Rwanda', 'RW', 'RWA', 1),
(178, 'Saint Kitts and Nevis', 'KN', 'KNA', 1),
(179, 'Saint Lucia', 'LC', 'LCA', 1),
(180, 'Saint Vincent and the Grenadines', 'VC', 'VCT', 1),
(181, 'Samoa', 'WS', 'WSM', 1),
(182, 'San Marino', 'SM', 'SMR', 1),
(183, 'Sao Tome and Principe', 'ST', 'STP', 1),
(184, 'Saudi Arabia', 'SA', 'SAU', 1),
(185, 'Senegal', 'SN', 'SEN', 1),
(186, 'Seychelles', 'SC', 'SYC', 1),
(187, 'Sierra Leone', 'SL', 'SLE', 1),
(188, 'Singapore', 'SG', 'SGP', 4),
(189, 'Slovakia (Slovak Republic)', 'SK', 'SVK', 1),
(190, 'Slovenia', 'SI', 'SVN', 1),
(191, 'Solomon Islands', 'SB', 'SLB', 1),
(192, 'Somalia', 'SO', 'SOM', 1),
(193, 'South Africa', 'ZA', 'ZAF', 1),
(194, 'South Georgia and the South Sandwich Islands', 'GS', 'SGS', 1),
(195, 'Spain', 'ES', 'ESP', 3),
(196, 'Sri Lanka', 'LK', 'LKA', 1),
(197, 'St. Helena', 'SH', 'SHN', 1),
(198, 'St. Pierre and Miquelon', 'PM', 'SPM', 1),
(199, 'Sudan', 'SD', 'SDN', 1),
(200, 'Suriname', 'SR', 'SUR', 1),
(201, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM', 1),
(202, 'Swaziland', 'SZ', 'SWZ', 1),
(203, 'Sweden', 'SE', 'SWE', 1),
(204, 'Switzerland', 'CH', 'CHE', 1),
(205, 'Syrian Arab Republic', 'SY', 'SYR', 1),
(206, 'Taiwan', 'TW', 'TWN', 1),
(207, 'Tajikistan', 'TJ', 'TJK', 1),
(208, 'Tanzania, United Republic of', 'TZ', 'TZA', 1),
(209, 'Thailand', 'TH', 'THA', 1),
(210, 'Togo', 'TG', 'TGO', 1),
(211, 'Tokelau', 'TK', 'TKL', 1),
(212, 'Tonga', 'TO', 'TON', 1),
(213, 'Trinidad and Tobago', 'TT', 'TTO', 1),
(214, 'Tunisia', 'TN', 'TUN', 1),
(215, 'Turkey', 'TR', 'TUR', 1),
(216, 'Turkmenistan', 'TM', 'TKM', 1),
(217, 'Turks and Caicos Islands', 'TC', 'TCA', 1),
(218, 'Tuvalu', 'TV', 'TUV', 1),
(219, 'Uganda', 'UG', 'UGA', 1),
(220, 'Ukraine', 'UA', 'UKR', 1),
(221, 'United Arab Emirates', 'AE', 'ARE', 1),
(222, 'United Kingdom', 'GB', 'GBR', 1),
(223, 'United States', 'US', 'USA', 2),
(224, 'United States Minor Outlying Islands', 'UM', 'UMI', 1),
(225, 'Uruguay', 'UY', 'URY', 1),
(226, 'Uzbekistan', 'UZ', 'UZB', 1),
(227, 'Vanuatu', 'VU', 'VUT', 1),
(228, 'Vatican City State (Holy See)', 'VA', 'VAT', 1),
(229, 'Venezuela', 'VE', 'VEN', 1),
(230, 'Viet Nam', 'VN', 'VNM', 1),
(231, 'Virgin Islands (British)', 'VG', 'VGB', 1),
(232, 'Virgin Islands (U.S.)', 'VI', 'VIR', 1),
(233, 'Wallis and Futuna Islands', 'WF', 'WLF', 1),
(234, 'Western Sahara', 'EH', 'ESH', 1),
(235, 'Yemen', 'YE', 'YEM', 1),
(236, 'Yugoslavia', 'YU', 'YUG', 1),
(237, 'Zaire', 'ZR', 'ZAR', 1),
(238, 'Zambia', 'ZM', 'ZMB', 1),
(239, 'Zimbabwe', 'ZW', 'ZWE', 1);

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE `currencies` (
  `currencies_id` int(11) NOT NULL,
  `title` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `code` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `symbol_left` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `symbol_right` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `decimal_point` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `thousands_point` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `decimal_places` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` float(13,8) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `currencies` (`currencies_id`, `title`, `code`, `symbol_left`, `symbol_right`, `decimal_point`, `thousands_point`, `decimal_places`, `value`, `last_updated`) VALUES
(1, 'U.S. Dollar', 'USD', '$', '', '.', ',', '2', 1.00000000, '2017-01-24 11:09:54'),
(2, 'Euro', 'EUR', '', 'Ã¢â€šÂ¬', '.', ',', '2', 1.00000000, '2017-01-24 11:09:54');

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customers_id` int(11) NOT NULL,
  `customers_gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customers_firstname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_lastname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_dob` datetime NOT NULL DEFAULT '1970-01-01 00:00:01',
  `customers_email_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_default_address_id` int(11) DEFAULT NULL,
  `customers_telephone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_fax` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customers_password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `customers_newsletter` char(1) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `customers_basket`;
CREATE TABLE `customers_basket` (
  `customers_basket_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `products_id` tinytext COLLATE utf8_unicode_ci NOT NULL,
  `customers_basket_quantity` int(2) NOT NULL,
  `final_price` decimal(15,4) DEFAULT NULL,
  `customers_basket_date_added` char(8) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `customers_basket_attributes`;
CREATE TABLE `customers_basket_attributes` (
  `customers_basket_attributes_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `products_id` tinytext COLLATE utf8_unicode_ci NOT NULL,
  `products_options_id` int(11) NOT NULL,
  `products_options_value_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `customers_info`;
CREATE TABLE `customers_info` (
  `customers_info_id` int(11) NOT NULL,
  `customers_info_date_of_last_logon` datetime DEFAULT NULL,
  `customers_info_number_of_logons` int(5) DEFAULT NULL,
  `customers_info_date_account_created` datetime DEFAULT NULL,
  `customers_info_date_account_last_modified` datetime DEFAULT NULL,
  `global_product_notifications` int(1) DEFAULT '0',
  `password_reset_key` char(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_reset_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `geo_zones`;
CREATE TABLE `geo_zones` (
  `geo_zone_id` int(11) NOT NULL,
  `geo_zone_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `geo_zone_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `geo_zones` (`geo_zone_id`, `geo_zone_name`, `geo_zone_description`, `last_modified`, `date_added`) VALUES
(1, 'All', 'Florida local sales tax zone', '2017-01-26 07:05:34', '2017-01-24 11:09:54');

DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `languages_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `code` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `directory` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort_order` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `languages` (`languages_id`, `name`, `code`, `image`, `directory`, `sort_order`) VALUES
(1, 'English', 'en', 'icon.gif', 'english', 1);


DROP TABLE IF EXISTS `manufacturers`;
CREATE TABLE `manufacturers` (
  `manufacturers_id` int(11) NOT NULL,
  `manufacturers_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `manufacturers_image` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `manufacturers` (`manufacturers_id`, `manufacturers_name`, `manufacturers_image`, `date_added`, `last_modified`) VALUES
(1, 'Matrox', 'manufacturer_matrox.gif', '2017-01-24 11:09:54', NULL),
(2, 'Microsoft', 'manufacturer_microsoft.gif', '2017-01-24 11:09:54', NULL),
(3, 'Warner', 'manufacturer_warner.gif', '2017-01-24 11:09:54', NULL),
(4, 'Fox', 'manufacturer_fox.gif', '2017-01-24 11:09:54', NULL),
(5, 'Logitech', 'manufacturer_logitech.gif', '2017-01-24 11:09:54', NULL),
(6, 'Canon', 'manufacturer_canon.gif', '2017-01-24 11:09:54', NULL),
(7, 'Sierra', 'manufacturer_sierra.gif', '2017-01-24 11:09:54', NULL),
(8, 'GT Interactive', 'manufacturer_gt_interactive.gif', '2017-01-24 11:09:54', NULL),
(9, 'Hewlett Packard', 'manufacturer_hewlett_packard.gif', '2017-01-24 11:09:54', NULL),
(10, 'Samsung', 'manufacturer_samsung.png', '2017-01-24 11:09:54', NULL);

DROP TABLE IF EXISTS `manufacturers_info`;
CREATE TABLE `manufacturers_info` (
  `manufacturers_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `manufacturers_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url_clicked` int(5) NOT NULL DEFAULT '0',
  `date_last_click` datetime DEFAULT NULL,
  `manufacturers_description` text COLLATE utf8_unicode_ci,
  `manufacturers_seo_description` text COLLATE utf8_unicode_ci,
  `manufacturers_seo_keywords` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `manufacturers_seo_title` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `manufacturers_info` (`manufacturers_id`, `languages_id`, `manufacturers_url`, `url_clicked`, `date_last_click`, `manufacturers_description`, `manufacturers_seo_description`, `manufacturers_seo_keywords`, `manufacturers_seo_title`) VALUES
(1, 1, 'http://www.matrox.com', 0, NULL, NULL, NULL, NULL, NULL),
(2, 1, 'http://www.microsoft.com', 0, NULL, NULL, NULL, NULL, NULL),
(3, 1, 'http://www.warner.com', 0, NULL, NULL, NULL, NULL, NULL),
(4, 1, 'http://www.fox.com', 0, NULL, NULL, NULL, NULL, NULL),
(5, 1, 'http://www.logitech.com', 0, NULL, NULL, NULL, NULL, NULL),
(6, 1, 'http://www.canon.com', 0, NULL, NULL, NULL, NULL, NULL),
(7, 1, 'http://www.sierra.com', 0, NULL, NULL, NULL, NULL, NULL),
(8, 1, 'http://www.infogrames.com', 0, NULL, NULL, NULL, NULL, NULL),
(9, 1, 'http://www.hewlettpackard.com', 0, NULL, NULL, NULL, NULL, NULL),
(10, 1, 'http://www.samsung.com', 1, '2017-02-02 06:02:49', NULL, NULL, NULL, NULL);

DROP TABLE IF EXISTS `newsletters`;
CREATE TABLE `newsletters` (
  `newsletters_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `module` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_added` datetime NOT NULL,
  `date_sent` datetime DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `locked` int(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orders_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `customers_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customers_street_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_suburb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customers_city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_postcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customers_country` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_telephone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_email_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_address_format_id` int(5) NOT NULL,
  `delivery_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delivery_street_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_suburb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delivery_city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_postcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delivery_country` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_address_format_id` int(5) NOT NULL,
  `billing_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `billing_company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_street_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `billing_suburb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `billing_postcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `billing_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_country` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `billing_address_format_id` int(5) NOT NULL,
  `payment_method` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cc_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc_owner` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc_number` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc_expires` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_purchased` datetime DEFAULT NULL,
  `orders_status` int(5) NOT NULL,
  `orders_date_finished` datetime DEFAULT NULL,
  `currency` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency_value` decimal(14,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `orders_products`;
CREATE TABLE `orders_products` (
  `orders_products_id` int(11) NOT NULL,
  `orders_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `products_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `products_price` decimal(15,4) NOT NULL,
  `final_price` decimal(15,4) NOT NULL,
  `products_tax` decimal(7,4) NOT NULL,
  `products_quantity` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `orders_products_attributes`;
CREATE TABLE `orders_products_attributes` (
  `orders_products_attributes_id` int(11) NOT NULL,
  `orders_id` int(11) NOT NULL,
  `orders_products_id` int(11) NOT NULL,
  `products_options` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `products_options_values` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `orders_products_attributes` (`orders_products_attributes_id`, `orders_id`, `orders_products_id`, `products_options`, `products_options_values`, `options_values_price`, `price_prefix`) VALUES
(1, 2, 2, 'Memory', '4 mb', '0.0000', '+'),
(2, 2, 2, 'Model', 'Value', '0.0000', '+');

DROP TABLE IF EXISTS `orders_products_download`;
CREATE TABLE `orders_products_download` (
  `orders_products_download_id` int(11) NOT NULL,
  `orders_id` int(11) NOT NULL DEFAULT '0',
  `orders_products_id` int(11) NOT NULL DEFAULT '0',
  `orders_products_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `download_maxdays` int(2) NOT NULL DEFAULT '0',
  `download_count` int(2) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `orders_status`;
CREATE TABLE `orders_status` (
  `orders_status_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `orders_status_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `public_flag` int(11) DEFAULT '1',
  `downloads_flag` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `orders_status` (`orders_status_id`, `language_id`, `orders_status_name`, `public_flag`, `downloads_flag`) VALUES
(1, 1, 'Pending', 1, 0),
(2, 1, 'Processing', 1, 1),
(3, 1, 'Delivered', 1, 1),
(4, 1, 'PayPal [Transactions]', 0, 0),
(5, 1, 'Authorize.net [Transactions]', 0, 0);

DROP TABLE IF EXISTS `orders_status_history`;
CREATE TABLE `orders_status_history` (
  `orders_status_history_id` int(11) NOT NULL,
  `orders_id` int(11) NOT NULL,
  `orders_status_id` int(5) NOT NULL,
  `date_added` datetime NOT NULL,
  `customer_notified` int(1) DEFAULT '0',
  `comments` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `orders_total`;
CREATE TABLE `orders_total` (
  `orders_total_id` int(10) UNSIGNED NOT NULL,
  `orders_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` decimal(15,4) NOT NULL,
  `class` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `oscom_app_paypal_log`;
CREATE TABLE `oscom_app_paypal_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `customers_id` int(11) NOT NULL,
  `module` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `result` tinyint(4) NOT NULL,
  `server` tinyint(4) NOT NULL,
  `request` text COLLATE utf8_unicode_ci NOT NULL,
  `response` text COLLATE utf8_unicode_ci NOT NULL,
  `ip_address` int(10) UNSIGNED DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `products_id` int(11) NOT NULL,
  `products_quantity` int(4) NOT NULL,
  `products_model` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `products_image` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_folder` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_display` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `products_price` decimal(15,4) NOT NULL,
  `products_date_added` datetime NOT NULL,
  `products_last_modified` datetime DEFAULT NULL,
  `products_date_available` datetime DEFAULT NULL,
  `products_weight` decimal(5,2) NOT NULL,
  `products_status` tinyint(1) NOT NULL,
  `products_tax_class_id` int(11) NOT NULL,
  `manufacturers_id` int(11) DEFAULT NULL,
  `products_ordered` int(11) NOT NULL DEFAULT '0',
  `products_gtin` char(14) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products` (`products_id`, `products_quantity`, `products_model`, `products_image`, `image_folder`, `image_display`, `products_price`, `products_date_added`, `products_last_modified`, `products_date_available`, `products_weight`, `products_status`, `products_tax_class_id`, `manufacturers_id`, `products_ordered`, `products_gtin`) VALUES
(1, 31, 'MG200MMS', 'matrox/mg200mms.gif', NULL, 0, '299.9900', '2017-01-24 11:09:54', NULL, NULL, '23.00', 1, 1, 1, 1, ''),
(2, 32, 'MG400-32MB', 'matrox/mg400-32mb.gif', NULL, 0, '499.9900', '2017-01-24 11:09:54', NULL, NULL, '23.00', 1, 1, 1, 0, ''),
(3, 2, 'MSIMPRO', 'microsoft/msimpro.gif', NULL, 0, '49.9900', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 3, 0, ''),
(4, 13, 'DVD-RPMK', 'dvd/replacement_killers.gif', NULL, 0, '42.0000', '2017-01-24 11:09:54', NULL, NULL, '23.00', 1, 1, 2, 0, ''),
(5, 16, 'DVD-BLDRNDC', 'dvd/blade_runner.gif', NULL, 0, '35.9900', '2017-01-24 11:09:54', '2017-01-26 13:03:53', NULL, '7.00', 1, 1, 3, 1, NULL),
(6, 10, 'DVD-MATR', 'dvd/the_matrix.gif', NULL, 0, '39.9900', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 3, 0, ''),
(7, 9, 'DVD-YGEM', 'youve_got_mail.gif', NULL, 0, '34.9900', '2017-01-24 11:09:54', '2017-02-01 14:31:56', NULL, '7.00', 1, 1, 3, 1, NULL),
(8, 9, 'DVD-ABUG', 'dvd/a_bugs_life.gif', NULL, 0, '35.9900', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 3, 1, ''),
(9, 10, 'DVD-UNSG', 'dvd/under_siege.gif', NULL, 0, '29.9900', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 3, 0, ''),
(10, 10, 'DVD-UNSG2', 'dvd/under_siege2.gif', NULL, 0, '29.9900', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 3, 0, ''),
(11, 10, 'DVD-FDBL', 'dvd/fire_down_below.gif', NULL, 0, '29.9900', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 3, 0, ''),
(12, 10, 'DVD-DHWV', 'dvd/die_hard_3.gif', NULL, 0, '39.9900', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 4, 0, ''),
(13, 10, 'DVD-LTWP', 'dvd/lethal_weapon.gif', NULL, 0, '34.9900', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 3, 0, ''),
(14, 9, 'DVD-REDC', 'dvd/red_corner.gif', NULL, 0, '32.0000', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 3, 1, ''),
(15, 9, 'DVD-FRAN', 'dvd/frantic.gif', NULL, 0, '35.0000', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 3, 1, ''),
(16, 9, 'DVD-CUFI', 'dvd/courage_under_fire.gif', NULL, 0, '38.9900', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 4, 1, ''),
(17, 9, 'DVD-SPEED', 'dvd/speed.gif', NULL, 0, '39.9900', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 4, 1, ''),
(18, 10, 'DVD-SPEED2', 'dvd/speed_2.gif', NULL, 0, '42.0000', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 4, 0, ''),
(19, 10, 'DVD-TSAB', 'theres_something_about_mary.gif', NULL, 0, '49.9900', '2017-01-24 11:09:54', '2017-02-01 14:31:27', NULL, '7.00', 1, 1, 4, 0, NULL),
(20, 9, 'DVD-BELOVED', NULL, NULL, 1, '54.9900', '2017-01-24 11:09:54', '2017-02-02 04:38:50', NULL, '7.00', 1, 1, 3, 1, NULL),
(21, 16, 'PC-SWAT3', 'sierra/swat_3.gif', NULL, 0, '79.9900', '2017-01-24 11:09:54', NULL, NULL, '7.00', 1, 1, 7, 0, ''),
(22, 13, 'PC-UNTM', 'gt_interactive/unreal_tournament.gif', NULL, 0, '89.9900', '2017-01-24 11:09:54', '2017-01-26 07:09:57', NULL, '7.00', 1, 1, 8, 0, '0000000000TEST'),
(23, 15, 'PC-TWOF', 'gt_interactive/wheel_of_time.gif', NULL, 0, '99.9900', '2017-01-24 11:09:54', NULL, NULL, '10.00', 1, 1, 8, 1, ''),
(24, 17, 'PC-DISC', 'gt_interactive/disciples.gif', NULL, 0, '90.0000', '2017-01-24 11:09:54', '2017-01-26 06:38:14', NULL, '8.00', 1, 1, 8, 0, NULL),
(25, 16, 'MSINTKB', 'microsoft/intkeyboardps2.gif', NULL, 0, '69.9900', '2017-01-24 11:09:54', NULL, NULL, '8.00', 1, 1, 2, 0, ''),
(26, 10, 'MSIMEXP', NULL, NULL, 1, '64.9500', '2017-01-24 11:09:54', '2017-02-02 05:48:21', NULL, '8.00', 1, 1, 2, 0, NULL),
(27, 8, 'HPLJ1100XI', 'hewlett_packard/lj1100xi.gif', NULL, 0, '499.9900', '2017-01-24 11:09:54', NULL, NULL, '45.00', 1, 1, 9, 0, ''),
(28, 99, 'GT-P1000', 'samsung/galaxy_tab.gif', NULL, 0, '749.9900', '2017-01-24 11:09:54', NULL, NULL, '1.00', 1, 1, 10, 1, '');

DROP TABLE IF EXISTS `products_attributes`;
CREATE TABLE `products_attributes` (
  `products_attributes_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `options_id` int(11) NOT NULL,
  `options_values_id` int(11) NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products_attributes` (`products_attributes_id`, `products_id`, `options_id`, `options_values_id`, `options_values_price`, `price_prefix`) VALUES
(1, 1, 4, 1, '0.0000', '+'),
(2, 1, 4, 2, '50.0000', '+'),
(3, 1, 4, 3, '70.0000', '+'),
(4, 1, 3, 5, '0.0000', '+'),
(5, 1, 3, 6, '100.0000', '+'),
(6, 2, 4, 3, '10.0000', '-'),
(7, 2, 4, 4, '0.0000', '+'),
(8, 2, 3, 6, '0.0000', '+'),
(9, 2, 3, 7, '120.0000', '+'),
(10, 26, 3, 8, '0.0000', '+'),
(11, 26, 3, 9, '6.0000', '+'),
(26, 22, 5, 10, '0.0000', '+'),
(27, 22, 5, 13, '0.0000', '+');

DROP TABLE IF EXISTS `products_attributes_download`;
CREATE TABLE `products_attributes_download` (
  `products_attributes_id` int(11) NOT NULL,
  `products_attributes_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `products_attributes_maxdays` int(2) DEFAULT '0',
  `products_attributes_maxcount` int(2) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products_attributes_download` (`products_attributes_id`, `products_attributes_filename`, `products_attributes_maxdays`, `products_attributes_maxcount`) VALUES
(26, 'unreal.zip', 7, 3);

DROP TABLE IF EXISTS `products_description`;
CREATE TABLE `products_description` (
  `products_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL DEFAULT '1',
  `products_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `products_description` text COLLATE utf8_unicode_ci,
  `products_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `products_viewed` int(5) DEFAULT '0',
  `products_seo_description` text COLLATE utf8_unicode_ci,
  `products_seo_keywords` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `products_seo_title` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products_description` (`products_id`, `language_id`, `products_name`, `products_description`, `products_url`, `products_viewed`, `products_seo_description`, `products_seo_keywords`, `products_seo_title`) VALUES
(1, 1, 'Matrox G200 MMS', 'Reinforcing its position as a multi-monitor trailblazer, Matrox Graphics Inc. has once again developed the most flexible and highly advanced solution in the industry. Introducing the new Matrox G200 Multi-Monitor Series; the first graphics card ever to support up to four DVI digital flat panel displays on a single 8&quot; PCI board.<br /><br />With continuing demand for digital flat panels in the financial workplace, the Matrox G200 MMS is the ultimate in flexible solutions. The Matrox G200 MMS also supports the new digital video interface (DVI) created by the Digital Display Working Group (DDWG) designed to ease the adoption of digital flat panels. Other configurations include composite video capture ability and onboard TV tuner, making the Matrox G200 MMS the complete solution for business needs.<br /><br />Based on the award-winning MGA-G200 graphics chip, the Matrox G200 Multi-Monitor Series provides superior 2D/3D graphics acceleration to meet the demanding needs of business applications such as real-time stock quotes (Versus), live video feeds (Reuters &amp; Bloombergs), multiple windows applications, word processing, spreadsheets and CAD.', 'www.matrox.com/mga/products/g200_mms/home.cfm', 38, NULL, NULL, NULL),
(2, 1, 'Matrox G400 32MB', '<strong>Dramatically Different High Performance Graphics</strong><br /><br />Introducing the Millennium G400 Series - a dramatically different, high performance graphics experience. Armed with the industry\'s fastest graphics chip, the Millennium G400 Series takes explosive acceleration two steps further by adding unprecedented image quality, along with the most versatile display options for all your 3D, 2D and DVD applications. As the most powerful and innovative tools in your PC\'s arsenal, the Millennium G400 Series will not only change the way you see graphics, but will revolutionize the way you use your computer.<br /><br /><strong>Key features:</strong><ul><li>New Matrox G400 256-bit DualBus graphics chip</li><li>Explosive 3D, 2D and DVD performance</li><li>DualHead Display</li><li>Superior DVD and TV output</li><li>3D Environment-Mapped Bump Mapping</li><li>Vibrant Color Quality rendering </li><li>UltraSharp DAC of up to 360 MHz</li><li>3D Rendering Array Processor</li><li>Support for 16 or 32 MB of memory</li></ul>', 'www.matrox.com/mga/products/mill_g400/home.htm', 40, NULL, NULL, NULL),
(3, 1, 'Microsoft IntelliMouse Pro', 'Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft\'s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.', 'www.microsoft.com/hardware/mouse/intellimouse.asp', 33, NULL, NULL, NULL),
(4, 1, 'The Replacement Killers', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />Languages: English, Deutsch.<br />Subtitles: English, Deutsch, Spanish.<br />Audio: Dolby Surround 5.1.<br />Picture Format: 16:9 Wide-Screen.<br />Length: (approx) 80 minutes.<br />Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'www.replacement-killers.com', 26, NULL, NULL, NULL),
(5, 1, 'Blade Runner - Director\'s Cut', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />\r\nLanguages: English, Deutsch.<br />\r\nSubtitles: English, Deutsch, Spanish.<br />\r\nAudio: Dolby Surround 5.1.<br />\r\nPicture Format: 16:9 Wide-Screen.<br />\r\nLength: (approx) 112 minutes.<br />\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'www.bladerunner.com', 26, '', '', ''),
(6, 1, 'The Matrix', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch.\r<br />\nAudio: Dolby Surround.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 131 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Making Of.', 'www.thematrix.com', 21, NULL, NULL, NULL),
(7, 1, 'You\'ve Got Mail', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />\r\nLanguages: English, Deutsch, Spanish.<br />\r\nSubtitles: English, Deutsch, Spanish, French, Nordic, Polish.<br />\r\nAudio: Dolby Digital 5.1.<br />\r\nPicture Format: 16:9 Wide-Screen.<br />\r\nLength: (approx) 115 minutes.<br />\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'www.youvegotmail.com', 21, '', '', ''),
(8, 1, 'A Bug\'s Life', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Digital 5.1 / Dobly Surround Stereo.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 91 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'www.abugslife.com', 48, NULL, NULL, NULL),
(9, 1, 'Under Siege', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 98 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 26, NULL, NULL, NULL),
(10, 1, 'Under Siege 2 - Dark Territory', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 98 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 22, NULL, NULL, NULL),
(11, 1, 'Fire Down Below', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 100 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 20, NULL, NULL, NULL),
(12, 1, 'Die Hard With A Vengeance', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 122 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 27, NULL, NULL, NULL),
(13, 1, 'Lethal Weapon', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 100 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 22, NULL, NULL, NULL),
(14, 1, 'Red Corner', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 117 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 24, NULL, NULL, NULL),
(15, 1, 'Frantic', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 115 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 23, NULL, NULL, NULL),
(16, 1, 'Courage Under Fire', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 112 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 29, NULL, NULL, NULL),
(17, 1, 'Speed', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 112 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 24, NULL, NULL, NULL),
(18, 1, 'Speed 2: Cruise Control', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 120 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 20, NULL, NULL, NULL),
(19, 1, 'There\'s Something About Mary', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />\r\nLanguages: English, Deutsch.<br />\r\nSubtitles: English, Deutsch, Spanish.<br />\r\nAudio: Dolby Surround 5.1.<br />\r\nPicture Format: 16:9 Wide-Screen.<br />\r\nLength: (approx) 114 minutes.<br />\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 21, '', '', ''),
(20, 1, 'Beloved', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />\r\nLanguages: English, Deutsch.<br />\r\nSubtitles: English, Deutsch, Spanish.<br />\r\nAudio: Dolby Surround 5.1.<br />\r\nPicture Format: 16:9 Wide-Screen.<br />\r\nLength: (approx) 164 minutes.<br />\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 38, '', '', ''),
(21, 1, 'SWAT 3: Close Quarters Battle', '<strong>Windows 95/98</strong><br /><br />211 in progress with shots fired. Officer down. Armed suspects with hostages. Respond Code 3! Los Angles, 2005, In the next seven days, representatives from every nation around the world will converge on Las Angles to witness the signing of the United Nations Nuclear Abolishment Treaty. The protection of these dignitaries falls on the shoulders of one organization, LAPD SWAT. As part of this elite tactical organization, you and your team have the weapons and all the training necessary to protect, to serve, and \"When needed\" to use deadly force to keep the peace. It takes more than weapons to make it through each mission. Your arsenal includes C2 charges, flashbangs, tactical grenades. opti-Wand mini-video cameras, and other devices critical to meeting your objectives and keeping your men free of injury. Uncompromised Duty, Honor and Valor!', 'www.swat3.com', 27, NULL, NULL, NULL),
(22, 1, 'Unreal Tournament', 'From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br />\r\n<br />\r\nThis stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It&#39;s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of &#39;bots&#39; (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.', 'www.unrealtournament.net', 49, '', '', ''),
(23, 1, 'The Wheel Of Time', 'The world in which The Wheel of Time takes place is lifted directly out of Jordan\'s pages; it\'s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you\'re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter\'angreal, Portal Stones, and the Ways. However you move around, though, you\'ll quickly discover that means of locomotion can easily become the least of the your worries...<br /><br />During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time\'s main characters. Some of these places are ripped directly from the pages of Jordan\'s books, made flesh with Legend\'s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you\'ll have this year.', 'www.wheeloftime.com', 28, NULL, NULL, NULL),
(24, 1, 'Disciples: Sacred Lands', 'A new age is dawning...<br />\r\n<br />\r\nEnter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br />\r\n<br />\r\nThe day of reckoning has come... and only the chosen will survive.', '', 42, '', '', ''),
(25, 1, 'Microsoft Internet Keyboard PS/2', 'The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!', '', 28, NULL, NULL, NULL),
(26, 1, 'Microsoft IntelliMouse Explorer', 'Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!', 'www.microsoft.com/hardware/mouse/explorer.asp', 28, '', '', ''),
(27, 1, 'Hewlett Packard LaserJet 1100Xi', 'HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP\'s Resolution Enhancement technology (REt) makes every document more professional.<br /><br />Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br /><br />HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).', 'www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100', 34, NULL, NULL, NULL),
(28, 1, 'Samsung Galaxy Tab', '<p>Powered by a Cortex A8 1.0GHz application processor, the Samsung GALAXY Tab is designed to deliver high performance whenever and wherever you are. At the same time, HD video contents are supported by a wide range of multimedia formats (DivX, XviD, MPEG4, H.263, H.264 and more), which maximizes the joy of entertainment.</p><p>With 3G HSPA connectivity, 802.11n Wi-Fi, and Bluetooth 3.0, the Samsung GALAXY Tab enhances users\' mobile communication on a whole new level. Video conferencing and push email on the large 7-inch display make communication more smooth and efficient. For voice telephony, the Samsung GALAXY Tab turns out to be a perfect speakerphone on the desk, or a mobile phone on the move via Bluetooth headset.</p>', 'http://galaxytab.samsungmobile.com', 37, NULL, NULL, NULL);

DROP TABLE IF EXISTS `products_images`;
CREATE TABLE `products_images` (
  `id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `image` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `htmlcontent` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products_images` (`id`, `products_id`, `image`, `htmlcontent`, `sort_order`) VALUES
(1, 28, 'samsung/galaxy_tab_1.jpg', NULL, 1),
(2, 28, 'samsung/galaxy_tab_2.jpg', NULL, 2),
(3, 28, 'samsung/galaxy_tab_3.jpg', NULL, 3),
(4, 28, 'samsung/galaxy_tab_4.jpg', '<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/tAbsmHMAhrQ\" frameborder=\"0\" allowfullscreen></iframe>', 4),
(5, 17, 'dvd/speed_large.jpg', NULL, 1),
(6, 12, 'dvd/die_hard_3_large.jpg', NULL, 1),
(7, 11, 'dvd/fire_down_below_large.jpg', NULL, 1),
(8, 13, 'dvd/lethal_weapon_large.jpg', NULL, 1),
(9, 18, 'dvd/speed_2_large.jpg', NULL, 1),
(10, 6, 'dvd/the_matrix_large.jpg', NULL, 1),
(11, 4, 'dvd/replacement_killers_large.jpg', NULL, 1),
(12, 9, 'dvd/under_siege_large.jpg', NULL, 1),
(17, 19, 'theres_something_about_mary.gif', '', 1),
(18, 7, 'youve_got_mail.gif', '', 1);

DROP TABLE IF EXISTS `products_notifications`;
CREATE TABLE `products_notifications` (
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `products_options`;
CREATE TABLE `products_options` (
  `products_options_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `products_options_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products_options` (`products_options_id`, `language_id`, `products_options_name`) VALUES
(1, 1, 'Color'),
(2, 1, 'Size'),
(3, 1, 'Model'),
(4, 1, 'Memory'),
(5, 1, 'Version');

DROP TABLE IF EXISTS `products_options_values`;
CREATE TABLE `products_options_values` (
  `products_options_values_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `products_options_values_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products_options_values` (`products_options_values_id`, `language_id`, `products_options_values_name`) VALUES
(1, 1, '4 mb'),
(2, 1, '8 mb'),
(3, 1, '16 mb'),
(4, 1, '32 mb'),
(5, 1, 'Value'),
(6, 1, 'Premium'),
(7, 1, 'Deluxe'),
(8, 1, 'PS/2'),
(9, 1, 'USB'),
(10, 1, 'Download: Windows - English'),
(13, 1, 'Box: Windows - English');

DROP TABLE IF EXISTS `products_options_values_to_products_options`;
CREATE TABLE `products_options_values_to_products_options` (
  `products_options_values_to_products_options_id` int(11) NOT NULL,
  `products_options_id` int(11) NOT NULL,
  `products_options_values_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products_options_values_to_products_options` (`products_options_values_to_products_options_id`, `products_options_id`, `products_options_values_id`) VALUES
(1, 4, 1),
(2, 4, 2),
(3, 4, 3),
(4, 4, 4),
(5, 3, 5),
(6, 3, 6),
(7, 3, 7),
(8, 3, 8),
(9, 3, 9),
(10, 5, 10),
(13, 5, 13);

DROP TABLE IF EXISTS `products_to_categories`;
CREATE TABLE `products_to_categories` (
  `products_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products_to_categories` (`products_id`, `categories_id`) VALUES
(1, 4),
(2, 4),
(3, 9),
(4, 10),
(5, 11),
(6, 10),
(7, 12),
(8, 13),
(9, 10),
(10, 10),
(11, 10),
(12, 10),
(13, 10),
(14, 15),
(15, 14),
(16, 15),
(17, 10),
(18, 10),
(19, 12),
(20, 15),
(21, 18),
(22, 19),
(23, 20),
(24, 20),
(25, 8),
(26, 9),
(27, 5),
(28, 23);

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `reviews_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) DEFAULT NULL,
  `customers_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `reviews_rating` int(1) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `reviews_status` tinyint(1) NOT NULL DEFAULT '0',
  `reviews_read` int(5) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `reviews` (`reviews_id`, `products_id`, `customers_id`, `customers_name`, `reviews_rating`, `date_added`, `last_modified`, `reviews_status`, `reviews_read`) VALUES
(1, 19, 0, 'John Doe', 5, '2017-01-24 11:09:54', '2017-01-26 08:29:51', 1, 0);

DROP TABLE IF EXISTS `reviews_description`;
CREATE TABLE `reviews_description` (
  `reviews_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `reviews_text` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `reviews_description` (`reviews_id`, `languages_id`, `reviews_text`) VALUES
(1, 1, 'This has to be one of the funniest movies released for 1999!');

DROP TABLE IF EXISTS `sec_directory_whitelist`;
CREATE TABLE `sec_directory_whitelist` (
  `id` int(11) NOT NULL,
  `directory` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `sec_directory_whitelist` (`id`, `directory`) VALUES
(1, 'admin/backups'),
(2, 'admin/images/graphs'),
(3, 'images'),
(4, 'images/banners'),
(5, 'images/dvd'),
(6, 'images/gt_interactive'),
(7, 'images/hewlett_packard'),
(8, 'images/matrox'),
(9, 'images/microsoft'),
(10, 'images/samsung'),
(11, 'images/sierra'),
(12, 'includes/work'),
(13, 'pub');

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `sesskey` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `expiry` int(11) UNSIGNED NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `specials`;
CREATE TABLE `specials` (
  `specials_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `specials_new_products_price` decimal(15,4) NOT NULL,
  `specials_date_added` datetime DEFAULT NULL,
  `specials_last_modified` datetime DEFAULT NULL,
  `expires_date` datetime DEFAULT NULL,
  `date_status_change` datetime DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `specials` (`specials_id`, `products_id`, `specials_new_products_price`, `specials_date_added`, `specials_last_modified`, `expires_date`, `date_status_change`, `status`) VALUES
(1, 3, '39.9900', '2017-01-24 11:09:54', NULL, NULL, NULL, 1),
(2, 5, '30.0000', '2017-01-24 11:09:54', NULL, NULL, NULL, 1),
(3, 6, '30.0000', '2017-01-24 11:09:54', NULL, NULL, NULL, 1),
(4, 16, '29.9900', '2017-01-24 11:09:54', NULL, NULL, NULL, 1),
(5, 2, '399.9900', '2017-01-30 08:04:24', NULL, NULL, NULL, 1),
(6, 8, '22.0000', '2017-01-30 08:04:43', '2017-02-01 14:08:38', NULL, NULL, 1),
(7, 20, '35.0000', '2017-02-02 05:14:37', NULL, NULL, NULL, 1),
(8, 1, '150.0000', '2017-02-02 10:59:53', NULL, NULL, NULL, 1);

DROP TABLE IF EXISTS `tax_class`;
CREATE TABLE `tax_class` (
  `tax_class_id` int(11) NOT NULL,
  `tax_class_title` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `tax_class_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `tax_class` (`tax_class_id`, `tax_class_title`, `tax_class_description`, `last_modified`, `date_added`) VALUES
(1, 'Taxable Goods', 'The following types of products are included non-food, services, etc', '2017-01-24 11:09:54', '2017-01-24 11:09:54');

DROP TABLE IF EXISTS `tax_rates`;
CREATE TABLE `tax_rates` (
  `tax_rates_id` int(11) NOT NULL,
  `tax_zone_id` int(11) NOT NULL,
  `tax_class_id` int(11) NOT NULL,
  `tax_priority` int(5) DEFAULT '1',
  `tax_rate` decimal(7,4) NOT NULL,
  `tax_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `tax_rates` (`tax_rates_id`, `tax_zone_id`, `tax_class_id`, `tax_priority`, `tax_rate`, `tax_description`, `last_modified`, `date_added`) VALUES
(1, 1, 1, 1, '7.0000', 'FL TAX 7.0%', '2017-01-24 11:09:54', '2017-01-24 11:09:54');

DROP TABLE IF EXISTS `testimonials`;
CREATE TABLE `testimonials` (
  `testimonials_id` int(11) NOT NULL,
  `customers_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `testimonials_status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `testimonials` (`testimonials_id`, `customers_name`, `date_added`, `last_modified`, `testimonials_status`) VALUES
(2, 'Simon', '2017-01-26 10:55:23', NULL, 1),
(3, 'Picky', '2017-01-26 10:56:00', NULL, 1),
(5, 'Frank', '2017-01-26 13:42:51', '2017-01-26 13:42:57', 1),
(6, 'Georg', '2017-01-26 13:43:49', NULL, 1);

DROP TABLE IF EXISTS `testimonials_description`;
CREATE TABLE `testimonials_description` (
  `testimonials_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `testimonials_text` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `testimonials_description` (`testimonials_id`, `languages_id`, `testimonials_text`) VALUES
(2, 1, 'The products and service here is fantastic. I will definitely purchase from this store again.'),
(3, 1, 'Thanks for the great response for my orders, the delivery is always in time.\r\n\r\nKids just love it, thanks again.'),
(5, 1, 'Best purchase ever. These guys know how to provide a good service.\r\n\r\nThank you so much.'),
(6, 1, 'Will come back again!');

DROP TABLE IF EXISTS `whos_online`;
CREATE TABLE `whos_online` (
  `customer_id` int(11) DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `session_id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `ip_address` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `time_entry` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `time_last_click` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `last_page_url` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `zones`;
CREATE TABLE `zones` (
  `zone_id` int(11) NOT NULL,
  `zone_country_id` int(11) NOT NULL,
  `zone_code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `zone_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `zones` (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES
(1, 223, 'AL', 'Alabama'),
(2, 223, 'AK', 'Alaska'),
(3, 223, 'AS', 'American Samoa'),
(4, 223, 'AZ', 'Arizona'),
(5, 223, 'AR', 'Arkansas'),
(6, 223, 'AF', 'Armed Forces Africa'),
(7, 223, 'AA', 'Armed Forces Americas'),
(8, 223, 'AC', 'Armed Forces Canada'),
(9, 223, 'AE', 'Armed Forces Europe'),
(10, 223, 'AM', 'Armed Forces Middle East'),
(11, 223, 'AP', 'Armed Forces Pacific'),
(12, 223, 'CA', 'California'),
(13, 223, 'CO', 'Colorado'),
(14, 223, 'CT', 'Connecticut'),
(15, 223, 'DE', 'Delaware'),
(16, 223, 'DC', 'District of Columbia'),
(17, 223, 'FM', 'Federated States Of Micronesia'),
(18, 223, 'FL', 'Florida'),
(19, 223, 'GA', 'Georgia'),
(20, 223, 'GU', 'Guam'),
(21, 223, 'HI', 'Hawaii'),
(22, 223, 'ID', 'Idaho'),
(23, 223, 'IL', 'Illinois'),
(24, 223, 'IN', 'Indiana'),
(25, 223, 'IA', 'Iowa'),
(26, 223, 'KS', 'Kansas'),
(27, 223, 'KY', 'Kentucky'),
(28, 223, 'LA', 'Louisiana'),
(29, 223, 'ME', 'Maine'),
(30, 223, 'MH', 'Marshall Islands'),
(31, 223, 'MD', 'Maryland'),
(32, 223, 'MA', 'Massachusetts'),
(33, 223, 'MI', 'Michigan'),
(34, 223, 'MN', 'Minnesota'),
(35, 223, 'MS', 'Mississippi'),
(36, 223, 'MO', 'Missouri'),
(37, 223, 'MT', 'Montana'),
(38, 223, 'NE', 'Nebraska'),
(39, 223, 'NV', 'Nevada'),
(40, 223, 'NH', 'New Hampshire'),
(41, 223, 'NJ', 'New Jersey'),
(42, 223, 'NM', 'New Mexico'),
(43, 223, 'NY', 'New York'),
(44, 223, 'NC', 'North Carolina'),
(45, 223, 'ND', 'North Dakota'),
(46, 223, 'MP', 'Northern Mariana Islands'),
(47, 223, 'OH', 'Ohio'),
(48, 223, 'OK', 'Oklahoma'),
(49, 223, 'OR', 'Oregon'),
(50, 223, 'PW', 'Palau'),
(51, 223, 'PA', 'Pennsylvania'),
(52, 223, 'PR', 'Puerto Rico'),
(53, 223, 'RI', 'Rhode Island'),
(54, 223, 'SC', 'South Carolina'),
(55, 223, 'SD', 'South Dakota'),
(56, 223, 'TN', 'Tennessee'),
(57, 223, 'TX', 'Texas'),
(58, 223, 'UT', 'Utah'),
(59, 223, 'VT', 'Vermont'),
(60, 223, 'VI', 'Virgin Islands'),
(61, 223, 'VA', 'Virginia'),
(62, 223, 'WA', 'Washington'),
(63, 223, 'WV', 'West Virginia'),
(64, 223, 'WI', 'Wisconsin'),
(65, 223, 'WY', 'Wyoming'),
(66, 38, 'AB', 'Alberta'),
(67, 38, 'BC', 'British Columbia'),
(68, 38, 'MB', 'Manitoba'),
(69, 38, 'NF', 'Newfoundland'),
(70, 38, 'NB', 'New Brunswick'),
(71, 38, 'NS', 'Nova Scotia'),
(72, 38, 'NT', 'Northwest Territories'),
(73, 38, 'NU', 'Nunavut'),
(74, 38, 'ON', 'Ontario'),
(75, 38, 'PE', 'Prince Edward Island'),
(76, 38, 'QC', 'Quebec'),
(77, 38, 'SK', 'Saskatchewan'),
(78, 38, 'YT', 'Yukon Territory'),
(79, 81, 'NDS', 'Niedersachsen'),
(80, 81, 'BAW', 'Baden-WÃƒÂ¼rttemberg'),
(81, 81, 'BAY', 'Bayern'),
(82, 81, 'BER', 'Berlin'),
(83, 81, 'BRG', 'Brandenburg'),
(84, 81, 'BRE', 'Bremen'),
(85, 81, 'HAM', 'Hamburg'),
(86, 81, 'HES', 'Hessen'),
(87, 81, 'MEC', 'Mecklenburg-Vorpommern'),
(88, 81, 'NRW', 'Nordrhein-Westfalen'),
(89, 81, 'RHE', 'Rheinland-Pfalz'),
(90, 81, 'SAR', 'Saarland'),
(91, 81, 'SAS', 'Sachsen'),
(92, 81, 'SAC', 'Sachsen-Anhalt'),
(93, 81, 'SCN', 'Schleswig-Holstein'),
(94, 81, 'THE', 'ThÃƒÂ¼ringen'),
(95, 14, 'WI', 'Wien'),
(96, 14, 'NO', 'NiederÃƒÂ¶sterreich'),
(97, 14, 'OO', 'OberÃƒÂ¶sterreich'),
(98, 14, 'SB', 'Salzburg'),
(99, 14, 'KN', 'KÃƒÂ¤rnten'),
(100, 14, 'ST', 'Steiermark'),
(101, 14, 'TI', 'Tirol'),
(102, 14, 'BL', 'Burgenland'),
(103, 14, 'VB', 'Voralberg'),
(104, 204, 'AG', 'Aargau'),
(105, 204, 'AI', 'Appenzell Innerrhoden'),
(106, 204, 'AR', 'Appenzell Ausserrhoden'),
(107, 204, 'BE', 'Bern'),
(108, 204, 'BL', 'Basel-Landschaft'),
(109, 204, 'BS', 'Basel-Stadt'),
(110, 204, 'FR', 'Freiburg'),
(111, 204, 'GE', 'Genf'),
(112, 204, 'GL', 'Glarus'),
(113, 204, 'JU', 'GraubÃƒÂ¼nden'),
(114, 204, 'JU', 'Jura'),
(115, 204, 'LU', 'Luzern'),
(116, 204, 'NE', 'Neuenburg'),
(117, 204, 'NW', 'Nidwalden'),
(118, 204, 'OW', 'Obwalden'),
(119, 204, 'SG', 'St. Gallen'),
(120, 204, 'SH', 'Schaffhausen'),
(121, 204, 'SO', 'Solothurn'),
(122, 204, 'SZ', 'Schwyz'),
(123, 204, 'TG', 'Thurgau'),
(124, 204, 'TI', 'Tessin'),
(125, 204, 'UR', 'Uri'),
(126, 204, 'VD', 'Waadt'),
(127, 204, 'VS', 'Wallis'),
(128, 204, 'ZG', 'Zug'),
(129, 204, 'ZH', 'ZÃƒÂ¼rich'),
(130, 195, 'A CoruÃƒÂ±a', 'A CoruÃƒÂ±a'),
(131, 195, 'Alava', 'Alava'),
(132, 195, 'Albacete', 'Albacete'),
(133, 195, 'Alicante', 'Alicante'),
(134, 195, 'Almeria', 'Almeria'),
(135, 195, 'Asturias', 'Asturias'),
(136, 195, 'Avila', 'Avila'),
(137, 195, 'Badajoz', 'Badajoz'),
(138, 195, 'Baleares', 'Baleares'),
(139, 195, 'Barcelona', 'Barcelona'),
(140, 195, 'Burgos', 'Burgos'),
(141, 195, 'Caceres', 'Caceres'),
(142, 195, 'Cadiz', 'Cadiz'),
(143, 195, 'Cantabria', 'Cantabria'),
(144, 195, 'Castellon', 'Castellon'),
(145, 195, 'Ceuta', 'Ceuta'),
(146, 195, 'Ciudad Real', 'Ciudad Real'),
(147, 195, 'Cordoba', 'Cordoba'),
(148, 195, 'Cuenca', 'Cuenca'),
(149, 195, 'Girona', 'Girona'),
(150, 195, 'Granada', 'Granada'),
(151, 195, 'Guadalajara', 'Guadalajara'),
(152, 195, 'Guipuzcoa', 'Guipuzcoa'),
(153, 195, 'Huelva', 'Huelva'),
(154, 195, 'Huesca', 'Huesca'),
(155, 195, 'Jaen', 'Jaen'),
(156, 195, 'La Rioja', 'La Rioja'),
(157, 195, 'Las Palmas', 'Las Palmas'),
(158, 195, 'Leon', 'Leon'),
(159, 195, 'Lleida', 'Lleida'),
(160, 195, 'Lugo', 'Lugo'),
(161, 195, 'Madrid', 'Madrid'),
(162, 195, 'Malaga', 'Malaga'),
(163, 195, 'Melilla', 'Melilla'),
(164, 195, 'Murcia', 'Murcia'),
(165, 195, 'Navarra', 'Navarra'),
(166, 195, 'Ourense', 'Ourense'),
(167, 195, 'Palencia', 'Palencia'),
(168, 195, 'Pontevedra', 'Pontevedra'),
(169, 195, 'Salamanca', 'Salamanca'),
(170, 195, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife'),
(171, 195, 'Segovia', 'Segovia'),
(172, 195, 'Sevilla', 'Sevilla'),
(173, 195, 'Soria', 'Soria'),
(174, 195, 'Tarragona', 'Tarragona'),
(175, 195, 'Teruel', 'Teruel'),
(176, 195, 'Toledo', 'Toledo'),
(177, 195, 'Valencia', 'Valencia'),
(178, 195, 'Valladolid', 'Valladolid'),
(179, 195, 'Vizcaya', 'Vizcaya'),
(180, 195, 'Zamora', 'Zamora'),
(181, 195, 'Zaragoza', 'Zaragoza');

DROP TABLE IF EXISTS `zones_to_geo_zones`;
CREATE TABLE `zones_to_geo_zones` (
  `association_id` int(11) NOT NULL,
  `zone_country_id` int(11) NOT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `geo_zone_id` int(11) DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `zones_to_geo_zones` (`association_id`, `zone_country_id`, `zone_id`, `geo_zone_id`, `last_modified`, `date_added`) VALUES
(1, 0, NULL, 1, '2017-01-26 07:03:43', '2017-01-24 11:09:54');

ALTER TABLE `action_recorder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_action_recorder_module` (`module`),
  ADD KEY `idx_action_recorder_user_id` (`user_id`),
  ADD KEY `idx_action_recorder_identifier` (`identifier`),
  ADD KEY `idx_action_recorder_date_added` (`date_added`);

ALTER TABLE `address_book`
  ADD PRIMARY KEY (`address_book_id`),
  ADD KEY `idx_address_book_customers_id` (`customers_id`);

ALTER TABLE `address_format`
  ADD PRIMARY KEY (`address_format_id`);

ALTER TABLE `administrators`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `banners`
  ADD PRIMARY KEY (`banners_id`),
  ADD KEY `idx_banners_group` (`banners_group`);

ALTER TABLE `banners_history`
  ADD PRIMARY KEY (`banners_history_id`),
  ADD KEY `idx_banners_history_banners_id` (`banners_id`);

ALTER TABLE `categories`
  ADD PRIMARY KEY (`categories_id`),
  ADD KEY `idx_categories_parent_id` (`parent_id`);

ALTER TABLE `categories_description`
  ADD PRIMARY KEY (`categories_id`,`language_id`),
  ADD KEY `idx_categories_name` (`categories_name`);

ALTER TABLE `configuration`
  ADD PRIMARY KEY (`configuration_id`);

ALTER TABLE `configuration_group`
  ADD PRIMARY KEY (`configuration_group_id`);

ALTER TABLE `countries`
  ADD PRIMARY KEY (`countries_id`),
  ADD KEY `IDX_COUNTRIES_NAME` (`countries_name`);

ALTER TABLE `currencies`
  ADD PRIMARY KEY (`currencies_id`),
  ADD KEY `idx_currencies_code` (`code`);

ALTER TABLE `customers`
  ADD PRIMARY KEY (`customers_id`),
  ADD KEY `idx_customers_email_address` (`customers_email_address`);

ALTER TABLE `customers_basket`
  ADD PRIMARY KEY (`customers_basket_id`),
  ADD KEY `idx_customers_basket_customers_id` (`customers_id`);

ALTER TABLE `customers_basket_attributes`
  ADD PRIMARY KEY (`customers_basket_attributes_id`),
  ADD KEY `idx_customers_basket_att_customers_id` (`customers_id`);

ALTER TABLE `customers_info`
  ADD PRIMARY KEY (`customers_info_id`);

ALTER TABLE `geo_zones`
  ADD PRIMARY KEY (`geo_zone_id`);

ALTER TABLE `languages`
  ADD PRIMARY KEY (`languages_id`),
  ADD KEY `IDX_LANGUAGES_NAME` (`name`);

ALTER TABLE `manufacturers`
  ADD PRIMARY KEY (`manufacturers_id`),
  ADD KEY `IDX_MANUFACTURERS_NAME` (`manufacturers_name`);

ALTER TABLE `manufacturers_info`
  ADD PRIMARY KEY (`manufacturers_id`,`languages_id`);

ALTER TABLE `newsletters`
  ADD PRIMARY KEY (`newsletters_id`);

ALTER TABLE `orders`
  ADD PRIMARY KEY (`orders_id`),
  ADD KEY `idx_orders_customers_id` (`customers_id`);

ALTER TABLE `orders_products`
  ADD PRIMARY KEY (`orders_products_id`),
  ADD KEY `idx_orders_products_orders_id` (`orders_id`),
  ADD KEY `idx_orders_products_products_id` (`products_id`);

ALTER TABLE `orders_products_attributes`
  ADD PRIMARY KEY (`orders_products_attributes_id`),
  ADD KEY `idx_orders_products_att_orders_id` (`orders_id`);

ALTER TABLE `orders_products_download`
  ADD PRIMARY KEY (`orders_products_download_id`),
  ADD KEY `idx_orders_products_download_orders_id` (`orders_id`);

ALTER TABLE `orders_status`
  ADD PRIMARY KEY (`orders_status_id`,`language_id`),
  ADD KEY `idx_orders_status_name` (`orders_status_name`);

ALTER TABLE `orders_status_history`
  ADD PRIMARY KEY (`orders_status_history_id`),
  ADD KEY `idx_orders_status_history_orders_id` (`orders_id`);

ALTER TABLE `orders_total`
  ADD PRIMARY KEY (`orders_total_id`),
  ADD KEY `idx_orders_total_orders_id` (`orders_id`);

ALTER TABLE `oscom_app_paypal_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_oapl_module` (`module`);

ALTER TABLE `products`
  ADD PRIMARY KEY (`products_id`),
  ADD KEY `idx_products_model` (`products_model`),
  ADD KEY `idx_products_date_added` (`products_date_added`);

ALTER TABLE `products_attributes`
  ADD PRIMARY KEY (`products_attributes_id`),
  ADD KEY `idx_products_attributes_products_id` (`products_id`);

ALTER TABLE `products_attributes_download`
  ADD PRIMARY KEY (`products_attributes_id`);

ALTER TABLE `products_description`
  ADD PRIMARY KEY (`products_id`,`language_id`),
  ADD KEY `products_name` (`products_name`);

ALTER TABLE `products_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_images_prodid` (`products_id`);

ALTER TABLE `products_notifications`
  ADD PRIMARY KEY (`products_id`,`customers_id`);

ALTER TABLE `products_options`
  ADD PRIMARY KEY (`products_options_id`,`language_id`);

ALTER TABLE `products_options_values`
  ADD PRIMARY KEY (`products_options_values_id`,`language_id`);

ALTER TABLE `products_options_values_to_products_options`
  ADD PRIMARY KEY (`products_options_values_to_products_options_id`);

ALTER TABLE `products_to_categories`
  ADD PRIMARY KEY (`products_id`,`categories_id`);

ALTER TABLE `reviews`
  ADD PRIMARY KEY (`reviews_id`),
  ADD KEY `idx_reviews_products_id` (`products_id`),
  ADD KEY `idx_reviews_customers_id` (`customers_id`);

ALTER TABLE `reviews_description`
  ADD PRIMARY KEY (`reviews_id`,`languages_id`);

ALTER TABLE `sec_directory_whitelist`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `sessions`
  ADD PRIMARY KEY (`sesskey`);

ALTER TABLE `specials`
  ADD PRIMARY KEY (`specials_id`),
  ADD KEY `idx_specials_products_id` (`products_id`);

ALTER TABLE `tax_class`
  ADD PRIMARY KEY (`tax_class_id`);

ALTER TABLE `tax_rates`
  ADD PRIMARY KEY (`tax_rates_id`);

ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`testimonials_id`);

ALTER TABLE `testimonials_description`
  ADD PRIMARY KEY (`testimonials_id`,`languages_id`);

ALTER TABLE `whos_online`
  ADD KEY `idx_whos_online_session_id` (`session_id`);

ALTER TABLE `zones`
  ADD PRIMARY KEY (`zone_id`),
  ADD KEY `idx_zones_country_id` (`zone_country_id`);

ALTER TABLE `zones_to_geo_zones`
  ADD PRIMARY KEY (`association_id`),
  ADD KEY `idx_zones_to_geo_zones_country_id` (`zone_country_id`);

ALTER TABLE `action_recorder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

ALTER TABLE `address_book`
  MODIFY `address_book_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `address_format`
  MODIFY `address_format_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `administrators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `banners`
  MODIFY `banners_id` int(11) NOT NULL AUTO_INCREMENT;
O_INCREMENT für Tabelle `banners_history`
--
ALTER TABLE `banners_history`
  MODIFY `banners_history_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `categories`
  MODIFY `categories_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

ALTER TABLE `configuration`
  MODIFY `configuration_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=680;

ALTER TABLE `configuration_group`
  MODIFY `configuration_group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

ALTER TABLE `countries`
  MODIFY `countries_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=240;

ALTER TABLE `currencies`
  MODIFY `currencies_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `customers`
  MODIFY `customers_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `customers_basket`
  MODIFY `customers_basket_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `customers_basket_attributes`
  MODIFY `customers_basket_attributes_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `geo_zones`
  MODIFY `geo_zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `languages`
  MODIFY `languages_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `manufacturers`
  MODIFY `manufacturers_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `newsletters`
  MODIFY `newsletters_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `orders`
  MODIFY `orders_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `orders_products`
  MODIFY `orders_products_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `orders_products_attributes`
  MODIFY `orders_products_attributes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `orders_products_download`
  MODIFY `orders_products_download_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `orders_status_history`
  MODIFY `orders_status_history_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `orders_total`
  MODIFY `orders_total_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `oscom_app_paypal_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `products`
  MODIFY `products_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

ALTER TABLE `products_attributes`
  MODIFY `products_attributes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

ALTER TABLE `products_description`
  MODIFY `products_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

ALTER TABLE `products_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

ALTER TABLE `products_options_values_to_products_options`
  MODIFY `products_options_values_to_products_options_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

ALTER TABLE `reviews`
  MODIFY `reviews_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `sec_directory_whitelist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

ALTER TABLE `specials`
  MODIFY `specials_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `tax_class`
  MODIFY `tax_class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `tax_rates`
  MODIFY `tax_rates_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `testimonials`
  MODIFY `testimonials_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `zones`
  MODIFY `zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=182;

ALTER TABLE `zones_to_geo_zones`
  MODIFY `association_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
