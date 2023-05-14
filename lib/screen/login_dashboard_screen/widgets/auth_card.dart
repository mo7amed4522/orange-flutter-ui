import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/buttons.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class AuthCard extends StatelessWidget {
  final TextEditingController emailController;
  final FocusNode emailFocus;
  final String emailError;
  final VoidCallback onContinueTap;
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  final VoidCallback onSignUpTap;
  final VoidCallback onForgotPwdTap;

  const AuthCard({
    Key? key,
    required this.emailController,
    required this.emailFocus,
    required this.emailError,
    required this.onContinueTap,
    required this.onGoogleTap,
    required this.onAppleTap,
    required this.onSignUpTap,
    required this.onForgotPwdTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 30),
          padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorRes.black.withOpacity(0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 44,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextField(
                  controller: emailController,
                  focusNode: emailFocus,
                  style: const TextStyle(fontFamily: FontRes.semiBold),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 14),
                    border: InputBorder.none,
                    hintText: emailError == "" ? AppRes.email : emailError,
                    hintStyle: TextStyle(
                      color:
                          emailError == "" ? ColorRes.dimGrey2 : ColorRes.red,
                      fontSize: 14,
                      fontFamily: FontRes.semiBold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SubmitButton1(title: AppRes.continueText, onTap: onContinueTap),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  AppRes.or,
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              socialButton(
                Image.asset(
                  AssetRes.googleLogo,
                  height: 20,
                  width: 20,
                ),
                AppRes.continueWithGoogle,
                onGoogleTap,
                const EdgeInsets.symmetric(horizontal: 16),
              ),
              const SizedBox(height: 15),
              Visibility(
                visible: Platform.isIOS ? true : false,
                child: socialButton(
                  Image.asset(
                    AssetRes.appleLogo,
                    height: 25,
                    width: 25,
                  ),
                  AppRes.continueWithApple,
                  onAppleTap,
                  const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  const Text(
                    AppRes.donTHaveAnAccount,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorRes.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: onSignUpTap,
                    child: const Text(
                      AppRes.signUp,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorRes.lightOrange2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: onForgotPwdTap,
                child: const Text(
                  AppRes.forgotYourPassword,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorRes.lightOrange2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget socialButton(
      Image image, String title, VoidCallback onTap, EdgeInsets padding) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        width: Get.width,
        padding: padding,
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 10,
              child: image,
            ),
            Text(
              title,
              style: const TextStyle(
                color: ColorRes.darkGrey2,
                fontSize: 14,
                fontFamily: FontRes.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
