import 'package:flutter/material.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/screen/live_stream_history_screen/widgets/center_area_live_stream_history.dart';
import 'package:orange_ui/screen/live_stream_history_screen/widgets/live_stream_history_top_bar.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

import 'live_stream_history_screen_view_model.dart';

class LiveStreamHistory extends StatelessWidget {
  const LiveStreamHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LiveStreamHistoryViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => LiveStreamHistoryViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              LiveStreamTopBar(onBackBtnTap: model.onBackBtnTap),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                width: MediaQuery.of(context).size.width,
                color: ColorRes.grey5,
              ),
              const SizedBox(
                height: 12,
              ),
              model.isLoading
                  ? Expanded(child: Loader().lottieWidget())
                  : CenterAreaLiveStream(
                      dataList: model.liveStreamHistory,
                      controller: model.scrollController,
                    ),
            ],
          ),
        );
      },
    );
  }
}
