import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/model/chat_and_live_stream/chat.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class TopBarArea extends StatelessWidget {
  final Conversation? conversation;
  final VoidCallback onBack;
  final Function(String value) onMoreBtnTap;
  final String blockUnblock;
  final VoidCallback onUserTap;
  final FocusNode msgFocusNode;

  const TopBarArea(
      {Key? key,
      required this.conversation,
      required this.onBack,
      required this.onMoreBtnTap,
      required this.blockUnblock,
      required this.onUserTap,
      required this.msgFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(21, 18, 23, 18),
            child: Row(
              children: [
                InkWell(
                  onTap: onBack,
                  child: SizedBox(
                    width: 20,
                    child: Image.asset(
                      AssetRes.backArrow,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: conversation?.user?.image == null ||
                          conversation!.user!.image!.isEmpty
                      ? Image.asset(
                          AssetRes.themeLabel,
                          height: 37,
                          width: 37,
                        )
                      : CachedNetworkImage(
                          imageUrl:
                              '${ConstRes.aImageBaseUrl}${conversation?.user?.image}',
                          height: 37,
                          width: 37,
                          fit: BoxFit.cover,
                          cacheKey:
                              '${ConstRes.aImageBaseUrl}${conversation?.user?.image}',
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              AssetRes.themeLabel,
                              height: 37,
                              width: 37,
                            );
                          },
                        ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: onUserTap,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            conversation?.user?.username != null
                                ? '${conversation?.user?.username} '
                                : ' ',
                            style: const TextStyle(
                              color: ColorRes.darkGrey4,
                              fontSize: 16,
                              fontFamily: FontRes.bold,
                            ),
                          ),
                          Text(
                            conversation?.user?.age != null
                                ? "${conversation?.user?.age}"
                                : '',
                            style: const TextStyle(
                              color: ColorRes.darkGrey4,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Visibility(
                              visible: conversation != null &&
                                  conversation?.user != null &&
                                  conversation?.user?.isHost != null &&
                                  conversation!.user!.isHost!,
                              child: Image.asset(AssetRes.tickMark,
                                  height: 15, width: 15)),
                        ],
                      ),
                      Text(
                        conversation?.user?.city != null
                            ? "${conversation?.user?.city}"
                            : '',
                        style: const TextStyle(
                          color: ColorRes.grey6,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    onMoreBtnTap(value);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  itemBuilder: (BuildContext context) {
                    msgFocusNode.unfocus();
                    return {blockUnblock, AppRes.report}.map(
                      (String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      },
                    ).toList();
                  },
                  child: Image.asset(
                    AssetRes.moreHorizontal,
                    height: 27,
                    width: 27,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            width: Get.width,
            margin: const EdgeInsets.only(right: 10, left: 10, bottom: 5.5),
            color: ColorRes.grey9,
          ),
        ],
      ),
    );
  }
}
