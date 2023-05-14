import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/livestream_end_screen/livestream_end_screen_view_model.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class LivestreamEndScreen extends StatefulWidget {
  const LivestreamEndScreen({Key? key}) : super(key: key);

  @override
  State<LivestreamEndScreen> createState() => _LivestreamEndScreenState();
}

class _LivestreamEndScreenState extends State<LivestreamEndScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ViewModelBuilder<LivestreamEndScreenViewModel>.reactive(
          onModelReady: (model) {
            model.init();
          },
          viewModelBuilder: () => LivestreamEndScreenViewModel(),
          builder: (context, model, child) {
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.height / 2,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(AssetRes.worldMap),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SpinKitRipple(
                            borderWidth: 100,
                            duration: const Duration(milliseconds: 1500),
                            size: Get.width / 1.1,
                            //color: ColorRes.o,
                            itemBuilder: (BuildContext context, int index) {
                              return CircleAvatar(
                                backgroundColor:
                                    ColorRes.grey21.withOpacity(0.40),
                              );
                            },
                          ),
                          SpinKitRipple(
                            borderWidth: 50,
                            duration: const Duration(milliseconds: 1500),
                            size: Get.width / 1.5,
                            //color: ColorRes.o,
                            itemBuilder: (BuildContext context, int index) {
                              return CircleAvatar(
                                backgroundColor:
                                    ColorRes.grey21.withOpacity(0.30),
                              );
                            },
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: model.image.isNotEmpty
                                ? Image.network(
                                    '${ConstRes.aImageBaseUrl}${model.image}',
                                    height: Get.width / 2.5,
                                    width: Get.width / 2.5,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    AssetRes.themeLabel,
                                    height: Get.width / 2.5,
                                    width: Get.width / 2.5,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ScaleTransition(
                      scale: _animation,
                      child: const Text(
                        'Your live stream has been ended!\nBelow is a summary of it.',
                        style: TextStyle(
                            fontFamily: FontRes.semiBold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SizeTransition(
                              sizeFactor: _animation,
                              axis: Axis.horizontal,
                              axisAlignment: -1,
                              child: Text(model.time,
                                  style: const TextStyle(
                                      fontFamily: FontRes.semiBold,
                                      fontSize: 15)),
                            ),
                            const Text(
                              'Stream for',
                              style: TextStyle(
                                  fontFamily: FontRes.semiBold, fontSize: 15),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizeTransition(
                              sizeFactor: _animation,
                              axis: Axis.horizontal,
                              axisAlignment: -1,
                              child: Text(model.watching,
                                  style: const TextStyle(
                                      fontFamily: FontRes.semiBold,
                                      fontSize: 15)),
                            ),
                            const Text(
                              'Users',
                              style: TextStyle(
                                  fontFamily: FontRes.semiBold, fontSize: 15),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizeTransition(
                              sizeFactor: _animation,
                              axis: Axis.horizontal,
                              axisAlignment: -1,
                              child: Text(model.diamond,
                                  style: const TextStyle(
                                      fontFamily: FontRes.semiBold,
                                      fontSize: 15)),
                            ),
                            const Text(
                              '💎 Collected',
                              style: TextStyle(
                                  fontFamily: FontRes.semiBold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: model.onOkBtnClick,
                        child: Container(
                          height: 50,
                          width: Get.width,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: ColorRes.orange3.withOpacity(0.13),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              AppRes.ok,
                              style: TextStyle(
                                  color: ColorRes.orange3,
                                  fontFamily: FontRes.heavy,
                                  letterSpacing: 0.8,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
