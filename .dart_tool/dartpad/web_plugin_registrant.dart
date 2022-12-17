// Flutter web plugin registrant file.
//
// Generated file. Do not edit.
//

// @dart = 2.13
// ignore_for_file: type=lint

import 'package:connectivity_plus_web/connectivity_plus_web.dart';
import 'package:device_info_plus_web/device_info_plus_web.dart';
import 'package:fluttertoast/fluttertoast_web.dart';
import 'package:platform_device_id_web/platform_device_id_web.dart';
import 'package:share_plus_web/share_plus_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  ConnectivityPlusPlugin.registerWith(registrar);
  DeviceInfoPlusPlugin.registerWith(registrar);
  FluttertoastWebPlugin.registerWith(registrar);
  PlatformDeviceIdWebPlugin.registerWith(registrar);
  SharePlusPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
