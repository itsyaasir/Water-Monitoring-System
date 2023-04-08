import 'package:get/get.dart';
import 'package:water_app/app/provider/authentication/auth_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );

    Get.put(AuthenticationController());
  }
}
