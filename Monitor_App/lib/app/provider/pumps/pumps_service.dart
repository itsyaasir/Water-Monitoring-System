import 'package:get_storage/get_storage.dart';

import '../../utils/login_mixin.dart';
import 'package:get/get.dart';

const String baseUrl = "http://localhost:3000/api/v1/pumps";

class PumpsService extends GetConnect with PrintLogMixin {
  Future<Response> toggleWaterPump() async {
    printLog("getLatestStats");
    final response = await post(
      "$baseUrl/waterStatus",
      {},
      contentType: "application/json",
      headers: Map.from({
        "x-token": "${GetStorage().read("token")}",
      }),
    );

    try {
      if (response.statusCode == 200) {
        printLog("toggleWaterPump: success");
        return response;
      } else {
        printLog("toggleWaterPump: failed ${response.body}");
        return response;
      }
    } catch (e) {
      printLog("toggleWaterPump: failed: $e");
      return response;
    }
  }

  Future<Response> toggleTreatmentPump() async {
    printLog("getAllStats");
    final response = await post(
      "$baseUrl/treatmentStatus",
      {},
      contentType: "application/json",
      headers: Map.from({
        "x-token": "${GetStorage().read("token")}",
      }),
    );

    try {
      if (response.statusCode == 200) {
        printLog("toggleTreatmentPump: success");
        return response;
      } else {
        printLog("toggleTreatmentPump: failed ${response.body}");
        return response;
      }
    } catch (e) {
      printLog("toggleTreatmentPump: failed: $e");
      return response;
    }
  }

  Future<Response> getWaterStatus() async {
    printLog("getWaterPumpStatus");

    final response = await get("$baseUrl/waterStatus",
        contentType: "application/json",
        headers: Map.from({
          "x-token": "${GetStorage().read("token")}",
        }));

    try {
      if (response.statusCode == 200) {
        printLog("getWaterPumpStatus: success");
        return response;
      } else {
        printLog("getWaterPumpStatus: failed ${response.body}");
        return response;
      }
    } catch (e) {
      printLog("getWaterPumpStatus: failed: $e");
      return response;
    }
  }

  Future<Response> getTreatmentStatus() async {
    final response = await get("$baseUrl/treatmentStatus",
        contentType: "application/json",
        headers: Map.from({
          "x-token": "${GetStorage().read("token")}",
        }));

    try {
      if (response.statusCode == 200) {
        printLog("getTreatmentStatus: success");
        return response;
      } else {
        printLog("getTreatmentStatus: failed ${response.body}");
        return response;
      }
    } catch (e) {
      printLog("getTreatmentStatus: failed: $e");
      return response;
    }
  }
}
