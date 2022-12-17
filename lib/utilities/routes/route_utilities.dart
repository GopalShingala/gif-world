import 'package:get/get.dart';
import 'package:gif_world/bindings/home/home_screen_bindings.dart';
import 'package:gif_world/bindings/home/image_details_bindings.dart';
import 'package:gif_world/bindings/search/search_screen_bindings.dart';
import 'package:gif_world/src/mvc/home/home_screen.dart';
import 'package:gif_world/src/mvc/home/image_list_screen.dart';
import 'package:gif_world/src/mvc/home/image_view_screen.dart';
import 'package:gif_world/src/mvc/home/search_screen.dart';
import 'package:gif_world/src/mvc/splash/splash_screen.dart';
import 'package:gif_world/utilities/arguments/arguments_utilities.dart';


/// All the routes and pages used in the application are used in this class.
class RouteUtilities {
  static String root = "/";
  static String splashScreen = "/splashScreen";
  static String homeScreen = "/homeScreen";
  static String imageListScreen = "/imageListScreen";
  static String imageViewScreen = "/imageViewScreen";
  static String searchScreen = "/searchScreen";

  static List<GetPage> pages = [
    GetPage(
      name: root,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
      binding: HomeScreenBindings(),
    ),
    GetPage(
      name: imageViewScreen,
      page: () {
        DetailsScreenArguments arguments = (Get.arguments is DetailsScreenArguments) ? Get.arguments : null;
        return ImageViewScreen(arguments: arguments);
      },
      binding: ImageDetailsBindings(),
    ),
    GetPage(
      name: searchScreen,
      page: () => const SearchScreen(),
      binding: SearchScreenBindings(),
    ),
    GetPage(
      name: imageListScreen,
      page: () {
        ImageListScreenArguments arguments = (Get.arguments is ImageListScreenArguments) ? Get.arguments : null;
        return ImageListScreen(
          arguments: arguments,
        );
      },
      binding: SearchScreenBindings(),
    ),
  ];
}
