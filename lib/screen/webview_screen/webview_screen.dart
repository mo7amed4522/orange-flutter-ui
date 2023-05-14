import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/screen/webview_screen/webview_screen_view_model.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String appBarTitle;
  final String url;

  const WebViewScreen({Key? key, required this.appBarTitle, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WebViewScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => WebViewScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorRes.white,
            leading: InkWell(
              onTap: model.onBackBtnClick,
              child: const Icon(
                CupertinoIcons.left_chevron,
                color: ColorRes.orange,
              ),
            ),
            elevation: 0,
            title: Text(
              appBarTitle,
              style: const TextStyle(
                  color: ColorRes.black, fontFamily: FontRes.semiBold),
            ),
          ),
          body: Stack(
            children: [
              WebView(
                initialUrl: '${ConstRes.base}$url',
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: model.onPageStarted,
                onProgress: model.onProgress,
                onPageFinished: model.onPageFinished,
              ),
              if (model.loadingPercentage < 100)
                LinearProgressIndicator(
                  value: model.loadingPercentage / 100.0,
                  color: ColorRes.orange,
                  backgroundColor: ColorRes.orange.withOpacity(0.2),
                ),
            ],
          ),
        );
      },
    );
  }
}
