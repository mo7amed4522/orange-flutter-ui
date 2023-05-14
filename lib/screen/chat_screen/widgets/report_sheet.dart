import 'package:flutter/material.dart';
import 'package:orange_ui/screen/chat_screen/view_model/report_sheet_view_model.dart';
import 'package:orange_ui/screen/report_user_screen/widget/report_bottomsheet.dart';
import 'package:stacked/stacked.dart';

class ReportSheet extends StatelessWidget {
  const ReportSheet({Key? key}) : super(key: key);

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
            explainMore: model.explainController,
            reasonList: model.reasonList,
            onCheckBoxChange: model.onCheckBoxChange,
            onReasonChange: model.onReasonChange,
            onSubmitBtnTap: model.onBackBtnClick,
            fullName: '${model.fullName}  ${model.age}',
            profileImage: model.userImage,
            address: model.city,
            explainMoreFocus: model.explainMoreFocus,
            explainMoreError: model.explainMoreError,
          ),
        );
      },
    );
  }
}
