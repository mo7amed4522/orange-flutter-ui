import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class EditProfileScreenViewModel extends BaseViewModel {
  void init() {
    getEditProfileApiCall();
    getInterestApiCall();
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();

  FocusNode ageFocus = FocusNode();
  FocusNode bioFocus = FocusNode();
  FocusNode aboutFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode youtubeFocus = FocusNode();
  FocusNode facebookFocus = FocusNode();
  FocusNode fullNameFocus = FocusNode();
  FocusNode instagramFocus = FocusNode();

  List<Interest>? hobbiesList = [];
  List<String> selectedList = [];

  String latitude = '';
  String longitude = '';
  String gender = AppRes.female;
  String fullNameError = '';
  String bioError = '';
  String aboutError = '';
  String addressError = '';
  String ageError = '';
  String? email;

  List<String> deleteIds = [];
  List<String?> interestList = [];
  List<Images>? imageList = [];
  List<File>? imageFileList = [];

  bool showDropdown = false;
  bool isLoading = false;
  ImagePicker imagePicker = ImagePicker();

  void onClipTap(String value) {
    bool selected = selectedList.contains(value);
    if (selected) {
      selectedList.remove(value);
    } else {
      selectedList.add(value);
    }
    notifyListeners();
  }

  void getInterestApiCall() async {
    ApiProvider().getInterest().then((value) {
      if (value != null && value.status!) {
        hobbiesList = value.data;
        notifyListeners();
      }
    }).then((value) {
      getPrefUser();
    });
  }

  void getEditProfileApiCall() {
    isLoading = true;
    ApiProvider().getProfile(userID: ConstRes.aUserId).then((value) async {
      imageList = value?.data?.images;
      fullNameController.text = value?.data?.fullname ?? '';
      bioController.text = value?.data?.bio ?? '';
      aboutController.text = value?.data?.about ?? '';
      addressController.text = value?.data?.live ?? '';
      ageController.text = value?.data?.age?.toString() ?? '';

      gender = value?.data?.gender == 1
          ? AppRes.male
          : value?.data?.gender == 2
              ? AppRes.female
              : AppRes.other;
      instagramController.text = value?.data?.instagram ?? '';
      facebookController.text = value?.data?.facebook ?? '';
      youtubeController.text = value?.data?.youtube ?? '';
      latitude = await PrefService.getLatitude() ?? '';
      longitude = await PrefService.getLongitude() ?? '';
      email = value?.data?.identity;
      await PrefService.saveUser(value?.data);
      isLoading = false;
      notifyListeners();
    });
  }

  void getPrefUser() {
    PrefService.getUserData().then((value) {
      value?.interests?.map((e) {
        selectedList.add(e.id.toString());
      }).toList();
      notifyListeners();
    });
  }

  void onImageRemove(int index) {
    File? imageOne;
    for (File image in imageFileList!) {
      if (image.path == imageList?[index].image) {
        imageOne = image;
      }
    }
    if (imageOne != null) {
      imageFileList?.remove(imageOne);
    }
    deleteIds.add(imageList![index].id.toString());
    imageList?.removeAt(index);
    notifyListeners();
  }

  void onImageAdd() async {
    selectImages();
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onAllScreenTap() {
    showDropdown = false;
    notifyListeners();
  }

  void onGenderTap() {
    addressFocus.unfocus();
    bioFocus.unfocus();
    aboutFocus.unfocus();
    ageFocus.unfocus();
    showDropdown = !showDropdown;
    notifyListeners();
  }

  void onGenderChange(String value) {
    gender = value;
    showDropdown = false;
    notifyListeners();
  }

  Future<void> onSaveTap() async {
    updateProfileApiCall();
  }

  void onPreviewTap() {}

  void selectImages() async {
    final selectedImages = await imagePicker.pickMultiImage(imageQuality: 25);
    if (selectedImages.isEmpty) return;
    if (selectedImages.isNotEmpty) {
      for (XFile image in selectedImages) {
        var images = File(image.path);
        imageFileList?.add(images);
        imageList?.add(
            Images(id: -123, userId: ConstRes.aUserId, image: images.path));
      }
    }
    notifyListeners();
  }

  void updateProfileApiCall() {
    bool validation = isValid();
    notifyListeners();
    if (validation) {
      Loader().lottieLoader();
      ApiProvider()
          .updateProfile(
              latitude: latitude,
              longitude: longitude,
              images: imageFileList,
              bio: bioController.text,
              age: ageController.text,
              instagram: instagramController.text,
              about: aboutController.text,
              facebook: facebookController.text,
              youtube: youtubeController.text,
              live: addressController.text,
              gender: gender == AppRes.male ? 1 : 2,
              fullName: fullNameController.text,
              deleteImageIds: deleteIds,
              interest: selectedList)
          .then((value) async {
        Get.back();
        Get.back();
      });
    }
  }

  bool isValid() {
    int i = 0;
    if (imageList == null || imageList!.isEmpty) {
      if (imageFileList == null || imageFileList!.isEmpty) {
        SnackBarWidget().snackBarWidget(AppRes.pleaseAddAtLeastEtc);
        i++;
      }
      SnackBarWidget().snackBarWidget(AppRes.imageIsEmpty);
      i++;
    } else {
      FocusScope.of(Get.context!).requestFocus(fullNameFocus);
    }
    if (fullNameController.text == '') {
      fullNameError = AppRes.enterFullName;
      i++;
    } else {
      fullNameFocus.unfocus();
      FocusScope.of(Get.context!).requestFocus(aboutFocus);
    }
    if (aboutController.text == '') {
      aboutError = AppRes.enterAbout;
      i++;
    } else {
      aboutFocus.unfocus();
      fullNameFocus.unfocus();
      FocusScope.of(Get.context!).requestFocus(ageFocus);
    }
    if (ageController.text == '') {
      ageError = AppRes.enterAge;
      ageFocus.requestFocus();
      i++;
    } else if (int.parse(ageController.text) < 18) {
      SnackBarWidget.snackBar(message: 'You must be 18+');
      return false;
    }
    if (selectedList.isEmpty) {
      SnackBarWidget().snackBarWidget(AppRes.pleaseAddAtLeastInterest);
      i++;
    }
    notifyListeners();
    return i == 0 ? true : false;
  }

  @override
  void dispose() {
    bioFocus.dispose();
    aboutFocus.dispose();
    ageFocus.dispose();
    youtubeFocus.dispose();
    addressFocus.dispose();
    fullNameFocus.dispose();
    facebookFocus.dispose();
    instagramFocus.dispose();
    super.dispose();
  }
}
