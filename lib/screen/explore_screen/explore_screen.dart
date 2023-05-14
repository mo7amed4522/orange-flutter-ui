import 'package:flutter/material.dart';
import 'package:orange_ui/screen/explore_screen/explore_screen_view_model.dart';
import 'package:orange_ui/screen/explore_screen/widgets/bottom_bottons.dart';
import 'package:orange_ui/screen/explore_screen/widgets/explore_top_area.dart';
import 'package:orange_ui/screen/explore_screen/widgets/full_image_view.dart';
import 'package:stacked/stacked.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExploreScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => ExploreScreenViewModel(),
      builder: (context, model, child) {
        return Column(
          children: [
            ExploreTopArea(
              onNotificationTap: model.onNotificationTap,
              onSearchTap: model.onSearchTap,
              onTitleTap: model.onTitleTap,
            ),
            const SizedBox(
              height: 20,
            ),
            FullImageView(
              userData: model.userData,
              userController: model.userController,
              onLiveBtnTap: model.onLiveBtnTap,
              onImageTap: model.onImageTap,
              onYoutubeTap: model.onYoutubeTap,
              onFacebookTap: model.onFBTap,
              onInstagramTap: model.onInstagramTap,
              isLoading: model.isLoading,
              onIndexChange: model.onIndexChange,
              isSocialBtnVisible: model.isSocialBtnVisible,
            ),
            const SizedBox(height: 26),
            BottomButtons(
              onPlayBtnTap: model.onPlayButtonTap,
              onNextBtnTap: model.onNextButtonTap,
              onEyeTap: model.onEyeButtonTap,
            ),
            const SizedBox(height: 26),
          ],
        );
      },
    );
  }
}
