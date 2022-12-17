import 'package:get/instance_manager.dart';
import 'package:gif_world/controller/home/image_details_controller.dart';

class ImageDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ImageDetailsController(), tag: ImageDetailsController().toString());
  }
}
