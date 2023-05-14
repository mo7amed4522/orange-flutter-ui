import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:orange_ui/model/notification/user_notification.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class PersonalNotificationPage extends StatelessWidget {
  final List<UserNotificationData>? userNotification;
  final ScrollController controller;
  final Function(RegistrationUserData? data) onUserTap;

  const PersonalNotificationPage(
      {Key? key,
      this.userNotification,
      required this.controller,
      required this.onUserTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return userNotification == null || userNotification!.isEmpty
        ? Center(
            child: LottieBuilder.asset(
              AssetRes.emptyListLottie,
              height: 200,
              width: 200,
            ),
          )
        : ListView.builder(
            controller: controller,
            padding: const EdgeInsets.only(top: 15),
            itemCount: userNotification?.length,
            itemBuilder: (context, index) {
              RegistrationUserData? data = userNotification?[index].dataUser;
              return InkWell(
                onTap: () {
                  onUserTap(data);
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 16, right: 19, bottom: 18),
                  child: Row(
                    children: [
                      data?.images == null || data!.images!.isEmpty
                          ? Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    ColorRes.lightOrange1,
                                    ColorRes.darkOrange,
                                  ],
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${ConstRes.aImageBaseUrl}${data.images?[0].image}',
                                cacheKey:
                                    '${ConstRes.aImageBaseUrl}${data.images?[0].image}',
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                errorWidget: (context, error, stackTrace) {
                                  return Image.asset(
                                    AssetRes.themeLabel,
                                    width: 40,
                                    height: 40,
                                  );
                                },
                              ),
                            ),
                      const SizedBox(width: 13),
                      SizedBox(
                        width: Get.width - 94,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${data?.fullname}',
                                  style: const TextStyle(
                                    fontFamily: FontRes.bold,
                                    fontSize: 15,
                                    color: ColorRes.darkGrey4,
                                  ),
                                ),
                                Text(
                                  ' ${data?.age}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: ColorRes.darkGrey4,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Visibility(
                                  visible: data?.isVerified == 2 ? true : false,
                                  child: Image.asset(
                                    AssetRes.tickMark,
                                    height: 14.87,
                                    width: 15.58,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  userNotification != null
                                      ? ConstRes.timeAgo(
                                          DateTime.parse(
                                              '${userNotification?[index].createdAt}'),
                                        )
                                      : '',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: ColorRes.grey7,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              userNotification?[index].type == 1
                                  ? '${data?.fullname} has liked your profile, you should check their profile!'
                                  : '',
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: ColorRes.grey6,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}
