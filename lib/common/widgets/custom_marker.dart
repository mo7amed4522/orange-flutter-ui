import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';

class CustomMarker extends StatelessWidget {
  final String image;

  const CustomMarker({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const AlignmentDirectional(0, -0.6),
      children: [
        Image.asset(
          AssetRes.markerBG,
          height: 47.25,
          width: 40.5,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.asset(
            image,
            height: 34,
            width: 34,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
