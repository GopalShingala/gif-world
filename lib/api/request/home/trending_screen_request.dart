import 'package:flutter/material.dart';
import 'package:gif_world/api/common/i_http_request.dart';
import '../../api_utils.dart';


class TrendingScreenRequest implements IHttpRequest {
  String? position;
  String? limit;

  @override
  String? absolutePath = ApiUtils.trending;

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
    };
    return map;
  }

  TrendingScreenRequest({
    @required String? limit,
    @required String? position,
  }) {
    this.limit = limit!;
    this.position = position!;
  }
}
