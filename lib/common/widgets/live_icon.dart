import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';

class LiveIcon extends StatelessWidget {
  const LiveIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(AssetRes.live1, height: 28, width: 28),
        Image.asset(AssetRes.live2, height: 20, width: 20),
        Image.asset(AssetRes.live3, height: 12.73, width: 12.73),
      ],
    );
  }
}
