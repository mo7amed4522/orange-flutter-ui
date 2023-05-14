import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class ReportSheetViewModel extends BaseViewModel {
  void init() {
    fullName = Get.arguments[0][FirebaseConst.fullName];
    city = Get.arguments[1][FirebaseConst.city];
    userImage = Get.arguments[2][FirebaseConst.userImage];
    age = Get.arguments[3][FirebaseConst.age];
  }

  String fullName = '';
  String city = '';
  String userImage = '';
  String age = '';

  TextEditingController explainController = TextEditingController();
  FocusNode explainMoreFocus = FocusNode();
  String explainMoreError = '';
  String reason = AppRes.cyberbullying;
  List<String> reasonList = [
    AppRes.cyberbullying,
    AppRes.harassment,
    AppRes.personalHarassment,
    AppRes.inappropriateContent
  ];
  bool? isCheckBox = false;
  bool isShowDown = false;

  void onCheckBoxChange(bool? value) {
    isCheckBox = value;
    explainMoreFocus.unfocus();
    notifyListeners();
  }

  void onReasonTap() {
    isShowDown = !isShowDown;
    explainMoreFocus.unfocus();
    notifyListeners();
  }

  void onBackBtnClick() {
    Get.back();
  }

  void onReasonChange(String value) {
    reason = value;
    isShowDown = !isShowDown;
    notifyListeners();
  }
}
