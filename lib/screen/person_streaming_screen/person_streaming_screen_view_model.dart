import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/model/chat_and_live_stream/live_stream.dart';
import 'package:orange_ui/model/setting.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/bottom_diamond_shop/bottom_diamond_shop.dart';
import 'package:orange_ui/screen/explore_screen/widgets/reverse_swipe_dialog.dart';
import 'package:orange_ui/screen/person_streaming_screen/widgets/bottom_purchase_shit.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen.dart';
import 'package:orange_ui/screen/user_report_screen/report_sheet.dart';
import 'package:orange_ui/service/agora_service.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:wakelock/wakelock.dart';

class PersonStreamingScreenViewModel extends BaseViewModel {
  FirebaseFirestore db = FirebaseFirestore.instance;

  String channel = '';
  String userName = '';

  int streamId = -1;
  int countDownValue = 0;
  int? walletCoin;

  List<LiveStreamComment> commentList = [];
  List<int> users = <int>[];
  List<Gifts>? diamondList = [];
  List<int>? gemsList = [];

  Timer? timer;

  bool isBroadcasting = false;
  bool muted = false;
  bool isSelected = false;

  late RtcEngine _engine;
  LiveStreamUser? liveStreamUser = LiveStreamUser();
  CollectionReference? collectionReference;
  RegistrationUserData? registrationUser;
  TextEditingController commentController = TextEditingController();
  FocusNode commentFocus = FocusNode();
  BottomController bottomController = Get.put(BottomController());
  StringBuffer concatenate = StringBuffer();

  void init() {
    Wakelock.enable();
    channel = Get.arguments[ConstRes.aChannelId];
    isBroadcasting = Get.arguments[ConstRes.aIsBroadcasting];
    liveStreamUser = Get.arguments[ConstRes.aUserInfo];
    initializeAgora();
    getDiamondPackApiCall();
    giftApiCall();
  }

