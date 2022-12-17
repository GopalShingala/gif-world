
import 'package:gif_world/api/common/i_http_request.dart';

import '../../api_utils.dart';

class FeatureScreenRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUtils.tags;

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
      'type': 'featured',
    };
    return map;
  }
}
