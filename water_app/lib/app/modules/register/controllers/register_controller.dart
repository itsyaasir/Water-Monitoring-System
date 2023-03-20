import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../provider/authentication/auth_controller.dart';

class RegisterController extends GetxController {
  final AuthenticationController _authenticationController =
      Get.find<AuthenticationController>();
  GlobalKey<FormState> saveFormKey = GlobalKey<FormState>();

  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

// TextEditing Controllers
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  // IsTapped
  final _isTapped = true.obs;
  bool get isTapped => this._isTapped.value;
  set isTapped(bool value) => this._isTapped.value = value;

  void validateAndSave() async {
    if (saveFormKey.currentState!.validate()) {
      loadingButtonController.start();
      await _authenticationController.register(
        email: email.text.trim().toLowerCase(),
        password: password.text.trim(),
        confirmPassword: confirmPassword.text,
      );

      loadingButtonController.stop();
      // email.clear();
      // password.clear();
      // confirmPassword.clear();
      // lastName.clear();
      // firstName.clear();
    }
    loadingButtonController.stop();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
