import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class TopBarArea extends StatelessWidget {
  final VoidCallback onBackBtnTap;

  const TopBarArea({Key? key, required this.onBackBtnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 46, 10, 0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 37,
                width: Get.width,
                child: Row(
                  children: [
                    InkWell(
                      onTap: onBackBtnTap,
                      child: Container(
                        height: 37,
                        width: 37,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorRes.white.withOpacity(0.20),
                        ),
                        child: Center(
                          child: Image.asset(
                            AssetRes.backArrow,
                            color: ColorRes.white,
                            height: 14,
                            width: 7,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    AppRes.go,
                    style: TextStyle(
                      color: ColorRes.white,
                      fontSize: 19,
                    ),
                  ),
                  Text(
                    " ${AppRes.premium}",
                    style: TextStyle(
                      color: ColorRes.white,
                      fontFamily: FontRes.bold,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 19),
          Container(
            height: 0.5,
            width: Get.width,
            color: ColorRes.white,
          ),
        ],
      ),
    );
  }
}
