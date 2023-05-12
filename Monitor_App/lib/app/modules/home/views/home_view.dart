import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_app/app/global_widgets/custom_switch.dart';
import 'package:water_app/app/provider/authentication/auth_controller.dart';
import 'package:water_app/app/provider/stats/stats_controller.dart';

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
              Row(
                children: [
                  const Text(
                    "Your Dashboard",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    icon: const Icon(Icons.more_vert_outlined),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          title: Text("Logout"),
                          trailing: Icon(Icons.keyboard_double_arrow_right),
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 1) {
                        Get.find<AuthenticationController>().logout();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                  future: Get.find<AuthenticationController>().getCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final fName = snapshot.data!["firstName"];
                      return Row(
                        children: [
                          Text(
                            "${_getTimeAndSetGreeting()}, ",
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            " $fName!",
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      );
                    } else {
                      return const Text('Loading...');
                    }
                  }),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Arduino Connected",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: Get.find<StatsProvider>().getLatestStats(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Water Level',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${data!["waterLevel"]}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: LinearProgressIndicator(
                              value: double.parse(data["waterLevel"]!) / 100,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text(
                                'Chlorine Level',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${data["chlorineLevel"]}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: LinearProgressIndicator(
                              value: double.parse(data["chlorineLevel"]!) / 100,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'pH',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${data["ph"]}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow.shade900,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text(
                                'Turbidity',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              // Show clear, moderate, or high based on the turbidity level
                              double.parse(data["turbidity"]!) < 30
                                  ? const Text(
                                      'Clear',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    )
                                  : double.parse(data["turbidity"]!) < 60
                                      ? Text(
                                          'Cloudy',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.yellow.shade900,
                                          ),
                                        )
                                      : const Text(
                                          'Dirty',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Show the last updated time
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text(
                                'Last Updated',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                _parseDate(data["createdAt"]!),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text('Loading...');
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Water Pump",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => CustomSwitch(
                        value: controller.getWaterPumpStatus(),
                        onChanged: (val) => {controller.toggleWaterPump()}),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  const Text(
                    "Treatment Pump",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => CustomSwitch(
                        value: controller.getTreatmentPumpStatus(),
                        onChanged: (val) => {controller.toggleTreatmentPump()}),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Take a look at your stats",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed("/stats"),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

String _getTimeAndSetGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return "Good Morning";
  } else if (hour < 17) {
    return "Good Afternoon";
  } else if (hour < 20) {
    return "Good Evening";
  } else {
    return "Good Night";
  }
}

// Parse date like this, `Today, 12:00 PM`
String _parseDate(String date) {
  // Check the date is today or not, and return the date accordingly
  final today = DateTime.now();

  if (today.day == DateTime.parse(date).day) {
    final parsedDate = DateTime.parse(date);
    final formatter = DateFormat('hh:mm a');
    final formatted = formatter.format(parsedDate);
    return 'Today, $formatted';
  }

  // If the date is not today, return the date like this, `12/12/2021`
  final parsedDate = DateTime.parse(date);
  final formatter = DateFormat('dd/MM/yyyy');
  final formatted = formatter.format(parsedDate);
  return formatted;
}
