import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class SearchBarArea extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedTab;
  final List<Interest>? tabList;
  final VoidCallback onBackBtnTap;
  final VoidCallback onSearchBtnTap;
  final VoidCallback onLocationTap;
  final Function(String value) onTabSelect;
  final Function(int? value) onTapSelectId;

  const SearchBarArea(
      {Key? key,
      required this.searchController,
      required this.selectedTab,
      required this.tabList,
      required this.onBackBtnTap,
      required this.onSearchBtnTap,
      required this.onLocationTap,
      required this.onTabSelect,
      required this.onTapSelectId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorRes.white,
      ),
      child: selectedTab == '' ? withoutSelected() : withSelected(),
    );
  }

  Widget withoutSelected() {
    return Column(
      children: [
        const SizedBox(height: 51),
        Row(
          children: [
            const SizedBox(width: 10),
            InkWell(
              onTap: onBackBtnTap,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 37,
                width: 37,
                padding: const EdgeInsets.only(right: 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorRes.orange2.withOpacity(0.06),
                ),
                child: Center(
                  child: Image.asset(
                    AssetRes.backArrow,
                    height: 14,
                    width: 7,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: textField()),
            const SizedBox(width: 12),
            InkWell(
              onTap: onLocationTap,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 37,
                width: 37,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorRes.orange2.withOpacity(0.06),
                ),
                child: Center(
                  child: Image.asset(
                    AssetRes.locationSearch,
                    height: 30,
                    width: 20,
                    color: ColorRes.orange2,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 35,
          width: Get.width,
          child: ListView.builder(
            itemCount: tabList?.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onTabSelect('${tabList?[index].title}');
                  onTapSelectId(tabList?[index].id);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: 12,
                    right: index == (tabList!.length - 1) ? 12 : 0,
                  ),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 8),
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorRes.orange2.withOpacity(0.06),
                  ),
                  child: Center(
                    child: Text(
                      '${tabList?[index].title}',
                      style: const TextStyle(
                        color: ColorRes.orange2,
                        fontFamily: FontRes.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 9),
      ],
    );
  }

  Widget withSelected() {
    return Column(
      children: [
        Container(
          width: Get.width,
          padding: const EdgeInsets.fromLTRB(10, 45, 10, 15),
          color: ColorRes.orange2.withOpacity(0.06),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                selectedTab,
                style: const TextStyle(
                  color: ColorRes.orange2,
                  fontSize: 18,
                  fontFamily: FontRes.bold,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: onBackBtnTap,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 37,
                      width: 37,
                      padding: const EdgeInsets.only(right: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorRes.orange2.withOpacity(0.06),
                      ),
                      child: Center(
                        child: Image.asset(
                          AssetRes.backArrow,
                          height: 14,
                          width: 7,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
          child: textField(),
        ),
      ],
    );
  }

  Widget textField() {
    return Container(
      height: 38,
      padding: const EdgeInsets.only(left: 5, bottom: 12),
      decoration: BoxDecoration(
        color: ColorRes.lightGrey2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: searchController,
        cursorHeight: 15,
        onChanged: (value) {
          onSearchBtnTap();
        },
        style: const TextStyle(
          color: ColorRes.grey17,
          fontSize: 15,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        ),
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
