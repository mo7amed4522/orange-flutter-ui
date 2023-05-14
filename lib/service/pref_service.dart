import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orange_ui/model/chat_and_live_stream/chat.dart';
import 'package:orange_ui/model/setting.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static Future<bool?> getLoginText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefConst.isLogin);
  }

  static Future<void> setLoginText(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefConst.isLogin, value);
  }

  static Future<bool?> getDialog(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> setDialog(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<String?> getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.fullName);
  }

  static Future<void> setFullName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.fullName, value);
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.email);
  }

  static Future<void> setEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.email, value);
  }

  static Future<String?> getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.address);
  }

  static Future<void> setAddress(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.address, value);
  }

  static Future<String?> getBioText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.bioText);
  }

  static Future<void> setBioText(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.bioText, value);
  }

  static Future<int?> getAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(PrefConst.age);
  }

  static Future<void> setAge(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefConst.age, value);
  }

  static Future<int?> getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(PrefConst.gender);
  }

  static Future<void> setGender(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefConst.gender, value);
  }

  static Future<bool?> getFirstProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefConst.firstProfile);
  }

  static Future<void> setFirstProfile(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefConst.firstProfile, value);
  }

  static Future<List<String>?> getProfileImageList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList(PrefConst.firstProfile);
    return list;
  }

  static Future<void> setProfileImageList(List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(PrefConst.firstProfile, value);
  }

  static Future<List<String>?> getInterestList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList(PrefConst.firstInterest);
    return list;
  }

  static Future<void> setInterestList(List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(PrefConst.firstInterest, value);
  }

  static Future<String?> getInstagramString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.instagram);
  }

  static Future<void> setInstagramString(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.instagram, value);
  }

  static Future<String?> getYoutubeString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.youtube);
  }

  static Future<void> setYoutubeString(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.youtube, value);
  }

  static Future<void> setLatitude(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.latitude, value);
  }

  static Future<String?> getLatitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.latitude);
  }

  static Future<void> setLongitude(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.longitude, value);
  }

  static Future<String?> getLongitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.longitude);
  }

  static Future<bool?> getOnOffNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefConst.onOffNotification);
  }

  static Future<void> setOnOffNotification(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefConst.onOffNotification, value);
  }

  static Future<bool?> getOnOffShowMeMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefConst.onOffShowMeMap);
  }

  static Future<void> setOnOffShowMeMap(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefConst.onOffShowMeMap, value);
  }

  static Future<bool?> getOnOffAnonymous() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefConst.onOffAnonymous);
  }

  static Future<void> setOnOffAnonymous(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefConst.onOffAnonymous, value);
  }

  static Future<void> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<void> saveUser(RegistrationUserData? value) async {
    if (value != null) {
      await saveString(PrefConst.registrationUser, jsonEncode(value));
    }
  }

  static void updateFirebase() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    RegistrationUserData? registrationUserData = await getUserData();
    db
        .collection(FirebaseConst.userChatList)
        .doc(registrationUserData?.identity)
        .collection(FirebaseConst.userList)
        .withConverter(
          fromFirestore: Conversation.fromFirestore,
          toFirestore: (Conversation value, options) {
            return value.toFirestore();
          },
        )
        .get()
        .then((value) {
      for (var element in value.docs) {
        db
            .collection(FirebaseConst.userChatList)
            .doc(element.data().user?.userIdentity)
            .collection(FirebaseConst.userList)
            .doc(registrationUserData?.identity)
            .withConverter(
              fromFirestore: Conversation.fromFirestore,
              toFirestore: (Conversation value, options) {
                return value.toFirestore();
              },
            )
            .get()
            .then((value) {
          ChatUser? user = value.data()?.user;
          user?.username = registrationUserData?.fullname ?? '';
          user?.age = registrationUserData?.age != null
              ? registrationUserData?.age.toString()
              : '';
          user?.image = registrationUserData?.images?[0].image ?? '';
          user?.city = registrationUserData?.live ?? '';
          db
              .collection(FirebaseConst.userChatList)
              .doc(element.data().user?.userIdentity)
              .collection(FirebaseConst.userList)
              .doc(registrationUserData?.identity)
              .update({FirebaseConst.user: user?.toJson()});
        });
      }
    });
  }

  static Future<void> saveSettingData(SettingData? value) async {
    await saveString(PrefConst.settingData, jsonEncode(value));
  }

  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<RegistrationUserData?> getUserData() async {
    String? data = await getString(PrefConst.registrationUser);
    if (data == null || data.isEmpty) return null;
    return RegistrationUserData.fromJson(jsonDecode(data));
  }

  static Future<SettingData?> getSettingData() async {
    String? data = await getString(PrefConst.settingData);
    if (data == null || data.isEmpty) return null;
    return SettingData.fromJson(jsonDecode(data));
  }
}
