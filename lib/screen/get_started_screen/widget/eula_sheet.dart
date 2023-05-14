import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EulaSheet extends StatelessWidget {
  final VoidCallback eulaAcceptClick;

  const EulaSheet({Key? key, required this.eulaAcceptClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
      Factory(() => EagerGestureRecognizer())
    };

    UniqueKey key = UniqueKey();
    return Container(
      margin: EdgeInsets.only(top: AppBar().preferredSize.height * 1.5),
      decoration: const BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 50 * 2),
            child: WebView(
              key: key,
              initialUrl:
                  'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/',
              javascriptMode: JavascriptMode.unrestricted,
              gestureRecognizers: gestureRecognizers,
            ),
          ),
          SafeArea(
            top: false,
            child: TextButton(
              onPressed: eulaAcceptClick,
              style: TextButton.styleFrom(
                backgroundColor: ColorRes.orange,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                'Accept',
                style: TextStyle(
                  color: ColorRes.white,
                  fontFamily: FontRes.semiBold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
