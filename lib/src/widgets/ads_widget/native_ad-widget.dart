// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:gif_world/utilities/admob/admob_utilities.dart';
// import 'package:native_ads_flutter/native_ads.dart';

// class NativeAdWidget extends StatefulWidget {
//   const NativeAdWidget({Key? key}) : super(key: key);

//   @override
//   State<NativeAdWidget> createState() => _NativeAdWidgetState();
// }

// class _NativeAdWidgetState extends State<NativeAdWidget> {
//   final NativeAdmobController _nativeAdController = NativeAdmobController();
//   StreamSubscription? _subscription;
//   double _height = 0;

//   @override
//   void initState() {
//     super.initState();
//     _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
//     // _controller.reloadAd();
//     // _controller.setTestDeviceIds(['45c0d672e271a877']);
//   }

//   void _onStateChanged(AdLoadState state) {
//     switch (state) {
//       case AdLoadState.loading:
//         setState(() {
//           _height = 0;
//         });
//         break;

//       case AdLoadState.loadCompleted:
//         setState(() {
//           _height = 330;
//         });
//         break;

//       default:
//         break;
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _subscription!.cancel();
//     _nativeAdController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: SizedBox(
//       height: 330,
//       child: Container(
//         height: _height, 
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.only(bottom: 20.0),
//         child: NativeAdmob(
//           // Your ad unit id
//           adUnitID: AdmobUtilities.nativeAdUnitId,
//           controller: _nativeAdController,
//           numberAds: 50,
//           key: UniqueKey(),
//           // Don't show loading widget when in loading state
//           loading: Container(), error: const Icon(Icons.error),
//           options: const NativeAdmobOptions(),
//         ),
//       ),
//     ));
//   }
// }
