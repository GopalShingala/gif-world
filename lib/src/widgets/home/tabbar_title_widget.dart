import 'package:flutter/material.dart';

class TabBarTitleWidget extends StatelessWidget {
  final String? lable;
  const TabBarTitleWidget({Key? key, this.lable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        lable!,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
