// ignore_for_file: deprecated_member_use, prefer_collection_literals, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_world/api/api_manager.dart';
import 'package:gif_world/model/home/explore_model.dart';
import 'package:gif_world/model/home/featured_model.dart';
import 'package:gif_world/model/home/trending_model.dart';
import 'package:gif_world/src/widgets/toast_msg_widget.dart';
import 'package:gif_world/utilities/api_utilities/show_alert_dailog_widget.dart';

class HomeScreenController extends GetxController {
  ///Trending GIF ------------------------------------------------------------------------------------------------------------
  TrendingsModel? trendingsModel;

  bool isTrendingNodataWidget = false;
  isTrendingNodataWidgetUpdate(bool value) {
    isTrendingNodataWidget = value;
    update();
  }

  bool isTrendingCircularProgressIndicator = false;
  isTrendingCircularProgressIndicatorUpdate(bool value) {
    isTrendingCircularProgressIndicator = value;
    update();
  }

  bool isNoInternetWidget = false;
  isNoInternetWidgetUpdate(bool value) {
    isNoInternetWidget = value;
    update();
  }

  String trendingGifposition = '';
  trendingGifpositionUpdate(String value) {
    trendingGifposition = value;
    update();
  }

  List<Map<String, Media>> trendingGifList = [];
  trendingGifListUpdate(List<Map<String, Media>> value) {
    trendingGifList.addAll(value);
    update();
  }

  List<Map<String, Media>> dtrendingGifList = [];
  dtrendingGifListUpdate(List<Map<String, Media>> value) {
    dtrendingGifList.addAll(value);
    update();
  }


  List<dynamic> trendingDynamicList = [];
  trendingDynamicListUpdate(List<dynamic> value) {
    trendingDynamicList.addAll(value);
    update();
  }

  void trendingGifData() async {
    var image = ImageClass();
    for (int i = 0; i < trendingDynamicList.length; i++) {
      if (i != 0 && (i + 1) % 7 == 0) {
        if (trendingDynamicList[i] is ImageClass) {
        } else {
          image.type = 'GoogleAd';
          trendingDynamicList.insert(i, image);
        }
      }
    }
    debugPrint(trendingDynamicList.length.toString());
  }

  trendingGif({@required BuildContext? context}) async {
    isTrendingCircularProgressIndicatorUpdate(true);
    await ApiManager().trendingGif(limit: '10', position: trendingGifposition).then((response) {
      isTrendingCircularProgressIndicatorUpdate(false);

      if (response.results!.isNotEmpty) {
        trendingsModel = response;
        for (int i = 0; i < trendingsModel!.results!.length; i++) {
          trendingGifListUpdate(response.results![i].media!);
          trendingDynamicListUpdate(response.results![i].media!);
        }
        trendingGifData();

        if (trendingsModel!.next!.isNotEmpty) {
          trendingGifpositionUpdate(trendingsModel!.next!);
        } else {
          ToastMessages().flutterToast('No More Data!');
        }
      } else {
        if (trendingGifposition.isEmpty) {
          isTrendingNodataWidgetUpdate(true);
        }
      }
    }).catchError((error) {
      isTrendingCircularProgressIndicatorUpdate(false);
      debugPrint('ERROR FROM CONTROLLER CLASS :  $error}');
      ShowAlertView(
        context: context,
        nageveCallBack: () {
          if (trendingGifList.isNotEmpty) {
            Navigator.pop(context!);
          } else {
            isNoInternetWidgetUpdate(true);
            Navigator.pop(context!);
          }
        },
        possitiveCallBack: () {
          if (trendingGifList.isNotEmpty) {
            Navigator.pop(context!);
          } else {
            trendingGif(context: context);
            Navigator.pop(context!);
          }
        },
        exception: error,
      ).checkForShowAlertDialog();
    });
  }

  ///Featured GIF ------------------------------------------------------------------------------------------------------------
  FeaturedModel? featuredModel;

  bool isFeaturedNodataWidget = false;
  isFeaturedNodataWidgetUpdate(bool value) {
    isFeaturedNodataWidget = value;
    update();
  }

  bool isFeaturedCircularProgressIndicator = false;
  isFeaturedCircularProgressIndicatorUpdate(bool value) {
    isFeaturedCircularProgressIndicator = value;
    update();
  }

  List<Tag> featuredTagList = [];
  featuredTagListUpdate(List<Tag> value) {
    featuredTagList.addAll(value);
    update();
  }

