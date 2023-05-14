import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orange_ui/screen/chat_screen/view_model/chat_screen_view_model.dart';
import 'package:orange_ui/screen/chat_screen/widgets/bottom_input_bar.dart';
import 'package:orange_ui/screen/chat_screen/widgets/bottom_selected_item_bar.dart';
import 'package:orange_ui/screen/chat_screen/widgets/chat_area.dart';
import 'package:orange_ui/screen/chat_screen/widgets/top_bar_area.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => ChatScreenViewModel(),
      builder: (context, model, child) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
        );
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              TopBarArea(
                conversation: model.conversation,
                onBack: model.onBackBtnTap,
                onMoreBtnTap: model.onMoreBtnTap,
                blockUnblock: model.blockUnblock,
                onUserTap: model.onUserTap,
                msgFocusNode: model.msgFocusNode,
              ),
              ChatArea(
                chatData: model.grouped,
                onImageTap: model.onImageTap,
                scrollController: model.scrollController,
                onVideoItemClick: model.onVideoItemClick,
                onLongPress: model.onLongPress,
                timeStamp: model.timeStamp,
              ),
              if (model.timeStamp.isNotEmpty)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: const Offset(0, 0.0),
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                        child: child);
                  },
                  child: BottomSelectedItemBar(
                      onCancelBtnClick: model.onCancelBtnClick,
                      selectedItemCount: model.timeStamp.length,
                      onItemDelete: model.chatDeleteDialog),
                )
              else
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: const Offset(0, 0.0),
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                        child: child);
                  },
                  child: model.isBlock == true
                      ? Center(
                          child: InkWell(
                            onTap: model.unblockDialog,
                            splashColor: ColorRes.transparent,
                            highlightColor: ColorRes.transparent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 38, vertical: 8),
                              decoration: BoxDecoration(
                                color: ColorRes.grey13,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 13),
                              child: const Text(
                                AppRes.youBlockThisUser,
                                style: TextStyle(
                                    color: ColorRes.grey14, fontSize: 12),
                              ),
                            ),
                          ),
                        )
                      : BottomInputBar(
                          msgController: model.textMsgController,
                          msgFocusNode: model.msgFocusNode,
                          onShareBtnTap: model.sendMessage,
                          onAddBtnTap: model.onPlusTap,
                          onCameraTap: model.onCameraTap,
                        ),
                )
            ],
          ),
        );
      },
    );
  }
}