  void countDown() async {
    if (registrationUser?.isFake != 1) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          countDownValue++;
          if (countDownValue == 60) {
            !isSelected ? timer.cancel() : null;
            if (ConstRes.liveWatchingPrice <= walletCoin! && walletCoin != 0) {
              isSelected
                  ? autoDebitCoin()
                  : Get.dialog(
                      ReverseSwipeDialog(
                          onCancelTap: () {
                            watchingUserRemove();
                            if (Get.isBottomSheetOpen == true) {
                              Get.back();
                            }
                            Get.back();
                            Get.back();
                            _engine.destroy();
                          },
                          onContinueTap: (isSelected) async {
                            await PrefService.setDialog(
                                PrefConst.liveStream, isSelected);
                            minusCoinApi();
                            countDownValue = 0;
                            countDown();
                            Get.back();
                          },
                          isCheckBoxVisible: true,
                          walletCoin: walletCoin,
                          title1: AppRes.liveCap,
                          title2: AppRes.streamCap,
                          dialogDisc: AppRes.liveStreamDisc,
                          coinPrice: '${ConstRes.liveWatchingPrice}'),
                      barrierColor: ColorRes.black3.withOpacity(0.44),
                    );
            } else {
              timer.cancel();
              Get.dialog(
                EmptyWalletDialog(
                  walletCoin: walletCoin,
                  onContinueTap: () {
                    Get.back();
                    Get.bottomSheet(
                      const BottomDiamondShop(),
                    ).then((value) {
                      if (Get.isBottomSheetOpen == true) {
                        //
                      } else {
                        watchingUserRemove();
                        Get.back();
                      }
                    });
                  },
                  onCancelTap: () {
                    watchingUserRemove();
                    if (Get.isBottomSheetOpen == true) {
                      Get.back();
                    }
                    Get.back();
                    Get.back();
                  },
                ),
              );
            }
          }
          notifyListeners();
        },
      );
    }
  }

  Future<void> minusCoinApi() async {
    await ApiProvider().minusCoinFromWallet(ConstRes.liveWatchingPrice);
    getProfileApiCall();
  }

  void autoDebitCoin() {
    minusCoinApi().then((value) {
      getProfileApiCall();
      countDownValue = 0;
      countDown();
    });
  }

  void giftApiCall() {
    ApiProvider().getSettingData().then((value) {
      diamondList = value.data?.gifts;
      notifyListeners();
    });
    getProfileApiCall();
  }

  void getDiamondPackApiCall() {
    ApiProvider().getDiamondPack().then((value) {
      notifyListeners();
    });
  }

  Future<void> getProfileApiCall() async {
    ApiProvider().getProfile(userID: ConstRes.aUserId).then((value) async {
      isSelected = await PrefService.getDialog(PrefConst.liveStream) ?? false;
      walletCoin = value?.data?.wallet;
      notifyListeners();
    });
  }

  Future<void> initializeAgora() async {
    await _initAgoraRtcEngine();
    // if (widget.isBroadcaster) {
    //   streamId = (await _engine.createDataStream(false, false))!;
    // }
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        notifyListeners();
      },
      userJoined: (uid, elapsed) {
        users.add(uid);
        notifyListeners();
      },
      leaveChannel: (stats) {
      },
      userOffline: (uid, elapsed) {
        users.remove(uid);
        if (Get.isDialogOpen == true) {
          Get.back();
        } else if (Get.isBottomSheetOpen == true) {
          Get.back();
        }
        Get.back();
        notifyListeners();
      },
    ));
    await _engine.joinChannel(null, channel, null, 0);
    initFirebase();
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(agoraId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Audience);
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (isBroadcasting) {
      list.add(const rtc_local_view.SurfaceView(
        mirrorMode: VideoMirrorMode.Auto,
      ));
    }
    for (var uid in users) {
      list.add(rtc_remote_view.SurfaceView(
        uid: uid,
        channelId: channel,
        mirrorMode: VideoMirrorMode.Enabled,
      ));
    }
    return list;
  }

  /// Video view row wrapper
  Widget _expandedVideoView(List<Widget> views) {
    final wrappedViews = views
        .map<Widget>((view) => Expanded(child: Container(child: view)))
        .toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget broadcastView() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Column(
          children: <Widget>[
            _expandedVideoView([views[0]])
          ],
        );
      case 2:
        return Column(
          children: <Widget>[
            _expandedVideoView([views[0]]),
            _expandedVideoView([views[1]])
          ],
        );
      case 3:
        return Column(
          children: <Widget>[
            _expandedVideoView(views.sublist(0, 2)),
            _expandedVideoView(views.sublist(2, 3))
          ],
        );
      case 4:
        return Column(
          children: <Widget>[
            _expandedVideoView(views.sublist(0, 2)),
            _expandedVideoView(views.sublist(2, 4))
          ],
        );
      default:
    }
    return Container();
  }

  void onViewTap() {}

  void onMoreBtnTap() {
    Get.bottomSheet(const UserReportSheet(),
        isScrollControlled: true,
        settings: RouteSettings(
          arguments: {
            AppRes.reportName: liveStreamUser?.fullName,
            AppRes.reportImage: liveStreamUser?.userImage,
            AppRes.reportAge: liveStreamUser?.age,
            AppRes.reportAddress: liveStreamUser?.address
          },
        ));
  }

  void onCommentSend() {
    if (commentController.text.trim().isNotEmpty) {
      collectionReference?.add(LiveStreamComment(
        id: DateTime.now().millisecondsSinceEpoch,
        userImage: registrationUser?.images != null ||
                registrationUser!.images!.isNotEmpty
            ? registrationUser?.images![0].image
            : '',
        userId: registrationUser?.id,
        city: registrationUser?.live ?? '',
        isHost: false,
        comment: commentController.text.trim(),
        commentType: FirebaseConst.msg,
        userName: registrationUser?.fullname ?? '',
      ).toJson());
    }
    commentController.clear();
    commentFocus.unfocus();
  }

  void onGiftBtnTap() {
    getProfileApiCall().then(
      (value) {
        bottomController.showDiamondShop.value = false;
        Get.bottomSheet(
          Obx(
            () {
              if (bottomController.showDiamondShop.isFalse) {
                return BottomPurchaseShirt(
                  diamondList: diamondList,
                  onGemsSubmit: onGemsSubmit,
                  onAddDiamonds: onAddDiamonds,
                  onGiftTap: onGiftTap,
                  diamond: walletCoin,
                  onGiftDiamondEmpty: onGiftDiamondEmpty,
                  userData: registrationUser,
                );
              } else {
                return const BottomDiamondShop();
              }
            },
          ),
        ).then((value) {
          commentFocus.unfocus();
        });
      },
    );
  }

  void onGiftDiamondEmpty() {
    bottomController.showDiamondShop.value = true;
  }

  void onGoPremiumTap() {
    // Get.to(() => const PremiumScreen());
  }

  void onGemsSubmit() {}

  void onAddDiamonds() {
    bottomController.onAddDiamonds();
  }

  Future<void> onGiftTap(Gifts? data) async {
    collectionReference?.add(LiveStreamComment(
      id: DateTime.now().millisecondsSinceEpoch,
      userImage: registrationUser?.images != null ||
              registrationUser!.images!.isNotEmpty
          ? registrationUser?.images![0].image
          : '',
      userId: registrationUser?.id,
      city: registrationUser?.live ?? '',
      isHost: false,
      comment: data?.image ?? '',
      commentType: FirebaseConst.image,
      userName: registrationUser?.fullname ?? '',
    ).toJson());

    db
        .collection(FirebaseConst.liveHostList)
        .doc(liveStreamUser?.hostIdentity)
        .update({
      FirebaseConst.collectedDiamond:
          liveStreamUser!.collectedDiamond! + data!.coinPrice!
    }).catchError((e) {
      debugPrint(e);
    });
    await ApiProvider().minusCoinFromWallet(data.coinPrice);
    Get.back();
  }

  void initFirebase() async {
    await PrefService.getUserData().then((value) {
      registrationUser = value;
      notifyListeners();
    });
    countDown();
    db
        .collection(FirebaseConst.liveHostList)
        .doc(liveStreamUser?.hostIdentity)
        .withConverter(
          fromFirestore: LiveStreamUser.fromFirestore,
          toFirestore: (value, options) {
            return LiveStreamUser().toFirestore();
          },
        )
        .snapshots()
        .any((element) {
      liveStreamUser = element.data();
      notifyListeners();
      return false;
    });

    collectionReference = db
        .collection(FirebaseConst.liveHostList)
        .doc(liveStreamUser?.hostIdentity)
        .collection(FirebaseConst.comments);

    collectionReference
        ?.orderBy(FirebaseConst.id, descending: true)
        .withConverter(
          fromFirestore: LiveStreamComment.fromFirestore,
          toFirestore: (LiveStreamComment value, options) {
            return value.toFirestore();
          },
        )
        .snapshots()
        .any((element) {
      commentList = [];
      for (int i = 0; i < element.docs.length; i++) {
        commentList.add(element.docs[i].data());
        notifyListeners();
      }
      return false;
    });
  }

  void onUserTap() {
    watchingUserRemove();
    Get.off(() => const UserDetailScreen(), arguments: liveStreamUser?.userId);
  }

  void onExitTap() async {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return Center(child: Loader().lottieWidget());
      },
    );
    watchingUserRemove();
    Get.back();
    Get.back();
  }

  void onBackTap() {
    Get.back();
  }

  void watchingUserRemove() {
    db
        .collection(FirebaseConst.liveHostList)
        .doc(liveStreamUser?.hostIdentity)
        .update(
      {
        FirebaseConst.watchingCount:
            liveStreamUser != null && liveStreamUser?.watchingCount != null
                ? liveStreamUser!.watchingCount! - 1
                : 0
      },
    );
  }

  @override
  void dispose() {
    Wakelock.disable();
    // clear users
    users.clear();
    // destroy sdk and leave channel
    timer?.cancel();
    _engine.destroy();
    super.dispose();
  }
}

class BottomController extends GetxController {
  Rx<bool> showDiamondShop = false.obs;

  void onAddDiamonds() {
    showDiamondShop.value = true;
  }

  void onDiamondPurchase() {
    showDiamondShop.value = false;
  }
}
