import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orange_ui/model/chat_and_live_stream/live_stream.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class TopBarArea extends StatelessWidget {
  final VoidCallback onEndBtnTap;
  final VoidCallback onDiamondTap;
  final VoidCallback onCameraTap;
  final VoidCallback onSpeakerTap;
  final bool mute;
  final LiveStreamUser? user;

  const TopBarArea(
      {Key? key,
      required this.onEndBtnTap,
      required this.onDiamondTap,
      required this.onCameraTap,
      required this.onSpeakerTap,
      required this.mute,
      this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 38),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: 39,
              width: Get.width,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.fromLTRB(13, 4, 4, 4),
              decoration: BoxDecoration(
                color: ColorRes.black4.withOpacity(0.33),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AssetRes.themeLabelWhite,
                        height: 20,
                        width: 69,
                      ),
                      const SizedBox(width: 2),
                      const Text(
                        AppRes.live,
                        style: TextStyle(
                          color: ColorRes.white,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: onEndBtnTap,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 31,
                          width: 88,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorRes.orange4,
                                ColorRes.darkOrange,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              AppRes.end,
                              style: TextStyle(
                                color: ColorRes.white,
                                fontSize: 12,
                                fontFamily: FontRes.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "${NumberFormat.compact(locale: 'en').format(double.parse('${user?.watchingCount ?? '0'}'))} ${AppRes.viewers}",
                      style: const TextStyle(
                        color: ColorRes.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: InkWell(
              onTap: onDiamondTap,
              child: Container(
                height: 39,
                width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.fromLTRB(13, 1, 1, 1),
                decoration: BoxDecoration(
                  color: ColorRes.black4.withOpacity(0.33),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      "💎 ${NumberFormat.compact(locale: 'en').format(double.parse('${user?.collectedDiamond ?? '0'}'))} ${AppRes.collected}",
                      style: const TextStyle(
                        color: ColorRes.white,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(37),
                      onTap: onCameraTap,
                      child: Container(
                        height: 37,
                        width: 37,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorRes.black.withOpacity(0.33),
                        ),
                        child: Center(
                          child: Image.asset(
                            AssetRes.camera2,
                            height: 15,
                            width: 15,
                            color: ColorRes.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      borderRadius: BorderRadius.circular(37),
                      onTap: onSpeakerTap,
                      child: Container(
                        height: 37,
                        width: 37,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorRes.black.withOpacity(0.33),
                        ),
                        child: Center(
                          child: Image.asset(
                            !mute ? AssetRes.speaker : AssetRes.speakerOff,
                            color: ColorRes.white,
                            height: 15,
                            width: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
