// ignore_for_file: prefer_final_fields, avoid_print

import 'dart:async';

import 'package:get/get.dart';
import 'package:gif_world/api/common/i_http_request.dart';
import 'package:gif_world/utilities/check_network/check_network_status_controller.dart';
import 'package:gif_world/utilities/exceptions/exception_helper.dart';
import 'package:gif_world/utilities/exceptions/exception_type.dart';
import 'package:http/http.dart' as http;

class Api {
  CheckNetWorkStatusController _checkNetWorkStatusController = Get.find(tag: CheckNetWorkStatusController().toString());
  Future<http.Response> request(IHttpRequest request) {
    List<String>? listKeys = [];
    List<String>? listValues = [];

    request.parameters!.forEach((key, value) {
      listKeys.add(key);
      listValues.add(value);
    });

    String? paramString = '';
    for (int i = 0; i < listKeys.length; i++) {
      if (i == 0) {
        paramString = paramString! + '?';
      }
      paramString = paramString! + listKeys[i] + '=' + listValues[i];

      if (i != listKeys.length - 1) {
        paramString = paramString + '&';
      }
    }

    Completer<http.Response> completer = Completer();

    if (_checkNetWorkStatusController.isNetWork) {
      // print('------------------------------------------------- Network is Availavle');
      if (request.httpMethod == HttpMethod.GET) {
        // print('GET absolutePath ${request.absolutePath}${paramString!}');
        // print('GET body ${request.body}');
        // print('GET headers ${request.headers}');
        // print('GET httpMethod ${request.httpMethod}');
        // print('GET parameters ${request.parameters}');
        http.get(Uri.parse(request.absolutePath! + paramString!), headers: request.headers as Map<String, String>).then((response) {
          // print("GET RESPONSE BODY -> ${response.body}");
          // print("GET RESPONSE STATUS CODE -> ${response.statusCode}");
          completer.complete(response);
        }).catchError((error) {
          completer.completeError(Exception(error));
        });
      } else if (request.httpMethod == HttpMethod.POST) {
        // print('POST absolutePath ${request.absolutePath}');
        // debugPrint('POST body ${request.body}');
        // print('POST headers ${request.headers}');
        // print('POST httpMethod ${request.httpMethod}');
        // print('POST parameters ${request.parameters}');
        http
            .post(
          Uri.parse(request.absolutePath! + paramString!),
          headers: request.headers as Map<String, String>,
          body: request.body,
        )
            .then((response) {
          completer.complete(response);
          // print('response $response');
          // print('response ${response.headers}');
          // print('response ${response.request}');
          // log("POST RESPONSE BODY -> ${response.body}");
          // print("POST RESPONSE STATUS CODE -> ${response.statusCode}");
        }).catchError((error) {
          // print('API CLASS error $error');
          completer.completeError(Exception(error));
        });
      }
      return completer.future;
    } else {
      print('YOU ARE OFFLINE');
      completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.NetworkException));
      return completer.future;
    }
  }
}
