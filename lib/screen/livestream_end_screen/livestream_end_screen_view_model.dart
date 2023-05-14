import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:stacked/stacked.dart';

import '../../api_provider/api_provider.dart';

class LivestreamEndScreenViewModel extends BaseViewModel {
  void init() {
    getPref();
  }

  String watching = '0';
  String diamond = '0';
  String image = '';
  String time = '';
  String date = '';

  void getPref() async {
    watching = await PrefService.getString('watching') ?? '';
    diamond = await PrefService.getString('diamond') ?? '';
    image = await PrefService.getString('userImage') ?? '';
    time = await PrefService.getString('time') ?? '';
    date = await PrefService.getString('date') ?? '';
    notifyListeners();
  }

  void addCoinWallet(int? amount) async {
    await ApiProvider().addCoinFromWallet(amount);
  }

  void onOkBtnClick() {
    addCoinWallet(int.parse(diamond));
    addLiveStreamHistoryApiCall();
    Get.back();
  }

  void addLiveStreamHistoryApiCall() async {
    await ApiProvider().addLiveStreamHistory(
        amountCollected: diamond,
        startedAt: DateFormat('h:mm a').format(DateTime.parse(date)),
        streamFor: dateTime(time));
  }

  String dateTime(String date) {
    String hours = date.split(':')[0];
    String minutes = date.split(':')[1];
    String second = date.split(':')[2];
    if (hours == '00' && minutes == '00') {
      return '$second sec';
    }
    if (hours == '00') {
      return '$minutes mins $second sec';
    }
    return '$hours hr $minutes mins';
  }
}
