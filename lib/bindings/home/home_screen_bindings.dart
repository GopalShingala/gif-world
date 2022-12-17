import 'package:get/get.dart';
import 'package:gif_world/controller/home/home_screen_controller.dart';


class HomeScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController(), tag: HomeScreenController().toString());
  }
}
