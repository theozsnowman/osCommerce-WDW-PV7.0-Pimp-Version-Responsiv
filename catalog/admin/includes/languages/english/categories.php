<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce

  Released under the GNU General Public License
*/

define('HEADING_TITLE', 'Categories / Products');
define('HEADING_TITLE_SEARCH', 'Search:');
define('HEADING_TITLE_GOTO', 'Go To:');

define('TABLE_HEADING_ID', 'ID');
define('TABLE_HEADING_CATEGORIES_PRODUCTS', 'Categories / Products');
define('TABLE_HEADING_ACTION', 'Action');
define('TABLE_HEADING_STATUS', 'Status');

define('TEXT_NEW_PRODUCT', 'New Product in &quot;%s&quot;');
define('TEXT_CATEGORIES', 'Categories:');
define('TEXT_SUBCATEGORIES', 'Subcategories:');
define('TEXT_PRODUCTS', 'Products:');
define('TEXT_PRODUCTS_PRICE_INFO', 'Price:');
define('TEXT_PRODUCTS_TAX_CLASS', 'Tax Class:');
define('TEXT_PRODUCTS_AVERAGE_RATING', 'Average Rating:');
define('TEXT_PRODUCTS_QUANTITY_INFO', 'Quantity:');
define('TEXT_DATE_ADDED', 'Date Added:');
define('TEXT_DATE_AVAILABLE', 'Date Available:');
define('TEXT_LAST_MODIFIED', 'Last Modified:');
define('TEXT_IMAGE_NONEXISTENT', 'IMAGE DOES NOT EXIST');
define('TEXT_NO_CHILD_CATEGORIES_OR_PRODUCTS', 'Please insert a new category or product in this level.');
define('TEXT_PRODUCT_MORE_INFORMATION', 'For more information, please visit this products <a href="http://%s" target="blank"><u>webpage</u></a>.');
define('TEXT_PRODUCT_DATE_ADDED', 'This product was added to our catalog on %s.');
define('TEXT_PRODUCT_DATE_AVAILABLE', 'This product will be in stock on %s.');

define('TEXT_EDIT_INTRO', 'Please make any necessary changes');
define('TEXT_EDIT_CATEGORIES_ID', 'Category ID:');
define('TEXT_EDIT_CATEGORIES_NAME', 'Category Name:');
define('TEXT_EDIT_CATEGORIES_IMAGE', 'Category Image:');
define('TEXT_EDIT_SORT_ORDER', 'Sort Order:');

define('TEXT_INFO_COPY_TO_INTRO', 'Please choose a new category you wish to copy this product to');
define('TEXT_INFO_CURRENT_CATEGORIES', 'Current Categories:');

define('TEXT_INFO_HEADING_NEW_CATEGORY', 'New Category');
define('TEXT_INFO_HEADING_EDIT_CATEGORY', 'Edit Category');
define('TEXT_INFO_HEADING_DELETE_CATEGORY', 'Delete Category');
define('TEXT_INFO_HEADING_MOVE_CATEGORY', 'Move Category');
define('TEXT_INFO_HEADING_DELETE_PRODUCT', 'Delete Product');
define('TEXT_INFO_HEADING_MOVE_PRODUCT', 'Move Product');
define('TEXT_INFO_HEADING_COPY_TO', 'Copy To');

define('TEXT_DELETE_CATEGORY_INTRO', 'Are you sure you want to delete this category?');
define('TEXT_DELETE_PRODUCT_INTRO', 'Are you sure you want to permanently delete this product?');

define('TEXT_DELETE_WARNING_CHILDS', '<strong>WARNING:</strong> There are %s (child-)categories still linked to this category!');
define('TEXT_DELETE_WARNING_PRODUCTS', '<strong>WARNING:</strong> There are %s products still linked to this category!');

define('TEXT_MOVE_PRODUCTS_INTRO', 'Please select which category you wish <strong>%s</strong> to reside in');
define('TEXT_MOVE_CATEGORIES_INTRO', 'Please select which category you wish <strong>%s</strong> to reside in');
define('TEXT_MOVE', 'Move <strong>%s</strong> to:');

define('TEXT_NEW_CATEGORY_INTRO', 'Please fill out the following information for the new category');
define('TEXT_CATEGORIES_NAME', 'Category Name:');
define('TEXT_CATEGORIES_IMAGE', 'Category Image:');
define('TEXT_SORT_ORDER', 'Sort Order:');

define('TEXT_PRODUCTS_STATUS', 'Products Status:');
define('TEXT_PRODUCTS_DATE_AVAILABLE', 'Date Available:');
define('TEXT_PRODUCT_AVAILABLE', 'In Stock');
define('TEXT_PRODUCT_NOT_AVAILABLE', 'Out of Stock');
define('TEXT_PRODUCTS_MANUFACTURER', 'Products Manufacturer:');
define('TEXT_PRODUCTS_NAME', 'Products Name:');
define('TEXT_PRODUCTS_DESCRIPTION', 'Products Description:');
define('TEXT_PRODUCTS_QUANTITY', 'Products Quantity:');
define('TEXT_PRODUCTS_MODEL', 'Products Model:');
define('TEXT_PRODUCTS_IMAGE', 'Products Image:');
define('TEXT_PRODUCTS_MAIN_IMAGE', 'Main Image');
define('TEXT_PRODUCTS_LARGE_IMAGE', 'Large Image');
define('TEXT_PRODUCTS_LARGE_IMAGE_HTML_CONTENT', 'HTML Content (for popup)');
define('TEXT_PRODUCTS_ADD_LARGE_IMAGE', 'Add Large Image');
define('TEXT_PRODUCTS_LARGE_IMAGE_DELETE_TITLE', 'Delete Large Product Image?');
define('TEXT_PRODUCTS_LARGE_IMAGE_CONFIRM_DELETE', 'Please confirm the removal of the large product image.');
define('TEXT_PRODUCTS_URL', 'Products URL:');
define('TEXT_PRODUCTS_URL_WITHOUT_HTTP', '<small>(without http://)</small>');
define('TEXT_PRODUCTS_PRICE_NET', 'Products Price (Net):');
define('TEXT_PRODUCTS_PRICE_GROSS', 'Products Price (Gross):');
define('TEXT_PRODUCTS_WEIGHT', 'Products Weight:');

