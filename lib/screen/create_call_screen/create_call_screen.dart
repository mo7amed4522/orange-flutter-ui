import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/create_call_screen/create_call_screen_view_model.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class CreateCallScreen extends StatelessWidget {
  const CreateCallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateCallScreenViewModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => CreateCallScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                AssetRes.profile6,
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
                        const SizedBox(height: 41),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetRes.themeLabelWhite,
                              height: 25,
                              fit: BoxFit.fitHeight,
                            ),
                            const Text(
                              AppRes.videoCall,
                              style: TextStyle(
                                fontFamily: FontRes.regular,
                                color: ColorRes.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 42),
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: Get.height * 0.36,
                          width: Get.height * 0.36,
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
                              AssetRes.profile28,
                              height: Get.height * 0.36,
                              width: Get.height * 0.36,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.053),
                        InkWell(
                          onTap: model.onCallingTap,
                          child: Row(
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
                        SizedBox(height: Get.height * 0.06),
                        const Text(
                          AppRes.calling,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontRes.regular,
                            color: ColorRes.white,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.14),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.08),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: model.onCancelTap,
                            child: Container(
                              width: Get.width,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorRes.red5.withOpacity(0.35),
                              ),
                              child: const Center(
                                child: Text(
                                  AppRes.cancelCap,
                                  style: TextStyle(
                                    color: ColorRes.white,
                                    fontFamily: FontRes.bold,
                                    letterSpacing: 0.8,
                                  ),
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
            ],
          ),
        );
      },
    );
  }
}
