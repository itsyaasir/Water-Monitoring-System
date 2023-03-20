import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed("/register");
                },
                child: const Text("Signup")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed("/login");
                },
                child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
