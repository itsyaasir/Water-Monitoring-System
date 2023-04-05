import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_app/app/provider/authentication/auth_controller.dart';
import 'package:water_app/app/provider/pumps/pumps_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  AuthenticationController authenticationController =
      AuthenticationController();

  PumpsProvider pumpsProvider = PumpsProvider();

  //arduinoConnected
  var treatmentPump = false.obs;

  // Water pump
  var waterPump = false.obs;

  void toggleWaterPump() async {
    await pumpsProvider.toggleWaterPump();
    waterPump.value = !waterPump.value;
  }

  void toggleTreatmentPump() async {
    await pumpsProvider.toggleTreatmentPump();
    treatmentPump.value = !treatmentPump.value;
  }

  Future<bool> getWaterPumpStatus() async {
    final waterStatus = await pumpsProvider.getWaterStatus();
    waterPump.value = waterStatus;
    return waterStatus;
  }

  Future<bool> getTreatmentPumpStatus() async {
    final treatmentStatus = await pumpsProvider.getTreatmentStatus();
    treatmentPump.value = treatmentStatus;
    return treatmentStatus;
  }
}
