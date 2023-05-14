import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/buttons.dart';
import 'package:orange_ui/common/widgets/starting_profile_top_text.dart';
import 'package:orange_ui/screen/select_hobbies_screen/select_hobbies_screen_view_model.dart';
import 'package:orange_ui/screen/select_hobbies_screen/widgets/hobbies_clips.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class SelectHobbiesScreen extends StatelessWidget {
  const SelectHobbiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectHobbiesScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => SelectHobbiesScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 20),
              const StartingProfileTopText(),
              SizedBox(height: Get.height * 0.0593),
              Expanded(
                child: Center(
                  child: HobbiesClips(
                    hobbiesList: model.hobbiesList!,
                    selectedList: model.selectedList,
                    onClipTap: model.onClipTap,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child:
                    SubmitButton2(title: AppRes.next, onTap: model.onNextTap),
              ),
              const SizedBox(height: 27),
              InkWell(
                onTap: model.onSkipTap,
                child: const Text(
                  AppRes.skip,
                  style: TextStyle(
                    color: ColorRes.dimGrey2,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 27),
            ],
          ),
        );
      },
    );
  }
}
