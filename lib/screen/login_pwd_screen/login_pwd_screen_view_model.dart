import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/dashboard/dashboard_screen.dart';
import 'package:orange_ui/screen/login_pwd_screen/widgets/forgot_password.dart';
import 'package:orange_ui/screen/select_hobbies_screen/select_hobbies_screen.dart';
import 'package:orange_ui/screen/select_photo_screen/select_photo_screen.dart';
import 'package:orange_ui/screen/starting_profile_screen/starting_profile_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class LoginPwdScreenViewModel extends BaseViewModel {
  String? tokenId;
  String email = '';
  TextEditingController pwdController = TextEditingController();
  FocusNode pwdFocus = FocusNode();
  String pwdError = "";
  bool showPwd = false;
  bool isVerified = false;
  RegistrationUserData? userData;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FocusNode resetFocusNode = FocusNode();
  bool isResetBtnVisible = false;

  void init(String email) {
    FirebaseMessaging.instance.getToken().then((token) {
      tokenId = token;
    });
    this.email = email;
  }

  void onViewBtnTap() {
    showPwd = !showPwd;
    notifyListeners();
  }

  void onBackBtnTap() {
    Get.back();
  }

  Future<void> onContinueTap() async {
    bool validation = inValid();
    notifyListeners();
    pwdFocus.unfocus();
    if (validation) {
      if (!GetUtils.isEmail(email)) {
        Loader().lottieLoader();
        ApiProvider()
            .registration(
                email: email,
                fullName: '',
                deviceToken: tokenId,
                loginType: 4,
                password: pwdController.text)
            .then((value) async {
          if (value.data != null) {
            Get.back();
            ConstRes.aUserId = value.data!.id!;
            await PrefService.setLoginText(true);
            await PrefService.saveUser(value.data);
            await PrefService.setFullName('${value.data?.fullname}');
            checkScreenCondition(value.data);
          } else {
            Get.back();
            SnackBarWidget().snackBarWidget('Incorrect password or UserId');
          }
        });
      } else {
        signIn(email: email, password: pwdController.text).then((value) async {
          if (value?.user?.email == email) {
            Loader().lottieLoader();
            if (value?.user?.emailVerified == true) {
              Get.back();
              Loader().lottieLoader();
              ApiProvider()
                  .registration(
                      email: email,
                      fullName: '',
                      deviceToken: tokenId,
                      loginType: 4)
                  .then((value) async {
                Get.back();
                ConstRes.aUserId = value.data!.id!;
                // print(ConstRes.aUserId);
                await PrefService.setLoginText(true);
                await PrefService.saveUser(value.data);
                await PrefService.setFullName('${value.data?.fullname}');
                checkScreenCondition(value.data);
              });
            } else {
              Get.back();
              SnackBarWidget()
                  .snackBarWidget('Please Verify your e-mail from your inbox');
            }
          }
        });
      }
    }
  }

  bool inValid() {
    if (pwdController.text == "") {
      pwdError = AppRes.enterPassword;
      return false;
    } else {
      return true;
    }
  }

  void resetBtnClick(TextEditingController controller) async {
    resetFocusNode.unfocus();
    if (controller.text.isEmpty) {
      SnackBarWidget.snackBar(message: 'Please Enter Email...!');
      return;
    } else if (!GetUtils.isEmail(controller.text)) {
      SnackBarWidget.snackBar(message: 'Please Enter valid email address');
      return;
    }
    Get.back();
    Loader().lottieLoader();
    try {
      await _auth.sendPasswordResetEmail(email: controller.text);
      controller.clear();
      Get.back();
      SnackBarWidget.snackBar(message: 'Email sent Successfully...');
    } on FirebaseAuthException catch (e) {
      Get.back();
      SnackBarWidget.snackBar(message: "${e.message}");
    }
  }

  void onForgotPwdTap() {
    Get.bottomSheet(
      ForgotPassword(
          resetBtnClick: resetBtnClick,
          resetFocusNode: resetFocusNode,
          email: email),
    );
  }

  //SIGN IN METHOD
  Future<UserCredential?> signIn(
      {required String email, required String password}) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      SnackBarWidget().snackBarWidget('${e.message}');
      return null;
    }
  }

  void checkScreenCondition(RegistrationUserData? data) {
    if (data?.age == null) {
      Get.offAll(() => const StartingProfileScreen());
    } else if (data!.images!.isEmpty || data.images == null) {
      Get.off(() => const SelectPhotoScreen());
    } else if (data.interests!.isEmpty || data.interests == null) {
      Get.off(() => const SelectHobbiesScreen());
    } else {
      Get.offAll(() => const DashboardScreen());
    }
  }
}
