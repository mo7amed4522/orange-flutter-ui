import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/buttons.dart';
import 'package:orange_ui/common/widgets/starting_profile_top_text.dart';
import 'package:orange_ui/screen/starting_profile_screen/starting_profile_screen_view_model.dart';
import 'package:orange_ui/screen/starting_profile_screen/widet/text_field_area/text_fields_area.dart';
import 'package:orange_ui/screen/starting_profile_screen/widet/top_card_area.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class StartingProfileScreen extends StatelessWidget {
  const StartingProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartingProfileScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => StartingProfileScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: GestureDetector(
            onTap: model.onAllScreenTap,
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const StartingProfileTopText(),
                  const SizedBox(height: 16),
                  TopCardArea(fullName: model.fullName),
                  const SizedBox(height: 18),
                  TextFieldsArea(
                    addressController: model.addressController,
                    bioController: model.bioController,
                    ageController: model.ageController,
                    gender: model.gender,
                    addressFocus: model.addressFocus,
                    ageFocus: model.ageFocus,
                    bioFocus: model.bioFocus,
                    onGenderTap: model.onGenderTap,
                    onTextFieldTap: model.onAllScreenTap,
                    showDropdown: model.showDropdown,
                    onGenderChange: model.onGenderChange,
                    bioError: model.bioError,
                    addressError: model.addressError,
                    ageError: model.ageError,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 22),
                    child: SubmitButton2(
                        title: AppRes.next, onTap: model.onNextTap),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
