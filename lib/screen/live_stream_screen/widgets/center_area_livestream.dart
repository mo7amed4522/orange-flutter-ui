import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

// ignore: must_be_immutable
class CenterAreaLiveStream extends StatelessWidget {
  final TextEditingController aboutController;
  final TextEditingController languageController;
  final TextEditingController videoController;
  final FocusNode aboutFocus;
  final FocusNode languageFocus;
  final FocusNode socialLinkFocus;
  final VoidCallback onSubmitTap;
  final Function(TextEditingController controller) onAddBtnTap;
  final Function(TextEditingController controller) onRemoveBtnTap;
  final VoidCallback onVideoPlayBtnTap;
  final VoidCallback onVideoChangeBtnTap;
  final VoidCallback onAttachBtnTap;
  final Function(String? value) onVideoControllerChange;
  final String? videoImage;
  final bool isVideoAttach;
  final List<TextEditingController> controllers;
  int? fieldCount;
  final bool isAbout;
  final bool isLanguages;
  final bool isIntroVideo;
  final bool isSocialLink;

  CenterAreaLiveStream(
      {Key? key,
      required this.aboutController,
      required this.languageController,
      required this.videoController,
      required this.onSubmitTap,
      required this.onAddBtnTap,
      required this.onRemoveBtnTap,
      required this.onVideoControllerChange,
      required this.onVideoChangeBtnTap,
      required this.onAttachBtnTap,
      required this.onVideoPlayBtnTap,
      required this.videoImage,
      required this.isVideoAttach,
      required this.controllers,
      this.fieldCount,
      required this.isSocialLink,
      required this.isIntroVideo,
      required this.isLanguages,
      required this.isAbout,
      required this.aboutFocus,
      required this.languageFocus,
      required this.socialLinkFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 15, bottom: 9),
                child: Text(
                  AppRes.something,
                  style: TextStyle(
                    fontFamily: FontRes.extraBold,
                    fontSize: 15,
                    color: ColorRes.darkGrey3,
                  ),
                ),
              ),
              Container(
                height: 103,
                width: Get.width - 14,
                padding: const EdgeInsets.only(left: 12, top: 12),
                decoration: BoxDecoration(
                    color: ColorRes.lightGrey2,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: isAbout
                            ? ColorRes.darkOrange
                            : ColorRes.transparent)),
                child: TextField(
                  controller: aboutController,
                  focusNode: aboutFocus,
                  textCapitalization: TextCapitalization.sentences,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  style: const TextStyle(
                    color: ColorRes.dimGrey3,
                  ),
                  decoration: const InputDecoration(
                    hintText: AppRes.shortIntro,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintStyle:
                        TextStyle(color: ColorRes.dimGrey3, fontSize: 14),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 10, bottom: 6),
                child: Text(
                  AppRes.languages,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: FontRes.extraBold,
                    color: ColorRes.darkGrey3,
                  ),
                ),
              ),
              Container(
                height: 71,
                width: Get.width - 14,
                padding: const EdgeInsets.only(left: 12, top: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorRes.lightGrey2,
                    border: Border.all(
                        color: isLanguages
                            ? ColorRes.darkOrange
                            : ColorRes.transparent)),
                child: TextField(
                  controller: languageController,
                  focusNode: languageFocus,
                  textCapitalization: TextCapitalization.sentences,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  style: const TextStyle(
                    color: ColorRes.dimGrey3,
                  ),
                  decoration: const InputDecoration(
                    hintText: AppRes.languagesDetail,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: ColorRes.dimGrey3,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 12, bottom: 6),
                child: Text(
                  AppRes.intro,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: FontRes.extraBold,
                      color: ColorRes.darkGrey3),
                ),
              ),
              Visibility(
                visible: isVideoAttach,
                child: InkWell(
                  onTap: onAttachBtnTap,
                  child: Container(
                    height: 67,
                    width: Get.width - 14,
                    decoration: BoxDecoration(
                        color: ColorRes.lightGrey2,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: isIntroVideo
                                ? ColorRes.darkOrange
                                : ColorRes.transparent)),
                    child: const Center(
                      child: Text(
                        AppRes.attach,
                        style: TextStyle(
                          color: ColorRes.dimGrey3,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible:
                    videoImage == null || videoImage!.isEmpty ? false : true,
                child: Container(
                  height: 75,
                  width: Get.width - 14,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: ColorRes.lightGrey2,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: isIntroVideo
                              ? ColorRes.darkOrange
                              : ColorRes.transparent)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: onVideoPlayBtnTap,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File('$videoImage'),
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 31,
                              width: 31,
                              decoration: BoxDecoration(
                                color: ColorRes.white.withOpacity(0.30),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  AssetRes.playButton,
                                  height: 16,
                                  width: 15,
                                  color: ColorRes.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: onVideoChangeBtnTap,
                        child: const Text(
                          'Change',
                          style: TextStyle(
                            color: ColorRes.dimGrey3,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 17, bottom: 6),
                child: Text(
                  AppRes.social,
                  style: TextStyle(
                    color: ColorRes.darkGrey3,
                    fontSize: 15,
                    fontFamily: FontRes.extraBold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, bottom: 12),
                child: Text(
                  AppRes.socialData,
                  style: TextStyle(
                    color: ColorRes.grey25,
                  ),
                ),
              ),
              textFieldList(),
              const SizedBox(height: 33),
              InkWell(
                onTap: onSubmitTap,
                child: Container(
                  height: 41,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
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
                      AppRes.submit,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 12,
                        fontFamily: FontRes.semiBold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24)
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldList() {
    return ListView(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      children: _buildList(),
    );
  }

  List<Widget> _buildList() {
    if (controllers.length < fieldCount!) {
      for (int i = controllers.length; i < fieldCount!; i++) {
        controllers.add(TextEditingController());
        //print('object');
      }
    }
    // cycle through the controllers, and recreate each, one per available controller
    return controllers.map<Widget>((TextEditingController controller) {
      return Container(
        height: 43,
        width: Get.width,
        padding: const EdgeInsets.only(right: 7),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorRes.lightGrey2,
            border: Border.all(
                color:
                    isSocialLink ? ColorRes.darkOrange : ColorRes.transparent)),
        child: controller.text.isEmpty
            ? Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      focusNode: socialLinkFocus,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.only(bottom: 10, left: 12, right: 12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (controller.text.isEmpty) return;
                      fieldCount = fieldCount! + 1;
                      controllers.add(TextEditingController());
                      onAddBtnTap(controller);
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorRes.tometo,
                      ),
                      child: const Center(
                        child: Text(
                          '+',
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          controller.text,
                          maxLines: 2,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      fieldCount = fieldCount! - 1;
                      controllers.remove(controller);
                      onRemoveBtnTap(controller);
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorRes.tometo,
                      ),
                      child: const Center(
                        child: Text(
                          '-',
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      );
    }).toList(); // convert to a list
  }
}
