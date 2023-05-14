import 'package:flutter/material.dart';
import 'package:orange_ui/screen/live_stream_screen/widgets/center_area_livestream.dart';
import 'package:orange_ui/screen/live_stream_screen/widgets/live_strream_top_area.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

import 'live_stream_screen_view_model.dart';

class LiveStreamScreen extends StatelessWidget {
  const LiveStreamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LiveStreamScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => LiveStreamScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              LiveStreamTopArea(onBackBtnTap: model.onBackBtnTap),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                width: MediaQuery.of(context).size.width,
                color: ColorRes.grey5,
              ),
              CenterAreaLiveStream(
                aboutController: model.aboutController,
                languageController: model.languageController,
                onSubmitTap: model.onSubmitBtnTap,
                videoController: model.videoController,
                onAddBtnTap: model.onPlusBtnTap,
                onRemoveBtnTap: model.onRemoveBtnTap,
                onVideoControllerChange: model.onVideoControllerChange,
                onVideoChangeBtnTap: model.onVideoChangeBtnTap,
                onVideoPlayBtnTap: model.onVideoPlayBtnTap,
                onAttachBtnTap: model.onAttachBtnTap,
                videoImage: model.videoImageFile,
                isVideoAttach: model.isVideoAttach,
                controllers: model.socialProfileController,
                fieldCount: model.fieldCount,
                isAbout: model.isAbout,
                isIntroVideo: model.isIntroVideo,
                isLanguages: model.isLanguages,
                isSocialLink: model.isSocialLink,
                aboutFocus: model.aboutFocus,
                languageFocus: model.languageFocus,
                socialLinkFocus: model.socialLinksFocus,
              ),
            ],
          ),
        );
      },
    );
  }
}
