<?php
/**
  * Gyakutsuki
 * subscribe.php
 * @copyright Copyright 2016
 * @copyright Portions Copyright osCommerce
 * @license GNU Public License V2.0
 * @version $Id:
 */

  chdir('../../../');

  require('includes/application_top.php');

  include('ext/api/mailchimp_v3/MailChimp.php');

  $key = MODULES_HEADER_TAGS_MAILCHIMP_API;

  if ( isset($_POST['anonymous'])) {
    $list_id = MODULES_HEADER_TAGS_MAILCHIMP_LIST_ANONYMOUS;
    $merge_vars = [
      'FNAME' => '',
      'LNAME' => ''
    ];

  } else {
    $list_id = MODULES_HEADER_TAGS_MAILCHIMP_LIST_CUSTOMERS;

    $merge_vars = [
      'FNAME' => $_POST['firstname'],
      'LNAME' => $_POST['lastname']
    ];
  }

  $array = [
              'email_address' => $_POST['email'],
              'merge_fields'  => $merge_vars,
              'status'        => MODULES_HEADER_TAGS_MAILCHIMP_STATUS_CHOICE
            ];


  if (MODULES_HEADER_TAGS_MAILCHIMP_STATUS_CHOICE == 'pending') {
    $status = 'pending';
  } else {
    $status = 'subscribed';
  }

  $mc = new \MailChimp($key);

// add the email to your list
    $result = $mc->post('/lists/' . $list_id . '/members', $array);

//send
    $result = json_encode($result);

// If being called via ajax, run the function, else fail - console
  if ( MODULES_HEADER_TAGS_MAILCHIMP_DEBUG == 'True') {
    if ($_POST['ajax']) {
      var_dump($result); // send the response back
    } else {
      var_dump('Method not allowed - please ensure JavaScript is enabled in this browser');
    }
  } else {
    echo $result;    
  }
