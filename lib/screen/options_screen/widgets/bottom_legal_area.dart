import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class BottomLegalArea extends StatelessWidget {
  final VoidCallback onPrivacyPolicyTap;
  final VoidCallback onTermsOfUseTap;
  final VoidCallback onLogoutTap;
  final VoidCallback onDeleteAccountTap;

  const BottomLegalArea({
    Key? key,
    required this.onPrivacyPolicyTap,
    required this.onTermsOfUseTap,
    required this.onLogoutTap,
    required this.onDeleteAccountTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppRes.legal,
          style: TextStyle(
            fontFamily: FontRes.bold,
            color: ColorRes.grey23,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 9),
        navigationTile(AppRes.privacyPolicy, onPrivacyPolicyTap),
        const SizedBox(height: 8),
        navigationTile(AppRes.termsOfUse, onTermsOfUseTap),
        // const SizedBox(height: 9),
        // navigationTile(AppRes.helpNSupport, onHelpNSupportTap),
        const SizedBox(height: 47),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onLogoutTap,
          child: Container(
            height: 46,
            width: Get.width,
            decoration: BoxDecoration(
              color: ColorRes.grey12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                AppRes.logOut,
                style: TextStyle(
                  fontSize: 15,
                  color: ColorRes.grey24,
                  fontFamily: FontRes.semiBold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Image.asset(
            AssetRes.themeLabel,
            height: 30,
            width: 150,
            fit: BoxFit.cover,
          ),
        ),
        const Center(
          child: Text(
            AppRes.versionText,
            style: TextStyle(
              fontSize: 12,
              color: ColorRes.grey25,
            ),
          ),
        ),
        const SizedBox(height: 23),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onDeleteAccountTap,
          child: Container(
            height: 46,
            width: Get.width,
            decoration: BoxDecoration(
              color: ColorRes.grey12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                AppRes.deleteAccount,
                style: TextStyle(
                  fontSize: 15,
                  color: ColorRes.grey24,
                  fontFamily: FontRes.semiBold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget navigationTile(String title, VoidCallback onTap) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: ColorRes.grey12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: ColorRes.grey24,
                fontSize: 15,
                fontFamily: FontRes.semiBold,
              ),
            ),
            const Spacer(),
            Transform.rotate(
              angle: 3.2,
              child: Image.asset(
                AssetRes.backArrow,
                height: 12,
                width: 6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
