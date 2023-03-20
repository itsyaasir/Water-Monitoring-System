import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_app/app/provider/authentication/auth_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  AuthenticationController authenticationController =
      AuthenticationController();

  GetStorage storage = GetStorage();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
