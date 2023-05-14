import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class DocTypeDropDown extends StatelessWidget {
  final String docType;
  final Function(String value) onChange;

  const DocTypeDropDown({
    Key? key,
    required this.docType,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: ColorRes.white, boxShadow: [
        BoxShadow(
          color: ColorRes.grey2.withOpacity(0.35),
          offset: const Offset(0, 2),
          blurRadius: 3,
        ),
        BoxShadow(
          color: ColorRes.grey2.withOpacity(0.35),
          offset: const Offset(2, 0),
          blurRadius: 3,
        ),
      ]),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  onChange(AppRes.drivingLicence);
                },
                child: Container(
                  height: 30,
                  width: Get.width - 80,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppRes.drivingLicence,
                    style: TextStyle(
                      color: docType == AppRes.drivingLicence
                          ? ColorRes.orange
                          : ColorRes.grey,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onChange(AppRes.idCard);
                },
                child: Container(
                  height: 30,
                  width: Get.width - 80,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppRes.idCard,
                    style: TextStyle(
                      color: docType == AppRes.idCard
                          ? ColorRes.orange
                          : ColorRes.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
