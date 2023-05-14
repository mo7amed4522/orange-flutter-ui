import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/custom_box_shadow.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class UserPopUp extends StatelessWidget {
  final VoidCallback onMoreInfoTap;
  final VoidCallback onCancelTap;
  final String? image;
  final String? userName;
  final String? live;

  const UserPopUp(
      {Key? key,
      required this.onMoreInfoTap,
      required this.onCancelTap,
      required this.image,
      this.userName,
      this.live})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: ColorRes.grey18.withOpacity(0.4),
      insetPadding: EdgeInsets.symmetric(horizontal: Get.width / 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            CustomBoxShadow(
              offset: const Offset(0, 0),
              color: ColorRes.black.withOpacity(0.15),
              blurRadius: 18,
              style: BlurStyle.outer,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              height: 300,
              width: 220,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  image!.isEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            AssetRes.themeLabel,
                            width: 99,
                            height: 99,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: '${ConstRes.aImageBaseUrl}$image',
                            cacheKey: '${ConstRes.aImageBaseUrl}$image',
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                AssetRes.themeLabel,
                                width: 99,
                                height: 99,
                              );
                            },
                            height: 99,
                            width: 99,
                            fit: BoxFit.cover,
                          ),
                        ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        userName == null ? '' : '$userName',
                        style: const TextStyle(
                          color: ColorRes.darkGrey5,
                          fontSize: 18,
                          fontFamily: FontRes.bold,
                        ),
                      ),
                      const Text(
                        AppRes.twentyFour,
                        style: TextStyle(
                          color: ColorRes.darkGrey5,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Image.asset(AssetRes.tickMark, height: 16.5, width: 16.5),
                    ],
                  ),
                  Text(
                    '$live',
                    style: const TextStyle(
                      color: ColorRes.grey19,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: onMoreInfoTap,
                    child: Container(
                      height: 38,
                      width: 127,
                      padding: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorRes.lightOrange1,
                            ColorRes.darkOrange,
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          AppRes.moreInfo,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontFamily: FontRes.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: onCancelTap,
                    child: const Text(
                      AppRes.cancel,
                      style: TextStyle(color: ColorRes.grey20, fontSize: 15),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
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
