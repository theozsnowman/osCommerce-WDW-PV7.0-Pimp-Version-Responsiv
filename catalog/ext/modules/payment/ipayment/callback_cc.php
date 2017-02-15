<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  chdir('../../../../');
  require('includes/application_top.php');

  require('includes/languages/' . $language . '/modules/payment/ipayment_cc.php');
  require('includes/modules/payment/ipayment_cc.php');
  $ipayment_cc = new ipayment_cc();

  if (!$ipayment_cc->check() || !$ipayment_cc->enabled) {
    exit;
  }

  if (in_array(tep_get_ip_address(), $ipayment_cc->gateway_addresses)) {
    $checksum_pass = 0; // unknown

    if (tep_not_null(MODULE_PAYMENT_IPAYMENT_CC_SECRET_HASH_PASSWORD)) {
// verify ret_param_checksum
      if ($_POST['ret_param_checksum'] == md5(MODULE_PAYMENT_IPAYMENT_CC_USER_ID . $_POST['trx_amount'] . $_POST['trx_currency'] . $_POST['ret_authcode'] . $_POST['ret_booknr'] . MODULE_PAYMENT_IPAYMENT_CC_SECRET_HASH_PASSWORD)) {
        $checksum_pass = 1; // true
      } else {
        $checksum_pass = -1; // false
      }
    }

    $ipayment_cc->sendDebugEmail($checksum_pass);
  }
?>
