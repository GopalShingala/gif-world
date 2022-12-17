import 'dart:io';

class AdmobUtilities {
  ///Test Admob Id
  // static const String testAndroidAdmobAppId =
  //     'ca-app-pub-3940256099942544~3347511713';
  // static const String testAndroidBannerAdmobId =
  //     'ca-app-pub-3940256099942544/6300978111';
  // static const String testAndroidNativAdmobId =
  //     'ca-app-pub-3940256099942544/2247696110';
  // static const String testAndroidInterstitialAdmobId =
  //     'ca-app-pub-3940256099942544/1033173712';
  // static const String testAndroidRewardedAdmobId =
  //     'ca-app-pub-3940256099942544/5224354917';

  // static const String testIOSAdmobAppId =
  //     'ca-app-pub-3940256099942544~1458002511';
  // static const String testIOSBannerAdmobId =
  //     'ca-app-pub-3940256099942544/2934735716';
  // static const String testIOSNativAdmobId =
  //     'ca-app-pub-3940256099942544/3986624511';

  ///Live Admob Id
  static const String androidAdmobAppId =
      'ca-app-pub-1917791848171914~2802305780';
  static const String androidAdmobBannerId =
      'ca-app-pub-1917791848171914/5616171381';
  static const String androidInterstitialId =
      'ca-app-pub-1917791848171914/7092904588';
  static const String androidNativBannerId =
      'ca-app-pub-1917791848171914/3043245360';

  static const String iosAdmobAppId = 'ca-app-pub-1917791848171914~9441178116';
  static const String iosAdmobBannerId =
      'ca-app-pub-1917791848171914/1523159649';
  static const String iosInterstitialId =
      'ca-app-pub-1917791848171914/6324894337';
  static const String iosNativId = 'ca-app-pub-1917791848171914/5750179267';
  static const String iosRewardedId = 'ca-app-pub-1917791848171914/2194077639';

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1917791848171914/1523159649';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1917791848171914/6324894337";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1917791848171914/2194077639";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
