import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class PremiumPopUp extends StatelessWidget {
  final VoidCallback onGoPremiumTap;
  final VoidCallback onCancelTap;

  const PremiumPopUp({
    Key? key,
    required this.onGoPremiumTap,
    required this.onCancelTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 70),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 345,
        width: 246,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 21),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "${AppRes.go} ",
                    style: TextStyle(
                      fontSize: 17,
                      color: ColorRes.black,
                      fontFamily: FontRes.medium,
                    ),
                  ),
                  TextSpan(
                    text: AppRes.premium,
                    style: TextStyle(
                      fontSize: 17,
                      color: ColorRes.black,
                      fontFamily: FontRes.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Image.asset(
              AssetRes.premiumCrown,
              height: 74,
              width: 74,
            ),
            const SizedBox(height: 18),
            const Text(
              AppRes.subscribeText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorRes.grey15,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              borderRadius: BorderRadius.circular(7),
              onTap: onGoPremiumTap,
              child: Container(
                height: Get.height * 0.05,
                width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorRes.lightOrange1,
                      ColorRes.darkOrange,
                    ],
                  ),
                ),
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "${AppRes.go} ",
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorRes.white,
                            fontFamily: FontRes.medium,
                          ),
                        ),
                        TextSpan(
                          text: AppRes.premium,
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorRes.white,
                            fontFamily: FontRes.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 27),
            InkWell(
              onTap: onCancelTap,
              child: const Text(
                AppRes.cancel,
                style: TextStyle(
                  color: ColorRes.grey15,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
