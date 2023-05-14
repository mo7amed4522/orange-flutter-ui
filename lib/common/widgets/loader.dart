import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:orange_ui/utils/asset_res.dart';

class Loader {
  Future<void> lottieLoader() {
    return showDialog(
        context: Get.context!,
        builder: (context) {
          return Center(
              child: Lottie.asset(AssetRes.loadingLottie,
                  height: 100, width: 100));
        },
        barrierLabel: '');
  }

  Widget lottieWidget() {
    return Center(
      child: Lottie.asset(AssetRes.loadingLottie, height: 100, width: 100),
    );
  }
}