define('EMPTY_CATEGORY', 'Empty Category');

define('TEXT_HOW_TO_COPY', 'Copy Method:');
define('TEXT_COPY_AS_LINK', 'Link product');
define('TEXT_COPY_AS_DUPLICATE', 'Duplicate product');

define('ERROR_CANNOT_LINK_TO_SAME_CATEGORY', 'Error: Can not link products in the same category.');
define('ERROR_CATALOG_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES);
define('ERROR_CATALOG_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog images directory does not exist: ' . DIR_FS_CATALOG_IMAGES);
define('ERROR_CANNOT_MOVE_CATEGORY_TO_PARENT', 'Error: Category cannot be moved into child category.');

define('TEXT_CATEGORIES_DESCRIPTION', 'Category Description:<br><small>shows in category page</small>');
define('TEXT_EDIT_CATEGORIES_DESCRIPTION', 'Edit the Category Description:');

define('TEXT_CATEGORIES_SEO_DESCRIPTION', 'Category Meta Description for SEO:<br><small>Add a &lt;description&gt; Meta Element.</small>');
define('TEXT_EDIT_CATEGORIES_SEO_DESCRIPTION', 'Edit the Category Meta Description for SEO:<br><small>Changes the &lt;description&gt; Meta Element.</small>');
define('TEXT_CATEGORIES_SEO_KEYWORDS', 'Category Meta Keywords for SEO:<br><small>Add a &lt;keyword&gt; Meta Element.<br>Must be comma separated.</small>');
define('TEXT_EDIT_CATEGORIES_SEO_KEYWORDS', 'Edit the Category Meta Keywords for SEO:<br><small>Changes the &lt;keyword&gt; Meta Element.<br>Must be comma separated.</small>');
 
const TEXT_PRODUCTS_GTIN = 'Products <abbr title="GTIN must be stored as 14 Digits. Any GTIN smaller than this will be zero-padded per GTIN Specifications.">GTIN</abbr>:<br><small>1 of UPC, EAN, ISBN etc</small>';
const TEXT_PRODUCTS_SEO_DESCRIPTION = 'Product Meta Description for SEO:<br><small>Add a &lt;description&gt; Meta Element.<br>HTML is not allowed.</small>';
const TEXT_PRODUCTS_SEO_KEYWORDS = 'Product Meta Keywords for SEO:<br><small>Add a &lt;keyword&gt; Meta Element or Search Engine.<br>Must be comma separated. HTML is not allowed.</small>';
const TEXT_PRODUCTS_SEO_TITLE = 'Products Title for SEO:<br><small>Replaces the product name in the &lt;title&gt; Meta Element<br>and optionally in the Breadcrumb Trail.<br>Leave blank to default to product name.</small>';
const TEXT_CATEGORIES_SEO_TITLE = 'Category Title for SEO:<br><small>Replaces the category name in the &lt;title&gt; Meta Element.<br>Leave blank to default to category name.</small>';
const TEXT_EDIT_CATEGORIES_SEO_TITLE = 'Edit the Category Title for SEO:<br><small>Replaces the category name in the &lt;title&gt; Meta Element<br>and optionally in the Breadcrumb Trail.<br>Leave blank to default to category name.</small>';

// added for image protection
define('TEXT_IMAGE_DISPLAY', 'Image Display:');
define('TEXT_NO_IMAGE', 'Do Not Display An Image (use if this is not a physical product, uploaded images will not be saved)');
define('TEXT_IMAGE_NOT_AVAILABLE', 'Display "No Picture Available" Image (uploaded images will not be saved)');
define('TEXT_USE_PRODUCT_IMAGE', 'Display The Product Image Uploaded Below');
define('BUTTON_MANAGE_IMAGES', 'Manage Product Images');
define('ERROR_CATALOG_PRODUCT_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog product images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES_PROD);
define('ERROR_CATALOG_PRODUCT_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog product images directory does not exist: ' . DIR_FS_CATALOG_IMAGES_PROD);
define('ERROR_CATALOG_THUMB_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog product thumbnail images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES_THUMBS);
define('ERROR_CATALOG_THUMB_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog product thumbnail images directory does not exist: ' . DIR_FS_CATALOG_IMAGES_THUMBS);
define('ERROR_CATALOG_CATEGORY_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog category images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES_CAT);
define('ERROR_CATALOG_CATEGORY_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog category images directory does not exist: ' . DIR_FS_CATALOG_IMAGES_CAT);
define('ERROR_CATALOG_ORIGINAL_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog original images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES_ORIG);
define('ERROR_CATALOG_ORIGINAL_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog original images directory does not exist: ' . DIR_FS_CATALOG_IMAGES_ORIG);
define('TEXT_IMAGE_IGNORED', 'Error: Because this product is not set to use uploaded images the image file that was uploaded will not be saved.');
define('TEXT_MORE_IMG', 'View More Images');
define('TEXT_LARGE_IMAGE_FAILURE', 'Error: The large product image could not be created.');
define('TEXT_CLICK_VIEW', 'Click to view all product original images');

define('ERROR_COULDNT_DUP', 'Failed to create duplicate image: ');
define('ERROR_NEWDIR_FAILED', 'Failed to create new image folder: ');
