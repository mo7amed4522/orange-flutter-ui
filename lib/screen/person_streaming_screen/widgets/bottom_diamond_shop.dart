import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orange_ui/model/get_diamond_pack.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class BottomDiamondShop extends StatefulWidget {
  final List<GetDiamondPackData>? diamondList;
  final Function(GetDiamondPackData? data) onDiamondPurchase;

  const BottomDiamondShop({
    Key? key,
    required this.diamondList,
    required this.onDiamondPurchase,
  }) : super(key: key);

  @override
  State<BottomDiamondShop> createState() => _BottomDiamondShopState();
}

class _BottomDiamondShopState extends State<BottomDiamondShop> {
  @override
  void initState() {
    const MethodChannel(ConstRes.aBubblyCamera)
        .setMethodCallHandler((payload) async {
      return;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 3,
          sigmaX: 3,
          tileMode: TileMode.mirror,
        ),
        child: Stack(
          children: [
            Container(
              width: Get.width,
              color: ColorRes.black.withOpacity(0.3),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              width: Get.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: AppRes.diamond,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 17,
                            fontFamily: FontRes.regular,
                          ),
                        ),
                        TextSpan(
                          text: " ${AppRes.shop}",
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 17,
                            fontFamily: FontRes.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: widget.diamondList?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.fromLTRB(17, 13, 9, 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ColorRes.white.withOpacity(0.14),
                          ),
                          child: Row(
                            children: [
                              Image.asset(AssetRes.diamond,
                                  height: 24, width: 24),
                              const SizedBox(width: 7),
                              Text(
                                "${widget.diamondList?[index].amount} ${AppRes.diamondsCamel}",
                                style: const TextStyle(
                                  color: ColorRes.white,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  widget.onDiamondPurchase(
                                    widget.diamondList?[index],
                                  );
                                },
                                child: Container(
                                  width: 131,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
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
                                      "${ConstRes.currency} ${widget.diamondList?[index].price}",
                                      style: const TextStyle(
                                        color: ColorRes.white,
                                        fontSize: 15,
                                        fontFamily: FontRes.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 23),
                  SizedBox(
                    width: Get.width / 1.7,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: AppRes.bayContinuingThePurchaseEtc,
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              fontFamily: FontRes.regular,
                            ),
                          ),
                          TextSpan(
                            text: AppRes.terms,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: ColorRes.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              fontFamily: FontRes.regular,
                            ),
                          ),
                          TextSpan(
                            text: " ${AppRes.and} ",
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              fontFamily: FontRes.regular,
                            ),
                          ),
                          TextSpan(
                            text: AppRes.privacyPolicy,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: ColorRes.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              fontFamily: FontRes.regular,
                            ),
                          ),
                          TextSpan(
                            text: " ${AppRes.automatically} ",
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              fontFamily: FontRes.regular,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
