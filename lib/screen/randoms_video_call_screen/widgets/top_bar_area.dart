import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orange_ui/common/widgets/custom_box_shadow.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class TopBarArea extends StatelessWidget {
  final VoidCallback onBackBtnTap;

  const TopBarArea({Key? key, required this.onBackBtnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            CustomBoxShadow(
              color: ColorRes.black.withOpacity(0.20),
              offset: const Offset(0, 1.0),
              blurRadius: 5.0,
              style: BlurStyle.outer,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: 60,
              padding: const EdgeInsets.fromLTRB(11, 7, 11, 10),
              decoration: BoxDecoration(
                color: ColorRes.black.withOpacity(0.33),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: onBackBtnTap,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 37,
                      width: 37,
                      padding: const EdgeInsets.only(right: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorRes.orange2.withOpacity(0.06),
                      ),
                      child: Center(
                        child: Image.asset(
                          AssetRes.backArrow,
                          height: 14,
                          width: 7,
                          color: ColorRes.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    AssetRes.themeLabelWhite,
                    height: 21,
                    width: 74,
                  ),
                  const Text(
                    AppRes.randoms,
                    style: TextStyle(color: ColorRes.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
