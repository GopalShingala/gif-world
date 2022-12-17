// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gif_world/api/common/api.dart';
import 'package:gif_world/api/request/home/explore_screen_request.dart';
import 'package:gif_world/api/request/home/featured_screen_request.dart';
import 'package:gif_world/api/request/home/trending_screen_request.dart';
import 'package:gif_world/api/request/search/search_screen_request.dart';
import 'package:gif_world/model/home/explore_model.dart';
import 'package:gif_world/model/home/featured_model.dart';
import 'package:gif_world/model/home/trending_model.dart';
import 'package:gif_world/model/search/search_model.dart';
import 'package:gif_world/utilities/exceptions/exception_helper.dart';
import 'package:gif_world/utilities/exceptions/exception_type.dart';

class ApiManager {
  BuildContext? context;

  Future<TrendingsModel> trendingGif({@required String? limit, @required String? position}) {
    Completer<TrendingsModel> completer = Completer();

    TrendingScreenRequest _trendingScreenRequest = TrendingScreenRequest(limit: limit, position: position);
    Api().request(_trendingScreenRequest).then((response) {
      if (response.statusCode == 200) {
        completer.complete(TrendingsModel.fromJson(jsonDecode(response.body)));
      } else {
        completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException));
      }
    }).catchError((error) {
      completer.completeError(Exception(error));
    });
    return completer.future;
  }

  Future<FeaturedModel> featuredGif() {
    Completer<FeaturedModel> completer = Completer();

    FeatureScreenRequest _featureScreenRequest = FeatureScreenRequest();
    Api().request(_featureScreenRequest).then((response) {
      if (response.statusCode == 200) {
        completer.complete(FeaturedModel.fromJson(jsonDecode(response.body)));
      } else {
        completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException));
      }
    }).catchError((error) {
      completer.completeError(Exception(error));
    });
    return completer.future;
  }

  Future<ExploreModel> exploreGif() {
    Completer<ExploreModel> completer = Completer();

    ExploreScreenRequest _exploreScreenRequest = ExploreScreenRequest();
    Api().request(_exploreScreenRequest).then((response) {
      if (response.statusCode == 200) {
        completer.complete(ExploreModel.fromJson(jsonDecode(response.body)));
      } else {
        completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException));
      }
    }).catchError((error) {
      completer.completeError(Exception(error));
    });
    return completer.future;
  }

  Future<SearchModel> searchGif({
    @required String? searchKeyword,
    @required String? limit,
    @required String? position,
  }) {
    Completer<SearchModel> completer = Completer();

    SearchScreenRequest _searchScreenRequest = SearchScreenRequest(limit: limit, position: position, searchKeyword: searchKeyword);
    Api().request(_searchScreenRequest).then((response) {
      if (response.statusCode == 200) {
        completer.complete(SearchModel.fromJson(jsonDecode(response.body)));
      } else {
        completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException));
      }
    }).catchError((error) {
      completer.completeError(Exception(error));
    });
    return completer.future;
  }
}
