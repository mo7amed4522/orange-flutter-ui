import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class BottomBar extends StatelessWidget {
  final int pageIndex;
  final Function(int index) onBottomBarTap;

  const BottomBar({
    Key? key,
    required this.pageIndex,
    required this.onBottomBarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 56,
        width: Get.width,
        decoration: BoxDecoration(color: ColorRes.white, boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 3,
            color: ColorRes.lightGrey.withOpacity(0.6),
          ),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ConstRes.settingData?.appdata?.isDating == 0
              ? [
                  iconBox(AssetRes.explore, AppRes.explore, 17.5, 17.5, 0),
                  iconBox(AssetRes.joinLives, AppRes.joinLive, 17.5, 17.5, 2),
                  iconBox(AssetRes.message, AppRes.message, 16.8, 18, 3),
                  iconBox(AssetRes.profile, AppRes.profile, 18, 17, 4),
                ]
              : [
                  iconBox(AssetRes.explore, AppRes.explore, 17.5, 17.5, 0),
                  iconBox(AssetRes.randoms, AppRes.randoms, 18.22, 20.02, 1),
                  iconBox(AssetRes.joinLives, AppRes.joinLive, 17.5, 17.5, 2),
                  iconBox(AssetRes.message, AppRes.message, 16.8, 18, 3),
                  iconBox(AssetRes.profile, AppRes.profile, 18, 17, 4),
                ],
        ),
      ),
    );
  }

  Widget iconBox(
      String icon, String title, double height, double width, int index) {
    return InkWell(
      onTap: () {
        onBottomBarTap(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            icon,
            height: height,
            width: width,
            color: index == pageIndex ? ColorRes.orange2 : ColorRes.dimGrey6,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                color:
                    index == pageIndex ? ColorRes.orange2 : ColorRes.dimGrey6,
                fontFamily: FontRes.medium),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
