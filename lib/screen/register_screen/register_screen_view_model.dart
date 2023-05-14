import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/screen/login_dashboard_screen/login_dashboard_screen.dart';
import 'package:orange_ui/screen/webview_screen/webview_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class RegisterScreenViewModel extends BaseViewModel {
  String? tokenId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode pwdFocus = FocusNode();
  FocusNode confirmPwdFocus = FocusNode();
  FocusNode ageFocus = FocusNode();

  String fullNameError = '';
  String emailError = '';
  String pwdError = '';
  String confirmPwdError = '';
  String ageError = '';

  bool showPwd = false;

  void init() {
    FirebaseMessaging.instance.getToken().then((token) {
      tokenId = token;
    });
  }

  void onViewTap() {
    showPwd = !showPwd;
    notifyListeners();
  }

  void onTermsOfUseTap() {
    Get.to(() => const WebViewScreen(
        appBarTitle: AppRes.termsOfUse, url: ConstRes.aTermsOfUse));
  }

  void onPrivacyPolicyTap() {
    Get.to(
      () => const WebViewScreen(
          appBarTitle: AppRes.privacyPolicy, url: ConstRes.aPrivacyPolicy),
    );
  }

  Future<void> onContinueTap() async {
    if (isValid()) {
      Loader().lottieLoader();
      signUp(email: emailController.text, password: pwdController.text)
          .then((value) {
        if (value == null) return;
        value.user?.sendEmailVerification();
        ApiProvider()
            .registration(
                email: emailController.text,
                fullName: fullNameController.text,
                deviceToken: tokenId,
                loginType: 5)
            .then((value) async {
          SnackBarWidget().snackBarWidget(AppRes.registrationSuccessfully);
          ConstRes.aUserId = value.data?.id ?? -1;
          await PrefService.saveUser(value.data);
          Get.back();
          Get.offAll(() => const LoginDashboardScreen());
        });
      });
    }
    notifyListeners();
  }

  bool isValid() {
    int count = 0;
    if (emailController.text == '') {
      count++;
      emailFocus.requestFocus();
      emailError = AppRes.enterEmail;
      return false;
    } else {
      bool isEmailValid = GetUtils.isEmail(emailController.text);
      if (!isEmailValid) {
        SnackBarWidget().snackBarWidget(AppRes.pleaseValidEmail);
        return false;
      } else {
        emailFocus.unfocus();
        FocusScope.of(Get.context!).requestFocus(fullNameFocus);
      }
    }
    if (fullNameController.text == '') {
      count++;
      fullNameFocus.requestFocus();
      fullNameError = AppRes.enterFullName;
      return false;
    } else {
      fullNameFocus.unfocus();
      FocusScope.of(Get.context!).requestFocus(pwdFocus);
    }
    if (pwdController.text == '') {
      count++;
      pwdError = AppRes.enterPassword;
      pwdFocus.requestFocus();
      return false;
    } else {
      pwdFocus.unfocus();
      FocusScope.of(Get.context!).requestFocus(confirmPwdFocus);
    }
    if (confirmPwdController.text == '') {
      count++;
      confirmPwdError = AppRes.enterConfirmPassword;
      confirmPwdFocus.requestFocus();
      return false;
    } else {
      if (confirmPwdController.text != pwdController.text) {
        count++;
        confirmPwdController.clear();
        confirmPwdError = AppRes.passwordMismatch;
      }
      confirmPwdFocus.unfocus();
      FocusScope.of(Get.context!).requestFocus(ageFocus);
    }
    if (ageController.text.isEmpty) {
      count++;
      ageError = AppRes.enterAge;
      ageFocus.requestFocus();
      return false;
    } else if (int.parse(ageController.text) < 18) {
      count++;
      SnackBarWidget.snackBar(message: 'You Must 18+');
      ageFocus.unfocus();
    }

    return count == 0 ? true : false;
  }

  Future<UserCredential?> signUp(
      {required String email, required String password}) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      SnackBarWidget().snackBarWidget('${e.message}');
      Get.offAll(() => const LoginDashboardScreen());
      return null;
    }
  }

  @override
  void dispose() {
    fullNameFocus.dispose();
    emailFocus.dispose();
    pwdFocus.dispose();
    confirmPwdFocus.dispose();
    ageFocus.dispose();
    fullNameController.dispose();
    emailController.dispose();
    pwdController.dispose();
    confirmPwdController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
