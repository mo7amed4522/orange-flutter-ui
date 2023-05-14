import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onBackTap;
  final Function(String value) onMoreBtnTap;
  final String? fullName;
  final String? age;
  final bool isVerified;
  final String blockUnblock;
  final RegistrationUserData? userData;
  final bool moreInfo;

  const TopBar(
      {Key? key,
      required this.onBackTap,
      required this.onMoreBtnTap,
      required this.fullName,
      required this.age,
      required this.isVerified,
      required this.blockUnblock,
      this.userData,
      required this.moreInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 40, 10, 7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: ColorRes.black.withOpacity(0.33),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: onBackTap,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: Image.asset(
                          AssetRes.backArrow,
                          height: 18,
                          width: 10,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: ConstRes.aUserId == userData?.id ? false : true,
                      child: Visibility(
                        visible: moreInfo == true ? false : true,
                        child: PopupMenuButton<String>(
                          onSelected: (value) {
                            onMoreBtnTap(value);
                          },
                          color: ColorRes.black2.withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          itemBuilder: (BuildContext context) {
                            return {blockUnblock, AppRes.report}.map(
                              (String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  textStyle: const TextStyle(
                                      fontFamily: FontRes.medium,
                                      color: ColorRes.white),
                                  child: Text(
                                    choice,
                                    style: const TextStyle(
                                        fontFamily: FontRes.medium,
                                        color: ColorRes.white),
                                  ),
                                );
                              },
                            ).toList();
                          },
                          child: Image.asset(
                            AssetRes.moreHorizontal,
                            height: 10,
                            width: 26.74,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      fullName ?? '',
                      style: const TextStyle(
                        color: ColorRes.white,
                        fontSize: 16,
                        fontFamily: FontRes.bold,
                      ),
                    ),
                    Text(
                      ' $age',
                      style: const TextStyle(
                        color: ColorRes.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 5.7),
                    Visibility(
                      visible: isVerified,
                      child:
                          Image.asset(AssetRes.tickMark, height: 16, width: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
