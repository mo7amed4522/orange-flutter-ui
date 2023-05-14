import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:orange_ui/screen/edit_profile_screen/edit_profile_screen_view_model.dart';
import 'package:orange_ui/screen/edit_profile_screen/widgets/image_list_area.dart';
import 'package:orange_ui/screen/edit_profile_screen/widgets/text_field_area/text_fields_area.dart';
import 'package:orange_ui/screen/edit_profile_screen/widgets/top_bar_area.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => EditProfileScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: GestureDetector(
            onTap: model.onAllScreenTap,
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  Column(
                    children: [
                      TopBarArea(onBackBtnTap: model.onBackBtnTap),
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: MediaQuery.of(context).size.width,
                        color: ColorRes.grey5,
                      ),
                      model.isLoading
                          ? Expanded(
                              child: Lottie.asset(AssetRes.loadingLottie,
                                  height: 70, width: 70),
                            )
                          : Expanded(
                              child: SingleChildScrollView(
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 16),
                                    ImageListArea(
                                      imageList: model.imageList,
                                      onImgRemove: model.onImageRemove,
                                      onAddBtnTap: model.onImageAdd,
                                    ),
                                    TextFieldsArea(
                                      model: model,
                                    ),
                                  ],
                                ),
                              ),
                            )
                    ],
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
