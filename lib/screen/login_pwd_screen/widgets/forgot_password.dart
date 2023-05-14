import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class ForgotPassword extends StatelessWidget {
  final Function(TextEditingController controller) resetBtnClick;
  final FocusNode resetFocusNode;
  final String? email;

  const ForgotPassword(
      {Key? key,
      required this.resetBtnClick,
      required this.resetFocusNode,
      this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController forgotEditController =
        TextEditingController(text: email);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: AspectRatio(
          aspectRatio: 1 / 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 15.0, top: 15, left: 15, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: ColorRes.black2,
                            fontSize: 18,
                            fontFamily: FontRes.semiBold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        color: ColorRes.darkGrey3,
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: ColorRes.darkGrey3,
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Enter your mail on which you have \ncreated an account. We will send a link \nto reset your password",
                  style: TextStyle(color: ColorRes.dimGrey3, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: Get.width / 15),
                child: const Text(
                  "Email",
                  style: TextStyle(
                      color: ColorRes.darkGrey3, fontFamily: FontRes.semiBold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: ColorRes.lightGrey3,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  controller: forgotEditController,
                  focusNode: resetFocusNode,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  style: const TextStyle(
                      color: ColorRes.dimGrey3, fontFamily: FontRes.medium),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              const Spacer(),
              InkWell(
                onTap: () => resetBtnClick(forgotEditController),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorRes.orange,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                        color: ColorRes.white, fontFamily: FontRes.semiBold),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
