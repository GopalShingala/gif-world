import 'package:flutter/material.dart';
import 'package:gif_world/utilities/assets/asset_utilities.dart';


class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 50,
            width: 50,
            image: AssetImage(AssetUtilities.noInternetImagePng),
          ),
          const Text(
            'No Internet!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
