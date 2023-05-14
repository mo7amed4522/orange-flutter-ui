import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orange_ui/common/widgets/custom_box_shadow.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class HobbySelectionBar extends StatelessWidget {
  final List<Interest>? hobbyList;
  final String selectedHobby;
  final Function(String value) onHobbySelect;

  const HobbySelectionBar({
    Key? key,
    required this.hobbyList,
    required this.selectedHobby,
    required this.onHobbySelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            CustomBoxShadow(
              color: ColorRes.black.withOpacity(0.20),
              offset: const Offset(0, 1.0),
              blurRadius: 4.0,
              style: BlurStyle.outer,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorRes.grey18.withOpacity(0.30),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 10, bottom: 9),
                itemCount: hobbyList?.length,
                itemBuilder: (context, index) {
                  bool selected = selectedHobby == hobbyList?[index].title;
                  return InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      onHobbySelect('${hobbyList?[index].title}');
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 13 : 10,
                        right: index == (hobbyList!.length - 1) ? 9 : 0,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selected
                            ? ColorRes.white
                            : ColorRes.orange2.withOpacity(0.06),
                        gradient: selected
                            ? const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorRes.lightOrange1,
                                  ColorRes.darkOrange,
                                ],
                              )
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          "${hobbyList?[index].title}",
                          style: TextStyle(
                            color: selected ? ColorRes.white : ColorRes.orange2,
                            fontSize: 12,
                            fontFamily: FontRes.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
