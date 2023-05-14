import 'package:flutter/material.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class OptionsTopBar extends StatelessWidget {
  final VoidCallback onBackBtnTap;

  const OptionsTopBar({Key? key, required this.onBackBtnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 45, 0, 18),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                AppRes.options,
                style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontFamily: FontRes.bold,
                ),
              ),
              SizedBox(width: 23),
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
