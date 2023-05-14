import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';

class TextFieldController extends GetxController {
  Rx<String> address = AppRes.newYorkUsa.obs;
  Rx<String> bio = AppRes.profileBioText.obs;
  Rx<String> age = AppRes.twentyFour.obs;

  void onAddressChange(String? value) {
    if (value != null) {
      address.value = value;
    }
  }

  void onBioChange(String? value) {
    if (value != null) {
      bio.value = value;
    }
  }

  void onAgeChange(String? value) {
    if (value != null) {
      age.value = value;
    }
  }
}
