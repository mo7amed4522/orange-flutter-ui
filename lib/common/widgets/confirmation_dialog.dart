import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class ConfirmationDialog extends StatefulWidget {
  final VoidCallback onYesBtnClick;
  final VoidCallback onNoBtnClick;
  final String subDescription;
  final double aspectRatio;
  final double horizontalPadding;
  final String clickText1;
  final String clickText2;
  final String heading;

  const ConfirmationDialog(
      {Key? key,
      required this.onNoBtnClick,
      required this.onYesBtnClick,
      required this.subDescription,
      required this.aspectRatio,
      required this.horizontalPadding,
      required this.clickText1,
      required this.clickText2,
      required this.heading})
      : super(key: key);

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog>
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
                const Spacer(
                  flex: 1,
                ),
                Text(
                  widget.heading,
                  style: const TextStyle(
                      color: ColorRes.darkGrey10,
                      fontFamily: FontRes.bold,
                      fontSize: 18),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.subDescription,
                    style: const TextStyle(
                        fontFamily: FontRes.medium, color: ColorRes.grey15),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
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
                          child: Text(
                            widget.clickText2,
                            style: const TextStyle(
                                color: ColorRes.grey15,
                                fontFamily: FontRes.semiBold),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        highlightColor: ColorRes.transparent,
                        splashColor: ColorRes.transparent,
                        onTap: widget.onYesBtnClick,
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          height: 35,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
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
                          child: Text(
                            widget.clickText1,
                            style: const TextStyle(
                                color: ColorRes.white,
                                fontFamily: FontRes.semiBold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
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
