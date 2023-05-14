import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class AddCoinSheet extends StatelessWidget {
  const AddCoinSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: ColorRes.white.withOpacity(0.3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: AppRes.diamondCap,
                      style: TextStyle(
                        color: ColorRes.black,
                        fontSize: 17,
                        fontFamily: FontRes.regular,
                      ),
                    ),
                    TextSpan(
                      text: " ${AppRes.shop}",
                      style: TextStyle(
                        color: ColorRes.black,
                        fontSize: 17,
                        fontFamily: FontRes.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 15,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Material(
                      elevation: 5,
                      color: ColorRes.transparent,
                      shadowColor: ColorRes.transparent,
                      surfaceTintColor: ColorRes.transparent,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 54,
                              width: Get.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(AssetRes.map1,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Container(
                              height: 54,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: ColorRes.darkGrey5.withOpacity(1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            SizedBox(
                              height: 54,
                              width: Get.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 13, right: 3),
                                    child: Row(
                                      children: [
                                        Image.asset(AssetRes.diamond,
                                            height: 24, width: 24),
                                        const SizedBox(width: 7),
                                        const Text(
                                          "10 ${AppRes.diamondsCamel}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: ColorRes.lightGrey5,
                                              fontFamily: FontRes.medium),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          onTap: () {
                                            // onDiamondPurchase(diamondList?[index]);
                                          },
                                          child: Container(
                                            width: 131,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  ColorRes.lightOrange1,
                                                  ColorRes.darkOrange,
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${ConstRes.currency} 20",
                                                style: const TextStyle(
                                                  color: ColorRes.white,
                                                  fontSize: 15,
                                                  fontFamily: FontRes.semiBold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: Get.width / 1.7,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: AppRes.bayContinuingThePurchaseEtc,
                        style: TextStyle(
                          color: ColorRes.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          fontFamily: FontRes.regular,
                        ),
                      ),
                      TextSpan(
                        text: AppRes.terms,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: ColorRes.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          fontFamily: FontRes.regular,
                        ),
                      ),
                      TextSpan(
                        text: " ${AppRes.and} ",
                        style: TextStyle(
                          color: ColorRes.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          fontFamily: FontRes.regular,
                        ),
                      ),
                      TextSpan(
                        text: AppRes.privacyPolicy,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: ColorRes.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          fontFamily: FontRes.regular,
                        ),
                      ),
                      TextSpan(
                        text: " ${AppRes.automatically} ",
                        style: TextStyle(
                          color: ColorRes.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          fontFamily: FontRes.regular,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
