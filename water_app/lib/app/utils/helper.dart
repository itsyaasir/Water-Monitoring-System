import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";

class Helpers {
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
        shouldIconPulse: true,
        colorText: Colors.white,
        overlayBlur: 5);
  }

// Validator
  static String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }
}
