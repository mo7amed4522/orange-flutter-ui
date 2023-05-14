import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:orange_ui/model/notification/admin_notification.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class AdminNotificationPage extends StatelessWidget {
  final List<AdminNotificationData>? adminNotification;
  final ScrollController controller;

  const AdminNotificationPage(
      {Key? key, this.adminNotification, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return adminNotification == null || adminNotification!.isEmpty
        ? Center(
            child: LottieBuilder.asset(
              AssetRes.emptyListLottie,
              height: 200,
              width: 200,
            ),
          )
        : ListView.builder(
            controller: controller,
            padding: const EdgeInsets.only(top: 15),
            itemCount: adminNotification?.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 16, right: 19, bottom: 18),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorRes.lightOrange1,
                            ColorRes.darkOrange,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 13),
                    SizedBox(
                      width: Get.width - 94,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${adminNotification?[index].title}',
                                style: const TextStyle(
                                  fontFamily: FontRes.bold,
                                  fontSize: 15,
                                  color: ColorRes.darkGrey4,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                adminNotification != null
                                    ? ConstRes.timeAgo(DateTime.parse(
                                        '${adminNotification?[index].createdAt}'))
                                    : '',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: ColorRes.grey7,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${adminNotification?[index].message}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: ColorRes.grey6,
                            ),
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
}
