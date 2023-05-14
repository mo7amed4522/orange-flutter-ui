import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
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

class ProfilePicArea extends StatelessWidget {
  final bool isLoading;
  final RegistrationUserData? userData;
  final PageController pageController;
  final VoidCallback onLeftBtnClick;
  final VoidCallback onRightBtnClick;
  final VoidCallback onInstagramTap;
  final VoidCallback onFacebookTap;
  final VoidCallback onYoutubeTap;
  final VoidCallback onLiveBtnTap;
  final VoidCallback onImageTap;
  final bool Function(String?) isSocialBtnVisible;

  const ProfilePicArea(
      {Key? key,
      this.userData,
      required this.isLoading,
      required this.pageController,
      required this.onLeftBtnClick,
      required this.onRightBtnClick,
      required this.onFacebookTap,
      required this.onInstagramTap,
      required this.onYoutubeTap,
      required this.onLiveBtnTap,
      required this.onImageTap,
      required this.isSocialBtnVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            width: Get.width,
            height: Get.height / 2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AssetRes.worldMap),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SpinKitRipple(
                  borderWidth: 100,
                  duration: const Duration(milliseconds: 1500),
                  size: Get.width / 1.1,
                  itemBuilder: (BuildContext context, int index) {
                    return CircleAvatar(
                      backgroundColor: ColorRes.grey21.withOpacity(0.40),
                    );
                  },
                ),
                SpinKitRipple(
                  borderWidth: 50,
                  duration: const Duration(milliseconds: 1500),
                  size: Get.width / 1.5,
                  itemBuilder: (BuildContext context, int index) {
                    return CircleAvatar(
                      backgroundColor: ColorRes.grey21.withOpacity(0.30),
                    );
                  },
                ),
                Container(
                  height: Get.width / 3,
                  width: Get.width / 3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${ConstRes.aImageBaseUrl}${Get.arguments[0][FirebaseConst.image]}'),
                    ),
                  ),
                ),
              ],
            ))
        : SizedBox(
            width: Get.width / 1.2,
            height: Get.height / 1.6,
            child: Stack(
              children: [
                userData?.images == null || userData!.images!.isEmpty
                    ? Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorRes.darkOrange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: Get.width - 100,
                              height: Get.height - 256,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorRes.darkOrange.withOpacity(0.2)),
                              child: Image.asset(
                                AssetRes.themeLabel,
                              ),
                            ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: userData?.images?.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            String? profileImage =
                                userData?.images?[index].image;
                            return FractionallySizedBox(
                              widthFactor: 1 / pageController.viewportFraction,
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        '${ConstRes.aImageBaseUrl}$profileImage',
                                    cacheKey:
                                        '${ConstRes.aImageBaseUrl}$profileImage',
                                    fit: BoxFit.cover,
                                    width: Get.width,
                                    height: Get.height - 256,
                                    filterQuality: FilterQuality.medium,
                                    errorWidget: (context, error, stackTrace) {
                                      return Container(
                                        color: ColorRes.grey13,
                                        child: Image.asset(
                                          AssetRes.themeLabel,
                                          width: Get.width,
                                          height: Get.height - 256,
                                        ),
                                      );
                                    },
                                    progressIndicatorBuilder:
                                        (context, child, loadingProgress) {
                                      return ShimmerScreen.rectangular(
                                        width: Get.width,
                                        height: Get.height - 256,
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
                                          onTap: onLeftBtnClick,
                                          child: Container(
                                            height: Get.height - 256,
                                            color: ColorRes.transparent,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: onRightBtnClick,
                                          child: Container(
                                            height: Get.height - 256,
                                            color: ColorRes.transparent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(
                  height: Get.height - 256,
                  width: Get.width,
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                      TopStoryLine(
                          pageController: pageController,
                          images: userData?.images ?? []),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 9),
                        child: Row(
                          children: [
                            SocialIcon(
                                icon: AssetRes.instaLogo,
                                size: 15,
                                onSocialIconTap: onInstagramTap,
                                isVisible:
                                    isSocialBtnVisible(userData?.instagram)),
                            SocialIcon(
                                icon: AssetRes.facebookLogo,
                                size: 21.0,
                                onSocialIconTap: onFacebookTap,
                                isVisible:
                                    isSocialBtnVisible(userData?.facebook)),
                            SocialIcon(
                                icon: AssetRes.youtubeLogo,
                                size: 20.16,
                                onSocialIconTap: onYoutubeTap,
                                isVisible:
                                    isSocialBtnVisible(userData?.youtube)),
                            const Spacer(),
                            Visibility(
                              visible: userData?.isLiveNow == 0 ? false : true,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: InkWell(
                                    onTap: onLiveBtnTap,
                                    child: Container(
                                      height: 35,
                                      width: 113,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: ColorRes.black.withOpacity(0.33),
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
                        onImageTap: onImageTap,
                        userData: userData,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
