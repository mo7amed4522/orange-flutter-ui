import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/model/chat_and_live_stream/chat.dart';
import 'package:orange_ui/screen/webview_screen/webview_screen.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class ReportSheetViewModel extends BaseViewModel {
  void init() {}

  String fullName = '';
  String city = '';
  String userImage = '';
  String age = '';

  Conversation? conversation;

  TextEditingController explainController = TextEditingController();
  FocusNode explainMoreFocus = FocusNode();
  String explainMoreError = '';
  String reason = AppRes.cyberbullying;
  bool isExplainError = false;
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

  void onAllScreenTap() {
    isShowDown = false;
    notifyListeners();
  }

  void onTermAndConditionClick() {
    Get.to(() => const WebViewScreen(
          appBarTitle: AppRes.termsOfUse,
          url: ConstRes.aTermsOfUse,
        ));
  }

  bool isValid() {
    int i = 0;
    explainMoreFocus.unfocus();
    isExplainError = false;

    if (explainController.text == '') {
      isExplainError = true;
      explainMoreError = AppRes.enterFullReason;
      i++;
      return false;
    }
    if (isCheckBox == false) {
      Get.rawSnackbar(
        message: AppRes.pleaseCheckTerm,
        backgroundColor: ColorRes.black,
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
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
          .addReport(reason, explainController.text, conversation?.user?.userid)
          .then(
        (value) {
          SnackBarWidget().snackBarWidget('${value.message}');
          Get.back();
        },
      );
    }
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
