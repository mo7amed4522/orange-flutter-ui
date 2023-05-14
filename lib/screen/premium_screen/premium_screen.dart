import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:orange_ui/screen/premium_screen/premium_screen_view_model.dart';
import 'package:orange_ui/screen/premium_screen/widgets/exclusive_text.dart';
import 'package:orange_ui/screen/premium_screen/widgets/premium_cards.dart';
import 'package:orange_ui/screen/premium_screen/widgets/top_bar_area.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PremiumScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => PremiumScreenViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            model.onBackBtnTap();
            return true;
          },
          child: Scaffold(
            body: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AssetRes.loginBG),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                child: Column(
                  children: [
                    TopBarArea(onBackBtnTap: model.onBackBtnTap),
                    model.isLoading == false
                        ? Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  const SizedBox(height: 36),
                                  ExclusiveText(
                                    pageController: model.pageController,
                                    descSubTitle: model.descSubtitle,
                                    descTitle: model.descTitle,
                                    onPageChange: model.onExclusivePageChange,
                                  ),
                                  const SizedBox(height: 18),
                                  PremiumCards(
                                    selectedOffer: model.selectedOffer,
                                    onOfferSelect: model.onOfferSelect,
                                    packageData: model.packageData,
                                  ),
                                  const SizedBox(height: 23),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 11),
                                    child: InkWell(
                                      onTap: model.onContinueTap,
                                      child: Container(
                                        height: 44,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              ColorRes.lightOrange1,
                                              ColorRes.darkOrange,
                                            ],
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            AppRes.continueCap,
                                            style: TextStyle(
                                              color: ColorRes.white,
                                              fontSize: 15,
                                              fontFamily: FontRes.bold,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  InkWell(
                                    onTap: model.onNoThanksTap,
                                    child: Text(
                                      AppRes.noThanks,
                                      style: TextStyle(
                                        color: ColorRes.white.withOpacity(0.70),
                                        fontFamily: FontRes.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 27),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "${AppRes.premiumWarning} ",
                                            style: TextStyle(
                                              color: ColorRes.white,
                                              fontSize: 10,
                                              fontFamily: FontRes.regular,
                                            ),
                                          ),
                                          TextSpan(
                                            text: AppRes.terms,
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: ColorRes.white,
                                              fontSize: 10,
                                              fontFamily: FontRes.regular,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " ${AppRes.and} ",
                                            style: TextStyle(
                                              color: ColorRes.white,
                                              fontSize: 10,
                                              fontFamily: FontRes.regular,
                                            ),
                                          ),
                                          TextSpan(
                                            text: AppRes.privacyPolicy,
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: ColorRes.white,
                                              fontSize: 10,
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
                          )
                        : Expanded(
                            child: Lottie.asset(
                              AssetRes.loadingLottie,
                              width: 90,
                              height: 90,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
