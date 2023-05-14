import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orange_ui/model/fetch_redeem_request.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class CenterAreaRedeemScreen extends StatelessWidget {
  final List<RedeemRequestData>? redeemData;

  const CenterAreaRedeemScreen({Key? key, this.redeemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: redeemData!.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetRes.themeLabel, width: 150),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  AppRes.noRedeemData,
                  style: TextStyle(
                      color: ColorRes.grey14,
                      fontFamily: FontRes.medium,
                      fontSize: 16),
                ),
              ],
            )
          : ListView.builder(
              itemCount: redeemData?.length,
              itemBuilder: (context, index) {
                RedeemRequestData? data = redeemData?[index];
                return Container(
                  width: Get.width,
                  margin: const EdgeInsets.only(left: 7, right: 7, bottom: 5),
                  padding: const EdgeInsets.only(
                      top: 10, left: 11, bottom: 11, right: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorRes.grey26,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${data?.requestId}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: FontRes.semiBold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.fromLTRB(16, 5, 13, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: data?.status == 0
                                  ? ColorRes.lightpink.withOpacity(0.20)
                                  : ColorRes.lightgreen.withOpacity(0.22),
                            ),
                            child: Center(
                              child: Text(
                                data?.status == 0
                                    ? AppRes.processing
                                    : AppRes.complete,
                                style: TextStyle(
                                  color: data?.status == 0
                                      ? ColorRes.lightorange
                                      : ColorRes.darkgreen,
                                  fontSize: 12,
                                  fontFamily: FontRes.semiBold,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            DateFormat(AppRes.dMY)
                                .format(DateTime.parse('${data?.createdAt}')),
                            style: const TextStyle(
                              fontSize: 14,
                              color: ColorRes.grey27,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          const Text(
                            AppRes.diamond1,
                            style: TextStyle(
                                color: ColorRes.grey27,
                                fontSize: 14,
                                fontFamily: FontRes.regular),
                          ),
                          Text(
                            ' ${data?.coinAmount}',
                            style: const TextStyle(
                              color: ColorRes.grey28,
                              fontSize: 14,
                              fontFamily: FontRes.semiBold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Visibility(
                        visible: data?.status == 0 ? false : true,
                        child: Row(
                          children: [
                            const Text(
                              AppRes.amount,
                              style: TextStyle(
                                  color: ColorRes.grey27, fontSize: 14),
                            ),
                            Text(
                              ' ${ConstRes.currency}${data?.amountPaid}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: ColorRes.grey28,
                                fontFamily: FontRes.semiBold,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
