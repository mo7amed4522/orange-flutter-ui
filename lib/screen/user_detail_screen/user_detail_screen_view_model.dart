import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/model/chat_and_live_stream/chat.dart';
import 'package:orange_ui/model/chat_and_live_stream/live_stream.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/chat_screen/chat_screen.dart';
import 'package:orange_ui/screen/person_streaming_screen/person_streaming_screen.dart';
import 'package:orange_ui/screen/user_report_screen/report_sheet.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';

class UserDetailScreenViewModel extends BaseViewModel {
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool isLoading = false;
  bool moreInfo = false;
  bool like = false;
  int selectedImgIndex = 0;
  bool save = false;
  String reason = AppRes.cyberbullying;
  bool showDropdown = false;
  LiveStreamUser? liveStreamUser;
  List<String?> joinedUsers = [];
  RegistrationUserData? userData;
  RegistrationUserData? _registrationUserData;
  int? userId;
  String? latitude = '';
  String? longitude = '';
  double distance = 0.0;
  String blockUnBlock = AppRes.block;
  InterstitialAd? interstitialAd;

  void init(bool? showInfo) {
    if (Get.arguments is int) {
      userId = Get.arguments;
    } else if (Get.arguments is String) {
      userId = int.parse(Get.arguments);
    } else {
      userData = Get.arguments;
    }
    userDetailApiCall();
    initInterstitialAds();
  }

