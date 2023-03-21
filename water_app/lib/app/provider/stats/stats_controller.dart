import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_app/app/models/success_response.dart';
import 'package:water_app/app/provider/stats/stats_service.dart';

import '../../models/error_response.dart';
import '../../utils/helper.dart';
import '../../utils/login_mixin.dart';

class StatsProvider extends GetxController with PrintLogMixin {
  final StatsService _statsService = StatsService();

  @override
  void onInit() {
    super.onInit();
  }

  Future<Map<dynamic, String>> getLatestStats() async {
    try {
      var response = await _statsService.getLatestStats();

      if (response.statusCode == 200) {
        final statsResponse = SuccessResponse.fromJson(response.body);

        final data = statsResponse.data;
        final latestStats = data[0];

        final temperature = latestStats['temperature'].toString();
        final ph = latestStats['ph'].toString();
        final turb = latestStats['turb'].toString();
        final createdAt = latestStats['createdAt'].toString();

        final stats = {
          'temperature': temperature,
          'ph': ph,
          'turb': turb,
          'createdAt': createdAt,
        };

        return stats;
      } else {
        printLog('getLatestStats failed');
        final errorResponse = ErrorResponse.fromJson(response.body);
        Helpers.showSnackbar(
            title: "getLatestStats Failed",
            message: errorResponse.error,
            color: Colors.red,
            icon: const Icon(Icons.error));
      }
      return {};
    } catch (e) {
      printLog('getLatestStats failed');
      Helpers.showSnackbar(
          title: "getLatestStats Failed",
          message: "Something went wrong, Please try again $e",
          color: Colors.red,
          icon: const Icon(Icons.error));
      rethrow;
    }
  }

  Future<List<dynamic>> getAllStats() async {
    try {
      var response = await _statsService.getAllStats();

      if (response.statusCode == 200) {
        final statsResponse = SuccessResponse.fromJson(response.body);

        final data = statsResponse.data;

        final stats = data.map((e) {
          final temperature = e['temperature'].toString();
          final ph = e['ph'].toString();
          final turb = e['turb'].toString();
          final createdAt = e['createdAt'].toString();

          return {
            'temperature': temperature,
            'ph': ph,
            'turb': turb,
            'createdAt': createdAt,
          };
        }).toList();

        return stats;
      } else {
        printLog('getAllStats failed');
        final errorResponse = ErrorResponse.fromJson(response.body);
        Helpers.showSnackbar(
            title: "getAllStats Failed",
            message: errorResponse.error,
            color: Colors.red,
            icon: const Icon(Icons.error));

        return [];
      }
    } catch (e) {
      printLog('getAllStats failed');
      Helpers.showSnackbar(
          title: "getAllStats Failed",
          message: "Something went wrong, Please try again $e",
          color: Colors.red,
          icon: const Icon(Icons.error));

      rethrow;
    }
  }

  Future<List<dynamic>> getDailyStats() async {
    try {
      final startDate = DateTime.now().subtract(Duration(days: 1));
      final endDate = new DateTime.now();

      var response = await _statsService.getStatsByRange(
          startDate: startDate.toString(), endDate: endDate.toString());

      if (response.statusCode == 200) {
        final statsResponse = SuccessResponse.fromJson(response.body);

        final data = statsResponse.data;

        final stats = data.map((e) {
          final temperature = e['temperature'].toString();
          final ph = e['ph'].toString();
          final turb = e['turb'].toString();
          final createdAt = e['createdAt'].toString();

          return {
            'temperature': temperature,
            'ph': ph,
            'turb': turb,
            'createdAt': createdAt,
          };
        }).toList() as List<dynamic>;

        return stats;
      } else {
        printLog('getDailyStats failed');
        final errorResponse = ErrorResponse.fromJson(response.body);
        Helpers.showSnackbar(
            title: "getDailyStats Failed",
            message: errorResponse.error,
            color: Colors.red,
            icon: const Icon(Icons.error));

        return [];
      }
    } catch (e) {
      printLog('getDailyStats failed');
      Helpers.showSnackbar(
          title: "getDailyStats Failed",
          message: "Something went wrong, Please try again $e",
          color: Colors.red,
          icon: const Icon(Icons.error));
      rethrow;
    }
  }

  Future<List<dynamic>> getWeeklyStats() async {
    try {
      final startDate = new DateTime.now().subtract(new Duration(days: 7));
      final endDate = new DateTime.now();

      var response = await _statsService.getStatsByRange(
          startDate: startDate.toString(), endDate: endDate.toString());

      if (response.statusCode == 200) {
        final statsResponse = SuccessResponse.fromJson(response.body);

        final data = statsResponse.data;

        final stats = data.map((e) {
          final temperature = e['temperature'].toString();
          final ph = e['ph'].toString();
          final turb = e['turb'].toString();
          final createdAt = e['createdAt'].toString();

          return {
            'temperature': temperature,
            'ph': ph,
            'turb': turb,
            'createdAt': createdAt,
          };
        }).toList();

        return stats;
      } else {
        printLog('getWeeklyStats failed');
        final errorResponse = ErrorResponse.fromJson(response.body);
        Helpers.showSnackbar(
            title: "getWeeklyStats Failed",
            message: errorResponse.error,
            color: Colors.red,
            icon: const Icon(Icons.error));

        return [];
      }
    } catch (e) {
      printLog('getWeeklyStats failed');
      Helpers.showSnackbar(
          title: "getWeeklyStats Failed",
          message: "Something went wrong, Please try again $e",
          color: Colors.red,
          icon: const Icon(Icons.error));
      rethrow;
    }
  }

  Future<List<dynamic>> getMonthlyStats() async {
    try {
      final startDate = new DateTime.now().subtract(new Duration(days: 30));
      final endDate = new DateTime.now();

      var response = await _statsService.getStatsByRange(
          startDate: startDate.toString(), endDate: endDate.toString());

      if (response.statusCode == 200) {
        final statsResponse = SuccessResponse.fromJson(response.body);

        final data = statsResponse.data;

        final stats = data.map((e) {
          final temperature = e['temperature'].toString();
          final ph = e['ph'].toString();
          final turb = e['turb'].toString();
          final createdAt = e['createdAt'].toString();

          return {
            'temperature': temperature,
            'ph': ph,
            'turb': turb,
            'createdAt': createdAt,
          };
        }).toList();

        return stats;
      } else {
        printLog('getMonthlyStats failed');
        final errorResponse = ErrorResponse.fromJson(response.body);
        Helpers.showSnackbar(
            title: "getMonthlyStats Failed",
            message: errorResponse.error,
            color: Colors.red,
            icon: const Icon(Icons.error));

        return [];
      }
    } catch (e) {
      printLog('getMonthlyStats failed');
      Helpers.showSnackbar(
          title: "getMonthlyStats Failed",
          message: "Something went wrong, Please try again $e",
          color: Colors.red,
          icon: const Icon(Icons.error));
      rethrow;
    }
  }
}
