import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_app/app/provider/authentication/auth_service.dart';
import 'package:water_app/app/utils/helper.dart';
import 'package:water_app/app/utils/login_mixin.dart';

import '../../models/error_response.dart';
import '../../models/success_response.dart';

class AuthenticationController extends GetxController with PrintLogMixin {
  final AuthenticationService _authenticationService = AuthenticationService();

  // We need to store the token in the local storage.
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  // Tokens usually expire after a 1D, so we need to refresh the token.
  // We can make an endpoint to refresh the token.

  Future<void> register(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    try {
      var response = await _authenticationService.register(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      if (response.statusCode == 200) {
        Helpers.showSnackbar(
            title: "Sign up Success",
            message: "You have signed up successfully, Redirecting to login",
            color: Colors.green,
            icon: const Icon(Icons.check_circle));

        Get.offNamed('/login');
      } else {
        printLog('Register failed');
        final errorResponse = ErrorResponse.fromJson(response.body);
        Helpers.showSnackbar(
            title: "Register Failed",
            message: errorResponse.error,
            color: Colors.red,
            icon: const Icon(Icons.error));
      }
    } catch (e) {
      printLog('Register failed');
      Helpers.showSnackbar(
          title: "Sign up Failed",
          message: "Something went wrong, Please try again $e",
          color: Colors.red,
          icon: const Icon(Icons.error));
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      var response = await _authenticationService.login(
        email: email,
        password: password,
      );

      if (response.statusCode == 200) {
        printLog('Login success');
        Helpers.showSnackbar(
            title: "Login Success",
            message: "You have been logged in successfully",
            color: Colors.green,
            icon: const Icon(Icons.check_circle));

        final successResponse = SuccessResponse.fromJson(response.body);

        final token = successResponse.data["token"];

        // Save the token in the local storage.
        _storage.write('token', token);

        // Navigate to the home page.
        Get.offNamed('/home');
      } else {
        printLog('Login failed');
        final errorLoginResponse = ErrorResponse.fromJson(response.body);
        Helpers.showSnackbar(
            title: "Login Failed",
            message:
                "Something went wrong, Please try again ${errorLoginResponse.error}",
            color: Colors.red,
            icon: const Icon(Icons.error));
      }
    } catch (e) {
      printLog('Login failed');
      Helpers.showSnackbar(
          title: "Login Failed",
          message: "Something went wrong, Please try again $e",
          color: Colors.red,
          icon: const Icon(Icons.error));
    }
  }

  void logout() {
    // Remove the token from the local storage.
    _storage.remove('token');

    // Navigate to the login page.
    Get.offNamed('/login');
  }

  // Check if the user is logged in.

  bool get isLogged => _storage.read('token') != null;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
