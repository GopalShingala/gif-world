// ignore_for_file: prefer_final_fields, avoid_print

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gif_world/utilities/check_network/check_network_status_controller.dart';

class CheckNetWorkUtilities {
  Connectivity _connectivity = Connectivity();
  ConnectivityResult? result;
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  CheckNetWorkStatusController _checkNetWorkStatusController = Get.find(tag: CheckNetWorkStatusController().toString());

  Future<void> instance() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();

      print('result $result');
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return updateConnectionStatus(result);
  }

  Future<void> init() async {
    instance();
    connectivitySubscription = _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        _checkNetWorkStatusController.isNetWorkUpdate(true);
        break;
      case ConnectivityResult.mobile:
        _checkNetWorkStatusController.isNetWorkUpdate(true);
        break;
      case ConnectivityResult.none:
        _checkNetWorkStatusController.isNetWorkUpdate(false);
        break;
      default:
        _checkNetWorkStatusController.isNetWorkUpdate(false);
        break;
    }
  }
}
