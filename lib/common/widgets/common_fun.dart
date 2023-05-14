import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:orange_ui/utils/const_res.dart';

class CommonFun {
  static Future<void> interstitialAd(
      Function(InterstitialAd ad) onAdLoaded) async {
    InterstitialAd.load(
      adUnitId: Platform.isIOS
          ? "${ConstRes.settingData?.appdata?.admobIntIos}"
          : "${ConstRes.settingData?.appdata?.admobInt}",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  static void bannerAd(Function(Ad ad) ad) {
    BannerAd(
      adUnitId: Platform.isIOS
          ? "${ConstRes.settingData?.appdata?.admobBannerIos}"
          : "${ConstRes.settingData?.appdata?.admobBanner}",
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: ad,
        onAdFailedToLoad: (ad, err) {
          // print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }
}
