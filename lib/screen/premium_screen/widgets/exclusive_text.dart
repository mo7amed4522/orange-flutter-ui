import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class ExclusiveText extends StatelessWidget {
  final PageController pageController;
  final List<String> descTitle;
  final List<String> descSubTitle;
  final Function(int index) onPageChange;

  const ExclusiveText({
    Key? key,
    required this.pageController,
    required this.descTitle,
    required this.descSubTitle,
    required this.onPageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 144,
          width: Get.width,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: descTitle.length,
            controller: pageController,
            onPageChanged: onPageChange,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 57,
                    width: 57,
                    decoration: const BoxDecoration(
                      color: ColorRes.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        AssetRes.getStarted4Camera,
                        height: 42,
                        width: 42,
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  Text(
                    descTitle[index],
                    style: const TextStyle(
                      color: ColorRes.white,
                      fontSize: 16,
                      fontFamily: FontRes.heavy,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    descSubTitle[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorRes.white.withOpacity(0.80),
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 3,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: descTitle.length,
            itemBuilder: (context, index) {
              return Container(
                height: 3,
                width: 22.17,
                margin: EdgeInsets.only(
                  right: index != (descTitle.length - 1) ? 2 : 0,
                ),
                decoration: BoxDecoration(
                  color: index != pageController.page!.round()
                      ? ColorRes.white.withOpacity(0.30)
                      : ColorRes.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
