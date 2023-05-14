import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class VideoCallBottomArea extends StatelessWidget {
  final VoidCallback onCallEnd;
  final VoidCallback onSmallImageTap;

  const VideoCallBottomArea({
    Key? key,
    required this.onCallEnd,
    required this.onSmallImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: Get.width * 0.40,
                width: Get.width * 0.29,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AssetRes.profile26),
                  ),
                ),
              ),
              const SizedBox(width: 17),
            ],
          ),
          InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onCallEnd,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                child: Container(
                  height: 69,
                  width: 69,
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorRes.black.withOpacity(0.33)),
                  child: Center(
                    child: Image.asset(AssetRes.callEnd),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 11),
        ],
      ),
    );
  }
}
