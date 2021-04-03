import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:ulomobile_project/widgets/animated_dialog.dart';

import 'widgets/custom_alert_dialog.dart';

class DataConnectivityService with ChangeNotifier {
  static StreamController<DataConnectionStatus> connectivityStreamController =
      StreamController<DataConnectionStatus>();
  DataConnectivityService() {
    DataConnectionChecker().onStatusChange.listen((event) {
      connectivityStreamController.add(event);
    });
  }
}

class NetworkConnectivityChecker {
  static checkConnection(BuildContext context, Function function) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      animatedDialog(
          context: context,
          child: CustomAlertDialog(
            title: 'Internet Error',
            content: Text('Please check your internet connection'),
          ));
    } else if (result == ConnectivityResult.mobile) {
      function();
    } else if (result == ConnectivityResult.wifi) {
      function();
    }
  }
}
