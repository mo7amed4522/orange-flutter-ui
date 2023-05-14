import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/model/chat_and_live_stream/chat.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/chat_screen/chat_screen.dart';
import 'package:orange_ui/screen/notification_screen/notification_screen.dart';
import 'package:orange_ui/screen/search_screen/search_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

import '../../common/widgets/confirmation_dialog.dart';

class MessageScreenViewModel extends BaseViewModel {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Conversation?> userList = [];
  Conversation? conversation;
  bool isLoading = false;
  StreamSubscription<QuerySnapshot<Conversation>>? subscription;
  RegistrationUserData? userData;
  BannerAd? bannerAd;

  void init() {
    getChatUsers();
    getProfileApi();
    getBannerAd();
  }

  void onNotificationTap() {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const NotificationScreen());
  }

  void getProfileApi() {
    ApiProvider().getProfile(userID: ConstRes.aUserId).then((value) {
      userData = value?.data;
      notifyListeners();
    });
  }

  void onSearchTap() {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const SearchScreen());
  }

  void onUserTap(Conversation? conversation) {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const ChatScreen(), arguments: conversation);
  }

  void getChatUsers() {
    isLoading = true;
    PrefService.getUserData().then((value) {
      subscription = db
          .collection(FirebaseConst.userChatList)
          .doc(value?.identity)
          .collection(FirebaseConst.userList)
          .orderBy(FirebaseConst.time, descending: true)
          .withConverter(
              fromFirestore: Conversation.fromFirestore,
              toFirestore: (Conversation value, options) => value.toFirestore())
          .snapshots()
          .listen((element) {
        userList = [];
        for (int i = 0; i < element.docs.length; i++) {
          if (element.docs[i].data().isDeleted == false) {
            userList.add(element.docs[i].data());
            notifyListeners();
          }
        }
        isLoading = false;
        notifyListeners();
      });
    });
  }

  void getBannerAd() {
    CommonFun.bannerAd((ad) {
      bannerAd = ad as BannerAd;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void onLongPress(Conversation? conversation) {
    HapticFeedback.vibrate();
    Get.dialog(
      ConfirmationDialog(
        aspectRatio: 1 / 0.6,
        clickText1: AppRes.deleteChat,
        clickText2: AppRes.cancel,
        heading: AppRes.deleteThisChat,
        subDescription: AppRes.messageWillOnlyBeRemoved,
        onNoBtnClick: () {
          Get.back();
        },
        onYesBtnClick: () {
          db
              .collection(FirebaseConst.userChatList)
              .doc(userData?.identity)
              .collection(FirebaseConst.userList)
              .doc(conversation?.user?.userIdentity)
              .update({
            FirebaseConst.isDeleted: true,
            FirebaseConst.deletedId: '${DateTime.now().millisecondsSinceEpoch}',
            FirebaseConst.block: false,
            FirebaseConst.blockFromOther: false,
          }).then((value) {
            Get.back();
          });
        },
        horizontalPadding: 65,
      ),
    );
    notifyListeners();
  }
}
