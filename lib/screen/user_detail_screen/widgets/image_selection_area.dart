import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/gradient_widget.dart';
import 'package:orange_ui/common/widgets/live_icon.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

import '../../../utils/asset_res.dart';

class ImageSelectionArea extends StatelessWidget {
  final int selectedImgIndex;
  final List<Images> imageList;
  final VoidCallback onJoinBtnTap;
  final bool like;
  final Function(int index) onImgSelect;
  final VoidCallback onMoreInfoTap;
  final VoidCallback onLikeBtnTap;
  final int? userId;
  final RegistrationUserData? userData;

  const ImageSelectionArea(
      {Key? key,
      required this.selectedImgIndex,
      required this.imageList,
      required this.like,
      required this.onJoinBtnTap,
      required this.onImgSelect,
      required this.onMoreInfoTap,
      required this.onLikeBtnTap,
      required this.userId,
      this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - 101,
      width: Get.width,
      child: Column(
        children: [
          joinBtnChip(),
          const Spacer(),
          Visibility(
              visible:
                  ConstRes.settingData?.appdata?.isDating == 0 ? false : true,
              child: LikeUnlikeBtn(
                  like: like, onLikeBtnTap: onLikeBtnTap, userId: userId)),
          const SizedBox(height: 15),
          imageListArea(),
          const SizedBox(height: 20),
          BottomMoreBtn(onMoreInfoTap: onMoreInfoTap),
        ],
      ),
    );
  }

  Widget joinBtnChip() {
    return Visibility(
      visible: ConstRes.aUserId == userId ? false : true,
      child: Visibility(
        visible: userData?.isLiveNow == 1 ? true : false,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: InkWell(
              onTap: onJoinBtnTap,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 35,
                width: 205,
                padding: const EdgeInsets.fromLTRB(4, 2, 2, 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ColorRes.black.withOpacity(0.33),
                ),
                child: Row(
                  children: [
                    const LiveIcon(),
                    const SizedBox(width: 3),
                    const Text(
                      AppRes.liveCap,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 12,
                      ),
                    ),
                    const Text(
                      " ${AppRes.nowCap}",
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 12,
                        fontFamily: "gilroy_bold",
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 31,
                      width: 95,
                      decoration: BoxDecoration(
                        color: ColorRes.white.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          AppRes.join,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 12,
                            fontFamily: "gilroy_bold",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageListArea() {
    return SizedBox(
      height: 58,
      child: ListView.builder(
        itemCount: imageList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              onImgSelect(index);
            },
            child: Container(
              height: 58,
              width: 58,
              margin: EdgeInsets.only(
                  right: index != (imageList.length - 1) ? 8.33 : 0),
              decoration: BoxDecoration(
                border: selectedImgIndex == index
                    ? Border.all(
                        color: ColorRes.white.withOpacity(0.80),
                        width: 2,
                      )
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl:
                      '${ConstRes.aImageBaseUrl}${imageList[index].image}',
                  height: 58,
                  width: 58,
                  fit: BoxFit.cover,
                  cacheKey:
                      '${ConstRes.aImageBaseUrl}${imageList[index].image}',
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      AssetRes.themeLabel,
                      height: 58,
                      width: 58,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LikeUnlikeBtn extends StatefulWidget {
  final VoidCallback onLikeBtnTap;
  final bool like;
  final int? userId;

  const LikeUnlikeBtn(
      {Key? key, required this.like, required this.onLikeBtnTap, this.userId})
      : super(key: key);

  @override
  State<LikeUnlikeBtn> createState() => _LikeUnlikeBtnState();
}

class _LikeUnlikeBtnState extends State<LikeUnlikeBtn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 350), vsync: this, value: 1.0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: ConstRes.aUserId == widget.userId ? false : true,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          widget.onLikeBtnTap();
          _controller.reverse().then((value) => _controller.forward());
        },
        child: Container(
          height: 76,
          width: 76,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorRes.white.withOpacity(0.30),
          ),
          child: Center(
            child: Container(
              height: 66,
              width: 66,
              padding: const EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorRes.white.withOpacity(0.30),
              ),
              child: widget.like
                  ? ScaleTransition(
                      scale: Tween(begin: 0.7, end: 1.0).animate(
                          CurvedAnimation(
                              parent: _controller, curve: Curves.easeOut)),
                      child: const GradientWidget(
                        child: Icon(
                          Icons.favorite,
                          color: ColorRes.white,
                          size: 40,
                        ),
                      ),
                    )
                  : ScaleTransition(
                      scale: Tween(begin: 0.7, end: 1.0).animate(
                          CurvedAnimation(
                              parent: _controller, curve: Curves.easeOut)),
                      child: const Icon(
                        Icons.favorite,
                        color: ColorRes.white,
                        size: 40,
                      ),
                    ),
              //Image.asset(AssetRes.like, height: 30.23, width: 33),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomMoreBtn extends StatefulWidget {
  final VoidCallback onMoreInfoTap;

  const BottomMoreBtn({Key? key, required this.onMoreInfoTap})
      : super(key: key);

  @override
  State<BottomMoreBtn> createState() => _BottomMoreBtnState();
}

class _BottomMoreBtnState extends State<BottomMoreBtn>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller?.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller?.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return SizedBox(
      height: 57,
      width: Get.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                child: Container(
                  width: Get.width,
                  height: 42,
                  decoration: BoxDecoration(
                    color: ColorRes.black.withOpacity(0.33),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              widget.onMoreInfoTap();
              HapticFeedback.lightImpact();
            },
            onTapUp: _tapUp,
            onTapDown: _tapDown,
            child: Transform.scale(
              scale: _scale,
              child: Container(
                padding: const EdgeInsets.fromLTRB(21, 10, 21, 9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorRes.lightOrange1,
                      ColorRes.darkOrange,
                    ],
                  ),
                ),
                child: Text(
                  AppRes.moreInfo,
                  style: TextStyle(
                    color: ColorRes.white.withOpacity(0.80),
                    fontSize: 11,
                    fontFamily: "gilroy_bold",
                    letterSpacing: 0.65,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageListArea extends StatefulWidget {
  final List<Images> imageList;
  final Function(int index) onImgSelect;
  final int selectedImgIndex;

  const ImageListArea(
      {Key? key,
      required this.imageList,
      required this.onImgSelect,
      required this.selectedImgIndex})
      : super(key: key);

  @override
  State<ImageListArea> createState() => _ImageListAreaState();
}

class _ImageListAreaState extends State<ImageListArea>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller?.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller?.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return SizedBox(
      height: 58,
      child: ListView.builder(
        itemCount: widget.imageList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              widget.onImgSelect(index);
            },
            onTapDown: _tapDown,
            onTapUp: _tapUp,
            child: Transform.scale(
              scale: _scale,
              child: Container(
                height: 58,
                width: 58,
                margin: EdgeInsets.only(
                    right: index != (widget.imageList.length - 1) ? 8.33 : 0),
                decoration: BoxDecoration(
                  border: widget.selectedImgIndex == index
                      ? Border.all(
                          color: ColorRes.white.withOpacity(0.80),
                          width: 2,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        '${ConstRes.aImageBaseUrl}${widget.imageList[index].image}'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
