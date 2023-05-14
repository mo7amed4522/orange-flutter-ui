import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/login_dashboard_screen/login_dashboard_screen_view_model.dart';
import 'package:orange_ui/screen/login_dashboard_screen/widgets/auth_card.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class LoginDashboardScreen extends StatelessWidget {
  const LoginDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginDashboardScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => LoginDashboardScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Image.asset(
                  AssetRes.loginBG,
                  height: Get.height,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height / 6),
                      Image.asset(
                        AssetRes.themeLabelWhite,
                        height: 51,
                        width: 176,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 23),
                      const Text(
                        AppRes.loginToContinue,
                        style: TextStyle(
                          color: ColorRes.white,
                          fontSize: 12,
                          fontFamily: FontRes.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: Get.height / 13),
                      AuthCard(
                        emailController: model.emailController,
                        emailFocus: model.emailFocus,
                        emailError: model.emailError,
                        onContinueTap: model.onContinueTap,
                        onGoogleTap: model.onGoogleTap,
                        onAppleTap: model.onAppleTap,
                        onSignUpTap: model.onSignUpTap,
                        onForgotPwdTap: model.onForgotPwdTap,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
