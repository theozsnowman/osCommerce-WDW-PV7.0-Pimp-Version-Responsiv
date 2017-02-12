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

  Don\'t forget all "filenames" and "some folder\'s" are hardcoded.<br />
  btw: I like it, don\'t waste time for include more files or content. <br /><br />
	
	PHP7 & MySql 5.7 Update<br />
	Methods with the same name as their class will not be constructors in a future version of PHP in module files and class files.<br />
	MySql querys for MySql 5.7 sql_mode<br /><br /> 
	
	Already changed<br />
	- Some new icons for the admin area<br />
  - all Class files now full PHP7+ suitable<br />
  - all MySQL querys now full MySQL 5.7 suitable<br />
  - Install: Change value of products_name varchar(64) to products_name varchar(128)<br />
  - Install: Some changes for to delete the install folder after finished<br />
  - Install: Change the chmod to 0444 for /admin/includes/configure.php and /includes/configure.php<br />
  - Frontend: Better position for the asterisk in the input field<br />
  - Frontend: Add margin-bottom: 20px; to the #bodyContent >>> better margin after the content<br />
  - Frontend: Change function to acivate the awesome fonts icons<br />
  - Frontend: Add function to acivate the awesome fonts icons<br />
  - Backend: Online Catalog link now open in new page<br />
  - Backend: Change the width of left column and the content<br /><br />

Webdesign Wedel (WDW) modified stuff<br />
	- cKEditor >>> Product description editable with ckEditor<br />
	- KCFinder >>> Image file uploder for cKEditor<br />
	- cKEditor >>> Banner Manager editable with ckEditor<br />
	- cKEditor >>> Newsletter editable with ckEditor<br />
	- cKEditor >>> Send E-Mail to customer editable with ckEditor<br />
  - Modular Category Page (Template modified to dropdown)<br />
  - Modular Sub Category Page (Template modified to dropdown)<br />
  - Modular Index Page (Template modified to dropdown)<br />
  - Show value in % on a Special product on every content<br />
  - Overlay Images Discount (Turn on/off in the Admin)<br />
  - New images path. Based on Protected Images for osC 2.3.4 (adapted by WDW for this version)<br />
  - New presentation of the product images with elevateZoom and fancybox<br />
  - Show the incl/excl Vat Text<br /><br />
 
Extensions included<br />
  - TCPDF 6.2.13<br />
  - Mailchimp Newsletter 2.02<br />
  - New Equal Height Header Tag Module (includes jQuery 3.1.0 fix)<br />
  - Modular Category Page v1.1<br />
  - Category New Products Carousel v1.4<br />
  - Category Popular Products Carousel v1.3<br />
  - Multiple Products Manager v2.7 (adapted by WDW for this version)<br />
  - Ultimate Seo Urls 5 for Responsive Oscommerce<br />
  - PDF Datasheet 1.2.3 Product Info as PDF file (adapted by WDW for this version)<br /><br />
	
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