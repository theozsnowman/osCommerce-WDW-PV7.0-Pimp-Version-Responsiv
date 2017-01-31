<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2014 osCommerce

  Released under the GNU General Public License
*/

// define our webserver variables
// FS = Filesystem (physical)
// WS = Webserver (virtual)
  define('HTTP_SERVER', ''); // eg, http://localhost or - https://localhost should not be NULL for productive servers
  define('HTTPS_SERVER', '');
  define('ENABLE_SSL', false);
  define('HTTP_COOKIE_DOMAIN', '');
  define('HTTPS_COOKIE_DOMAIN', '');
  define('HTTP_COOKIE_PATH', '');
  define('HTTPS_COOKIE_PATH', '');
  define('HTTP_CATALOG_SERVER', '');
  define('HTTPS_CATALOG_SERVER', '');
  define('ENABLE_SSL_CATALOG', 'false'); // secure webserver for catalog module
  define('DIR_FS_DOCUMENT_ROOT', $DOCUMENT_ROOT); // where your pages are located on the server. if $DOCUMENT_ROOT doesnt suit you, replace with your local path. (eg, /usr/local/apache/htdocs)
  define('DIR_WS_ADMIN', '/admin/');
  define('DIR_WS_HTTPS_ADMIN', '/admin/');
  define('DIR_FS_ADMIN', DIR_FS_DOCUMENT_ROOT . DIR_WS_ADMIN);
  define('DIR_WS_CATALOG', '/catalog/');
  define('DIR_WS_HTTPS_CATALOG', '/catalog/');
  define('DIR_FS_CATALOG', DIR_FS_DOCUMENT_ROOT . DIR_WS_CATALOG);
  define('DIR_WS_CATALOG_IMAGES', DIR_WS_CATALOG . 'images/');
  define('DIR_WS_CATALOG_LANGUAGES', DIR_WS_CATALOG . 'includes/languages/');
  define('DIR_FS_CATALOG_LANGUAGES', DIR_FS_CATALOG . 'includes/languages/');
  define('DIR_FS_CATALOG_IMAGES', DIR_FS_CATALOG . 'images/');
  define('DIR_FS_CATALOG_MODULES', DIR_FS_CATALOG . 'includes/modules/');
  define('DIR_FS_BACKUP', DIR_FS_ADMIN . 'backups/');
  define('DIR_FS_DOWNLOAD', DIR_FS_CATALOG . 'download/');
  define('DIR_FS_DOWNLOAD_PUBLIC', DIR_FS_CATALOG . 'pub/');

	define('DIR_WS_CATALOG_IMAGES_ORIG', DIR_WS_CATALOG_IMAGES . 'originals/');
  define('DIR_WS_CATALOG_IMAGES_CAT', DIR_WS_CATALOG_IMAGES . 'categories/');
  define('DIR_WS_CATALOG_IMAGES_MFG', DIR_WS_CATALOG_IMAGES . 'manufacturers/');
  define('DIR_WS_CATALOG_IMAGES_PROD', DIR_WS_CATALOG_IMAGES . 'products/');
  define('DIR_WS_CATALOG_IMAGES_THUMBS', DIR_WS_CATALOG_IMAGES . 'product_thumbnails/');
  define('DIR_WS_CATALOG_IMAGES_TEMP', DIR_WS_CATALOG_IMAGES . 'temporary/');
  
  define('DIR_FS_CATALOG_IMAGES_ORIG', DIR_FS_CATALOG_IMAGES . 'originals/');
  define('DIR_FS_CATALOG_IMAGES_CAT', DIR_FS_CATALOG_IMAGES . 'categories/');
  define('DIR_FS_CATALOG_IMAGES_MFG', DIR_FS_CATALOG_IMAGES . 'manufacturers/');
  define('DIR_FS_CATALOG_IMAGES_PROD', DIR_FS_CATALOG_IMAGES . 'products/');
  define('DIR_FS_CATALOG_IMAGES_THUMBS', DIR_FS_CATALOG_IMAGES . 'product_thumbnails/');
  define('DIR_FS_CATALOG_IMAGES_TEMP', DIR_FS_CATALOG_IMAGES . 'temporary/');
  define('DIR_CATALOG_RELATIVE_ADMIN', '..');

// define our database connection
  define('DB_SERVER', '');
  define('DB_SERVER_USERNAME', 'mysql');
  define('DB_SERVER_PASSWORD', '');
  define('DB_DATABASE', 'osCommerce');
  define('USE_PCONNECT', 'false');
  define('STORE_SESSIONS', '');
?>
