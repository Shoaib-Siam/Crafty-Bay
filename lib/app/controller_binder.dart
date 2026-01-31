import 'package:get/get.dart';

import '../features/shared/presentation/controller/main_nav_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainNavController());
  }
}
