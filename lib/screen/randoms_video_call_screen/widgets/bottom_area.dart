import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class BottomArea extends StatelessWidget {
  final VoidCallback onMoreBtnTap;
  final VoidCallback onCallEnd;

  const BottomArea({
    Key? key,
    required this.onMoreBtnTap,
    required this.onCallEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
                  decoration: BoxDecoration(
                    color: ColorRes.black.withOpacity(0.33),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorRes.white, width: 2),
                          image: const DecorationImage(
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
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        AssetRes.moreHorizontal,
                        width: 30,
                        color: ColorRes.white,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
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
