import "dart:math";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";

import "../global_widgets/custom_button.dart";

class Helpers {
  static String formatCurrency(dynamic amount) {
    final currencyFormat = new NumberFormat("#,###.##", "en_KE");
    return currencyFormat.format(amount);
  }

  static void showSnackbar({
    required String title,
    required String message,
    required Color color,
    required Icon icon,
  }) {
    Get.snackbar(title, message,
        icon: Icon(icon.icon, size: 30, color: Colors.white),
        duration: const Duration(seconds: 2),
        backgroundColor: color,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 16,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        barBlur: 4,
        overlayBlur: 5);
  }

  static Widget showLoading() {
    return const Center(
      child: const CircularProgressIndicator(
        color: Colors.black,
      ),
    );
  }

  // Show toast

  static Widget showToast(String message) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  static String formatDate(DateTime date) {
    return DateFormat("dd-MM-yyyy").format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat("HH:mm a").format(date);
  }

  static void showDialog(
      {VoidCallback? editCallBackFunction,
      VoidCallback? deleteCallBackFunction}) {
    Get.dialog(Center(
      child: Container(
        height: 100,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              data: "Delete",
              color: Colors.red,
              height: 50,
              width: 100,
              callbackFunction: deleteCallBackFunction,
            ),
            const SizedBox(
              width: 20,
            ),
            CustomButton(
              data: "Edit",
              height: 50,
              width: 100,
              color: Colors.blue,
              callbackFunction: editCallBackFunction,
            )
          ],
        ),
      ),
    ));
  }

  //Generate random int
  static int randomInt() {
    return 0 + Random().nextInt(100000 - 0);
  }

  // format daterange
  static String formatDateRange(DateTimeRange? dateTimeRange) {
    if (dateTimeRange!.start == dateTimeRange.end) {
      return formatDate(dateTimeRange.start);
    } else {
      return "${formatDate(dateTimeRange.start)} - ${formatDate(dateTimeRange.end)}";
    }
  }

  // format date with hour
  static String formatDateWithHour(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd 00:00:00").format(dateTime);
  }

  // format date with hour
  static String formatDateWithHourAndMinute(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd 24:00:00").format(dateTime);
  }

// Validator
  static String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }
}
