import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/incoming_call_screen/incoming_call_screen_view_model.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class IncomingCallScreen extends StatelessWidget {
  const IncomingCallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IncomingCallScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => IncomingCallScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                AssetRes.profile30,
                height: Get.height,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 45),
                        Image.asset(
                          AssetRes.themeLabelWhite,
                          height: 30,
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          AppRes.incomingVideoCall,
                          style: TextStyle(
                            fontFamily: FontRes.regular,
                            color: ColorRes.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 39),
                        Container(
                          padding: const EdgeInsets.all(8.5),
                          height: Get.height * 0.3,
                          width: Get.height * 0.3,
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                              AssetRes.profile29,
                              height: Get.height * 0.3 - 8,
                              width: Get.height * 0.3 - 8,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.068),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppRes.nataliaNora,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: FontRes.bold,
                                color: ColorRes.white,
                              ),
                            ),
                            const Text(
                              AppRes.age24,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: FontRes.regular,
                                color: ColorRes.white,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Image.asset(
                              AssetRes.tickMark,
                              height: 18,
                              width: 18,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          AppRes.lasVegasUsa,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontRes.regular,
                            color: ColorRes.white,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.05),
                        const Text(
                          AppRes.calling,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontRes.regular,
                            color: ColorRes.white,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: model.onCallCut,
                              child: Container(
                                height: 74,
                                width: 74,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorRes.red9,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    AssetRes.callEnd,
                                    color: ColorRes.white,
                                    height: 16,
                                    width: 37,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: model.onCallReceive,
                              child: Container(
                                height: 74,
                                width: 74,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorRes.green3,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    AssetRes.callUp,
                                    color: ColorRes.white,
                                    height: 37,
                                    width: 37,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
