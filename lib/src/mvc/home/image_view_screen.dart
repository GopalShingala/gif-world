// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:gif_world/controller/home/image_details_controller.dart';
import 'package:gif_world/src/widgets/ads_widget/banner_ad_widget.dart';
import 'package:gif_world/src/widgets/home/image_view_widget.dart';
import 'package:gif_world/src/widgets/image_details/button_widget.dart';
import 'package:gif_world/src/widgets/popup_menu_widget.dart';
import 'package:gif_world/utilities/admob/admob_utilities.dart';
import 'package:gif_world/utilities/arguments/arguments_utilities.dart';
import 'package:gif_world/utilities/settings/variable_utilities.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ImageViewScreen extends StatefulWidget {
  final DetailsScreenArguments? arguments;
  const ImageViewScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  final ImageDetailsController _imageDetailsController =
      Get.find(tag: ImageDetailsController().toString());
  final GlobalKey _globalKey = GlobalKey();

  InterstitialAd? interstitialAd;
  int interstitialAttempts = 0;
  int maxAttempts = 3;
  RewardedAd? rewardedAd;
  int rewardedAdAttempts = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      createInterstitialAd();
      createRewardedAd();
    });
  }

  @override
  void dispose() {
    super.dispose();
    interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.arguments!.imageUrl);

    return Scaffold(
      appBar: AppBar(
        title: const Text('''GIF's World'''),
        actions: const [
          PopUpMenuWidget(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              key: _globalKey,
              child: Container(
                color: VariableUtilities.theme.blackColor,
                child: Center(
                  child: ImageViewWidget(
                    gifUrl: widget.arguments!.imageUrl,
                    isLableShow: false,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                lable: 'Download',
                onTap: () {
                  showRewardedAd();
                  // _imageDetailsController.saveVideo(gifUrl: widget.arguments!.imageUrl);
                },
              ),
              ButtonWidget(
                lable: 'Share',
                onTap: () {
                  showInterstitialAd();
                  // _imageDetailsController.shareImage(
                  //     gifUrl: widget.arguments!.imageUrl);
                },
              ),
            ],
          ),
          BannerAdWidget(
            adSize: AdSize.banner,
            key: UniqueKey(),
          ),
        ],
      ),
    );
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdmobUtilities.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          interstitialAttempts = 0;
        },
        onAdFailedToLoad: (error) {
          interstitialAttempts++;
          interstitialAd = null;
          debugPrint('Failed to load ${error.message}');

          if (interstitialAttempts <= maxAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      createInterstitialAd();
      return;
    }

    interstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdShowedFullScreenContent: (ad) {
      debugPrint(
          'FullScreenContentCallback $ad 😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆');
    }, onAdDismissedFullScreenContent: (ad) {
      _imageDetailsController.shareImage(gifUrl: widget.arguments!.imageUrl);
      debugPrint(
          'onAdDismissedFullScreenContent $ad 😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆');
      ad.dispose();
      createInterstitialAd();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      debugPrint(
          'failed to show the ad $ad 😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆');
      createInterstitialAd();
    });

    interstitialAd!.show();
    interstitialAd = null;
  }

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdmobUtilities.rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          rewardedAd = ad;
          rewardedAdAttempts = 0;
        }, onAdFailedToLoad: (error) {
          rewardedAdAttempts++;
          rewardedAd = null;
          print('failed to load  ${error.message}');

          if (rewardedAdAttempts <= maxAttempts) {
            createRewardedAd();
          }
        }));
  }

  void showRewardedAd() {
    if (rewardedAd == null) {
      createRewardedAd();
      return;
    }

    rewardedAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdShowedFullScreenContent: (ad) {
      print('FullScreenContentCallback 😆😆😆😆😆😆😆😆😆😆😆😆😆😆');
    }, onAdDismissedFullScreenContent: (ad) {
      ad.dispose();
      print('DISMISS 😆😆😆😆😆😆😆😆😆😆😆😆😆😆');
      createRewardedAd();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      print(
          'failed to show the ad 😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆 $ad');

      createRewardedAd();
    });

    rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      print(
          'reward video 😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆😆 ${reward.amount} ${reward.type}');
      _imageDetailsController.saveVideo(gifUrl: widget.arguments!.imageUrl);
    });
    rewardedAd = null;
  }
}
