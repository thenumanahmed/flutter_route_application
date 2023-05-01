import 'package:get/get.dart';

import '../controllers/theme_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    // Get.put(CustomMenuController());
    // Get.put(TracksController());
  }
}
