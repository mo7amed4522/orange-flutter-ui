import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/screen/dashboard/dashboard_screen.dart';
import 'package:orange_ui/screen/get_started_screen/widget/eula_sheet.dart';
import 'package:orange_ui/screen/login_dashboard_screen/login_dashboard_screen.dart';
import 'package:orange_ui/screen/select_hobbies_screen/select_hobbies_screen.dart';
import 'package:orange_ui/screen/select_photo_screen/select_photo_screen.dart';
import 'package:orange_ui/screen/starting_profile_screen/starting_profile_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:stacked/stacked.dart';

class GetStartedScreenViewModel extends BaseViewModel {
  String? currency = '';
  String? coinRate = '';
  int? minThreshold = 0;
  int screenIndex = 0;
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPlugin();
    });
    getPref();
    settingApiCall();
  }

  void getPref() {
    PrefService.getUserData().then((value) {
      if (value == null) return;
      ConstRes.aUserId = value.id!;
      notifyListeners();
    });
  }

  void settingApiCall() async {
    await ApiProvider().getSettingData().then((value) async {
      if (value.data == null) return;
      ConstRes.settingData = value.data;
      ConstRes.currency = value.data?.appdata?.currency ?? '';
      ConstRes.minThreshold = value.data?.appdata?.minThreshold ?? 0;
      ConstRes.coinRate = value.data?.appdata?.coinRate ?? '';
      ConstRes.messagePrice = value.data?.appdata?.messagePrice ?? 0;
      ConstRes.liveWatchingPrice = value.data?.appdata?.liveWatchingPrice ?? 0;
      ConstRes.reverseSwipePrice = value.data?.appdata?.reverseSwipePrice ?? 0;
      ConstRes.isDating == value.data?.appdata?.isDating;
      notifyListeners();
    });
    getPrefSettingData();
  }

  void getPrefSettingData() async {
    await PrefService.getSettingData().then((value) {
      if (value == null) return;
      ConstRes.settingData = value;
      ConstRes.currency = value.appdata?.currency ?? '';
      ConstRes.minThreshold = value.appdata?.minThreshold ?? 0;
      ConstRes.coinRate = value.appdata?.coinRate ?? '';
      ConstRes.messagePrice = value.appdata?.messagePrice ?? 0;
      ConstRes.liveWatchingPrice = value.appdata?.liveWatchingPrice ?? 0;
      ConstRes.reverseSwipePrice = value.appdata?.reverseSwipePrice ?? 0;
      ConstRes.maximumMinutes = value.appdata?.maxMinuteLive ?? 0;
      ConstRes.minimumUserLive = value.appdata?.minUserLive ?? 0;
      ConstRes.iosBannerAd = value.appdata?.admobBannerIos ?? '';
      ConstRes.androidBannerAd = value.appdata?.admobBanner ?? '';
      ConstRes.iosInterstitialAd = value.appdata?.admobIntIos ?? '';
      ConstRes.androidInterstitialAd = value.appdata?.admobInt ?? '';
      notifyListeners();
    });
  }

  Future<void> initPlugin() async {
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      notifyListeners();
      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
        notifyListeners();
      }
    } on PlatformException {
      notifyListeners();
    }
    await AppTrackingTransparency.getAdvertisingIdentifier();
  }

  Future<bool> onBack() async {
    if (screenIndex != 0) {
      screenIndex--;
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  Future<void> screen1NextTap() async {
    bool isEulaSheetAccept = (await PrefService.getDialog('EULA')) ?? false;
    if (Platform.isIOS) {
      if (!isEulaSheetAccept) {
        eulaSheet();
      } else {
        loginToNavigateScreen();
      }
    } else {
      loginToNavigateScreen();
    }
  }

  void loginToNavigateScreen() async {
    bool isLogin = (await PrefService.getLoginText()) ?? false;
    if (isLogin) {
      ApiProvider().getProfile(userID: ConstRes.aUserId).then(
        (value) {
          if (value?.data?.age == null) {
            Get.off(() => const StartingProfileScreen());
          } else if (value?.data?.images == null ||
              value!.data!.images!.isEmpty) {
            Get.off(() => const SelectPhotoScreen());
          } else if (value.data?.interests == null ||
              value.data!.interests!.isEmpty) {
            Get.off(() => const SelectHobbiesScreen());
          } else {
            Get.off(() => const DashboardScreen());
          }
        },
      );
    } else {
      if (ConstRes.settingData?.appdata?.isDating == 0) {
        screenIndex = 3;
      } else {
        screenIndex = 1;
      }
    }
    notifyListeners();
  }

  void eulaSheet() {
    Get.bottomSheet(EulaSheet(eulaAcceptClick: eulaAcceptClick),
        isScrollControlled: true, isDismissible: false);
  }

  void eulaAcceptClick() async {
    PrefService.setDialog('EULA', true);
    Get.back();
    loginToNavigateScreen();
  }

  void onSkipTap() {
    Get.off(() => const LoginDashboardScreen());
  }

  /// Explore profile
  void screen2NextTap() {
    screenIndex = 2;
    notifyListeners();
  }

  ///Nearby profiles on map
  void screen3NextTap() async {
    checkPermissionScreen3();
    notifyListeners();
  }

  ///Stream yourself
  void screen4NextTap() {
    checkPermissionsScreen4();
  }

  void checkPermissionScreen3() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    Loader().lottieLoader();
    await geo.Geolocator.getCurrentPosition(
            desiredAccuracy: geo.LocationAccuracy.high)
        .then((value) async {
      await PrefService.setLatitude(value.latitude.toString());
      await PrefService.setLongitude(value.longitude.toString());
      Get.back();
      screenIndex = 3;
      notifyListeners();
    });
  }

  void checkPermissionsScreen4() async {
    Map<permission.Permission, permission.PermissionStatus> statuses = await [
      permission.Permission.camera,
      permission.Permission.storage,
      permission.Permission.microphone,
      permission.Permission.manageExternalStorage,
    ].request();
    if (statuses[permission.Permission.camera] ==
            permission.PermissionStatus.denied &&
        statuses[permission.Permission.storage] ==
            permission.PermissionStatus.denied &&
        statuses[permission.Permission.microphone] ==
            permission.PermissionStatus.denied &&
        statuses[permission.Permission.manageExternalStorage] ==
            permission.PermissionStatus.denied) {
      await permission.openAppSettings();
    } else {
      Get.off(() => const LoginDashboardScreen());
    }
  }
}
