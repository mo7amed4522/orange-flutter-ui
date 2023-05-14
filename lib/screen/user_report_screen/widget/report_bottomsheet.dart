import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/user_report_screen/widget/report_reason_drop_down_box.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class ReportBottomSheet extends StatelessWidget {
  final VoidCallback onBackBtnTap;
  final VoidCallback onTextFieldTap;
  final VoidCallback onTermAndConditionClick;
  final bool showDropdown;
  final bool? checkBoxValue;
  final VoidCallback onReasonTap;
  final TextEditingController explainMoreController;
  final String reason;
  final String? profileImage;
  final String fullName;
  final String address;
  final List<String> reasonList;
  final Function(String reason) onReasonChange;
  final Function(bool? isCheck) onCheckBoxChange;
  final VoidCallback onSubmitBtnTap;
  final String explainMoreError;
  final FocusNode explainMoreFocus;
  final bool explainError;

  const ReportBottomSheet(
      {Key? key,
      required this.onBackBtnTap,
      required this.onTextFieldTap,
      required this.showDropdown,
      required this.onReasonTap,
      required this.reason,
      required this.checkBoxValue,
      required this.explainMoreController,
      required this.reasonList,
      required this.onCheckBoxChange,
      required this.onReasonChange,
      required this.onSubmitBtnTap,
      required this.fullName,
      required this.profileImage,
      required this.address,
      required this.explainMoreError,
      required this.explainMoreFocus,
      required this.explainError,
      required this.onTermAndConditionClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 40, sigmaX: 40),
          child: Container(
            width: Get.width,
            height: Get.height - 100,
            padding: const EdgeInsets.fromLTRB(21, 20, 21, 0),
            decoration: BoxDecoration(
              color: ColorRes.black.withOpacity(0.33),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      InkWell(
                        onTap: onBackBtnTap,
                        child: Image.asset(
                          AssetRes.backArrow,
                          height: 20,
                          width: 15,
                        ),
                      ),
                      const Center(
                        child: Text(
                          AppRes.reportUser,
                          style: TextStyle(
                              color: ColorRes.white,
                              fontFamily: FontRes.bold,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    AppRes.youAreReporting,
                    style: TextStyle(
                        color: ColorRes.white, fontFamily: FontRes.semiBold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: ColorRes.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        profileImage == null || profileImage!.isEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: ColorRes.white),
                                  child: Image.asset(
                                    AssetRes.themeLabel,
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${ConstRes.aImageBaseUrl}$profileImage',
                                  cacheKey:
                                      '${ConstRes.aImageBaseUrl}$profileImage',
                                  errorWidget: (context, url, error) {
                                    return Image.asset(
                                      AssetRes.themeLabel,
                                      width: 50,
                                      height: 50,
                                    );
                                  },
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              fullName,
                              style: const TextStyle(color: ColorRes.white),
                            ),
                            Text(
                              address,
                              style: const TextStyle(color: ColorRes.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    AppRes.selectReason,
                    style: TextStyle(
                        color: ColorRes.white, fontFamily: FontRes.semiBold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: onReasonTap,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              height: 40,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: ColorRes.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      reason,
                                      style: const TextStyle(
                                        color: ColorRes.dimGrey7,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: showDropdown ? 3.1 : 0,
                                      child: Image.asset(
                                        AssetRes.downArrow,
                                        height: 7,
                                        width: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: showDropdown ? 130 : 0,
                          )
                        ],
                      ),
                      showDropdown
                          ? Positioned(
                              top: 45,
                              left: 0,
                              child: ReportReasonDropDownBox(
                                reason: reason,
                                onChange: onReasonChange,
                                reasonList: reasonList,
                                backGroundColor:
                                    ColorRes.white.withOpacity(0.15),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    AppRes.explainMore,
                    style: TextStyle(color: ColorRes.white),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: ColorRes.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: explainError == false
                                ? ColorRes.transparent
                                : ColorRes.red)),
                    child: TextField(
                      controller: explainMoreController,
                      focusNode: explainMoreFocus,
                      onTap: onTextFieldTap,
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        color: ColorRes.dimGrey3,
                        fontSize: 15,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: explainMoreError == ''
                            ? AppRes.explainMore
                            : explainMoreError,
                        hintStyle: TextStyle(
                          color: explainMoreError == ""
                              ? ColorRes.dimGrey2
                              : ColorRes.red,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.only(bottom: 10, left: 10, top: 9),
                        counterText: "",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: checkBoxValue,
                        onChanged: onCheckBoxChange,
                        activeColor: ColorRes.orange,
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(
                              width: 1.5, color: ColorRes.orange),
                        ),
                      ),
                      InkWell(
                        onTap: onTermAndConditionClick,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: AppRes.iAgreeTo,
                                style: TextStyle(
                                  color: ColorRes.dimGrey2,
                                  fontSize: 13,
                                  fontFamily: FontRes.regular,
                                ),
                              ),
                              TextSpan(
                                text: AppRes.termAndCondition,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = onTermAndConditionClick,
                                style: const TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 13,
                                  fontFamily: FontRes.semiBold,
                                ),
                              ),
                              const TextSpan(
                                text: AppRes.continuePlease,
                                style: TextStyle(
                                  color: ColorRes.dimGrey2,
                                  fontSize: 13,
                                  fontFamily: FontRes.regular,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: onSubmitBtnTap,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0.0, 1.0), //(x,y)
                            blurRadius: 1.0,
                          ),
                        ],
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
                            fontFamily: FontRes.bold,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
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
    );
  }
}
