import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:water_app/app/provider/authentication/auth_controller.dart';

class LoginController extends GetxController {
  // Get storage token
  final _storage = GetStorage();
  final AuthenticationController _authenticationController =
      Get.find<AuthenticationController>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RoundedLoadingButtonController roundedLoadingButtonOne =
      RoundedLoadingButtonController();
  // IsTapped
  final _isTapped = true.obs;
  bool get isTapped => this._isTapped.value;
  set isTapped(bool value) => this._isTapped.value = value;

  void validateAndSubmit() {
    roundedLoadingButtonOne.start();
    _authenticationController.login(
      email: email.text.trim().toLowerCase(),
      password: password.text.trim(),
    );

    // Get storage token
    final token = _storage.read('token');
    print("Token: $token ");
    roundedLoadingButtonOne.stop();
  }

  @override
  void onInit() {
    super.onInit();
  }
}