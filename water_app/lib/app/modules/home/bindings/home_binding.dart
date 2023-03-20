import 'package:get/get.dart';
import 'package:water_app/app/provider/authentication/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.put(AuthenticationController());
  }
}
