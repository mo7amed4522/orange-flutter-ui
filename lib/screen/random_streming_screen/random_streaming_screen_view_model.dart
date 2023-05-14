import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/confirmation_dialog.dart';
import 'package:orange_ui/model/chat_and_live_stream/live_stream.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/livestream_end_screen/livestream_end_screen.dart';
import 'package:orange_ui/service/agora_service.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:wakelock/wakelock.dart';

class RandomStreamingScreenViewModel extends BaseViewModel {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String channelName = '';
  String? identity;
  late RtcEngine engine;
  int streamId = -1;
  bool isBroadcaster = false;
  bool muted = false;
  TextEditingController commentController = TextEditingController();
  FocusNode commentFocus = FocusNode();
  List<LiveStreamComment> commentList = [];
  final users = <int>[];
  LiveStreamUser? liveStreamUser;
  DocumentReference? collectionReference;
  RegistrationUserData? registrationUserData;
  Stopwatch watch = Stopwatch();
  late Timer timer;
  bool startStop = true;
  String elapsedTime = '';
  List<String> timeAdd = [];
  ScrollController scrollController = ScrollController();
  DateTime? dateTime;
  int count = ConstRes.maximumMinutes * ConstRes.minimumUserLive;
  Timer? minimumUserLiveTimer;
  int countTimer = 0;
  int maxMinutes = ConstRes.maximumMinutes * 60;

  void init() {
    Wakelock.enable();
    channelName = Get.arguments[ConstRes.aChannelId];
    isBroadcaster = Get.arguments[ConstRes.aIsBroadcasting];
    getValueFromPrefs();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    await _initAgoraRtcEngine();
    startWatch();
    if (isBroadcaster) {
      streamId = (await engine.createDataStream(false, false))!;
    }
    engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        notifyListeners();
      },
      userJoined: (uid, elapsed) {
        users.add(uid);
        notifyListeners();
      },
    ));
    await engine.joinChannel(null, channelName, null, 0).catchError((e) {});
  }

  Future<void> _initAgoraRtcEngine() async {
    engine = await RtcEngine.create(agoraId);
    await engine.enableVideo();
    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (isBroadcaster) {
      await engine.setClientRole(ClientRole.Broadcaster);
    } else {
      await engine.setClientRole(ClientRole.Audience);
    }
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (isBroadcaster) {
      list.add(const rtc_local_view.SurfaceView(
        mirrorMode: VideoMirrorMode.Auto,
      ));
    }
    for (var uid in users) {
      list.add(rtc_remote_view.SurfaceView(
        uid: uid,
        channelId: channelName,
      ));
    }
    // debugPrint('list of users :- ${list.length}');
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
            _expandedVideoView([views[0]]),
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

  Future<void> getValueFromPrefs() async {
    PrefService.getUserData().then((value) {
      identity = value?.identity;
    });
    initializeFireStore();
  }

  void onEndVideoTap() {
    stopWatch();
    savePrefData().then(
      (value) async {
        disClosed();
        db.collection(FirebaseConst.liveHostList).doc(identity).delete();
        final batch = db.batch();
        var collection = db
            .collection(FirebaseConst.liveHostList)
            .doc(identity)
            .collection(FirebaseConst.comments);
        var snapshots = await collection.get();
        for (var doc in snapshots.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        Get.off(
          () => const LivestreamEndScreen(),
        );
      },
    );
  }

  void disClosed() {
    // clear users
    users.clear();
    // destroy sdk and leave channel
    engine.destroy();
  }

  Future<void> savePrefData() async {
    PrefService.saveString(
        PrefConst.watching, '${liveStreamUser?.joinedUser?.length ?? '0'}');
    PrefService.saveString(
        PrefConst.diamond, '${liveStreamUser?.collectedDiamond ?? '0'}');
    PrefService.saveString(
        PrefConst.userImage, liveStreamUser?.userImage ?? '');
    PrefService.saveString(PrefConst.date, dateTime.toString());
  }

  void onEndBtnTap() async {
    Get.dialog(
      ConfirmationDialog(
          onNoBtnClick: onBackBtnTap,
          onYesBtnClick: onEndVideoTap,
          subDescription: AppRes.areYouSureYouWantToEnd,
          aspectRatio: 1 / 0.65,
          horizontalPadding: 70,
          clickText1: AppRes.yes,
          clickText2: AppRes.no,
          heading: AppRes.areYouSure),
    );
  }

  void onCameraTap() {
    engine.switchCamera();
  }

  void onSpeakerTap() {
    muted = !muted;
    notifyListeners();
    engine.muteLocalAudioStream(muted);
  }

  void onDiamondTap() {}

  void onCommentSend() {
    if (commentController.text.trim().isNotEmpty) {
      collectionReference
          ?.collection(FirebaseConst.comments)
          .add(LiveStreamComment(
            id: DateTime.now().millisecondsSinceEpoch,
            userImage: registrationUserData?.images != null ||
                    registrationUserData!.images!.isNotEmpty
                ? registrationUserData?.images![0].image
                : '',
            userId: registrationUserData?.id,
            city: registrationUserData?.live ?? '',
            isHost: false,
            comment: commentController.text.trim(),
            commentType: FirebaseConst.msg,
            userName: registrationUserData?.fullname ?? '',
          ).toJson());
    }
    commentController.clear();
    commentFocus.unfocus();
  }

  void onBackBtnTap() {
    Get.back();
  }

  void initializeFireStore() {
    PrefService.getUserData().then((value) {
      registrationUserData = value;
      collectionReference =
          db.collection(FirebaseConst.liveHostList).doc(value?.identity);

      collectionReference
          ?.withConverter(
            fromFirestore: LiveStreamUser.fromFirestore,
            toFirestore: (LiveStreamUser value, options) {
              return LiveStreamUser().toFirestore();
            },
          )
          .snapshots()
          .any((element) {
        liveStreamUser = element.data();
        minimumUserLiveTimer ??=
            Timer.periodic(const Duration(seconds: 1), (timer) {
          countTimer++;
          if (countTimer == maxMinutes &&
              liveStreamUser!.watchingCount! <= ConstRes.minimumUserLive) {
            timer.cancel();
            onEndVideoTap();
          }
          if (countTimer == maxMinutes) {
            countTimer = 0;
          }
        });
        notifyListeners();
        return false;
      });
      collectionReference
          ?.collection(FirebaseConst.comments)
          .orderBy(FirebaseConst.id, descending: true)
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
    });
  }

  updateTime(Timer timer) {
    if (watch.isRunning) {
      elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      notifyListeners();
    }
  }

  void startWatch() {
    startStop = false;
    watch.start();
    timer = Timer.periodic(const Duration(milliseconds: 100), updateTime);
    dateTime = DateTime.now();
    notifyListeners();
  }

  void stopWatch() {
    startStop = true;
    watch.stop();
    setTime();
    PrefService.saveString(FirebaseConst.time, elapsedTime);
    notifyListeners();
  }

  void setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    elapsedTime = transformMilliSeconds(timeSoFar);
    notifyListeners();
  }

  String transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  void dispose() {
    Wakelock.disable();
    minimumUserLiveTimer?.cancel();
    scrollController.dispose();
    commentController.dispose();
    timer.cancel();
    // destroy sdk and leave channel
    engine.destroy();
    super.dispose();
  }
}
