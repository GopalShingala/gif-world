import 'package:get/instance_manager.dart';
import 'package:gif_world/controller/search/search_controller.dart';


class SearchScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SearchScreenController(), tag: SearchScreenController().toString());
  }
}
