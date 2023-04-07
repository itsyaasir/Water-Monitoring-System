import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_app/app/provider/authentication/auth_controller.dart';
import 'package:water_app/app/provider/pumps/pumps_controller.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    setWaterPumpStatus();
    setTreatmentPumpStatus();
  }

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

  void setWaterPumpStatus() async {
    final waterStatus = await pumpsProvider.getWaterStatus();
    waterPump.value = waterStatus;
  }

  void setTreatmentPumpStatus() async {
    final treatmentStatus = await pumpsProvider.getTreatmentStatus();
    treatmentPump.value = treatmentStatus;
  }

  bool getWaterPumpStatus() {
    return waterPump.value;
  }

  bool getTreatmentPumpStatus() {
    return treatmentPump.value;
  }
}
