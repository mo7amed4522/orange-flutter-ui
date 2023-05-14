import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/color_res.dart';

class SnackBarWidget {
  void snackBarWidget(String titleName) {
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(
          SnackBar(
            content: Text(
              titleName,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
              maxLines: 2,
            ),
            backgroundColor: ColorRes.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 2500),
          ),
        )
        .closed
        .then((value) => ScaffoldMessenger.of(Get.context!).clearSnackBars());
  }

  static void snackBar({required String message}) {
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: const TextStyle(color: ColorRes.white),
      ),
      backgroundColor: ColorRes.black,
    );
  }
}