  List<Tag> featuredDynamicList = [];
  featuredDynamicListUpdate(Tag value) {
    featuredDynamicList.add(value);
    update();
  }

  void featuredGifData() async {
    for (int i = 0; i < featuredDynamicList.length; i++) {
      if (i != 0 && (i + 1) % 7 == 0) {
        if (featuredDynamicList[i].type == 'GoogleAd') {
        } else {
          featuredDynamicList.insert(i, Tag(type: ''));
        }
      }
    }
  }

  featuredGif({@required BuildContext? context}) async {
    isFeaturedCircularProgressIndicatorUpdate(true);
    await ApiManager().featuredGif().then((response) {
      isFeaturedCircularProgressIndicatorUpdate(false);

      if (response.tags!.isNotEmpty) {
        featuredModel = response;
        for (int i = 0; i < featuredModel!.tags!.length; i++) {
          featuredTagListUpdate(response.tags!);
          featuredDynamicListUpdate(response.tags![i]);
        }
        featuredGifData();
      } else {
        if (featuredTagList.isEmpty) {
          isFeaturedNodataWidgetUpdate(true);
        }
      }
    }).catchError((error) {
      isFeaturedCircularProgressIndicatorUpdate(false);
      debugPrint('ERROR FROM CONTROLLER CLASS :  $error}');
      ShowAlertView(
        context: context,
        nageveCallBack: () {
          if (featuredTagList.isNotEmpty) {
            Navigator.pop(context!);
          } else {
            isNoInternetWidgetUpdate(true);
            Navigator.pop(context!);
          }
        },
        possitiveCallBack: () {
          if (featuredTagList.isNotEmpty) {
            Navigator.pop(context!);
          } else {
            featuredGif(context: context);
            Navigator.pop(context!);
          }
        },
        exception: error,
      ).checkForShowAlertDialog();
    });
  }

  ///Explore GIF ------------------------------------------------------------------------------------------------------------
  ExploreModel? _exploreModel;

  bool isExploreNoDataWidget = false;
  isExploreNodataWidgetUpdate(bool value) {
    isExploreNoDataWidget = value;
    update();
  }

  bool isExploreCircularProgressIndicator = false;
  isExploreCircularProgressIndicatorUpdate(bool value) {
    isExploreCircularProgressIndicator = value;
    update();
  }

  List<ExploreTagModel> exploreTagList = [];
  exploreTagListUpdate(List<ExploreTagModel> value) {
    exploreTagList.addAll(value);
    update();
  }

  List<ExploreTagModel> exploreDynamicList = [];
  exploreDynamicListUpdate(ExploreTagModel value) {
    exploreDynamicList.add(value);
    update();
  }

  void exploreGifData() async {
    for (int i = 0; i < exploreDynamicList.length; i++) {
      if (i != 0 && (i + 1) % 7 == 0) {
        if (exploreDynamicList[i].type == 'GoogleAd') {
        } else {
          exploreDynamicList.insert(i, ExploreTagModel(type: ''));
        }
      }
    }
  }

  exploreGif({@required BuildContext? context}) async {
    isExploreCircularProgressIndicatorUpdate(true);
    await ApiManager().exploreGif().then((response) {
      isExploreCircularProgressIndicatorUpdate(false);

      if (response.tags!.isNotEmpty) {
        _exploreModel = response;
        for (int i = 0; i < _exploreModel!.tags!.length; i++) {
          exploreTagListUpdate(response.tags!);
          exploreDynamicListUpdate(response.tags![i]);
        }
        exploreGifData();
      } else {
        if (exploreTagList.isEmpty) {
          isExploreNodataWidgetUpdate(true);
        }
      }
    }).catchError((error) {
      isExploreCircularProgressIndicatorUpdate(false);
      debugPrint('ERROR FROM CONTROLLER CLASS :  $error}');
      ShowAlertView(
        context: context,
        nageveCallBack: () {
          if (exploreTagList.isNotEmpty) {
            Navigator.pop(context!);
          } else {
            isNoInternetWidgetUpdate(true);
            Navigator.pop(context!);
          }
        },
        possitiveCallBack: () {
          if (exploreTagList.isNotEmpty) {
            Navigator.pop(context!);
          } else {
            exploreGif(context: context);
            Navigator.pop(context!);
          }
        },
        exception: error,
      ).checkForShowAlertDialog();
    });
  }
}

class ImageClass {
  String? type;
}
