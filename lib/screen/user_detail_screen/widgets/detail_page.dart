import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class DetailPage extends StatelessWidget {
  final RegistrationUserData? userData;
  final bool save;
  final VoidCallback onHideBtnTap;
  final VoidCallback onSaveTap;
  final VoidCallback onChatWithTap;
  final VoidCallback onShareWithTap;
  final VoidCallback onReportTap;
  final double distance;

  const DetailPage(
      {Key? key,
      this.userData,
      required this.save,
      required this.onHideBtnTap,
      required this.onSaveTap,
      required this.onChatWithTap,
      required this.onShareWithTap,
      required this.onReportTap,
      required this.distance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - 100,
      width: Get.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                child: Container(
                  width: Get.width,
                  height: Get.height - 116,
                  padding: const EdgeInsets.fromLTRB(21, 20, 21, 0),
                  decoration: BoxDecoration(
                    color: ColorRes.black.withOpacity(0.33),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: Text(
                                      '${userData?.fullname}',
                                      style: const TextStyle(
                                          color: ColorRes.white,
                                          fontSize: 22,
                                          fontFamily: FontRes.bold,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      userData?.age == null
                                          ? ''
                                          : " ${userData?.age} ",
                                      style: const TextStyle(
                                          color: ColorRes.white,
                                          fontSize: 22,
                                          fontFamily: FontRes.regular,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Flexible(
                                    child: Visibility(
                                      visible: userData?.isVerified == 2
                                          ? true
                                          : false,
                                      child: Image.asset(
                                        AssetRes.tickMark,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: ConstRes.aUserId == userData?.id
                                  ? false
                                  : true,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: onSaveTap,
                                child: Container(
                                  height: 37,
                                  width: 37,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: ColorRes.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    AssetRes.save,
                                    color: save
                                        ? null
                                        : ColorRes.dimGrey5.withOpacity(0.70),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          userData?.bio ?? '',
                          style: TextStyle(
                            color: ColorRes.white.withOpacity(0.80),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    height: 27,
                                    width: 27,
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: ColorRes.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(AssetRes.home),
                                  ),
                                  const SizedBox(width: 7),
                                  Flexible(
                                    child: Text(
                                      userData?.live == null ||
                                              userData!.live!.isEmpty
                                          ? ''
                                          : '${userData?.live}',
                                      style: TextStyle(
                                          color:
                                              ColorRes.white.withOpacity(0.80),
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Visibility(
                                visible: ConstRes.aUserId == userData?.id
                                    ? false
                                    : true,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      padding: const EdgeInsets.all(6.5),
                                      decoration: const BoxDecoration(
                                        color: ColorRes.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        AssetRes.locationPin,
                                        color: ColorRes.darkOrange,
                                        height: 12.25,
                                        width: 10.5,
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                    Flexible(
                                      child: Text(
                                        distance == 0.0
                                            ? 'No Location'
                                            : '${distance.toStringAsFixed(2)} kms Away',
                                        style: TextStyle(
                                            color: ColorRes.white
                                                .withOpacity(0.80),
                                            fontSize: 14,
                                            overflow: TextOverflow.ellipsis),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          AppRes.about,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontFamily: FontRes.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          userData?.about ?? '',
                          style: TextStyle(
                            color: ColorRes.white.withOpacity(0.80),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          AppRes.interest,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontFamily: FontRes.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 11),
                        interestButtons(userData?.interests ?? []),
                        const SizedBox(height: 6),
                        Visibility(
                          visible:
                              ConstRes.aUserId == userData?.id ? false : true,
                          child: InkWell(
                            onTap: onChatWithTap,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 50,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: ColorRes.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  '${AppRes.chatWithNatalia}${userData?.fullname?.toUpperCase()}',
                                  style: const TextStyle(
                                    color: ColorRes.red3,
                                    fontSize: 12,
                                    fontFamily: FontRes.bold,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 11),
                        InkWell(
                          onTap: onShareWithTap,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: ColorRes.dimGrey7.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '${AppRes.share} ${userData?.fullname?.toUpperCase()}\'S ${AppRes.profileCap}',
                                style: const TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 12,
                                  fontFamily: FontRes.bold,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 27),
                        Visibility(
                          visible:
                              ConstRes.aUserId == userData?.id ? false : true,
                          child: Center(
                            child: InkWell(
                              onTap: onReportTap,
                              child: Text(
                                '${AppRes.reportNatalia}${userData?.fullname?.toUpperCase()}',
                                style: TextStyle(
                                  color: ColorRes.white.withOpacity(0.50),
                                  fontSize: 12,
                                  fontFamily: FontRes.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          HideInfoChip(onHideBtnTap: onHideBtnTap),
        ],
      ),
    );
  }

  Widget interestButtons(List<Interest> interests) {
    return Wrap(
      children: interests.map<Widget>((e) {
        return Container(
          margin: const EdgeInsets.only(right: 8, bottom: 10),
          padding: const EdgeInsets.fromLTRB(20.6, 9.50, 20.6, 8.51),
          decoration: BoxDecoration(
            color: ColorRes.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            '${e.title?.toUpperCase()}',
            style: const TextStyle(
              fontSize: 12,
              color: ColorRes.white,
              letterSpacing: 0.5,
              fontFamily: FontRes.semiBold,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class HideInfoChip extends StatefulWidget {
  final VoidCallback onHideBtnTap;

  const HideInfoChip({Key? key, required this.onHideBtnTap}) : super(key: key);

  @override
  State<HideInfoChip> createState() => _HideInfoChipState();
}

class _HideInfoChipState extends State<HideInfoChip>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller?.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller?.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        widget.onHideBtnTap();
        HapticFeedback.lightImpact();
      },
      onTapUp: _tapUp,
      onTapDown: _tapDown,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          padding: const EdgeInsets.fromLTRB(21, 10, 21, 9),
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
          child: Text(
            AppRes.hideInfo,
            style: TextStyle(
              color: ColorRes.white.withOpacity(0.80),
              fontSize: 11,
              fontFamily: FontRes.bold,
              letterSpacing: 0.65,
            ),
          ),
        ),
      ),
    );
  }
}
