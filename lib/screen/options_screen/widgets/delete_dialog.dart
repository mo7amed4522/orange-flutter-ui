import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class DeleteDialog extends StatefulWidget {
  final VoidCallback onYesBtnClick;
  final VoidCallback onNoBtnClick;
  final String subDescription;
  final double aspectRatio;
  final double horizontalPadding;

  const DeleteDialog(
      {Key? key,
      required this.onNoBtnClick,
      required this.onYesBtnClick,
      required this.subDescription,
      required this.aspectRatio,
      required this.horizontalPadding})
      : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Dialog(
          insetPadding:
              EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Column(
              children: [
                const Spacer(flex: 2),
                RichText(
                  text: const TextSpan(
                    style:
                        TextStyle(fontFamily: FontRes.semiBold, fontSize: 18),
                    children: [
                      TextSpan(
                        text: 'Are you',
                        style: TextStyle(color: ColorRes.grey15),
                      ),
                      TextSpan(
                        text: ' Sure?',
                        style: TextStyle(color: ColorRes.darkGrey),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Image(
                  image: AssetImage(AssetRes.themeLabel),
                  width: 100,
                ),
                const Spacer(
                  flex: 2,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.subDescription,
                    style: const TextStyle(
                        fontFamily: FontRes.semiBold, color: ColorRes.grey15),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                InkWell(
                  highlightColor: ColorRes.transparent,
                  splashColor: ColorRes.transparent,
                  onTap: widget.onYesBtnClick,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorRes.lightOrange1,
                          ColorRes.darkOrange,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                          color: ColorRes.white, fontFamily: FontRes.semiBold),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  highlightColor: ColorRes.transparent,
                  splashColor: ColorRes.transparent,
                  onTap: widget.onNoBtnClick,
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(
                          color: ColorRes.grey15, fontFamily: FontRes.semiBold),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
