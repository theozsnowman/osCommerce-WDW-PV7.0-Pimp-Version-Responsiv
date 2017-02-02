osCommerce WDW-PV7.0 Pimp Version Responsiv
===========================================
Based on osCommerce 2.3.4-Responsiv with Bootstrap
https://github.com/BrockleyJohn/Responsive-osCommerce/tree/php7_compatibility_01

- Don't forget all "filenames" and "folder's" are hardcoded.
- btw: I like it, don't waste time for include more files.

Master Update 2. Feb. 2017
===========================
- All new system settings and much more in the new /catalog/install/oscommerce.sql
- New path for product images, categories and manufactures, same like osCommerce 3.0

PHP7 & MySql 5.7 Update
========================
Methods with the same name as their class will not be constructors in a future version of PHP in module files and class files.
MySql querys for MySql 5.7 sql_mode 

Admin Side
- [x] MySql Query
- [x] classes
- [x] functions
- [x] modules
- [x] other

Shop Side
- [x] MySql Query
- [x] classes
- [x] functions
- [x] modules/action_recorder
- [x] modules/boxes
- [x] modules/content
- [x] modules/header_tags
- [x] modules/navbar_modules
- [x] modules/order_total
- [x] modules/payment
- [x] modules/shipping
- [x] modules/social_bookmarks
- [x] other

Already changed
===============
- Some new icons for the admin area
- all Class files now full PHP7+ suitable
- all MySql querys now full MySql 5.7 suitable
- /catalog/install/oscommerce.sql change value of products_name varchar(64) to products_name varchar(128)
- /catalog/install/templates/pages/install_4.php >>> some changes for to delete the install folder after finished
- /catalog/install/templates/pages/install_4.php >>> change the chmod to 0444 for /admin/includes/configure.php and /includes/configure.php
- /catalog/ext/bootstrap/css/bootstrap.css >>> better position for the asterisk in the input field
- /catalog/ext/bootstrap/css/bootstrap.min.css >>> better position for the asterisk in the input field
- /catalog/catalog/ext/bootstrap/css/bootstrap.css.map >>> better position for the asterisk in the input field
- /catalog/ext/bootstrap/css/bootstrap.css.map >>> better position for the asterisk in the input field
- /catalog/ext/bootstrap/css/bootstrap.min.css.map >>> better position for the asterisk in the input field
- /catalog/custom.css >>> add margin-bottom: 20px; to the #bodyContent >>> better margin after the content
- /catalog/includes/classes/message_stack.php >>> change function add to acivate the awesome fonts icons
- /catalog/includes/functions/html_output.php >>> add function tep_draw_icon to acivate the awesome fonts icons
- /catalog/admin/includes/header.php >>> Online Catalog link now open in new page 
- /catalog/admin/includes/header.php >>> Support Site link now open in new page
- /catalog/admin/includes/stylesheet.css >>> change the width of left column and the content

WDW modified stuff
===================
- Modular Category Page (Template modified to dropdown)
- Modular Sub Category Page (Template modified to dropdown)
- Modular Index Page (Template modified to dropdown)
- Show value in % on a Special product on every content<br />
- New images path, same like osCommerce 3.0 /images/categories/, /images/manufacturers/, /images/originals/, /images/product_thumbnails/, /images/products/, /images/temporary/. Code changes for functionality with this Version. Based on Protected Images for osC 2.3.4 (adapted by WDW for this version)

Extensions included
===================
- cKEditor >>> Product description editable with ckEditor
- KCFinder >>> Image file uploder for cKEditor
- Mailchimp Newsletter 2.02
- Protected Images for osC 2.3.4 (adapted by WDW for this version)
- New Equal Height Header Tag Module (includes jQuery 3.1.0 fix)
- Multiple Products Manager fo 2.3.3 v2.7
- Category New Products Carousel v1.4
- Category Popular Products Carousel v1.3

Planned Extensions
===================
- New email Class RMail
- Europe/German law suitable
- All Europe languages
- Product info (frontend) possibility of output as PDF-file
- Show product picture with magnifying and more
- Newsletter (admin) editable with ckEditor
- Send email (admin) editable with ckEditor
- Banner manager (admin) editable with ckEditor
- Order email with attachment Terms of Condition, Right of Cancellation, bill and delivery note as pdf
- One page checkout
- One click cancellation (frontend) for the customer
- email Forget Password editable with ckEditor 			 
- email Order editable with ckEditor
- email Order Status editable with ckEditor
- email Welcome editable with ckEditor
- Content Battery Law editable with ckEditor
- Content Disclaimer editable with ckEditor
- Content Gift Voucher FAQ editable with ckEditor
- Content Home editable with ckEditor
- Content Imprint editable with ckEditor
- Content Instructions for Returned Goods editable with ckEditor
- Content Order Help editable with ckEditor
- Content Payment editable with ckEditor
- Content Privacy & Data Protection editable with ckEditor
- Content Right of Cancellation editable with ckEditor
- Content Shipping editable with ckEditor
- Content Terms of Condition editable with ckEditor
- Content About Us editable with ckEditor
- Content Find Us editable with ckEditor
- Content Disclaimer, Privacy & Data Protection, Right of Cancellation, Terms of Condition (frontend) Possibility of output as PDF-file

You can choose to download:

https://github.com/mcmannehan/osCommerce-WDW-PV7.0-Pimp-Version-Responsiv/archive/master.zip


Help to move the Project forward
================================
I need your help to move this Project forward. At the moment, this project is done on my own, as and when time can be given.  

To allow me to give more time to this Project, I need your support:

- give time for testing new code and/or getting involved in discussions
- give code to the project - create a github account, fork and start coding

If you cannot give time or code, please give a Pledgie.  Simply click on the Donate button below to donate...

<a target="_blank" href='https://pledgie.com/campaigns/33267'><img alt='Click here to lend your support to: osCommerce-2.3.4-Responsiv and make a donation at pledgie.com !' src='https://pledgie.com/campaigns/33267.png?skin_name=chrome' border='0' ></a>

or this link:

<a target="_blank" href='https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FLUDFVAR3BL4U'>Donate, we need your support.</a>

Minimum PHP Version
===================
PHP7+ If you are on an older PHP version, you may find errors.  Update your PHP version.

Demo Site
=========
Check out the demo site at https://osc.webdesign-wedel.de
More or less, this is how Responsive osCommerce looks out of the box.

Installation
============
Install as if this is a new osCommerce installation.
