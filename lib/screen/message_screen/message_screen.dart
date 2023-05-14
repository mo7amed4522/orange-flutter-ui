import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/model/chat_and_live_stream/chat.dart';
import 'package:orange_ui/screen/message_screen/message_screen_view_model.dart';
import 'package:orange_ui/screen/message_screen/widgets/user_card.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

import 'widgets/message_top_area.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => MessageScreenViewModel(),
      builder: (context, model, child) {
        return Container(
          color: ColorRes.white,
          child: Column(
            children: [
              MessageTopArea(
                onNotificationTap: model.onNotificationTap,
                onSearchTap: model.onSearchTap,
              ),
              const SizedBox(height: 3),
              if (model.isLoading)
                Expanded(child: Loader().lottieWidget())
              else
                Expanded(
                  child: model.userList.isEmpty
                      ? const Center(
                          child: Text(
                            'No Data',
                            style: TextStyle(
                                color: ColorRes.grey14,
                                fontFamily: FontRes.semiBold,
                                fontSize: 17),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          itemCount: model.userList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Conversation? conversation = model.userList[index];
                            ChatUser? chatUser = conversation?.user;
                            return InkWell(
                              onTap: () {
                                model.onUserTap(conversation);
                              },
                              onLongPress: () {
                                model.onLongPress(conversation);
                              },
                              child: UserCard(
                                name: chatUser?.username ?? '',
                                age: chatUser?.age ?? '',
                                msg: conversation!.lastMsg!.isEmpty
                                    ? ''
                                    : conversation.lastMsg,
                                time: conversation.time.toString(),
                                image: chatUser?.image ?? '',
                                newMsg: chatUser?.isNewMsg ?? false,
                                tickMark: chatUser?.isHost,
                              ),
                            );
                          },
                        ),
                ),
              const SizedBox(
                height: 10,
              ),
              if (model.bannerAd != null)
                Container(
                  alignment: Alignment.center,
                  width: model.bannerAd?.size.width.toDouble(),
                  height: model.bannerAd?.size.height.toDouble(),
                  child: AdWidget(ad: model.bannerAd!),
                ),
            ],
          ),
        );
      },
    );
  }
}
