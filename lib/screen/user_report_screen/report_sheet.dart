import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/user_report_screen/report_sheet_view_model.dart';
import 'package:orange_ui/screen/user_report_screen/widget/report_bottomsheet.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:stacked/stacked.dart';

class UserReportSheet extends StatelessWidget {
  const UserReportSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportSheetViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => ReportSheetViewModel(),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            model.explainMoreFocus.unfocus();
          },
          child: ReportBottomSheet(
            onBackBtnTap: model.onBackBtnClick,
            showDropdown: model.isShowDown,
            onReasonTap: model.onReasonTap,
            reason: model.reason,
            checkBoxValue: model.isCheckBox,
            explainMoreController: model.explainController,
            reasonList: model.reasonList,
            onCheckBoxChange: model.onCheckBoxChange,
            onReasonChange: model.onReasonChange,
            onSubmitBtnTap: model.onSubmitBtnTap,
            fullName:
                '${Get.arguments[AppRes.reportName]}  ( ${Get.arguments[AppRes.reportAge]} )',
            profileImage: Get.arguments[AppRes.reportImage],
            address: Get.arguments[AppRes.reportAddress] ?? '',
            explainMoreFocus: model.explainMoreFocus,
            explainMoreError: model.explainMoreError,
            onTextFieldTap: model.onAllScreenTap,
            onTermAndConditionClick: model.onTermAndConditionClick,
            explainError: model.isExplainError,
          ),
        );
      },
    );
  }
}
