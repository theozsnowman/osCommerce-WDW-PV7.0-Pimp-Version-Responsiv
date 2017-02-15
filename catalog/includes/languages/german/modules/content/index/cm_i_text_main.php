<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2016 osCommerce

  Released under the GNU General Public License
*/

  const MODULE_CONTENT_TEXT_MAIN_TITLE       = 'Bitte lesen';
  const MODULE_CONTENT_TEXT_MAIN_DESCRIPTION = 'Shows the "Text" module on your Index page.';
  
  const MODULE_CONTENT_TEXT_MAIN_TEXT        = 'Hier läuft (mit PHP7.1.1 und MySQL 5.7):<br />
  <a target="_blank" href="https://github.com/mcmannehan/osCommerce-WDW-PV7.0-Pimp-Version-Responsiv">https://github.com/mcmannehan/osCommerce-WDW-PV7.0-Pimp-Version-Responsiv</a><br />
  
  Vergessen Sie nicht, alle "Dateinamen" und "einige Inhaltverzeichnisse" sind hartcodiert.<br /><br />
	
	Download dieser Shop Version <a href="https://github.com/mcmannehan/osCommerce-WDW-PV7.0-Pimp-Version-Responsiv/archive/master.zip">hier</a><br /><br />

	Fragen und Support in unserem Forum (im Moment nur in Englisch): <a target="_blank" href="https://forum.webdesign-wedel.de/index.php">https://forum.webdesign-wedel.de</a><br /><br />
	
	Helfen Sie, das Projekt weiter voranzubringen<br />
	====================================<br />
	Ich brauche Ihre Hilfe, um dieses Projekt voranzubringen. Im Moment wird dieses Projekt alleine von mir bearbeitet, <br />
	so wie ich die Zeit dazu habe.<br /><br />
	
	Um mehr Zeit für dieses Projekt zu haben, brauche ich Ihre Unterstützung:<br /><br />

	- Sie haben Zeit für das Testen von neuem Code und/oder beteiligen Sie sich an Diskussionen<br />
	- Erstellen Sie ein Github-Konto, Fork und starten programmieren<br /><br />

	Wenn Sie keine Zeit haben, geben Sie bitte eine Spende...<br />
	<a target="_blank" href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FLUDFVAR3BL4U">Bitte spenden Sie, wir brauchen Ihre Unterstützung.</a><br /><br />
		
	PHP7 & MySql 5.7 Update<br />
	Methoden mit dem gleichen Namen wie die Klasse werden keine Konstruktion in zukünftigen Versionen von PHP in Moduldateien und Klassendateien haben. MySql-Abfragen für MySql 5.7 sql_mode<br /><br /> 
	
	Bereits geändert<br />
	- Einige neue Icons für den Adminbereich<br />
	- alle Classfiles jetzt voll PHP7+ geeignet<br />
	- alle MySQL-Abfragen jetzt voll MySQL5.7 geeignet<br />
	- Install: Wert von products_name varchar(64) geändert in products_name varchar (128)<br />
	- Install: Einige Änderungen, um den Installationsordner zu löschen, nachdem alles installiert ist<br />
	- Install: Änderung von chmod zu 0444 für /admin/includes/configure.php und /includes/configure.php<br />
	- Frontend: Bessere Position für das Asterisk im Eingabefeld<br />
	- Frontend: margin-bottom hinzugefügt: 20px; #bodyContent >>> besserer Margin nach dem Inhalt<br />
	- Frontend: Funktion hinzugefügt um die awesome fonts icons zu aktivieren<br />
	- Frontend: Funktion add geändert um die awesome fonts icons anzuzeigen<br />
	- Backend: Online Katalog Link wird jetzt in neuer Seite geöffnet<br />
	- Backend: Die Breite der linken Spalte und des Inhalts geändert<br />
	- Deutsche Sprache installiert (95% übersetzt)<br /><br />

	Geändert von Webdesign Wedel (WDW)<br />
	- Produktbeschreibung bearbeitbar mit ckEditor<br />
	- Bilddatei-Uploder für cKEditor<br />
	- Banner-Manager bearbeitbar mit ckEditor<br />
	- Newsletter bearbeitbar mit ckEditor<br />
	- E-Mail an Kunden senden, bearbeitbar mit ckEditor<br />
	- Modulare Kategorie-Seite (Vorlage geändert in Dropdown-Liste)<br />
	- Modulare Unterkategorien-Seite (Vorlage geändert in Dropdown-Liste)<br />
	- Modulare Indexseite (Vorlage geändert in Dropdown-Liste)<br />
	- Zeige Rabatt in % bei jedem Angebot<br />
	- Overlay Bild Rabatt (Ein-/Ausschalten im Admin)<br />
	- Neuer Bilderpfad basierend auf Protected Images für osC 2.3.4 (von WDW für diese Version angepasst)<br />
	- Neue Präsentation der Produktbilder mit elevateZoom und fancybox<br />
	- Zeige inkl. MwSt/exkl. MwSt bei jedem Preis<br /><br />
 
	Enthaltene Erweiterungen<br />
  - TCPDF 6.2.13<br />
  - Mailchimp Newsletter 2.02<br />
  - New Equal Height Header Tag Module (inklusiv jQuery 3.1.0 fix)<br />
  - Modular Category Page v1.1<br />
  - Superfish Box 1.2.2<br />
  - Categories Menu XS v1.2<br />
  - Horizontal Categories Menu BS v1.3.1 (adapted by WDW for this version)<br />
  - USU5 XML Site Maps (von WDW geändert, öffnet jetzt jQuery modular)<br />
  - Category New Products Carousel v1.4<br />
  - Category Popular Products Carousel v1.3<br />
  - Multiple Products Manager v2.7 (von WDW für diese Version angepasst)<br />
  - Specials Image Overlay 1.0.1 (von WDW für diese Version angepasst)<br />
  - Protected Images for osC 2.3.4 (von WDW für diese Version angepasst)<br />
  - Scroll Boxes V1.7 (von WDW für diese Version angepasst)<br />
  - Ultimate Seo Urls 5 for Responsive Oscommerce<br />
  - PDF Datasheet 1.2.3 Produkt Info als PDF Datei (von WDW für diese Version angepasst)<br /><br />
  ';