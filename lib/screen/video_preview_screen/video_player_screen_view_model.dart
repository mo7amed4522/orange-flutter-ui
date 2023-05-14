import 'dart:async';

import 'package:get/get.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenViewModel extends BaseViewModel {
  String videoPath = '';
  late VideoPlayerController videoPlayerController;
  late Timer timer;
  late Duration duration;
  bool isExceptionError = false;

  void init() {
    videoPath = Get.arguments;
    videoInit();
  }

  void videoInit() {
    duration = const Duration();
    videoPlayerController = VideoPlayerController.network(
      '${ConstRes.aImageBaseUrl}$videoPath',
    )..initialize().then((value) {
        videoPlayerController.play();
        timer = Timer.periodic(videoPlayerController.value.position, (timer) {
          duration = videoPlayerController.value.position;
          notifyListeners();
        });
      }).onError((e, e1) {
        isExceptionError = true;
        notifyListeners();
      }).catchError((e) {
        isExceptionError = true;
        notifyListeners();
      });
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onPlayPauseTap() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      notifyListeners();
    } else {
      videoPlayerController.play();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    isExceptionError ? null : timer.cancel();
    // chewieController.dispose();
    super.dispose();
  }
}
