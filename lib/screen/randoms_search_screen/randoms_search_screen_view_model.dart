import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/randoms_video_call_screen/randoms_video_call_screen.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class RandomsSearchScreenViewModel extends BaseViewModel {
  bool isLoading = false;
  RegistrationUserData? userData;
  String selectedGender = AppRes.both;
  PageController pageController = PageController();
  int currentPageIndex = 0;

  void init() {
    selectedGender = Get.arguments[0][ConstRes.aGender];
    pageController = PageController(initialPage: 0, viewportFraction: 1.01)
      ..addListener(() {
        changeMainImage();
      });
    getRandomApiCall();
  }

  void getRandomApiCall() async {
    isLoading = true;
    await Future.delayed(
      Duration(
        seconds: Random().nextInt(5),
      ),
    );
    ApiProvider()
        .getRandomProfile(
            gender: selectedGender == AppRes.boys
                ? 1
                : selectedGender == AppRes.girls
                    ? 2
                    : 3)
        .then((value) {
      userData = value.data;
      isLoading = false;
      notifyListeners();
    });
  }

  void onSearchingTextTap() {
    Get.to(() => const RandomsVideoCallScreen());
  }

  void onCancelTap() {
    Get.back();
  }

  void onNextTap() {
    getRandomApiCall();
    notifyListeners();
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onLeftBtnClick() {
    if (currentPageIndex == 0) return;
    currentPageIndex--;
    pageController.animateToPage(currentPageIndex,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    notifyListeners();
  }

  void onRightBtnClick() {
    if (userData!.images!.length - 1 == currentPageIndex) return;
    currentPageIndex++;
    pageController.animateToPage(currentPageIndex,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    notifyListeners();
  }

  void changeMainImage() {
    if (pageController.page!.round() != currentPageIndex) {
      currentPageIndex = pageController.page!.round();
      notifyListeners();
    }
  }

  void onLiveBtnTap() {
    // Get.to(() => const PremiumScreen());
  }

  void onImageTap() {
    Get.to(() => const UserDetailScreen(), arguments: userData);
  }

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch ';
  }

  bool isSocialBtnVisible(String? socialLink) {
    if (socialLink != null) {
      return socialLink.contains("http://") || socialLink.contains("https://");
    } else {
      return false;
    }
  }

  void onInstagramTap() {
    _launchUrl(userData?.instagram ?? '');
  }

  void onFBTap() {
    _launchUrl(userData?.facebook ?? '');
  }

  void onYoutubeTap() {
    _launchUrl(userData?.youtube ?? '');
  }
}
