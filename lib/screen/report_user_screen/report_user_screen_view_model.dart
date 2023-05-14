import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:stacked/stacked.dart';

import '../../api_provider/api_provider.dart';
import '../../utils/color_res.dart';

class ReportUserScreenViewModel extends BaseViewModel {
  void init() {
    registrationUserData = Get.arguments;
  }

  RegistrationUserData? registrationUserData;

  List<String> reasonList = [
    AppRes.cyberbullying,
    AppRes.harassment,
    AppRes.personalHarassment,
    AppRes.inappropriateContent
  ];

  void onBackBtnTap() {
    Get.back();
  }

  bool showDropdown = false;
  bool? isCheckBox = false;
  String reason = AppRes.cyberbullying;
  String explainMoreError = '';
  TextEditingController explainMoreController = TextEditingController();
  FocusNode explainFocusNode = FocusNode();

  void onReasonTap() {
    showDropdown = !showDropdown;
    notifyListeners();
  }

  void onReasonChange(String value) {
    reason = value;
    showDropdown = false;
    notifyListeners();
  }

  void onCheckBoxChange(bool? value) {
    isCheckBox = value;
    notifyListeners();
  }

  bool isValid() {
    int i = 0;
    if (explainMoreController.text == '') {
      explainMoreError = AppRes.enterFullReason;
      i++;
      return false;
    }
    if (isCheckBox == false) {
      Get.rawSnackbar(
        message: "Please check Term & Condition",
        backgroundColor: ColorRes.black,
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 1),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        dismissDirection: DismissDirection.horizontal,
      );
      i++;
    }
    notifyListeners();
    return i == 0 ? true : false;
  }

  void onSubmitBtnTap() {
    bool validation = isValid();
    notifyListeners();
    if (validation) {
      ApiProvider()
          .addReport(
              reason, explainMoreController.text, registrationUserData?.id)
          .then(
        (value) {
          SnackBarWidget().snackBarWidget('${value.message}');
          Get.back();
        },
      );
    }
  }
}
