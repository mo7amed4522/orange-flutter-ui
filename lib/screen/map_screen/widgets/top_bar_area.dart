import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orange_ui/common/widgets/custom_box_shadow.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class TopBarArea extends StatelessWidget {
  final List<int> distanceList;
  final int selectedDistance;
  final VoidCallback onBackBtnTap;
  final Function(int value) onDistanceChange;

  const TopBarArea({
    Key? key,
    required this.distanceList,
    required this.selectedDistance,
    required this.onBackBtnTap,
    required this.onDistanceChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          CustomBoxShadow(
            color: ColorRes.black.withOpacity(0.20),
            offset: const Offset(0, 1.0),
            blurRadius: 5.0,
            style: BlurStyle.outer,
          ),
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Container(
              height: 54,
              padding: const EdgeInsets.fromLTRB(11, 8, 8, 8),
              decoration: BoxDecoration(
                color: ColorRes.grey18.withOpacity(0.22),
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
                        color: ColorRes.red4.withOpacity(0.10),
                      ),
                      child: Center(
                        child: Image.asset(
                          AssetRes.backArrow,
                          height: 14,
                          width: 7,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(AssetRes.themeLabel, height: 25, width: 75),
                  const SizedBox(width: 4),
                  const Text(
                    AppRes.map,
                    style: TextStyle(
                      color: ColorRes.black2,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.fromLTRB(11, 9, 11, 13),
                    decoration: BoxDecoration(
                      color: ColorRes.darkGrey3.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: DropdownButton<int>(
                      underline: const SizedBox(),
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 16),
                        child: Transform.rotate(
                          angle: 4.7,
                          child: Image.asset(
                            AssetRes.backArrow,
                            color: ColorRes.grey14,
                            height: 14,
                            width: 7,
                          ),
                        ),
                      ),
                      isDense: true,
                      items: distanceList
                          .map<DropdownMenuItem<int>>(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  "$e ${AppRes.km}",
                                  style: const TextStyle(
                                    color: ColorRes.grey14,
                                    fontFamily: FontRes.semiBold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      value: selectedDistance,
                      onChanged: (int? value) {
                        if (value != null) {
                          onDistanceChange(value);
                        }
                      },
                    ),
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
