import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/color_res.dart';

class ReportReasonDropDownBox extends StatelessWidget {
  final String reason;
  final Function(String value) onChange;
  final List<String> reasonList;
  final Color backGroundColor;

  const ReportReasonDropDownBox({
    Key? key,
    required this.reason,
    required this.onChange,
    required this.reasonList,
    required this.backGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: backGroundColor,
      ),
      child: ListView.builder(
        itemCount: reasonList.length,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              onChange(reasonList[index]);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              height: 40,
              width: Get.width - 80,
              alignment: Alignment.centerLeft,
              child: Text(
                reasonList[index],
                style: TextStyle(
                  color: reason == reasonList[index]
                      ? ColorRes.white
                      : ColorRes.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
