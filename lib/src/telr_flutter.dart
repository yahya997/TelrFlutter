import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './model/billing_address.dart';
import './model/config.dart';
import './model/transaction.dart';

class TelrFlutter {
  final TelrConfiguration configuration;
  BillingAddress billingAddress;
  Transaction transaction;
  MethodChannel _channel = const MethodChannel('telr_flutter');

  TelrFlutter({@required this.configuration});

  Future<String> _startTransaction() async {
    final String transActionId =
        await _channel.invokeMethod<String>('startTransaction', {
      "config": configuration.toMap(),
      "billingAddress": billingAddress.toMap(),
      "transaction": transaction.toMap(),
    });
    log(transActionId.toString());
    print("=-=-=-=-=-== TRANACTION ID YA PRINCE -=-=> $transActionId");
    return transActionId;
  }

  Future<String> makePayment({@required Transaction transaction}) async {
    if (billingAddress == null) {
      return null;
    }
    this.transaction = transaction;
    return _startTransaction();
  }
}
