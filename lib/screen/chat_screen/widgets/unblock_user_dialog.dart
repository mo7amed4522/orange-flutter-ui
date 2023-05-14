import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class UnblockUserDialog extends StatelessWidget {
  final VoidCallback unblockUser;
  final VoidCallback onCancelBtnClick;
  final String? name;

  const UnblockUserDialog(
      {Key? key,
      required this.onCancelBtnClick,
      required this.unblockUser,
      this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AspectRatio(
        aspectRatio: 2.7,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const Spacer(),
              Text(
                '${AppRes.unBlock} $name ${AppRes.toSendMessage}',
                style: const TextStyle(
                    color: ColorRes.grey14,
                    fontSize: 16,
                    fontFamily: FontRes.medium),
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: onCancelBtnClick,
                    splashColor: ColorRes.transparent,
                    highlightColor: ColorRes.transparent,
                    child: const Text(
                      AppRes.cancelCap,
                      style: TextStyle(
                          color: ColorRes.grey, fontFamily: FontRes.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      unblockUser();
                      Get.back();
                    },
                    child: const Text(
                      AppRes.unblockCap,
                      style: TextStyle(
                          color: ColorRes.orange2, fontFamily: FontRes.bold),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
