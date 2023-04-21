import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:water_app/app/provider/stats/stats_controller.dart';

class StatsController extends GetxController {
  final StatsProvider _statsProvider = StatsProvider();
  final _filterTime = "Daily".obs;
  get filterTime => _filterTime.value;
  set filterTime(value) => _filterTime.value = value;

  Future<List<dynamic>> getData() async {
    switch (filterTime) {
      case "All":
        return await _statsProvider.getAllStats();

      case "Daily":
        return await _statsProvider.getDailyStats();

      case "Weekly":
        return await _statsProvider.getWeeklyStats();

      case "Monthly":
        return await _statsProvider.getMonthlyStats();

      default:
        return await _statsProvider.getAllStats();
    }
  }

  // Export as csv
  Future<void> exportAsCsv() async {
    final data = await getData();
    final csvData = data.map((e) {
      return [
        e['waterLevel'].toString(),
        e['chlorineLevel'].toString(),
        e['ph'].toString(),
        e['turbidity'].toString(),
        DateFormat("dd-MM-yyyy").format(DateTime.parse(e["createdAt"]!)),
      ];
    }).toList();
    final header = [
      "Water Level",
      "Chlorine Level",
      "Ph",
      "Turbidity",
      "Created At",
    ];

    csvData.insert(0, header);

    final csv = const ListToCsvConverter().convert(csvData);
    // create a file
    String directory = (await getApplicationDocumentsDirectory()).path;
    String filePath =
        "$directory/stats-${DateFormat("dd-MM-yyy").format(DateTime.now())}.csv";
    File file = File(filePath);
    await file.writeAsString(csv);
  }
}
