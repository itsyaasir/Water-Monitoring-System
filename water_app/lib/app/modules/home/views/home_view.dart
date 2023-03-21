import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_app/app/global_widgets/animated_switch.dart';
import 'package:water_app/app/global_widgets/water_purity.dart';
import 'package:water_app/app/global_widgets/water_tank.dart';
import 'package:water_app/app/provider/authentication/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: Get.find<AuthenticationController>().getCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final fName = snapshot.data!["firstName"];
                      return Row(
                        children: [
                          const Text(
                            "Hi,",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          Text(
                            " $fName!",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      );
                    } else {
                      return const Text('Loading...');
                    }
                  }),
              const SizedBox(height: 20),
              // Switch on/off ardunio

              Center(child: StatefulBuilder(
                builder: (context, setState) {
                  return AnimatedButton(
                      onPressed: () {
                        setState(() {
                          controller.setIsOn(!controller.getIsOn);
                        });
                      },
                      isOn: controller.getIsOn);
                },
              )),
              const SizedBox(height: 30),
              const WaterTankCard(waterLevel: 100),
              const SizedBox(height: 20),
              // Row(
              //   children: const [
              //     Text(
              //       "Water Tank Level",
              //       style: TextStyle(
              //           fontSize: 20,
              //           color: Colors.black,
              //           fontWeight: FontWeight.normal),
              //     ),
              //     Spacer(),
              //     // Text(
              //     //   "100%",
              //     //   style: TextStyle(
              //     //       fontSize: 20,
              //     //       color: Colors.black,
              //     //       fontWeight: FontWeight.normal),
              //     // ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
