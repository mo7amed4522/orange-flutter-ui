import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';

class TopArea extends StatelessWidget {
  final String notification;
  final VoidCallback onBack;

  const TopArea({
    Key? key,
    required this.notification,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              notification,
              style: const TextStyle(
                fontSize: 17,
                fontFamily: "gilroy_bold",
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 23.0),
                child: InkWell(
                  onTap: onBack,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 37,
                    width: 37,
                    padding: const EdgeInsets.only(right: 3),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AssetRes.backButton),
                      ),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
