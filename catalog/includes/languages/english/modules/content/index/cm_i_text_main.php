<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
*/

  const MODULE_CONTENT_TEXT_MAIN_TITLE       = 'Please Read';
  const MODULE_CONTENT_TEXT_MAIN_DESCRIPTION = 'Shows the "Text" module on your Index page.';
  
  const MODULE_CONTENT_TEXT_MAIN_TEXT        = 'Here runs: <a target="_blank" href="https://github.com/mcmannehan/osCommerce-WDW-PV7.0-Pimp-Version-Responsiv">https://github.com/mcmannehan/osCommerce-WDW-PV7.0-Pimp-Version-Responsiv</a><br />
  
  based on Version: <a target="_blank" href="https://github.com/BrockleyJohn/Responsive-osCommerce/tree/php7_compatibility_01">https://github.com/BrockleyJohn/Responsive-osCommerce/tree/php7_compatibility_01</a><br /><br />
  
  With the follow Server conditions:<br />
  HTTP Server: 	Apache<br />PHP Version: 	7.0.15 (Zend: 3.0.0) Fast-CGI<br />MySQL Version: 5.7.17<br /><br />
  
  Don\'t forget all "filenames" and "folder\'s" are hardcoded.<br />
  btw: I like it, don\'t waste time for include more files. <br /><br />

  Master Update 31. Jan. 2017<br />
  All new system settings and much more in the new /catalog/install/oscommerce.sql<br />
  New path for product images, categorien and manufactures, same like osCommerce 3.0<br /><br />
  
	Already changed<br />
	- Some new icons for the admin area<br />
  - all Class files now full PHP7+ suitable<br />
  - all MySQL querys now full MySQL 5.7 suitable<br />
  - /catalog/install/oscommerce.sql change value of products_name varchar(64) to products_name varchar(128)<br />
  - /catalog/install/templates/pages/install_4.php >>> some changes for to delete the install folder after finished<br />
  - /catalog/install/templates/pages/install_4.php >>> change the chmod to 0444 for /admin/includes/configure.php and /includes/configure.php<br />
  - /catalog/ext/bootstrap/css/bootstrap.css >>> better position for the asterisk in the input field<br />
  - /catalog/ext/bootstrap/css/bootstrap.min.css >>> better position for the asterisk in the input field<br />
  - /catalog/catalog/ext/bootstrap/css/bootstrap.css.map >>> better position for the asterisk in the input field<br />
  - /catalog/ext/bootstrap/css/bootstrap.css.map >>> better position for the asterisk in the input field<br />
  - /catalog/ext/bootstrap/css/bootstrap.min.css.map >>> better position for the asterisk in the input field<br />
  - /catalog/custom.css >>> add margin-bottom: 20px; to the #bodyContent >>> better margin after the content<br />
  - /catalog/includes/classes/message_stack.php >>> change function add to acivate the awesome fonts icons<br />
  - /catalog/includes/functions/html_output.php >>> add function tep_draw_icon to acivate the awesome fonts icons<br />
  - /catalog/admin/includes/header.php >>> Online Catalog link now open in new page<br />
  - /catalog/admin/includes/header.php >>> Support Site link now open in new page<br />
  - /catalog/admin/includes/stylesheet.css >>> change the width of left column and the content<br /><br />

Webdesign Wedel (WDW) modified stuff<br />
  - Modular Category Page (Template modified to dropdown)<br />
  - Modular Sub Category Page (Template modified to dropdown)<br />
  - Modular Index Page (Template modified to dropdown)<br />
  - Show value in % on a Special product on every content<br />
  - New images path, same like osCommerce 3.0,<br />
  	/images/categories/, /images/manufacturers/, /images/originals/,<br />
  	/images/product_thumbnails/, /images/products/, /images/temporary/.<br />
  	Code changes for functionality with this Version. Based on Protected Images for osC 2.3.4 [still under WDW development]<br /><br />
 
Extensions included<br />
  - cKEditor >>> Product description editable with ckEditor<br />
  - KCFinder >>> Image file uploder for cKEditor<br />
  - Mailchimp Newsletter 2.02<br />
  - New Equal Height Header Tag Module (includes jQuery 3.1.0 fix)<br />
  - Multiple Products Manager fo  2.3.3 v2.7 [still under WDW development]<br />
  - Category New Products Carousel v1.4<br />
  - Category Popular Products Carousel v1.3<br /><br />
	
	Help to move the Project forward<br />
	==========================<br />
	I need your help to move this Project forward. At the moment, this project is done on my own,<br />
	as and when time can be given.<br /><br />
	To allow me to give more time to this Project, I need your support:<br /><br />

		- give time for testing new code and/or getting involved in discussions<br />
		- give code to the project - create a github account, fork and start coding<br /><br />

		If you cannot give time or code, please give a Donation...<br />
		<a target="_blank" href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FLUDFVAR3BL4U">Please Donate, we need your support.</a><br /><br />
	';