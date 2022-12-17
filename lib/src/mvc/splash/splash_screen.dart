import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_world/src/widgets/asset_image_widget.dart';
import 'package:gif_world/utilities/assets/asset_utilities.dart';
import 'package:gif_world/utilities/routes/route_utilities.dart';
import 'package:gif_world/utilities/settings/variable_utilities.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(RouteUtilities.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    VariableUtilities.screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          const Center(
            child: AvatarGlow(
              glowColor: Colors.blue,
              endRadius: 150.0,
              duration: Duration(milliseconds: 650),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              child: Text(''),
            ),
          ),
          Center(
            child: AssetImageCustomWidget(
              assetImageUrl: AssetUtilities.logoCirImagePng,
              height: 130,
              width: 130,
            ),
          ),
        ],
      )),
    );
  }
}
