import 'package:flutter/material.dart';
import 'package:gif_world/api/common/i_http_request.dart';
import 'package:gif_world/utilities/api_utilities/alert_massage_utils.dart';

import 'package:http/http.dart';

class TokenDetails {
  void setTokenValue({@required String? token}) {
    IHttpRequest.defaultHeader = {'Accept': 'application/json', 'Content-Type': 'application/json', 'Authorization': "Bearer " + token!};
  }

  bool checkTokenExpiry({
    @required Response? response,
  }) {
    // if (response.statusCode == 401)
    if (response!.statusCode == 401 && response.body.toLowerCase().compareTo(AlertMassageUtils.unauthenticatedText!) == 1) {
      return true;
    }
    return false;
  }
}
