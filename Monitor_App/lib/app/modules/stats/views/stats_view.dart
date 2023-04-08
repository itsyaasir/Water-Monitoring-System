import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:water_app/app/modules/stats/widgets/stats_table.dart";
import "../controllers/stats_controller.dart";

class StatsView extends GetView<StatsController> {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Stats",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(
                    "Here are your stats",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey.shade900,
                        letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Details",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Obx(() => Row(
                            children: [
                              SizedBox(
                                width: Get.width / 4.0,
                              ),
                              DropdownButton(
                                items: <String>[
                                  "All",
                                  "Daily",
                                  "Weekly",
                                  "Monthly"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                value: controller.filterTime,
                                onChanged: (value) => {
                                  controller.filterTime = value,
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Today, ${DateFormat("dd MMMM yyyy").format(DateTime.now())}",
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StatsTable(
                        filterTime: controller.filterTime,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
