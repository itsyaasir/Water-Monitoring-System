import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_app/app/modules/home/views/home_view.dart';
import 'package:water_app/app/modules/login/controllers/login_controller.dart';
import 'package:water_app/app/modules/login/views/login_view.dart';
import 'package:water_app/app/provider/pumps/pumps_controller.dart';
import 'package:water_app/app/provider/stats/stats_controller.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/provider/authentication/auth_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      title: "Water App",
      getPages: AppPages.routes,
      home: const SplashPage(),
      initialBinding: SplashPageBindings(),
    ),
  );
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Get.find<AuthenticationController>().isLogged
            ? const HomeView()
            : const LoginView(),
      ),
    );
  }
}

// Bindings
class SplashPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut(() => StatsProvider());
    Get.lazyPut(() => PumpsProvider());
  }
}
