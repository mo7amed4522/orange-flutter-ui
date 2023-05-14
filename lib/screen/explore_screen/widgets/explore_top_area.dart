import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class ExploreTopArea extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onTitleTap;
  final VoidCallback onSearchTap;

  const ExploreTopArea({
    Key? key,
    required this.onNotificationTap,
    required this.onSearchTap,
    required this.onTitleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible:
                    ConstRes.settingData?.appdata?.isDating == 0 ? false : true,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: onNotificationTap,
                  child: Image.asset(
                    AssetRes.bell,
                    height: 37,
                    width: 37,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onSearchTap,
                child: Image.asset(
                  AssetRes.search,
                  height: 37,
                  width: 37,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: onTitleTap,
            child: Image.asset(
              AssetRes.themeLabel,
              height: 50,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
