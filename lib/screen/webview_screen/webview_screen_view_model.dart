import 'dart:io';

import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreenViewModel extends BaseViewModel {
  void init() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isIOS) WebView.platform = CupertinoWebView();
  }

  var loadingPercentage = 0;

  void onPageFinished(String url) {
    loadingPercentage = 100;
    notifyListeners();
  }

  void onProgress(int progress) {
    loadingPercentage = progress;
    notifyListeners();
  }

  void onPageStarted(String url) {
    loadingPercentage = 0;
    notifyListeners();
  }

  void onBackBtnClick() {
    Get.back();
  }
}
