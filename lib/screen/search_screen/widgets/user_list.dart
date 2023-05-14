import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserList extends StatelessWidget {
  final List<RegistrationUserData>? userList;
  final Function(RegistrationUserData? data) onUserTap;
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;

  const UserList(
      {Key? key,
      required this.userList,
      required this.onUserTap,
      required this.refreshController,
      required this.onRefresh,
      required this.onLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: onRefresh,
        onLoading: onLoading,
        header: const WaterDropHeader(
          waterDropColor: Colors.deepOrange,
        ),
        footer: CustomFooter(
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const SizedBox();
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text(
                "Load Failed!Click retry!",
                style: TextStyle(
                  color: ColorRes.grey6,
                  fontSize: 13,
                ),
              );
            } else if (mode == LoadStatus.canLoading) {
              body = const Text(
                "release to load more",
                style: TextStyle(
                  color: ColorRes.grey6,
                  fontSize: 13,
                ),
              );
            } else {
              body = const Text(
                "No more Data",
                style: TextStyle(
                  color: ColorRes.grey6,
                  fontSize: 13,
                ),
              );
            }
            return SizedBox(
              child: Center(child: body),
            );
          },
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: userList?.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            List<Images>? images = userList?[index].images;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  onUserTap(userList?[index]);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  decoration: BoxDecoration(
                    color: ColorRes.lightGrey2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: images == null || images.isEmpty
                            ? Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorRes.white),
                                child: Image.asset(
                                  AssetRes.themeLabel,
                                  height: 40,
                                  width: 40,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    '${ConstRes.aImageBaseUrl}${images[0].image ?? ''}',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                cacheKey:
                                    '${ConstRes.aImageBaseUrl}${images[0].image ?? ''}',
                                errorWidget: (context, url, error) {
                                  return Image.asset(
                                    AssetRes.themeLabel,
                                    height: 40,
                                    width: 40,
                                  );
                                },
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: Text(
                                    '${userList?[index].fullname ?? ''} ',
                                    style: const TextStyle(
                                      color: ColorRes.darkGrey4,
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: FontRes.bold,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                Flexible(
                                  child: Text(
                                    '${userList?[index].age ?? ''}',
                                    style: const TextStyle(
                                        color: ColorRes.darkGrey4,
                                        fontSize: 18,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                Flexible(
                                  child: userList?[index].isVerified == 2
                                      ? Image.asset(AssetRes.tickMark,
                                          height: 18, width: 18)
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                            Text(
                              userList?[index].live ?? '',
                              style: const TextStyle(
                                  color: ColorRes.grey6,
                                  fontSize: 13,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
