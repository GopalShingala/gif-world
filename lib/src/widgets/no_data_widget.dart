import 'package:flutter/material.dart';
import 'package:gif_world/utilities/assets/asset_utilities.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 300,
            width: 300,
            image: AssetImage(
              AssetUtilities.emptyDataImagePng,
            ),
          ),
        ],
      ),
    );
  }
}
