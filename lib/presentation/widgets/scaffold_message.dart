import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScaffoldMessage {
  static void showScafflodMessage(String message, Color backgroundColor) {
    Get.snackbar('', message,
        backgroundColor: backgroundColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1));
  }
}
