import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/buttons.dart';
import 'package:orange_ui/screen/register_screen/register_screen_view_model.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class RegisterCard extends StatelessWidget {
  final RegisterScreenViewModel model;

  const RegisterCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 30),
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorRes.black.withOpacity(0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppRes.registerInfoText,
                style: TextStyle(
                  color: ColorRes.lightGrey,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 25),
              textField(
                  controller: model.emailController,
                  focusNode: model.emailFocus,
                  error: model.emailError,
                  textCapitalization: TextCapitalization.none,
                  hint: AppRes.email),
              const SizedBox(height: 20),
              textField(
                controller: model.fullNameController,
                focusNode: model.fullNameFocus,
                error: model.fullNameError,
                textCapitalization: TextCapitalization.sentences,
                hint: AppRes.fullName,
              ),
              const SizedBox(height: 20),
              textField(
                  controller: model.pwdController,
                  focusNode: model.pwdFocus,
                  error: model.pwdError,
                  hint: AppRes.password,
                  showPwd: model.showPwd,
                  textCapitalization: TextCapitalization.sentences,
                  onViewTap: model.onViewTap),
              const SizedBox(height: 20),
              textField(
                controller: model.confirmPwdController,
                focusNode: model.confirmPwdFocus,
                error: model.confirmPwdError,
                hint: AppRes.confirmPassword,
                textCapitalization: TextCapitalization.sentences,
                showPwd: false,
              ),
              const SizedBox(height: 20),
              textField(
                  controller: model.ageController,
                  focusNode: model.ageFocus,
                  error: model.ageError,
                  hint: AppRes.enterAge,
                  textCapitalization: TextCapitalization.sentences,
                  textInputType: TextInputType.number),
              const SizedBox(height: 25),
              policyText(),
              const SizedBox(height: 30),
              SubmitButton1(
                  title: AppRes.agreeNContinue, onTap: model.onContinueTap),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(
      {required TextEditingController controller,
      required FocusNode focusNode,
      required String error,
      required String hint,
      bool? showPwd,
      required TextCapitalization textCapitalization,
      VoidCallback? onViewTap,
      TextInputType textInputType = TextInputType.text}) {
    return Container(
      height: 44,
      width: Get.width,
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: showPwd == null ? false : !showPwd,
        textCapitalization: textCapitalization,
        keyboardType: textInputType,
        style: const TextStyle(
          fontFamily: FontRes.semiBold,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 14, top: 12),
          border: InputBorder.none,
          hintText: error == "" ? hint : error,
          suffixIcon: onViewTap == null
              ? const SizedBox()
              : InkWell(
                  onTap: onViewTap,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      showPwd! ? AppRes.hide : AppRes.view,
                      style: const TextStyle(
                        color: ColorRes.veryDarkGrey2,
                        fontSize: 13,
                        fontFamily: FontRes.bold,
                      ),
                    ),
                  ),
                ),
          hintStyle: TextStyle(
            color: error == "" ? ColorRes.dimGrey2 : ColorRes.red,
            fontSize: 14,
            fontFamily: FontRes.semiBold,
          ),
        ),
      ),
    );
  }

  Widget policyText() {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: AppRes.policy1,
            style: TextStyle(
              color: ColorRes.lightGrey,
              fontSize: 13,
              fontFamily: FontRes.regular,
            ),
          ),
          TextSpan(
            text: AppRes.policy2,
            recognizer: TapGestureRecognizer()..onTap = model.onTermsOfUseTap,
            style: const TextStyle(
              color: ColorRes.lightOrange3,
              fontSize: 13,
              fontFamily: FontRes.semiBold,
            ),
          ),
          const TextSpan(
            text: AppRes.policy3,
            style: TextStyle(
              color: ColorRes.lightGrey,
              fontSize: 13,
              fontFamily: FontRes.regular,
            ),
          ),
          TextSpan(
            text: AppRes.policy4,
            recognizer: TapGestureRecognizer()
              ..onTap = model.onPrivacyPolicyTap,
            style: const TextStyle(
              color: ColorRes.lightOrange3,
              fontSize: 13,
              fontFamily: FontRes.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
