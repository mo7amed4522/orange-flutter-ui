import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orange_ui/model/chat_and_live_stream/fetch_live_stream_history.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class CenterAreaLiveStream extends StatelessWidget {
  final List<FetchLiveStreamHistoryData>? dataList;
  final ScrollController controller;

  const CenterAreaLiveStream(
      {Key? key, required this.dataList, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: controller,
        padding: EdgeInsets.zero,
        itemCount: dataList?.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return customContainer(
            time: dataList?[index].startedAt,
            streamed: dataList?[index].streamedFor,
            collected: dataList?[index].amountCollected.toString(),
            date: dataList?[index].updatedAt,
          );
        },
      ),
    );
  }

  Widget customContainer(
      {String? time, String? date, String? streamed, String? collected}) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.only(top: 12, left: 13, bottom: 12, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorRes.grey26,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                AppRes.time,
                style: TextStyle(
                  color: ColorRes.grey28,
                  fontFamily: FontRes.semiBold,
                ),
              ),
              Expanded(
                child: Text(
                  " $time",
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorRes.grey27,
                  ),
                ),
              ),
              Text(
                DateFormat('dd MMM yyyy').format(DateTime.parse('$date')),
                style: const TextStyle(
                  fontSize: 14,
                  color: ColorRes.grey27,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              const Text(
                AppRes.streamed,
                style: TextStyle(
                  color: ColorRes.grey28,
                  fontFamily: FontRes.semiBold,
                ),
              ),
              Text(
                " $streamed",
                style: const TextStyle(
                  fontFamily: FontRes.regular,
                  fontSize: 14,
                  color: ColorRes.grey27,
                ),
              )
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              const Text(
                AppRes.diamond,
                style: TextStyle(
                  color: ColorRes.grey28,
                  fontFamily: FontRes.semiBold,
                ),
              ),
              Text(
                " $collected",
                style: const TextStyle(
                  fontFamily: FontRes.regular,
                  fontSize: 14,
                  color: ColorRes.grey27,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
