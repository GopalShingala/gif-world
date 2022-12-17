// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DialogUtils {
  // ignore: non_constant_identifier_names
  static Future<String?> showNetworkAlertDialog({
    required BuildContext context,
    final String? title,
    final String? message,
    final String? negativeMsg,
    final String? positiveMsg,
    final VoidCallback? negativeOnTap,
    final VoidCallback? positiveOnTap,
  }) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(title!, style: TextStyle(fontWeight: FontWeight.w500)),
          content: Text(
            message!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            Visibility(
              visible: negativeMsg == "" ? false : true,
              // ignore: deprecated_member_use
              child: ElevatedButton(
                child: Text(negativeMsg!),
                onPressed: negativeOnTap,
              ),
            ),
            Visibility(
              visible: positiveMsg == "" ? false : true,
              // ignore: deprecated_member_use
              child: ElevatedButton(
                child: Text(positiveMsg!),
                onPressed: positiveOnTap,
              ),
            ),
          ],
        );
      },
    );
  }
}
