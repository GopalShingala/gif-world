import 'package:flutter/material.dart';
import 'package:gif_world/utilities/admob/admob_utilities.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  final AdSize? adSize;
  const BannerAdWidget({Key? key, this.adSize = AdSize.fullBanner})
      : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  @override
  void initState() {
    super.initState();

    _bannerAd = BannerAd(
      adUnitId: AdmobUtilities.bannerAdUnitId,
      request: const AdRequest(),
      size: widget.adSize!,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd!.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isBannerAdReady
          ? Center(
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(
                  ad: _bannerAd!,
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
