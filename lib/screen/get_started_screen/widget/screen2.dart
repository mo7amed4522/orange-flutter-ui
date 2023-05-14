import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/get_started_screen/widget/bottom_info_field.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class Screen2 extends StatelessWidget {
  final VoidCallback onNextTap;
  final VoidCallback onSkipTap;

  const Screen2({
    Key? key,
    required this.onNextTap,
    required this.onSkipTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: ColorRes.white,
      child: Stack(
        children: [
          Image.asset(
            AssetRes.getStarted2BG,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: Get.height / 10),
                Row(
                  children: [
                    SizedBox(width: Get.width / 2.25),
                    clipTile(AssetRes.fitness, AppRes.fitness),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    SizedBox(width: Get.width / 4.8),
                    clipTile(AssetRes.music, AppRes.music),
                    const SizedBox(width: 7),
                    clipTile(AssetRes.fastFood, AppRes.foodies),
                  ],
                ),
                const SizedBox(height: 6),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      SizedBox(width: Get.width / 10),
                      clipTile(AssetRes.movies, AppRes.movies),
                      const SizedBox(width: 11),
                      clipTile(AssetRes.walking, AppRes.walking),
                      const SizedBox(width: 11),
                      clipTile(AssetRes.chef, AppRes.chef),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SizedBox(width: Get.width / 4.0),
                    clipTile(AssetRes.microphone, AppRes.singing),
                    const SizedBox(width: 11),
                    clipTile(AssetRes.travel, AppRes.travel),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    SizedBox(width: Get.width / 2.5),
                    clipTile(AssetRes.artist, AppRes.artist),
                  ],
                ),
                SizedBox(height: Get.height / 8),
              ],
            ),
          ),
          BottomInfoField(
            title: AppRes.exploreProfiles,
            subTitle: AppRes.getStarted2Subtitle,
            onNextTap: onNextTap,
            onSkipTap: onSkipTap,
            buttonText: AppRes.thatGreat,
          )
        ],
      ),
    );
  }

  Widget clipTile(String icon, String label) {
    return Container(
      height: 39,
      width: 116,
      decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: ColorRes.black.withOpacity(0.10),
              offset: const Offset(0, 0.5),
              blurRadius: 3,
              spreadRadius: 2,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 18,
            width: 18,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              color: ColorRes.darkGrey,
              fontSize: 15,
              fontFamily: FontRes.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
