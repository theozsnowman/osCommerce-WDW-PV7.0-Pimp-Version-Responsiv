<?php
/*
  $Id: prod-img-manager.php v2.0 2012-09-12 by Kevin L. Shelton $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce

  Released under the GNU General Public License
*/

define('HEADING_TITLE', 'Image Manager');

define('TABLE_HEADING_IMAGE', 'Image');
define('TABLE_HEADING_FNAME', 'File Name');
define('TABLE_HEADING_ACTION', 'Action');
define('TABLE_HEADING_ERRORS', 'Info');
define('TABLE_HEADING_NAME', 'Product Name');
define('TABLE_HEADING_MODEL', 'Product Model');
define('TABLE_HEADING_PRODUCT_PRICE', 'Product Price');
define('TABLE_HEADING_MFG', 'Manufacturer');
define('TABLE_HEADING_CATEGORY', 'Category');

define('ENTRY_SET_DEFAULT_IMAGE', 'Set this image as the new default image for the product (the one displayed in product listings).');
define('ENTRY_SORT_ORDER', 'Sort Order: ');
define('ENTRY_HTML', 'HTML Content: ');

define('ERROR_CATALOG_ORIG_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog original images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES_ORIG);
define('ERROR_CATALOG_ORIG_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog original images directory does not exist: ' . DIR_FS_CATALOG_IMAGES_ORIG);
define('ERROR_CATALOG_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES);
define('ERROR_CATALOG_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog images directory does not exist: ' . DIR_FS_CATALOG_IMAGES);
define('ERROR_CATALOG_PRODUCT_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog product images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES_PROD);
define('ERROR_CATALOG_PRODUCT_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog product images directory does not exist: ' . DIR_FS_CATALOG_IMAGES_PROD);
define('ERROR_CATALOG_THUMB_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog product thumbnail images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES_THUMBS);
define('ERROR_CATALOG_THUMB_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog product thumbnail images directory does not exist: ' . DIR_FS_CATALOG_IMAGES_THUMBS);
define('ERROR_CATALOG_CATEGORY_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog category images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES_CAT);
define('ERROR_CATALOG_CATEGORY_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog category images directory does not exist: ' . DIR_FS_CATALOG_IMAGES_CAT);
define('ERROR_CATALOG_MFG_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog manufacturer images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES_MFG);
define('ERROR_CATALOG_MFG_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog manufacturer images directory does not exist: ' . DIR_FS_CATALOG_IMAGES_MFG);
define('ERROR_CATALOG_TEMP_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Error: Catalog temporary images directory is not writeable: ' . DIR_FS_CATALOG_IMAGES_TEMP);
define('ERROR_CATALOG_TEMP_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Error: Catalog temporary images directory does not exist: ' . DIR_FS_CATALOG_IMAGES_TEMP);

define('BUTTON_DEFAULT', 'Make Default Image');
define('BUTTON_CHANGE_DISPLAY', 'Change Image Display Setting');
define('BUTTON_ADD_IMAGE', 'Add An Image To This Product');
define('BUTTON_DELETE_IMAGE', 'Delete Image');
define('BUTTON_REBUILD_THUMBS', 'Rebuild Small Images');
define('BUTTON_SELECT', 'Use This Product');
define('BUTTON_SEARCH', 'Perform Search');
define('BUTTON_SELECT_DROPDOWN', 'Choose Different Product Using List');
define('BUTTON_SELECT_SEARCH', 'Choose Different Product Using Search');
define('BUTTON_PRODUCT_ENTRY', 'Return To Product Maintenance');
define('BUTTON_ADD_DB', 'Add To Database');
define('BUTTON_ADD_ORIG', 'Copy As Original Image');
define('BUTTON_DB_REMOVE', 'Remove From Database');
define('BUTTON_CHECK_MFG', 'Check Manufacturer Images');
define('BUTTON_CHECK_CAT', 'Check Category Images');
define('BUTTON_COPY_THUMB', 'Copy Thumbnail as Original Image');
define('BUTTON_RETURN_MFG', 'Return to Manufacturer Maintenance');
define('BUTTON_ADD_IMG', 'Add An Image');
define('BUTTON_REBUILD_THUMB', 'Recreate Thumbnail Image');
define('BUTTON_CHANGE_IMG', 'Change Image');
define('BUTTON_ORPHAN_CHECK', 'Check For Orphaned Images');
define('BUTTON_RETRY', 'Try Again');

define('TEXT_IMAGE_DISPLAY', 'Image Display:');
define('TEXT_NO_IMAGE', 'Do Not Display An Image (use if this is not a physical product, uploaded image will not be saved)');
define('TEXT_IMAGE_NOT_AVAILABLE', 'Display "No Picture Available" Image (uploaded image will not be saved)');
define('TEXT_USE_PRODUCT_IMAGE', 'Display The Product Image Uploaded Below');
define('TEXT_NEW_IMAGE', 'New Image For &ldquo;%s&rdquo;');
define('TEXT_IMAGE_LIST', 'List Of Original Images For &ldquo;%s&rdquo;');
define('TEXT_IMAGE_NONEXISTENT', 'IMAGE DOES NOT EXIST');
define('TEXT_DELETE_IMAGE_INTRO', 'Are you sure you want to permanently delete this image?');
define('TEXT_PRODUCTS_IMAGE', 'Products Image:');
define('TEXT_IMAGE_IGNORED', 'Error: Because this product is not set to use uploaded images the image file that was uploaded will not be saved.');
define('TEXT_INFO_HEADING_DELETE_IMAGE', 'Delete Image?');
define('TEXT_DISPLAYS_NOTHING', 'This product is set to display no images at all.');
define('TEXT_DISPLAYS_NOIMG', 'This product is set to display the &ldquo;no picture available&rdquo; image.');
define('TEXT_THIS_DEFAULT', 'Current Default Image');
define('TEXT_REBUILD_FOR', 'Recreate product thumbnail and large images for:');
define('TEXT_THIS_PRODUCT', 'This Product');
define('TEXT_ALL_PRODUCT', 'All Products');
define('TEXT_REBUILD_TIME', 'Warning: This process could take a long time if there are a lot of product images for which to recreate the thumbnail and large product images.');
define('TEXT_ENTER_TERMS', 'Enter text to search for:');
define('TEXT_NAME_ONLY', 'Search On Product Name, Model & Manufacturer Only');
define('TEXT_DESCRIPTIONS', 'Search In Product Descriptions Also');
define('TEXT_NOT_FOUND', 'No products were found to match the search terms given.');
define('TEXT_MULTIPLE_FOUND', 'Multiple products were found to match the search terms given. Please select from the list below or try again with more specific search terms.');
define('HEADING_SELECT_PRODUCT', 'Select A Different Product');
define('TEXT_INFO_MANUFACTURER', 'Manufacturer: ');
define('TEXT_INFO_MODEL', 'Model #: ');
define('TEXT_INFO_PRICE', 'Regular Price: ');
define('TEXT_THUMBNAIL_FAILURE1', 'Unable to read dimensions and type of original file.');
define('TEXT_THUMBNAIL_FAILURE2', 'The file type of the original image file is not supported. Only JPEG, GIF and PNG files can be resized.');
define('TEXT_THUMBNAIL_FAILURE3', 'Invalid parameters. Maximum width and height must be positive numbers.');
define('TEXT_THUMBNAIL_FAILURE4', 'Unable to write the resized file to disk.');
define('TEXT_THUMBNAIL_FAILURE7', 'The specified path for the image either does not exist and cannot be created or else it is not writeable and cannot be made writeable: ');
define('TEXT_COPY_FAILURE', 'Unable to copy the file to the new location.');
define('TEXT_FILE_NOT_FOUND', 'Uploaded file could not be found.');
define('TEXT_DEFAULT_IMG_NOTE', "The product default image is the one that is shown in product listings.");
define('TEXT_LRGIMG_SUCCESS', 'The product large image was successfully created.');
define('TEXT_LRGIMG_FAILURE', 'Error: The product large image could not be created! ');
define('TEXT_ERROR_NO_THUMB', 'Missing Thumbnail Image<br />');
define('TEXT_ERROR_NO_LARGE', 'Missing Large Image<br />');
define('TEXT_ERROR_NO_ORIG', 'Missing Original Image<br />');
define('TEXT_ERROR_INVALID_THUMB', 'Thumbnail Image Is Not A Valid Web Image Type<br />');
define('TEXT_ERROR_INVALID_LARGE', 'Large Image Is Not A Valid Web Image Type<br />');
define('TEXT_ERROR_INVALID_ORIG', 'Original Image Is Not A Valid Web Image Type<br />');
define('TEXT_ERROR_NOT_DB', 'Missing From Database');
define("TEXT_NO_ERRORS", 'No Image Errors');
define('TEXT_REBUILD_SUGGESTED', 'You should check the display of this product in the catalog product info page and rebuild the small images if needed.');
define('TEXT_HAS_HTML', 'Has HTML component<br />');
define('TEXT_NO_HTML', 'No HTML component<br />');
define('TEXT_DB_ONLY', 'File only found in database');
define('TEXT_ERROR_NO_IMG_FOLDER','ERROR! No image folder is set for this product!');
define('TEXT_NO_IMAGE_FILE', 'Does not have an image<br />');
define('TEXT_ERROR_THUMB_SIZE', 'Thumbnail image is not the correct size');
define('TEXT_ORPHAN_CHECK', 'Now checking for image files and folders not referenced by any product, category or manufacturer. Any orphaned images found will be listed below and automatically checked. Uncheck any that you do not wish to delete. Orphaned images are typically caused when you replace one product image with another one or when you replace a category or manufacturer image with one that is of a different type such as a JPEG replacing a GIF. Orphaned folders are unlikely to occur and would most probably be caused by a manual upload or restoring a backup of files without restoring the osCommerce database. Because orphaned folders are unlikely, any that are found and their contents will not be automatically checked when they are listed. If you decide to delete an orphaned folder you will also need to delete its contents by checking them as well as the folder. Once the list is complete click the delete button to remove all checked items. Mini thumbnails will be displayed of any image file found. Click on this thumbnail to view the full sized image, then click on the full sized image to hide it again. <br /><br />The following orphaned files and folders have been found:');
define('TEXT_ORPHAN_COMPLETE', 'Orphan Check Is Completed');
define('TEXT_TYPE_FILE', 'File: ');
define('TEXT_TYPE_FOLDER', 'Folder: ');
define('TEXT_ORPHAN_SOURCE', ' Source: ');
define('BUTTON_DELETE_CHECKED', 'Delete Items Checked Above');
define('TEXT_ORIGINALS_FOLDER', 'Original Images Folder');
define('TEXT_LARGE_FOLDER', 'Product Large Images Folder');
define('TEXT_THUMBS_FOLDER', 'Product Thumbnail Images Folder');
define('TEXT_CAT_FOLDER', 'Category Images Folder');
define('TEXT_MFG_FOLDER', 'Manufacturer Images Folder');
define('TEXT_TEMP_FOLDER', 'Temporary Images Folder');
?>
