import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class CreateCallScreenViewModel extends BaseViewModel {
  void init() {}

  void onCancelTap() {
    Get.back();
  }

  void onCallingTap() {
    // Get.off(() => const IncomingCallScreen());
  }
}
