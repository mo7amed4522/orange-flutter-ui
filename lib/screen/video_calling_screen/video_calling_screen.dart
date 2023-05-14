import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/video_calling_screen/video_calling_screen_view_model.dart';
import 'package:orange_ui/screen/video_calling_screen/widgets/video_call_bottom_area.dart';
import 'package:orange_ui/screen/video_calling_screen/widgets/video_call_top_bar.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class VideoCallingScreen extends StatelessWidget {
  const VideoCallingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoCallingScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => VideoCallingScreenViewModel(),
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
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  VideoCallTopBar(
                    onBackBtnTap: model.onBackBtnTap,
                    onMoreBtnTap: model.onMoreBtnTap,
                  ),
                  const SizedBox(height: 15),
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
                  VideoCallBottomArea(
                    onCallEnd: model.onCallCut,
                    onSmallImageTap: model.onSmallImageTap,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
