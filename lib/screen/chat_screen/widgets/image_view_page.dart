import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orange_ui/model/chat_and_live_stream/chat.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class ImageViewPage extends StatelessWidget {
  final ChatMessage? userData;
  final VoidCallback onBack;
  final TransformationController transformationController;
  final VoidCallback handleDoubleTap;
  final Function(TapDownDetails details) handleDoubleTapDown;

  const ImageViewPage(
      {Key? key,
      this.userData,
      required this.onBack,
      required this.transformationController,
      required this.handleDoubleTap,
      required this.handleDoubleTapDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorRes.black,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
    );
    return Scaffold(
      backgroundColor: ColorRes.black,
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onDoubleTapDown: handleDoubleTapDown,
              onDoubleTap: handleDoubleTap,
              child: InteractiveViewer(
                transformationController: transformationController,
                child: CachedNetworkImage(
                  imageUrl: '${ConstRes.aImageBaseUrl}${userData?.image}',
                  height: Get.height,
                  width: double.infinity,
                ),
              ),
            ),
            topBarArea()
          ],
        ),
      ),
    );
  }

  Widget topBarArea() {
    return Container(
      color: ColorRes.black.withOpacity(0.3),
      padding: const EdgeInsets.fromLTRB(21, 18, 23, 18),
      child: Row(
        children: [
          InkWell(
            onTap: onBack,
            splashColor: ColorRes.transparent,
            highlightColor: ColorRes.transparent,
            child: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                AssetRes.backArrow,
                height: 20,
                width: 10,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    userData?.senderUser?.userid == ConstRes.aUserId
                        ? AppRes.you
                        : '${userData?.senderUser?.username} ',
                    style: const TextStyle(
                      color: ColorRes.white,
                      fontSize: 16,
                      fontFamily: FontRes.bold,
                    ),
                  ),
                ],
              ),
              Text(
                DateFormat('${AppRes.dMY}, ${AppRes.hhMmA}').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        userData!.time!.toInt())),
                style: const TextStyle(
                  color: ColorRes.white,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