  void shareLink(RegistrationUserData? userData) async {
    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: 'flutter/branch',
      title: userData?.fullname ?? '',
      imageUrl: '${ConstRes.aImageBaseUrl}${userData?.images?[0].image}',
      contentDescription: userData?.about ?? '',
      publiclyIndex: true,
      locallyIndex: true,
      contentMetadata: BranchContentMetaData()
        ..addCustomMetadata('user_id', userData?.id),
    );
    BranchLinkProperties lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
        tags: ['one', 'two', 'three']);
    lp.addControlParam('url', 'http://www.google.com');
    lp.addControlParam('url2', 'http://flutter.dev');
    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    if (response.success) {
      Share.share(
        'Check out this Profile ${response.result}',
        subject: 'Look ${userData?.fullname}',
      );
    } else {}
  }

  Future<void> userProfileApiCall() async {
    isLoading = true;
    await ApiProvider().getProfile(userID: userId ?? userData?.id).then(
      (value) async {
        userData = value?.data;
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> registrationUserApiCall() async {
    await ApiProvider().getProfile(userID: ConstRes.aUserId).then((value) {
      _registrationUserData = value?.data;
      blockUnBlock =
          value?.data?.blockedUsers?.contains('${userData?.id}') == true
              ? AppRes.unBlock
              : AppRes.block;
      save = value?.data?.savedprofile?.contains('${userData?.id}') ?? false;
      like = value?.data?.likedprofile?.contains('${userData?.id}') ?? false;
      notifyListeners();
    });
  }

  void userDetailApiCall() async {
    userProfileApiCall().then((value) {
      registrationUserApiCall();
    });
    latitude = await PrefService.getLatitude() ?? '';
    longitude = await PrefService.getLongitude() ?? '';

    if (latitude != null &&
        latitude!.isNotEmpty &&
        latitude != '0.0' &&
        userData?.lattitude != null &&
        userData!.lattitude!.isNotEmpty &&
        userData?.lattitude != '0.0') {
      distance = calculateDistance(
        lat1: double.parse(latitude ?? '0.0'),
        lon1: double.parse(longitude ?? '0.0'),
        lat2: double.parse(userData?.lattitude ?? '0.0'),
        lon2: double.parse(userData?.longitude ?? '0.0'),
      );
    } else {
      distance = 0;
    }
    notifyListeners();
  }

  void onReasonChange(String value) {
    reason = value;
    showDropdown = false;
    notifyListeners();
  }

  void onReasonTap() {
    showDropdown = !showDropdown;
    notifyListeners();
  }

  void onImageSelect(int index) {
    selectedImgIndex = index;
    notifyListeners();
  }

  void onJoinBtnTap() {
    List<Images>? images = userData?.images;
    joinedUsers.add(userData?.identity ?? '');
    liveStreamUser = LiveStreamUser(
        userId: userData?.id,
        userImage: images != null && images.isNotEmpty ? images[0].image : '',
        id: DateTime.now().millisecondsSinceEpoch,
        watchingCount: 0,
        joinedUser: [],
        isVerified: userData?.isVerified == 2 ? true : false,
        hostIdentity: userData?.identity,
        collectedDiamond: 0,
        agoraToken: '',
        fullName: userData?.fullname ?? '',
        age: userData?.age ?? 0,
        address: userData?.live ?? '');
    db.collection(FirebaseConst.liveHostList).doc(userData?.identity).update(
      {
        FirebaseConst.joinedUser: FieldValue.arrayUnion(joinedUsers),
        FirebaseConst.watchingCount: liveStreamUser!.watchingCount! + 1
      },
    ).then((value) {
      Get.to(() => const PersonStreamingScreen(), arguments: {
        ConstRes.aChannelId: userData?.identity,
        ConstRes.aIsBroadcasting: false,
        ConstRes.aUserInfo: liveStreamUser
      });
    }).catchError((e) {
      SnackBarWidget().snackBarWidget(AppRes.userNotLive);
    });
  }

  void onHideInfoTap() {
    notifyListeners();
  }

  void onBackTap() {
    PrefService.getUserData().then((value) {
      if (value?.id == userData?.id) {
        Get.back();
      } else {
        if (interstitialAd != null) {
          interstitialAd?.show().whenComplete(() {
            Get.back();
          });
        } else {
          Get.back();
        }
      }
    });
  }

  void initInterstitialAds() {
    CommonFun.interstitialAd((ad) {
      interstitialAd = ad;
    });
  }

  void onMoreBtnTap(String value) {
    if (value == AppRes.block) {
      blockUnblockApi(blockProfileId: userData?.id).then((value) {
        registrationUserApiCall();
      });
    } else if (value == AppRes.unBlock) {
      blockUnblockApi(blockProfileId: userData?.id).then((value) {
        registrationUserApiCall();
      });
    } else {
      onReportTap();
    }
  }

  Future<void> blockUnblockApi({int? blockProfileId}) async {
    Loader().lottieLoader();
    await ApiProvider().userBlockList(blockProfileId);
    onBackTap();
  }

  void onLikeBtnTap() async {
    await ApiProvider().updateLikedProfile(userData?.id);
    like == true
        ? null
        : await ApiProvider()
            .notifyLikeUser(userId: userData?.id ?? 0, type: 1);
    like = !like;
    notifyListeners();
  }

  void onSaveTap() {
    ApiProvider().updateSaveProfile(userData?.id);
    save = !save;
    notifyListeners();
  }

  void onChatWithBtnTap() {
    PrefService.getUserData().then((value) {
      ChatUser chatUser = ChatUser(
        age: '${userData?.age ?? ''}',
        city: userData?.live ?? '',
        image: userData?.images == null || userData!.images!.isEmpty
            ? ''
            : userData?.images?[0].image,
        userIdentity: userData?.identity,
        userid: userData?.id,
        isNewMsg: false,
        isHost: userData?.isVerified == 2 ? true : false,
        date: DateTime.now().millisecondsSinceEpoch.toDouble(),
        username: userData?.fullname,
      );
      Conversation conversation = Conversation(
        block:
            _registrationUserData?.blockedUsers?.contains('${userData?.id}') ==
                    true
                ? true
                : false,
        blockFromOther:
            userData?.blockedUsers?.contains('${_registrationUserData?.id}') ==
                    true
                ? true
                : false,
        conversationId: '${value?.identity}${userData?.identity}',
        deletedId: '',
        time: DateTime.now().millisecondsSinceEpoch.toDouble(),
        isDeleted: false,
        isMute: false,
        lastMsg: '',
        newMsg: '',
        user: chatUser,
      );
      Get.to(() => const ChatScreen(), arguments: conversation)?.then((value) {
        registrationUserApiCall();
      });
    });
  }

  void onShareProfileBtnTap() {
    shareLink(userData);
  }

  void onReportTap() {
    Get.bottomSheet(
      const UserReportSheet(),
      isScrollControlled: true,
      settings: RouteSettings(
        arguments: {
          AppRes.reportName: userData?.fullname,
          AppRes.reportImage:
              userData?.images == null || userData!.images!.isEmpty
                  ? ''
                  : userData?.images?[0].image,
          AppRes.reportAge: userData?.age ?? '',
          AppRes.reportAddress: userData?.live
        },
      ),
    );
  }

  double calculateDistance({lat1, lon1, lat2, lon2}) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
