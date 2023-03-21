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
                  Text(
                    "Hi!",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Here are your stats",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey.shade900,
                        letterSpacing: 0.5),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              const SizedBox(height: 15),
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
                  Text("${DateFormat("dd-MM-yyyy").format(DateTime.now())}"),
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
