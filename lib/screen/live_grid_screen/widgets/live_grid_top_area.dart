import 'package:flutter/material.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class LiveGridTopArea extends StatelessWidget {
  final VoidCallback onBackBtnTap;
  final VoidCallback onGoLiveTap;
  final RegistrationUserData? userData;

  const LiveGridTopArea(
      {Key? key,
      required this.onBackBtnTap,
      required this.onGoLiveTap,
      this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 19),
        child: Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: onBackBtnTap,
              child: Container(
                height: 37,
                width: 37,
                padding: const EdgeInsets.fromLTRB(11, 11, 14, 11),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetRes.backButton),
                  ),
                ),
                child: Image.asset(
                  AssetRes.backArrow,
                ),
              ),
            ),
            const SizedBox(width: 13),
            Image.asset(AssetRes.themeLabel,
                height: 30, width: 100, fit: BoxFit.cover),
            const Text(
              " ${AppRes.live}",
              style: TextStyle(
                fontSize: 20,
                color: ColorRes.black2,
              ),
            ),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                if (userData?.isFake != 1) {
                  userData?.canGoLive == 0
                      ? SnackBarWidget().snackBarWidget(
                          'Please apply for live stream from livestream dashboard from profile!')
                      : userData?.canGoLive == 1
                          ? SnackBarWidget().snackBarWidget(
                              'Your Application is pending please wait')
                          : onGoLiveTap();
                } else {
                  onGoLiveTap();
                }
              },
              child: Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorRes.lightOrange1,
                      ColorRes.darkOrange,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AssetRes.sun,
                      height: 21,
                      width: 21,
                      color: ColorRes.white,
                    ),
                    const SizedBox(width: 7.62),
                    const Text(
                      AppRes.goLive,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 14,
                        fontFamily: FontRes.extraBold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
