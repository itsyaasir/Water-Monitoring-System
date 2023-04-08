import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_app/app/utils/login_mixin.dart';

import '../../models/success_response.dart';

import '../../models/error_response.dart';

const String baseUrl = "http://localhost:3000/api/v1/auth";

class AuthenticationService extends GetConnect with PrintLogMixin {
  Future<Response> register(
      {required String email,
      required String password,
      required String confirmPassword,
      required String firstName,
      required String lastName}) async {
    printLog("registerUser");
    final response = await post(
      "$baseUrl/register",
      {
        "email": email,
        "password": password,
        "confirmPassword": password,
        "firstName": firstName,
        "lastName": lastName,
      },
      contentType: "application/json",
    );

    try {
      if (response.statusCode == 201) {
        printLog("registerUser: success");
        return response;
      } else {
        printLog("registerUser: failed ${response.body}");
        return response;
      }
    } catch (e) {
      printLog("registerUser: failed: $e");
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
      contentType: "application/json",
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
      rethrow;
    }
  }

  Future<dynamic> getCurrentUser() async {
    printLog("getCurrentUser");
    final response = await get("$baseUrl/current",
        headers: Map.from({
          "x-token": "${GetStorage().read("token")}",
        }));

    try {
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
