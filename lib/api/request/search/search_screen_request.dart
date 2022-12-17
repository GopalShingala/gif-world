import 'package:flutter/material.dart';
import 'package:gif_world/api/common/i_http_request.dart';
import '../../api_utils.dart';

class SearchScreenRequest implements IHttpRequest {
  String? position;
  String? limit;
  String? searchKeyword;

  @override
  String? absolutePath = ApiUtils.search;

  @override
  Object? body;

  @override
  HttpMethod? httpMethod = HttpMethod.GET;

  @override
  Map<String, dynamic>? get headers {
    return IHttpRequest.defaultHeader;
  }

  @override
  Map<String, String>? get parameters {
    Map<String, String> map = <String, String>{};
    map = {
      'key': '66HIPT7UZJE0',
      'limit': limit!,
      'pos': position!,
      'q': searchKeyword!,
    };
    return map;
  }

  SearchScreenRequest({
    @required String? limit,
    @required String? position,
    @required String? searchKeyword,
  }) {
    this.limit = limit!;
    this.position = position!;
    this.searchKeyword = searchKeyword!;
  }
}
