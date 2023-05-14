import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/full_image_view_shimmer.dart';
import 'package:orange_ui/common/widgets/live_icon.dart';
import 'package:orange_ui/common/widgets/profile_detail_card.dart';
import 'package:orange_ui/common/widgets/social_icon.dart';
import 'package:orange_ui/common/widgets/top_story_line.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/shimmer_screen/shimmer_screen.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class FullImageView extends StatelessWidget {
  final List<RegistrationUserData>? userData;
  final VoidCallback onLiveBtnTap;
  final VoidCallback onImageTap;
  final VoidCallback onInstagramTap;
  final VoidCallback onFacebookTap;
  final VoidCallback onYoutubeTap;
  final bool isLoading;
  final SwiperController userController;
  final Function(int index) onIndexChange;
  final bool Function(String? value) isSocialBtnVisible;

  const FullImageView(
      {Key? key,
      this.userData,
      required this.onLiveBtnTap,
      required this.onImageTap,
      required this.onInstagramTap,
      required this.onFacebookTap,
      required this.onYoutubeTap,
      required this.isLoading,
      required this.userController,
      required this.onIndexChange,
      required this.isSocialBtnVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const FullImageViewShimmer();
    } else {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 17),
          child: AspectRatio(
            aspectRatio: 1 / 1.30,
            child: Swiper(
              controller: userController,
              duration: 500,
              itemCount: userData?.length ?? 0,
              physics: const NeverScrollableScrollPhysics(),
              onIndexChanged: onIndexChange,
              itemBuilder: (context, currentProfileIndex) {
                List<Images>? imagesProfile =
                    userData?[currentProfileIndex].images;
                final PageController pageController = PageController();
                return Stack(
                  children: [
                    imagesProfile == null || imagesProfile.isEmpty
                        ? Container(
                            width: double.infinity,
                            height: Get.height,
                            decoration: BoxDecoration(
                              color: ColorRes.lightGrey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(AssetRes.imageWarning),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: PageView.builder(
                              controller: pageController,
                              itemCount:
                                  userData?[currentProfileIndex].images?.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, currentImageIndex) {
                                return Stack(
                                  children: [
                                    Image.network(
                                      '${ConstRes.aImageBaseUrl}${imagesProfile[currentImageIndex].image}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      filterQuality: FilterQuality.medium,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: ColorRes.grey13,
                                          child: Image.asset(
                                            AssetRes.themeLabel,
                                            width: Get.width,
                                            height: Get.height,
                                          ),
                                        );
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return ShimmerScreen.rectangular(
                                          width: Get.width,
                                          height: Get.height,
                                          shapeBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(21),
                                          ),
                                        );
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (currentImageIndex == 0) {
                                                return;
                                              }
                                              pageController.previousPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.linear);
                                            },
                                            child: Container(
                                              height: Get.height - 256,
                                              color: ColorRes.transparent,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (imagesProfile.length - 1 ==
                                                  currentImageIndex) {
                                                return;
                                              }
                                              pageController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.linear);
                                            },
                                            child: Container(
                                              height: Get.height - 256,
                                              color: ColorRes.transparent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                    Column(
                      children: [
                        const SizedBox(height: 14),
                        TopStoryLine(
                            pageController: pageController,
                            images:
                                userData?[currentProfileIndex].images ?? []),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: Row(
                            children: [
                              SocialIcon(
                                  icon: AssetRes.instaLogo,
                                  size: 15,
                                  onSocialIconTap: onInstagramTap,
                                  isVisible: isSocialBtnVisible(
                                      userData?[currentProfileIndex]
                                          .instagram)),
                              SocialIcon(
                                  icon: AssetRes.facebookLogo,
                                  size: 21.0,
                                  onSocialIconTap: onFacebookTap,
                                  isVisible: isSocialBtnVisible(
                                      userData?[currentProfileIndex].facebook)),
                              SocialIcon(
                                  icon: AssetRes.youtubeLogo,
                                  size: 20.16,
                                  onSocialIconTap: onYoutubeTap,
                                  isVisible: isSocialBtnVisible(
                                      userData?[currentProfileIndex].youtube)),
                              const Spacer(),
                              Visibility(
                                visible:
                                    userData?[currentProfileIndex].isLiveNow ==
                                            1
                                        ? true
                                        : false,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: InkWell(
                                      onTap: onLiveBtnTap,
                                      child: Container(
                                        height: 35,
                                        width: 113,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color:
                                              ColorRes.black.withOpacity(0.33),
                                        ),
                                        child: Row(
                                          children: const [
                                            LiveIcon(),
                                            Text(
                                              " ${AppRes.liveCap}",
                                              style: TextStyle(
                                                color: ColorRes.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              " ${AppRes.nowCap}",
                                              style: TextStyle(
                                                color: ColorRes.white,
                                                fontFamily: FontRes.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                        ProfileDetailCard(
                          userData: userData?[currentProfileIndex],
                          onImageTap: onImageTap,
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
