import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CheckNetWorkStatusController extends GetxController {
  bool isNetWork = true;
  isNetWorkUpdate(bool value) {
    isNetWork = value;
    update();
  }
}
