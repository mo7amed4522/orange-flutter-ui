import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/video_preview_screen/video_preview_screen_view_model.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatelessWidget {
  const VideoPreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorRes.black,
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
    );
    return ViewModelBuilder<VideoPlayerScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => VideoPlayerScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.black,
          body: SafeArea(
            child: Stack(
              children: [
                model.isExceptionError
                    ? const Text(
                        AppRes.failedToLoadVideo,
                        style: TextStyle(color: ColorRes.white),
                      )
                    : Center(
                        child: AspectRatio(
                          aspectRatio:
                              model.videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(model.videoPlayerController),
                        ),
                      ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: InkWell(
                    onTap: model.onBackBtnTap,
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: ColorRes.white,
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: Get.height / 1.2,
                    width: double.infinity,
                    child: InkWell(
                      onTap: model.onPlayPauseTap,
                      splashColor: ColorRes.transparent,
                      highlightColor: ColorRes.transparent,
                      child: AnimatedOpacity(
                        opacity: model.isUIVisible == true ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 500),
                        child: Icon(
                          model.videoPlayerController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: ColorRes.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_printDuration(model.duration)} / ${_printDuration(model.videoPlayerController.value.duration)}',
                        style: const TextStyle(color: ColorRes.white),
                      ),
                      VideoProgressIndicator(
                        model.videoPlayerController,
                        allowScrubbing: true,
                        padding: const EdgeInsets.only(bottom: 15, top: 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigits(duration.inHours) == '00') {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
