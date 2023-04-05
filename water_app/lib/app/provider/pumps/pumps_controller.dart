import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_app/app/models/success_response.dart';
import 'package:water_app/app/provider/pumps/pumps_service.dart';
import 'package:water_app/app/provider/stats/stats_service.dart';

import '../../models/error_response.dart';
import '../../utils/helper.dart';
import '../../utils/login_mixin.dart';

class PumpsProvider extends GetxController with PrintLogMixin {
  final PumpsService _pumpsService = PumpsService();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> toggleWaterPump() async {
    try {
      var response = await _pumpsService.toggleWaterPump();

      if (response.statusCode == 200) {
        return;
      } else {
        printLog('toggleWaterPump failed');
        final errorResponse = ErrorResponse.fromJson(response.body);
        Helpers.showSnackbar(
            title: "toggleWaterPump Failed",
            message: errorResponse.error,
            color: Colors.red,
            icon: const Icon(Icons.error));
      }
      return;
    } catch (e) {
      printLog('toggleWaterPump failed');
      Helpers.showSnackbar(
          title: "toggleWaterPump Failed",
          message: "Something went wrong, Please try again $e",
          color: Colors.red,
          icon: const Icon(Icons.error));
      rethrow;
    }
  }

  Future<void> toggleTreatmentPump() async {
    try {
      var response = await _pumpsService.toggleTreatmentPump();

      if (response.statusCode == 200) {
        return;
      } else {
        printLog('toggleTreatmentPump failed');
        final errorResponse = ErrorResponse.fromJson(response.body);
        Helpers.showSnackbar(
            title: "toggleTreatmentPump Failed",
            message: errorResponse.error,
            color: Colors.red,
            icon: const Icon(Icons.error));

        return;
      }
    } catch (e) {
      printLog('toggleTreatmentPump failed');
      Helpers.showSnackbar(
          title: "toggleTreatmentPump Failed",
          message: "Something went wrong, Please try again $e",
          color: Colors.red,
          icon: const Icon(Icons.error));

      rethrow;
    }
  }

  Future<bool> getWaterStatus() async {
    try {
      var response = await _pumpsService.getWaterStatus();

      if (response.statusCode == 200) {
        final statsResponse = SuccessResponse.fromJson(response.body);

        final data = statsResponse.data;

        return data;
      } else {
        printLog('getWaterStatus failed');
        final errorResponse = ErrorResponse.fromJson(response.body);
        Helpers.showSnackbar(
            title: "getWaterStatus Failed",
            message: errorResponse.error,
            color: Colors.red,
            icon: const Icon(Icons.error));

        return false;
      }
    } catch (e) {
      printLog('getWaterStatus failed');
      Helpers.showSnackbar(
          title: "getWaterStatus Failed",
          message: "Something went wrong, Please try again $e",
          color: Colors.red,
          icon: const Icon(Icons.error));
      rethrow;
    }
  }

  Future<bool> getTreatmentStatus() async {
    try {
      var response = await _pumpsService.getTreatmentStatus();

      if (response.statusCode == 200) {
        final statsResponse = SuccessResponse.fromJson(response.body);

        final data = statsResponse.data;

        return data;
      } else {
        printLog('getTreatmentStatus failed');
        final errorResponse = ErrorResponse.fromJson(response.body);
        Helpers.showSnackbar(
            title: "getTreatmentStatus Failed",
            message: errorResponse.error,
            color: Colors.red,
            icon: const Icon(Icons.error));

        return false;
      }
    } catch (e) {
      printLog('getTreatmentStatus failed');
      Helpers.showSnackbar(
          title: "getTreatmentStatus Failed",
          message: "Something went wrong, Please try again $e",
          color: Colors.red,
          icon: const Icon(Icons.error));
      rethrow;
    }
  }
}
