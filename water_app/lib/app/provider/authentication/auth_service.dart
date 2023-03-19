import 'package:get/get.dart';
import 'package:water_app/app/utils/login_mixin.dart';

import '../../models/Authentication/success/success_login_reponse.dart';

import '../../models/Authentication/error/error_login_response.dart';

const String baseUrl = "http://localhost:3000/api/v1/auth";

class AuthenticationService extends GetConnect with PrintLogMixin {
  Future<Response> register(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    printLog("registerUser");
    final response = await post(
      "$baseUrl/register",
      {
        "email": email,
        "password": password,
        "confirmPassword": password,
      },
    );

    try {
      if (response.statusCode == 201) {
        printLog("registerUser: success");
        return response;
      } else {
        printLog("registerUser: failed");
        return response;
      }
    } catch (e) {
      printLog("registerUser: failed");
      return response;
    }
  }

  Future<Response> login(
      {required String email, required String password}) async {
    printLog("loginUser");
    final response = await post(
      "$baseUrl/login",
      {
        "email": email,
        "password": password,
      },
    );

    try {
      if (response.statusCode == 200) {
        printLog("loginUser: success");
        return response;
      } else {
        printLog("loginUser: failed");
        return response;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    printLog("logoutUser");
    final response = await post("$baseUrl/logout", {});

    try {
      if (response.statusCode == 200) {
        printLog("logoutUser: success");
      } else {
        printLog("logoutUser: failed");
      }
    } catch (e) {
      printLog("logoutUser: failed");
      printLog(e);
      throw e;
    }
  }

  Future<String> getCurrentUser() async {
    printLog("getCurrentUser");
    final response = await get(
      "$baseUrl/current",
    );

    try {
      if (response.statusCode == 200) {
        printLog("getCurrentUser: success");
        final signInReponse = signInReponseFromJson(response.body);
        return signInReponse.data.token;
      } else {
        printLog("getCurrentUser: failed");
        final error = errorSignInResponseFromJson(response.body);
        printLog(error);
        return error.error;
      }
    } catch (e) {
      printLog("getCurrentUser: failed");
      printLog(e);
      throw e;
    }
  }
}