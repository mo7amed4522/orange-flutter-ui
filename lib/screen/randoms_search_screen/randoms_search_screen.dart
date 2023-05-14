import 'package:flutter/material.dart';
import 'package:orange_ui/screen/randoms_search_screen/randoms_search_screen_view_model.dart';
import 'package:orange_ui/screen/randoms_search_screen/widgets/bottom_area.dart';
import 'package:orange_ui/screen/randoms_search_screen/widgets/profile_pic_area.dart';
import 'package:orange_ui/screen/randoms_search_screen/widgets/top_bar_area.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class RandomsSearchScreen extends StatelessWidget {
  const RandomsSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandomsSearchScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => RandomsSearchScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              TopBarArea(
                onBackBtnTap: model.onBackBtnTap,
              ),
              const SizedBox(height: 27),
              ProfilePicArea(
                isLoading: model.isLoading,
                userData: model.userData,
                pageController: model.pageController,
                onLeftBtnClick: model.onLeftBtnClick,
                onRightBtnClick: model.onRightBtnClick,
                onYoutubeTap: model.onYoutubeTap,
                onFacebookTap: model.onFBTap,
                onInstagramTap: model.onInstagramTap,
                onLiveBtnTap: model.onLiveBtnTap,
                onImageTap: model.onImageTap,
                isSocialBtnVisible: model.isSocialBtnVisible,
              ),
              Visibility(
                visible: model.isLoading == true ? true : false,
                child: const Text(
                  AppRes.searching,
                  style: TextStyle(
                    fontFamily: FontRes.bold,
                    fontSize: 22,
                    color: ColorRes.darkGrey7,
                  ),
                ),
              ),
              const Spacer(),
              BottomArea(
                onSearchingTextTap: model.onSearchingTextTap,
                onCancelTap: model.onCancelTap,
                onNextTap: model.onNextTap,
                isLoading: model.isLoading,
              ),
            ],
          ),
        );
      },
    );
  }
}
