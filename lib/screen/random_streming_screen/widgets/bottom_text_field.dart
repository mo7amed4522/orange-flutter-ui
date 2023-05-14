import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class BottomTextField extends StatelessWidget {
  final TextEditingController commentController;
  final FocusNode commentFocus;
  final VoidCallback onMsgSend;

  const BottomTextField(
      {Key? key,
      required this.commentController,
      required this.onMsgSend,
      required this.commentFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: Get.width,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: ColorRes.black4.withOpacity(0.33),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(
                    fontSize: 13,
                    color: ColorRes.white.withOpacity(0.70),
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  controller: commentController,
                  focusNode: commentFocus,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: AppRes.comment,
                    contentPadding:
                        const EdgeInsets.only(left: 14, bottom: 10, top: 0),
                    hintStyle: TextStyle(
                      color: ColorRes.white.withOpacity(0.45),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: onMsgSend,
                child: Container(
                  height: 36,
                  width: 36,
                  padding: const EdgeInsets.fromLTRB(10, 9, 6, 9),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ColorRes.lightOrange1,
                        ColorRes.darkOrange,
                      ],
                    ),
                  ),
                  child: Image.asset(AssetRes.share),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
