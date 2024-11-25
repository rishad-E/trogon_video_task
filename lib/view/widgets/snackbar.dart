import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarPopUps {
  static Future<void> popUpB(String text) async {
    Get.showSnackbar(
      GetSnackBar(
        snackStyle: SnackStyle.FLOATING,
        message: text,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Future<void> popUpG(String text, BuildContext context) async {
    Get.showSnackbar(
      GetSnackBar(
        snackStyle: SnackStyle.FLOATING,
        message: text,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
