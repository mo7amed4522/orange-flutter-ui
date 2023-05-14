import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class OptionsCenterArea extends StatelessWidget {
  final bool notificationEnable;
  final bool showMeOnMap;
  final bool goAnnonymous;
  final VoidCallback onApplyForVerTap;
  final VoidCallback onLiveStreamTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onShowMeOnMapTap;
  final VoidCallback onAnnonymousTap;
  final int? verification;

  const OptionsCenterArea(
      {Key? key,
      required this.notificationEnable,
      required this.showMeOnMap,
      required this.goAnnonymous,
      required this.onLiveStreamTap,
      required this.onNotificationTap,
      required this.onShowMeOnMapTap,
      required this.onAnnonymousTap,
      required this.onApplyForVerTap,
      required this.verification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 9),
        InkWell(
          onTap: onLiveStreamTap,
          child: Container(
            height: 49,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorRes.grey12),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13, top: 12, bottom: 12),
                  child: Image.asset(
                    AssetRes.sun,
                    height: 25,
                    width: 25,
                  ),
                ),
                const SizedBox(width: 21),
                const Text(
                  AppRes.livestream,
                  style: TextStyle(
                    color: ColorRes.blueGrey,
                    fontSize: 15,
                    fontFamily: FontRes.semiBold,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 9),
        Visibility(
          visible: verification == 0 ? true : false,
          child: InkWell(
            onTap: onApplyForVerTap,
            child: Container(
              height: 49,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.grey12),
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 13, top: 12, bottom: 12),
                    child: Image.asset(
                      AssetRes.tickMark,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 21),
                  const Text(
                    AppRes.verification,
                    style: TextStyle(
                      color: ColorRes.blueGrey,
                      fontSize: 15,
                      fontFamily: FontRes.semiBold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: verification == 2 ? 0 : 9,
        ),
        Visibility(
          visible: verification == 2 ? false : true,
          child: Visibility(
            visible: verification == 0 ? false : true,
            child: Stack(
              children: [
                SizedBox(
                  height: 54,
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(AssetRes.map1),
                  ),
                ),
                Container(
                  height: 54,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: ColorRes.darkGrey5.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(
                  height: 54,
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaY: 15, sigmaX: 15, tileMode: TileMode.mirror),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 5),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 9,
                                  width: 9,
                                  color: ColorRes.white,
                                ),
                                Image.asset(
                                  AssetRes.tickMark,
                                  height: 17.5,
                                  width: 18.33,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              AppRes.liveVerification,
                              style: TextStyle(
                                color: ColorRes.blueGrey,
                                fontSize: 15,
                                fontFamily: FontRes.semiBold,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 36.17,
                              width: 112,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: verification == 0
                                    ? ColorRes.red7.withOpacity(0.20)
                                    : verification == 1
                                        ? ColorRes.lightpink.withOpacity(0.20)
                                        : ColorRes.lightgreen1
                                            .withOpacity(0.20),
                              ),
                              child: Center(
                                child: Text(
                                  verification == 0
                                      ? AppRes.notEligible
                                      : verification == 1
                                          ? AppRes.pending
                                          : AppRes.eligible,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: verification == 0
                                        ? ColorRes.red8
                                        : verification == 1
                                            ? ColorRes.lightorange
                                            : ColorRes.green2,
                                    fontFamily: FontRes.semiBold,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 17, bottom: 9),
          child: Text(
            AppRes.privacy,
            style: TextStyle(
              color: ColorRes.grey23,
              fontSize: 14,
              fontFamily: FontRes.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
        permissionTile(
          0,
          AppRes.pushNotification,
          AppRes.notificationData,
          notificationEnable,
          onNotificationTap,
        ),
        const SizedBox(height: 9),
        permissionTile(
          1,
          AppRes.switchMap,
          AppRes.switchMapData,
          showMeOnMap,
          onShowMeOnMapTap,
        ),
        const SizedBox(height: 10),
        permissionTile(
          2,
          AppRes.annonymous,
          AppRes.annonymousData,
          goAnnonymous,
          onAnnonymousTap,
        ),
      ],
    );
  }

  Widget permissionTile(int index, String title, String subTitle, bool enable,
      VoidCallback onTap) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.fromLTRB(
          14, index == 0 ? 21 : 14, 8, index == 0 ? 21 : 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorRes.grey12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: ColorRes.grey24,
                  fontFamily: FontRes.semiBold,
                ),
              ),
              const SizedBox(height: 3),
              SizedBox(
                width: Get.width - 90,
                child: Text(
                  subTitle,
                  style: const TextStyle(
                    color: ColorRes.grey25,
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onTap,
            child: Container(
              height: 25,
              width: 36,
              padding: const EdgeInsets.symmetric(horizontal: 3.5),
              alignment: enable ? Alignment.centerRight : Alignment.centerLeft,
              decoration: BoxDecoration(
                color: ColorRes.grey,
                borderRadius: BorderRadius.circular(30),
                gradient: enable
                    ? const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorRes.lightOrange1,
                          ColorRes.darkOrange,
                        ],
                      )
                    : null,
              ),
              child: Container(
                height: 19,
                width: 19,
                decoration: const BoxDecoration(
                  color: ColorRes.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
