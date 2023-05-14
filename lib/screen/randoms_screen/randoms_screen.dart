import 'package:flutter/material.dart';
import 'package:orange_ui/screen/randoms_screen/randoms_screen_view_model.dart';
import 'package:orange_ui/screen/randoms_screen/widgets/bottom_buttons.dart';
import 'package:orange_ui/screen/randoms_screen/widgets/profile_pic_area.dart';
import 'package:orange_ui/screen/randoms_screen/widgets/top_bar_area.dart';
import 'package:stacked/stacked.dart';

class RandomsScreen extends StatelessWidget {
  const RandomsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandomsScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => RandomsScreenViewModel(),
      builder: (context, model, child) {
        return Column(
          children: [
            TopBarArea(
              onNotificationTap: model.onNotificationTap,
              onSearchBtnTap: model.onSearchBtnTap,
            ),
            const SizedBox(height: 27),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfilePicArea(
                        data: model.data, isLoading: model.isLoading),
                    BottomButtons(
                      bannerAd: model.bannerAd,
                      genderList: model.genderList,
                      selectedGender: model.selectedGender,
                      onGenderSelect: model.onGenderChange,
                      onMatchingStart: model.onStartMatchingTap,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
