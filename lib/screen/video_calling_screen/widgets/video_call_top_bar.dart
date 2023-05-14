import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class VideoCallTopBar extends StatelessWidget {
  final VoidCallback onMoreBtnTap;
  final VoidCallback onBackBtnTap;

  const VideoCallTopBar({
    Key? key,
    required this.onMoreBtnTap,
    required this.onBackBtnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
            decoration: BoxDecoration(
              color: ColorRes.black.withOpacity(0.33),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: onBackBtnTap,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 21),
                    child: Image.asset(
                      AssetRes.backArrow,
                      color: ColorRes.white,
                      height: 17,
                    ),
                  ),
                ),
                Container(
                  height: 43,
                  width: 43,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(AssetRes.profile13),
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Jhonson Smith",
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 16,
                            fontFamily: FontRes.bold,
                          ),
                        ),
                        const Text(
                          " 24",
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 2),
                        InkWell(
                          onTap: onMoreBtnTap,
                          child: Image.asset(
                            AssetRes.tickMark,
                            height: 16,
                            width: 16,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      AppRes.lasVegasUsa,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(
                  AssetRes.moreHorizontal,
                  //height: 6,
                  width: 30,
                  color: ColorRes.white,
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
