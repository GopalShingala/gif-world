// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gif_world/src/widgets/alert_dialog_widget.dart';
import 'package:gif_world/src/widgets/toast_msg_widget.dart';

import 'alert_massage_utils.dart';
class ShowAlertView {
  BuildContext? context;
  VoidCallback? possitiveCallBack;
  VoidCallback? nageveCallBack;
  Exception? exception;

  ShowAlertView({
    @required this.context,
    @required this.possitiveCallBack,
    @required this.nageveCallBack,
    @required this.exception,
  });

  void checkForShowAlertDialog() {
    /// if NetWork Exception

    if (exception.toString().contains('SocketException')) {
      ToastMessages().flutterToast('No Connection!');
      // ignore: prefer_const_constructors
      // Get.dialog(SimpleDialog(
      //   title: const Text('No Connection!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
      // ));
      // DialogUtils.showNetworkAlertDialog(
      //   context: context!,
      //   title: AlertMassageUtils.noInternetTitleMsg,
      //   message: AlertMassageUtils.noInternetMsg,
      //   negativeMsg: AlertMassageUtils.cancelMsg,
      //   positiveMsg: AlertMassageUtils.retryMsg,
      //   negativeOnTap: nageveCallBack,
      //   positiveOnTap: possitiveCallBack,
      // );
    } else if (exception.toString().contains('NetworkException')) {
      // ToastMessages().flutterToast(AlertMassageUtils.noInternetTitleMsg!);

      DialogUtils.showNetworkAlertDialog(
        context: context!,
        title: AlertMassageUtils.noInternetTitleMsg,
        message: AlertMassageUtils.noInternetMsg,
        negativeMsg: AlertMassageUtils.cancelMsg,
        positiveMsg: AlertMassageUtils.retryMsg,
        negativeOnTap: nageveCallBack,
        positiveOnTap: possitiveCallBack,
      );
    }

    /// if HTTP Exception
    else if (exception.toString().contains('HttpException')) {
      ToastMessages().flutterToast(AlertMassageUtils.httpError!);
      // DialogUtils.showNetworkAlertDialog(
      //   context: context!,
      //   title: AlertMassageUtils.tokenExpiredTitleMsg,
      //   message: AlertMassageUtils.tokenExpiredMsg,
      //   negativeMsg: AlertMassageUtils.retryMsg,
      //   positiveMsg: AlertMassageUtils.cancelMsg,
      //   negativeOnTap: nageveCallBack,
      //   positiveOnTap: possitiveCallBack,
      // );
    }

    /// if other Error
    else {
      ToastMessages().flutterToast(AlertMassageUtils.someThingWrongMsg!);
      // DialogUtils.showNetworkAlertDialog(
      //   context: context!,
      //   title: AlertMassageUtils.tokenExpiredTitleMsg,
      //   message: AlertMassageUtils.tokenExpiredMsg,
      //   negativeMsg: AlertMassageUtils.retryMsg,
      //   positiveMsg: AlertMassageUtils.cancelMsg,
      //   negativeOnTap: nageveCallBack,
      //   positiveOnTap: possitiveCallBack,
      // );
    }
  }
}
