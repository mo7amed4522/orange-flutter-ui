import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/confirmation_dialog.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/livestream_dashboard_screen/livestream_dashboard_screen.dart';
import 'package:orange_ui/screen/login_dashboard_screen/login_dashboard_screen.dart';
import 'package:orange_ui/screen/verification_screen/verification_screen.dart';
import 'package:orange_ui/screen/webview_screen/webview_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class OptionalScreenViewModel extends BaseViewModel {
  bool notificationEnable = false;
  bool showMeOnMap = false;
  bool goAnonymous = false;
  int? loginType;
  int? verificationProcess = 0;
  bool isLoading = false;
  int? deleteId;
  RegistrationUserData? userData;
  FirebaseAuth auth = FirebaseAuth.instance;

  void init() {
    getProfileApiCall();
    getPref();
  }

  void onBackBtnTap() {
    Get.back();
  }

  void getProfileApiCall() {
    isLoading = true;
    ApiProvider().getProfile(userID: ConstRes.aUserId).then((value) {
      userData = value?.data;
      deleteId = value?.data?.id;
      verificationProcess = value?.data?.isVerified == 0
          ? 0
          : value?.data?.isVerified == 1
              ? 1
              : 2;
      isLoading = false;
      notifyListeners();
    });
  }

  void getPref() async {
    PrefService.getUserData().then((value) {
      if (value == null) return;
      notificationEnable = value.isNotification == 1 ? true : false;
      showMeOnMap = value.showOnMap == 1 ? true : false;
      goAnonymous = value.anonymous == 1 ? true : false;
      loginType = value.loginType;
      notifyListeners();
    });
  }

  void onLiveStreamTab() {
    Get.snackbar("The Live !!", "The Live stram will comming soon",
        snackPosition: SnackPosition.BOTTOM);
  }

  void onLiveStreamTap() {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const LiveStreamDashBoard());
  }

  void onApplyForVerTap() {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const VerificationScreen(), arguments: userData)
            ?.then((value) {
            getProfileApiCall();
          });
  }

  void onNotificationTap() {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : ApiProvider()
            .onOffNotification(notificationEnable ? 0 : 1)
            .then((value) async {
            if (value.status == true) {
              notificationEnable =
                  value.data?.isNotification == 1 ? true : false;
              await PrefService.saveUser(value.data);
              notifyListeners();
              SnackBarWidget().snackBarWidget(value.message!);
            }
          });
  }

  void onShowMeOnMapTap() {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : ApiProvider()
            .onOffShowMeOnMap(showMeOnMap ? 0 : 1)
            .then((value) async {
            if (value.status == true) {
              showMeOnMap = value.data?.showOnMap == 1 ? true : false;
              await PrefService.saveUser(value.data);
              SnackBarWidget().snackBarWidget(value.message!);
              notifyListeners();
            }
          });
  }

  void onGoAnonymousTap() {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : ApiProvider().onOffAnonymous(goAnonymous ? 0 : 1).then((value) async {
            if (value.status == true) {
              goAnonymous = value.data?.anonymous == 1 ? true : false;
              // await PrefService.setOnOffAnonymous(goAnonymous);
              await PrefService.saveUser(value.data);
              notifyListeners();
              SnackBarWidget().snackBarWidget(value.message!);
            }
          });
  }

  void onPrivacyPolicyTap() {
    Get.to(
      () => const WebViewScreen(
        appBarTitle: AppRes.privacyPolicy,
        url: ConstRes.aPrivacyPolicy,
      ),
    );
  }

  void onTermsOfUseTap() {
    Get.to(
      () => const WebViewScreen(
        appBarTitle: AppRes.termsOfUse,
        url: ConstRes.aTermsOfUse,
      ),
    );
  }

  Future<void> onLogOutYesBtnClick() async {
    if (loginType == 1) {
      await googleSignOut();
    }
    if (loginType == 2) {
      // apple logout
    }
    if (loginType == 3) {
      //facebook logout
    }
    if (loginType == 4) {
      //email logout
    }
    ApiProvider().logoutUser().then((value) {
      PrefService.setLoginText(false);
      SnackBarWidget().snackBarWidget('${value.message}');
      Get.offAll(() => const LoginDashboardScreen());
    });
  }

  void onLogoutTap() async {
    Get.dialog(
      ConfirmationDialog(
          onNoBtnClick: onNoBtnClick,
          onYesBtnClick: onLogOutYesBtnClick,
          subDescription: AppRes.logOutDis,
          aspectRatio: 1 / 0.7,
          horizontalPadding: 70,
          clickText1: AppRes.yes,
          clickText2: AppRes.no,
          heading: AppRes.areYouSure),
    );
  }

  Future googleSignOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  final db = FirebaseFirestore.instance;

  void onDeleteYesBtnClick() async {
    Get.back();
    Loader().lottieLoader();

    FirebaseAuth.instance.currentUser?.delete();
    await FirebaseAuth.instance.signOut();
    ApiProvider().deleteAccount(deleteId).then((value) async {
      if (value.status == true) {
        await deleteFirebaseUser();
        SnackBarWidget().snackBarWidget(value.message ?? '');
        PrefService.setLoginText(false);
        Get.offAll(() => const LoginDashboardScreen());
      }
      notifyListeners();
    });
  }

  Future<void> deleteFirebaseUser() async {
    await db
        .collection(FirebaseConst.userChatList)
        .doc(userData?.identity)
        .collection(FirebaseConst.userList)
        .get()
        .then((value) {
      for (var element in value.docs) {
        db
            .collection(FirebaseConst.userChatList)
            .doc(element.id)
            .collection(FirebaseConst.userList)
            .doc(userData?.identity)
            .update({
          FirebaseConst.isDeleted: true,
          FirebaseConst.deletedId: '${DateTime.now().millisecondsSinceEpoch}',
          FirebaseConst.block: false,
          FirebaseConst.blockFromOther: false,
        });

        db
            .collection(FirebaseConst.userChatList)
            .doc(userData?.identity)
            .collection(FirebaseConst.userList)
            .doc(element.id)
            .update({
          FirebaseConst.isDeleted: true,
          FirebaseConst.deletedId: '${DateTime.now().millisecondsSinceEpoch}',
          FirebaseConst.block: false,
          FirebaseConst.blockFromOther: false,
        });
      }
    });
  }

  void onNoBtnClick() {
    Get.back();
  }

  void onDeleteAccountTap() {
    Get.dialog(
      ConfirmationDialog(
          onNoBtnClick: onNoBtnClick,
          onYesBtnClick: onDeleteYesBtnClick,
          subDescription: AppRes.deleteDialogDis,
          aspectRatio: 1 / 0.8,
          horizontalPadding: 65,
          clickText1: AppRes.yes,
          clickText2: AppRes.no,
          heading: AppRes.areYouSure),
    );
  }
}
