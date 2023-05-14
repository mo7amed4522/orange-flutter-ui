import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/randoms_video_call_screen/randoms_video_call_screen_view_model.dart';
import 'package:orange_ui/screen/randoms_video_call_screen/widgets/bottom_area.dart';
import 'package:orange_ui/screen/randoms_video_call_screen/widgets/top_bar_area.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class RandomsVideoCallScreen extends StatelessWidget {
  const RandomsVideoCallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandomsVideoCallScreenVIewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => RandomsVideoCallScreenVIewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AssetRes.profile17),
              ),
            ),
            child: Column(
              children: [
                TopBarArea(onBackBtnTap: model.onBackBtnTap),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: Get.width,
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: model.onCameraSwitch,
                        child: Container(
                          height: 47,
                          width: 47,
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorRes.black.withOpacity(0.33),
                          ),
                          child: Center(
                            child: Image.asset(AssetRes.camera2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: model.onSpeakerTap,
                        child: Container(
                          height: 47,
                          width: 47,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorRes.black.withOpacity(0.33),
                          ),
                          child: Center(
                            child: Image.asset(
                              AssetRes.speaker,
                              height: 18,
                              width: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                BottomArea(
                  onMoreBtnTap: model.onMoreBtnTap,
                  onCallEnd: model.onCallCut,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
