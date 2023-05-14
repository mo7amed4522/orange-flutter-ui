import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/dashboard/dashboard_screen.dart';
import 'package:orange_ui/screen/select_hobbies_screen/select_hobbies_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:stacked/stacked.dart';

class SelectPhotoScreenViewModel extends BaseViewModel {
  late PageController pageController;
  List<String> imageList = [];
  int pageIndex = 0;
  String fullName = '';
  int? age;
  int gender = 0;
  String address = '';
  String bioText = '';
  int currentImgIndex = 0;
  final ImagePicker imagePicker = ImagePicker();
  List<File>? imageFileList = [];

  void init() {
    getPrefsData();
    pageController = PageController(initialPage: 0, viewportFraction: 1.05)
      ..addListener(() {
        onMainImageChange();
      });
  }

  Future<void> getPrefsData() async {
    PrefService.getUserData().then((value) {
      fullName = value?.fullname ?? '';
      age = value?.age ?? 0;
      bioText = value?.bio ?? '';
      address = value?.live ?? '';
      notifyListeners();
    });
  }

  void onMainImageChange() {
    if (currentImgIndex != pageController.page!.round()) {
      currentImgIndex = pageController.page!.round();
      notifyListeners();
    }
  }

  void onImageRemove(int index) {
    imageFileList?.removeAt(index);
    notifyListeners();
  }

  void onImageAdd() async {
    selectImages();
  }

  void onPlayButtonTap() {
    if (imageFileList == null || imageFileList!.isEmpty) {
      SnackBarWidget().snackBarWidget(AppRes.pleaseSelectImage);
      return;
    }
    Loader().lottieLoader();
    for (int i = 0; i < imageFileList!.length; i++) {
      String image = imageFileList![i].path;
      imageList.add(image);
    }
    ApiProvider().updateProfile(images: imageFileList).then((value) {
      Get.back();
      checkScreenCondition(value.data);
    });
  }

  void selectImages() async {
    final selectedImages = await imagePicker.pickMultiImage(imageQuality: 25);
    if (selectedImages.isEmpty) return;
    if (selectedImages.isNotEmpty) {
      for (XFile image in selectedImages) {
        var images = File(image.path);

        imageFileList?.add(images);
      }
    }
    notifyListeners();
  }

  void checkScreenCondition(RegistrationUserData? data) {
    if (data!.images == null || data.images!.isEmpty) {
      return;
    } else if (data.interests!.isEmpty || data.interests == null) {
      Get.offAll(() => const SelectHobbiesScreen());
    } else {
      Get.offAll(() => const DashboardScreen());
    }
  }
}
