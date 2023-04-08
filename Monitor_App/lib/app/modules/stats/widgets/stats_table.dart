import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:water_app/app/data/constants.dart";
import "package:water_app/app/provider/stats/stats_controller.dart";

class StatsTable extends GetView<StatsProvider> {
  final String filterTime;
  StatsTable({
    super.key,
    required this.filterTime,
  });
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: filterTime == "All"
            ? controller.getAllStats()
            : filterTime == "Daily"
                ? controller.getDailyStats()
                : filterTime == "Weekly"
                    ? controller.getWeeklyStats()
                    : controller.getMonthlyStats(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (data.hasError) {
            return Center(
              child: Text(data.error.toString()),
            );
          }
          if (data.data == null) {
            return const Center(
              child: Text("No data"),
            );
          }
          return DataTable(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            showBottomBorder: true,
            columnSpacing: 20.0,
            headingRowColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) => Colors.black),
            columns: getColumns(StatsValues.columns),
            rows: getRows(data.data!),
          );
        });
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
          label: Text(column,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white))))
      .toList();

  final StatsProvider statsController = Get.put(StatsProvider());

  List<DataRow> getRows(List<dynamic> data) {
    return List<DataRow>.generate(data.length, (i) {
      final statsList = data[i];
      print(statsList);

      final cells = [
        statsList["waterLevel"]!,
        statsList["chlorineLevel"]!,
        statsList["ph"]!,
        statsList["turbidity"]!,
        DateFormat("dd-MM-yyyy").format(
          DateTime.parse(statsList["createdAt"]!),
        ),
      ];
      return DataRow(cells: getCells(cells));
    });
  }

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((cell) => DataCell(
            Center(
              child: Text("$cell",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ))
      .toList();
}
