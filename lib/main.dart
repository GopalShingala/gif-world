import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gif_world/utilities/check_network/check_network_status_controller.dart';
import 'package:gif_world/utilities/check_network/check_network_status_utility.dart';
import 'package:gif_world/utilities/fonts/font_utilities.dart';
import 'package:gif_world/utilities/routes/route_utilities.dart';
import 'package:gif_world/utilities/settings/preference_key.dart';
import 'package:gif_world/utilities/settings/variable_utilities.dart';
import 'package:gif_world/utilities/theme/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:platform_device_id/platform_device_id.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  GetStorage.init(PreferenceKey.applicationStorageKey);
  VariableUtilities.prefs = GetStorage(PreferenceKey.applicationStorageKey);
  String? deviceId = await PlatformDeviceId.getDeviceId;
  print('😈😈😈😈😈😈😈😈😈😈😈 DEVICE ID --->>> $deviceId');

  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: ['0C1ECEAC56AD7E998C1FD6F6878F9A60']);
  MobileAds.instance.updateRequestConfiguration(configuration);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    return runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    ThemeManager.initializeTheme();
  }

  CheckNetWorkStatusController checkNetWorkStatusController = Get.put(
      CheckNetWorkStatusController(),
      tag: CheckNetWorkStatusController().toString());

  @override
  Widget build(BuildContext context) {
    CheckNetWorkUtilities().init();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteUtilities.root,
      getPages: RouteUtilities.pages,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: VariableUtilities.theme.primaryColor,
          centerTitle: true,
          titleTextStyle: FontUtilities.h22(
              fontColor: VariableUtilities.theme.whiteColor,
              fontWeight: FWT.medium),
        ),
        scaffoldBackgroundColor: VariableUtilities.theme.whiteColor,
      ),
    );
  }
}
