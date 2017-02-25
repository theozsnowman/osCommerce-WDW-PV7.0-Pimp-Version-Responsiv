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
  
  const MODULE_CONTENT_TEXT_MAIN_TEXT        = 'Here runs (with PHP7.1.2 and MySQL 5.7):<br />
  <a target="_blank" href="https://github.com/mcmannehan/osCommerce-WDW-PV7.0-Pimp-Version-Responsiv">https://github.com/mcmannehan/osCommerce-WDW-PV7.0-Pimp-Version-Responsiv</a><br />
  
  Don\'t forget all "filenames" and "some folder\'s" are hardcoded.<br /><br />
	
	Download this shop version <a href="https://github.com/mcmannehan/osCommerce-WDW-PV7.0-Pimp-Version-Responsiv/archive/master.zip">here</a><br /><br />
	
	Questions and Support at our forum: <a target="_blank" href="https://forum.webdesign-wedel.de/index.php">https://forum.webdesign-wedel.de</a><br /><br />
	
	Help to move the Project forward<br />
	==========================<br />
	I need your help to move this Project forward. At the moment, this project is done on my own,<br />
	as and when time can be given.<br /><br />
	
	To allow me to give more time to this Project, I need your support:<br /><br />

	- give time for testing new code and/or getting involved in discussions<br />
	- give code to the project - create a github account, fork and start coding<br /><br />

	If you cannot give time or code, please give a Donation...<br />
	<a target="_blank" href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FLUDFVAR3BL4U">Please Donate, we need your support.</a><br /><br />
		
	PHP7 & MySql 5.7 Update<br />
	Methods with the same name as their class will not be constructors in a future version of PHP in module files and class files. MySql querys for MySql 5.7 sql_mode<br /><br /> 
	
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
  - Frontend: German languages installed (99% translation)<br />
  - Backend: Online Catalog link now open in new page<br />
  - Backend: Change the width of left column and the content<br />
  - Backend: German languages installed (20% translation)<br /><br />
  

Modified by Webdesign Wedel (WDW)<br />
	- Product description editable with ckEditor<br />
	- Image file uploder for cKEditor<br />
	- Banner Manager editable with ckEditor<br />
	- Newsletter editable with ckEditor<br />
	- Send E-Mail to customer editable with ckEditor<br />
	- Shop corresponds to Europe/German law<br />
	- Modular Category Page (Template modified to dropdown)<br />
	- Modular Sub Category Page (Template modified to dropdown)<br />
	- Modular Index Page (Template modified to dropdown)<br />
	- Overlay Images Discount (Turn on/off in the Admin)<br />
	- Product images on shopping cart<br />
	- Product images on check out page<br/ >
	- New presentation of the product images with elevateZoom and fancybox<br />
	- Show the incl/excl Vat Text at every price (turn on/off in Admin Configuration -> My Store)<br />
	- Show shipping info (turn on/off in Admin Configuration -> My Store)<br />
	- Show discount value in % on a special product (turn on/off in Admin Configuration -> My Store)<br /><br />
 
Extensions included<br />
	- WDW EasyTabs 1.0.1<br />
  - TCPDF 6.2.13<br />
  - Mailchimp Newsletter 2.02<br />
  - New Equal Height Header Tag Module (includes jQuery 3.1.0 fix)<br />
  - Modular Category Page v1.1<br />
  - Corrected Version 2.3.4 German utf8<br />
  - Superfish Box 1.2.2<br />
  - Categories Menu XS v1.2<br />
  - Horizontal Categories Menu BS v1.3.1 (adapted by WDW for this version)<br />
  - USU5 XML Site Maps (changed by WDW now jQuery modular)<br />
  - Category New Products Carousel v1.4<br />
  - Category Popular Products Carousel v1.3<br />
  - Multiple Products Manager v2.7 (adapted by WDW for this version)<br />
  - Specials Image Overlay 1.0.1 (adapted by WDW for this version)<br />
  - Protected Images for osC 2.3.4 (adapted by WDW for this version)<br />
  - Scroll Boxes V1.7 (adapted by WDW for this version)<br />
  - Ultimate Seo Urls 5 for Responsive osCommerce<br />
  - PDF Datasheet 1.2.3 Product Info as PDF file (adapted by WDW for this version)<br /><br />
  ';