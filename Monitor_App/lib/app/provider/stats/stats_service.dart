import 'package:get_storage/get_storage.dart';

import '../../utils/constants.dart';
import '../../utils/login_mixin.dart';
import 'package:get/get.dart';

const String baseUrl = "$SERVER_URL/api/v1/stats";

class StatsService extends GetConnect with PrintLogMixin {
  Future<Response> getLatestStats() async {
    printLog("getLatestStats");
    final response = await get(
      "$baseUrl/latest",
      contentType: "application/json",
      headers: Map.from({
        "x-token": "${GetStorage().read("token")}",
      }),
    );

    try {
      if (response.statusCode == 200) {
        printLog("getLatestStats: success");
        return response;
      } else {
        printLog("getLatestStats: failed ${response.body}");
        return response;
      }
    } catch (e) {
      printLog("getLatestStats: failed: $e");
      return response;
    }
  }

  Future<Response> getAllStats() async {
    printLog("getAllStats");
    final response = await get(
      "$baseUrl/all",
      contentType: "application/json",
      headers: Map.from({
        "x-token": "${GetStorage().read("token")}",
      }),
    );

    try {
      if (response.statusCode == 200) {
        printLog("getAllStats: success");
        return response;
      } else {
        printLog("getAllStats: failed ${response.body}");
        return response;
      }
    } catch (e) {
      printLog("getAllStats: failed: $e");
      return response;
    }
  }

  Future<Response> getStatsByRange(
      {required String startDate, required String endDate}) async {
    printLog("getStatsByRange");
    final url = "$baseUrl/range?start=$startDate&end=$endDate";
    printLog("url: $url");
    final response = await get("$baseUrl/range?start=$startDate&end=$endDate",
        contentType: "application/json",
        headers: Map.from({
          "x-token": "${GetStorage().read("token")}",
        }));

    try {
      if (response.statusCode == 200) {
        printLog("getStatsByRange: success");
        return response;
      } else {
        printLog("getStatsByRange: failed ${response.body}");
        return response;
      }
    } catch (e) {
      printLog("getStatsByRange: failed: $e");
      return response;
    }
  }
}
