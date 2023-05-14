import 'package:flutter/material.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class TopBarRedeemScreen extends StatelessWidget {
  final VoidCallback onBackBtnTap;

  const TopBarRedeemScreen({Key? key, required this.onBackBtnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 45, 23, 18),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                AppRes.redeem,
                style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  // fontFamily: FontRes.bold,
                ),
              ),
              Text(
                AppRes.requests,
                style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontFamily: FontRes.bold,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: onBackBtnTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 37,
              width: 37,
              padding: const EdgeInsets.only(right: 3),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetRes.backButton),
                ),
              ),
              child: Center(
                child: Image.asset(
                  AssetRes.backArrow,
                  height: 14,
                  width: 7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
