import 'package:get/get.dart';

import '../../../provider/authentication/auth_controller.dart';
import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );

    Get.put(AuthenticationController());
  }
}
