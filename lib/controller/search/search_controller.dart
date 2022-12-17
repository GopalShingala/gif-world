import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_world/api/api_manager.dart';
import 'package:gif_world/controller/home/home_screen_controller.dart';
import 'package:gif_world/model/search/search_model.dart';
import 'package:gif_world/src/widgets/toast_msg_widget.dart';
import 'package:gif_world/utilities/api_utilities/show_alert_dailog_widget.dart';

class SearchScreenController extends GetxController {
  final TextEditingController searchEditingController = TextEditingController();

  ///Search GIF
  SearchModel? _searchModel;

  bool isSearchNoDataWidget = false;
  isSearchNodataWidgetUpdate(bool value) {
    isSearchNoDataWidget = value;
    update();
  }

  bool isSearchCircularProgressIndicator = false;
  isSearchCircularProgressIndicatorUpdate(bool value) {
    isSearchCircularProgressIndicator = value;
    update();
  }

  bool isNoInternetWidget = false;
  isNoInternetWidgetUpdate(bool value) {
    isNoInternetWidget = value;
    update();
  }

  String searchGifposition = '';
  searchGifpositionUpdate(String value) {
    searchGifposition = value;
    update();
  }

  List<Map<String, Media>> searchGifList = [];
  searchGifListUpdate(List<Map<String, Media>> value) {
    searchGifList.addAll(value);
    update();
  }

  searchGifListClearUpdate() {
    searchGifList.clear();
    searchDynamicList.clear();
    update();
    print('GIF LIST LNG ${searchGifList.length}');
  }

  List<dynamic> searchDynamicList = [];
  searchDynamicListUpdate(List<dynamic> value) {
    searchDynamicList.addAll(value);
    update();
  }

  void searchGifData() async {
    var image = ImageClass();
    for (int i = 0; i < searchDynamicList.length; i++) {
      if (i != 0 && (i + 1) % 7 == 0) {
        if (searchDynamicList[i] is ImageClass) {
        } else {
          image.type = 'GoogleAd';
          searchDynamicList.insert(i, image);
        }
      }
    }
  }

  searchGif({@required BuildContext? context, @required String? searchKeyword}) {
    // searchGifListClearUpdate();
    isSearchCircularProgressIndicatorUpdate(true);
    ApiManager().searchGif(limit: '10', searchKeyword: searchKeyword, position: searchGifposition).then((response) {
      isSearchCircularProgressIndicatorUpdate(false);

      if (response.results!.isNotEmpty) {
        _searchModel = response;
        for (int i = 0; i < response.results!.length; i++) {
          searchGifListUpdate(response.results![i].media!);
          searchDynamicListUpdate(response.results![i].media!);
        }
        searchGifData();

        if (_searchModel!.next!.isNotEmpty) {
          searchGifpositionUpdate(_searchModel!.next!);
        } else {
          ToastMessages().flutterToast('No More Data!');
        }
      } else {
        if (searchGifposition.isEmpty) {
          isSearchNodataWidgetUpdate(true);
        }
      }
    }).catchError((error) {
      isSearchCircularProgressIndicatorUpdate(false);
      debugPrint('ERROR FROM CONTROLLER CLASS :  $error}');
      ShowAlertView(
        context: context,
        nageveCallBack: () {
          if (searchGifList.isNotEmpty) {
            Navigator.pop(context!);
          } else {
            isNoInternetWidgetUpdate(true);
            Navigator.pop(context!);
          }
        },
        possitiveCallBack: () {
          if (searchGifList.isNotEmpty) {
            Navigator.pop(context!);
          } else {
            searchGif(context: context, searchKeyword: searchKeyword);
            Navigator.pop(context!);
          }
        },
        exception: error,
      ).checkForShowAlertDialog();
    });
  }
}
