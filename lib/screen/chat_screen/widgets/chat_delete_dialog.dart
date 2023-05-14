import 'package:flutter/material.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class ChatDeleteDialog extends StatelessWidget {
  final VoidCallback onCancelBtnCLick;
  final VoidCallback onDeleteBtnClick;

  const ChatDeleteDialog(
      {Key? key,
      required this.onCancelBtnCLick,
      required this.onDeleteBtnClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 2.5,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                AppRes.deleteMessage,
                style: TextStyle(fontSize: 18, fontFamily: FontRes.extraBold),
              ),
              const Spacer(),
              const Text(
                AppRes.areYouSureYouEtc,
                style: TextStyle(
                    color: ColorRes.grey,
                    fontFamily: FontRes.medium,
                    fontSize: 15),
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: onCancelBtnCLick,
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
                    onTap: onDeleteBtnClick,
                    child: const Text(
                      AppRes.deleteCap,
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
