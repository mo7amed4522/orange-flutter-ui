import 'package:flutter/material.dart';
import 'package:orange_ui/screen/video_preview_screen/video_player_screen_view_model.dart';
import 'package:orange_ui/screen/video_preview_screen/widget/video_player_top_bar_area.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoPlayerScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => VideoPlayerScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            children: [
              VideoPlayerTopBarArea(onBackBtnTap: model.onBackBtnTap),
              Expanded(
                child: model.isExceptionError
                    ? const Center(
                        child: Text('Failed to load video: Cannot Open'))
                    : Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.height / 1.3,
                              height: MediaQuery.of(context).size.height / 1.3,
                              margin: const EdgeInsets.all(10),
                              child: VideoPlayer(model.videoPlayerController),
                            ),
                          ),
                          InkWell(
                            onTap: model.onPlayPauseTap,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  !model.videoPlayerController.value.isPlaying
                                      ? Icons.play_arrow
                                      : Icons.pause,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${_printDuration(model.duration)} / ${_printDuration(model.videoPlayerController.value.duration)}'),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: VideoProgressIndicator(
                                  model.videoPlayerController,
                                  allowScrubbing: true,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
              )
            ],
          ),
        );
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
