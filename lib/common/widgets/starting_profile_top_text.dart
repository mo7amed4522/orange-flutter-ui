import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class StartingProfileTopText extends StatelessWidget {
  const StartingProfileTopText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height / 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetRes.themeLabel,
              height: 28,
              width: 93,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 5),
            const Text(
              AppRes.profile,
              style: TextStyle(
                color: ColorRes.black2,
                fontSize: 21,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AppRes.startingProfileInfoText,
            style: TextStyle(
              color: ColorRes.grey2,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
