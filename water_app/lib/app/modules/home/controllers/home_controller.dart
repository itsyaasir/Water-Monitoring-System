import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_app/app/provider/authentication/auth_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  AuthenticationController authenticationController =
      AuthenticationController();

  GetStorage storage = GetStorage();

  // isOn
  var isOn = false.obs;
  // setter
  void setIsOn(bool value) => isOn.value = value;
  // getter
  bool get getIsOn => isOn.value;
}
