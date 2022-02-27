import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  
  //show error dialog
  static void showErroDialog(
      {String ?title = '--- Warning! ---', String? description = 'Something went wrong'}) {
         Get.snackbar("", "",
        titleText: Text(
          title ?? '',
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        messageText: Text(
          description ?? '',
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 253, 99, 88),
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20));
  }
  
  // show fast msgs
  static void showFastmsg([String? title, String? message]) {
    Get.snackbar("", "",
        titleText: Text(
          title ?? '',
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        messageText: Text(
          message ?? '',
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 253, 99, 88),
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20));
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
