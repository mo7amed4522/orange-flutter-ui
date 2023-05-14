import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class UserCard extends StatelessWidget {
  final String? name;
  final String? age;
  final String? msg;
  final String? time;
  final String? image;
  final bool newMsg;
  final bool? tickMark;

  const UserCard({
    Key? key,
    required this.name,
    required this.age,
    required this.msg,
    required this.time,
    required this.image,
    required this.newMsg,
    required this.tickMark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding:
              const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 11),
          height: 74,
          width: Get.width,
          decoration: BoxDecoration(
            color: ColorRes.skyBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: image == null || image!.isEmpty
                    ? Image.asset(
                        AssetRes.themeLabel,
                        height: 53,
                        width: 53,
                      )
                    : CachedNetworkImage(
                        imageUrl: '${ConstRes.aImageBaseUrl}$image',
                        height: 53,
                        width: 53,
                        fit: BoxFit.cover,
                        cacheKey: '${ConstRes.aImageBaseUrl}$image',
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            AssetRes.themeLabel,
                            height: 53,
                            width: 53,
                          );
                        },
                      ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: Text(
                                    '$name',
                                    softWrap: false,
                                    style: const TextStyle(
                                        color: ColorRes.veryDarkGrey3,
                                        fontFamily: FontRes.bold,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    ' ${age ?? ''}',
                                    style: const TextStyle(fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: tickMark == true
                                      ? Image.asset(
                                          AssetRes.tickMark,
                                          height: 17.5,
                                          width: 18.33,
                                        )
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            ConstRes.readTimestamp(
                              double.parse(time ?? ''),
                            ),
                            style: const TextStyle(
                                fontSize: 12, color: ColorRes.grey4),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 20,
                            child: Text(
                              '$msg',
                              style: const TextStyle(
                                fontSize: 14,
                                color: ColorRes.grey3,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const Spacer(),
                          Visibility(
                            visible: newMsg,
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: newMsg
                                    ? const LinearGradient(
                                        colors: [
                                          ColorRes.orange2,
                                          ColorRes.red2,
                                        ],
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
