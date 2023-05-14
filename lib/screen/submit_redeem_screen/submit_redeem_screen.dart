import 'package:flutter/material.dart';
import 'package:orange_ui/screen/submit_redeem_screen/submit_redeem_screen_view_model.dart';
import 'package:orange_ui/screen/submit_redeem_screen/widgets/center_area_submit_redeem_screen.dart';
import 'package:orange_ui/screen/submit_redeem_screen/widgets/top_area_submit_redeem_screen.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class SubmitRedeemScreen extends StatelessWidget {
  const SubmitRedeemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubmitRedeemScreenViewModel>.reactive(
        onModelReady: (model) {
          model.init();
        },
        viewModelBuilder: () => SubmitRedeemScreenViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            body: Column(
              children: [
                TopAreaSubmitRedeemScreen(onBackBtnTap: model.onBackBtnTap),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: MediaQuery.of(context).size.width,
                  color: ColorRes.grey5,
                ),
                CenterAreaSubmitRedeemScreen(
                  wallet: model.coinValue,
                  onSubmitBtnTap: model.onSubmitBtnTap,
                  accountDetailController: model.accountDetailController,
                  onPaymentChange: model.onPaymentChange,
                  paymentList: model.paymentList,
                  payment: model.paymentGateway,
                  accountError: model.accountError,
                  isEmpty: model.isEmpty,
                ),
              ],
            ),
          );
        });
  }
}
