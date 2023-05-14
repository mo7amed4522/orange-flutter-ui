import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart' as messaging;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/dashboard/dashboard_screen.dart';
import 'package:orange_ui/screen/login_pwd_screen/login_pwd_screen.dart';
import 'package:orange_ui/screen/login_pwd_screen/widgets/forgot_password.dart';
import 'package:orange_ui/screen/register_screen/register_screen.dart';
import 'package:orange_ui/screen/select_hobbies_screen/select_hobbies_screen.dart';
import 'package:orange_ui/screen/select_photo_screen/select_photo_screen.dart';
import 'package:orange_ui/screen/starting_profile_screen/starting_profile_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';

class LoginDashboardScreenViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? tokenId;
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  String emailError = "";
  String appleUserName = '';
  FocusNode resetFocusNode = FocusNode();

  void init() {
    messaging.FirebaseMessaging.instance.getToken().then((token) {
      tokenId = token;
    });
    getEmail();
  }

  void getEmail() async {
    emailController.text = await PrefService.getEmail() ?? '';
  }

  bool isValid() {
    if (emailController.text == "") {
      emailError = AppRes.enterEmail;
      return false;
    } else {
      emailError = "";
      return true;
    }
  }

  void onContinueTap() {
    bool validation = isValid();
    notifyListeners();
    emailFocus.unfocus();
    if (validation) {
      Get.to(() => LoginPwdScreen(email: emailController.text));
    }
  }

  void onGoogleTap() {
    Loader().lottieLoader();
    signInWithGoogle().then((value) async {
      if (value == null) {
        Get.back();
        return;
      }
      // if (value?.user?.email == null||value!.user!.email!.isEmpty) return;
      Get.back();
      registrationApiCall(
          email: value.user?.email,
          name: value.user?.displayName,
          loginType: 1);
    });
  }

  void onAppleTap() {
    signInWithApple().then((value) async {
      if (value == null) {
        return;
      }
      String appleFullName = await PrefService.getFullName() ?? '';
      registrationApiCall(
          email: value.user?.email, name: appleFullName, loginType: 2);
      notifyListeners();
    });
  }

  void onSignUpTap() {
    Get.to(() => const RegisterScreen());
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
      ),
    );
  }

  Future<UserCredential?> signInWithApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final credential = OAuthProvider('apple.com').credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );

    final user = await _auth.signInWithCredential(credential);

    final fullName = appleIdCredential.givenName;

    final familyName = appleIdCredential.familyName;

    if (fullName != null || familyName != null) {
      String name = '$fullName $familyName';
      await user.user?.updateDisplayName(name);
      await PrefService.setFullName(name);
      notifyListeners();
    }
    // await user.user?.updateDisplayName(familyName);
    return user;
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    //final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleSignInAccount?.authentication;

    // Create a new credential
    if (googleAuth == null ||
        googleAuth.accessToken == null ||
        googleAuth.idToken == null) {
      Get.back();
      return null;
    }
    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final user = await _auth.signInWithCredential(credential);
    return user;
  }

  void registrationApiCall(
      {required String? email, required String? name, required int loginType}) {
    Loader().lottieLoader();
    ApiProvider()
        .registration(
            email: email,
            fullName: name,
            deviceToken: tokenId,
            loginType: loginType,
            password: '')
        .then((value) async {
      if (value.status == true) {
        ConstRes.aUserId = value.data!.id!;
        await PrefService.setLoginText(true);
        if (value.data?.lattitude != null) {
          await PrefService.setLatitude("${value.data?.lattitude}");
          await PrefService.setLongitude("${value.data?.longitude}");
        }
        await PrefService.saveUser(value.data);
        Get.back();
        await checkScreenCondition(value.data);
      } else {
        Get.back();
      }
    });
  }

  Future<void> checkScreenCondition(RegistrationUserData? data) async {
    if (data == null) return;
    if (data.age == null) {
      Get.offAll(
        () => const StartingProfileScreen(),
      );
    } else if (data.images == null || data.images!.isEmpty) {
      Get.off(() => const SelectPhotoScreen());
    } else if (data.interests!.isEmpty || data.interests == null) {
      Get.off(() => const SelectHobbiesScreen());
    } else {
      Get.offAll(() => const DashboardScreen());
    }
  }
}
