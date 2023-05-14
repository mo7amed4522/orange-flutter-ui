import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:orange_ui/model/chat_and_live_stream/add_live_stream_history.dart';
import 'package:orange_ui/model/chat_and_live_stream/apply_for_live.dart';
import 'package:orange_ui/model/chat_and_live_stream/fetch_live_stream_history.dart';
import 'package:orange_ui/model/fetch_redeem_request.dart';
import 'package:orange_ui/model/get_diamond_pack.dart';
import 'package:orange_ui/model/get_explore_screen.dart';
import 'package:orange_ui/model/get_interest.dart';
import 'package:orange_ui/model/get_package.dart';
import 'package:orange_ui/model/map/fetch_user_coordinate.dart';
import 'package:orange_ui/model/notification/admin_notification.dart';
import 'package:orange_ui/model/notification/notify_like_user.dart';
import 'package:orange_ui/model/notification/on_off_anonymous.dart';
import 'package:orange_ui/model/notification/on_off_notification.dart';
import 'package:orange_ui/model/notification/on_off_show_me_map.dart';
import 'package:orange_ui/model/notification/user_notification.dart';
import 'package:orange_ui/model/place_redeem_request.dart';
import 'package:orange_ui/model/report.dart';
import 'package:orange_ui/model/search/search_user.dart';
import 'package:orange_ui/model/search/search_user_by_id.dart';
import 'package:orange_ui/model/setting.dart';
import 'package:orange_ui/model/store_file_give_path.dart';
import 'package:orange_ui/model/update_saved_profile.dart';
import 'package:orange_ui/model/user/delete_account.dart';
import 'package:orange_ui/model/user/get_profile.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/model/user/update_profile.dart';
import 'package:orange_ui/model/user_block_list.dart';
import 'package:orange_ui/model/verification.dart';
import 'package:orange_ui/model/wallet/minus_coin_from_wallet.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/const_res.dart';

class ApiProvider {
  Future<RegistrationUser> registration({
    required String? email,
    required String? fullName,
    required String? deviceToken,
    required int? loginType,
    String? password,
  }) async {
    Map<String, dynamic> map = {};
    map[ConstRes.aFullName] = fullName;
    map[ConstRes.aDeviceToken] = deviceToken;
    map[ConstRes.aDeviceType] =
        Platform.isAndroid ? ConstRes.aOne : ConstRes.aTwo;
    map[ConstRes.aLoginType] = loginType.toString();
    map[ConstRes.aIdentity] = email;
    map[ConstRes.aInterests] = '';
    if (password != null && password.isNotEmpty) {
      map[ConstRes.aPassword] = password;
    }
    http.Response response = await http.post(Uri.parse(ConstRes.aRegister),
        headers: {ConstRes.aApiKeyName: ConstRes.aApiKey}, body: map);
    return RegistrationUser.fromJson(jsonDecode(response.body));
  }

  Future<GetInterest?> getInterest() async {
    http.Response response = await http.post(Uri.parse(ConstRes.aGetInterests),
        headers: {ConstRes.aApiKeyName: ConstRes.aApiKey});
    //print(response.body);
    return GetInterest.fromJson(jsonDecode(response.body));
  }

  Future<GetPackage> getPackage() async {
    http.Response response = await http.post(Uri.parse(ConstRes.aGetPackage),
        headers: {ConstRes.aApiKeyName: ConstRes.aApiKey});
    // print(response.body);
    return GetPackage.fromJson(jsonDecode(response.body));
  }

  Future<ApplyForLive> applyForLive(File? introVideo, String aboutYou,
      String languages, String socialLinks) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.aApplyForLive),
    );
    request.headers.addAll({
      ConstRes.aApiKeyName: ConstRes.aApiKey,
    });
    request.fields[ConstRes.aUserIdName] = ConstRes.aUserId.toString();
    request.fields[ConstRes.aSocialLink] = socialLinks;
    if (introVideo != null) {
      request.files.add(
        http.MultipartFile(ConstRes.aIntroVideo,
            introVideo.readAsBytes().asStream(), introVideo.lengthSync(),
            filename: introVideo.path.split("/").last),
      );
    }
    request.fields[ConstRes.aLanguages] = languages;
    request.fields[ConstRes.aAboutYou] = aboutYou;

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    // print(respStr);
    final responseJson = jsonDecode(respStr);
    ApplyForLive applyForLive = ApplyForLive.fromJson(responseJson);
    // print(responseJson.hashCode);
    return applyForLive;
  }

  Future<UpdateProfile> updateProfile(
      {List<File>? images,
      String? live,
      String? bio,
      List<String>? interest,
      String? age,
      String? latitude,
      String? longitude,
      String? instagram,
      String? facebook,
      String? youtube,
      String? fullName,
      List<String>? deleteImageIds,
      int? gender,
      String? about}) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.aUpdateProfile),
    );
    request.headers.addAll({
      ConstRes.aApiKeyName: ConstRes.aApiKey,
    });
    request.fields[ConstRes.aUserIdName] = ConstRes.aUserId.toString();
    if (live != null) {
      request.fields[ConstRes.aLive] = live;
    }
    if (bio != null) {
      request.fields[ConstRes.aBio] = bio;
    }
    if (age != null) {
      request.fields[ConstRes.aAge] = age;
    }
    if (fullName != null) {
      request.fields[ConstRes.aFullName] = fullName;
    }
    if (instagram != null) {
      request.fields[ConstRes.aInstagram] = instagram;
    }
    if (facebook != null) {
      request.fields[ConstRes.aFacebook] = facebook;
    }
    if (youtube != null) {
      request.fields[ConstRes.aYoutube] = youtube;
    }
    if (latitude != null) {
      request.fields[ConstRes.aLatitude] = latitude;
    }
    if (longitude != null) {
      request.fields[ConstRes.aLongitude] = longitude;
    }
    if (interest != null) {
      request.fields[ConstRes.aInterests] = interest.join(",");
    }
    if (gender != null) {
      request.fields[ConstRes.aGender] = gender.toString();
    }
    if (about != null) {
      request.fields[ConstRes.aAbout] = about;
    }
    List<http.MultipartFile> newList = <http.MultipartFile>[];
    Map<String, String> map = {};

    if (deleteImageIds != null) {
      for (int i = 0; i < deleteImageIds.length; i++) {
        map['${ConstRes.aDeleteImagesId}[$i]'] = deleteImageIds[i];
        // request.fields[ConstRes.aDeleteImagesId] = deleteImageIds[i];
      }
    }
    request.fields.addAll(map);
    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        File imageFile = images[i];
        var multipartFile = http.MultipartFile(ConstRes.aImages,
            imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
            filename: imageFile.path.split('/').last);
        newList.add(multipartFile);
      }
    }
    request.files.addAll(newList);
    // if (image != null) {
    //   request.files.add(http.MultipartFile(
    //       'image', image.readAsBytes().asStream(), image.lengthSync(),
    //       filename: image.path.split("/").last));
    // }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    // print(respStr);
    final responseJson = jsonDecode(respStr);
    UpdateProfile updateProfile = UpdateProfile.fromJson(responseJson);
    await PrefService.saveUser(updateProfile.data);
    PrefService.updateFirebase();
    return updateProfile;
  }

  Future<GetProfile?> getProfile({int? userID}) async {
    if (kDebugMode) {
      print(ConstRes.aGetProfile);
    }
    http.Response response = await http.post(Uri.parse(ConstRes.aGetProfile),
        headers: {ConstRes.aApiKeyName: ConstRes.aApiKey},
        body: {ConstRes.aUserIdName: userID.toString()});
    return GetProfile.fromJson(jsonDecode(response.body));
  }

  Future<OnOffNotification> onOffNotification(int state) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aOnOffNotification), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aState: state.toString()
    });
    return OnOffNotification.fromJson(jsonDecode(response.body));
  }

  Future<OnOffShowMeMap> onOffShowMeOnMap(int state) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aOnOffShowMeOnMap), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aState: state.toString()
    });
    return OnOffShowMeMap.fromJson(jsonDecode(response.body));
  }

  Future<OnOffAnonymous> onOffAnonymous(int? state) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aOnOffAnonymous), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aState: state.toString()
    });

    // print(response.body);
    return OnOffAnonymous.fromJson(jsonDecode(response.body));
  }

  Future<Report> addReport(String reason, String description, int? id) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aAddReport), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aReason: reason,
      ConstRes.aDescription: description,
      ConstRes.aUserIdName: id.toString()
    });
    // print(response.body);
    return Report.fromJson(jsonDecode(response.body));
  }

  Future<AdminNotification> adminNotifiation(int start) async {
    http.Response response = await http
        .post(Uri.parse(ConstRes.aGetAdminNotification), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aStart: start.toString(),
      ConstRes.aCount: ConstRes.aFifteen
    });
    return AdminNotification.fromJson(jsonDecode(response.body));
  }

  Future<UserNotification> getUserNotification(int start) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aGetUserNotification), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aStart: start.toString(),
      ConstRes.aCount: ConstRes.aFifteen
    });
    // print(response.body);
    return UserNotification.fromJson(jsonDecode(response.body));
  }

  Future<PlaceRedeemRequest> placeRedeemRequest(
      String? paymentGateway, String accountDetails) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aPlaceRedeemRequest), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aAccountDetails: paymentGateway,
      ConstRes.aPaymentGateway: accountDetails,
    });
    // print(response.body);
    return PlaceRedeemRequest.fromJson(jsonDecode(response.body));
  }

  Future<Setting> getSettingData() async {
    http.Response response = await http.post(
      Uri.parse(ConstRes.aGetSettingData),
      headers: {ConstRes.aApiKeyName: ConstRes.aApiKey},
    );
    // print(response.body);
    Setting setting = Setting.fromJson(jsonDecode(response.body));
    await PrefService.saveSettingData(setting.data);
    return setting;
  }

  Future<SearchUser> searchUser(String searchKeyword, int start) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aSearchUsers), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aKeyword: searchKeyword,
      ConstRes.aStart: start.toString(),
      ConstRes.aCount: ConstRes.aFifteen
    });
    return SearchUser.fromJson(jsonDecode(response.body));
  }

  Future<SearchUserById> searchUserById(
      String searchKeyword, int? interestId, int start) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aSearchUsersForInterest), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aKeyword: searchKeyword,
      ConstRes.aStart: start.toString(),
      ConstRes.aCount: ConstRes.aFifteen,
      ConstRes.aInterestId: interestId.toString()
    });
    return SearchUserById.fromJson(jsonDecode(response.body));
  }

  Future<UpdateSavedProfile> updateLikedProfile(int? profileId) async {
    var userData = await PrefService.getUserData();
    String? likedProfile = userData?.likedprofile;
    List<int> list = [];
    if (likedProfile != null &&
        likedProfile.isNotEmpty &&
        !likedProfile.contains(profileId.toString())) {
      likedProfile += ',$profileId';
    } else {
      if (likedProfile == null || likedProfile.isEmpty) {
        likedProfile = profileId.toString();
      } else if (likedProfile.contains(profileId.toString())) {
        for (int i = 0; i < likedProfile.split(',').length; i++) {
          list.add(int.parse(likedProfile.split(',')[i]));
        }
        for (int i = 0; i < likedProfile.split(',').length; i++) {
          if (likedProfile.split(',')[i] == profileId.toString()) {
            list.removeAt(i);
            break;
          }
        }
        likedProfile = list.join(",");
      }
    }
    // print(likedProfile);
    http.Response response =
        await http.post(Uri.parse(ConstRes.aUpdateLikedProfile), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aProfiles: likedProfile,
    });

    // print(response.body);
    UpdateSavedProfile updateSavedProfile =
        UpdateSavedProfile.fromJson(jsonDecode(response.body));
    PrefService.saveUser(updateSavedProfile.data);
    return updateSavedProfile;
  }

  Future<UpdateSavedProfile> updateSaveProfile(int? profileId) async {
    var userData = await PrefService.getUserData();
    String? savedProfile = userData?.savedprofile;
    List<int> savedProfileList = [];
    if (savedProfile != null &&
        savedProfile.isNotEmpty &&
        !savedProfile.contains(profileId.toString())) {
      savedProfile += ',$profileId';
    } else {
      if (savedProfile == null || savedProfile.isEmpty) {
        savedProfile = profileId.toString();
      } else if (savedProfile.contains(profileId.toString())) {
        for (int i = 0; i < savedProfile.split(',').length; i++) {
          savedProfileList.add(int.parse(savedProfile.split(',')[i]));
        }
        for (int i = 0; i < savedProfile.split(',').length; i++) {
          if (savedProfile.split(',')[i] == profileId.toString()) {
            savedProfileList.removeAt(i);
            break;
          }
        }
        savedProfile = savedProfileList.join(",");
      }
    }

    http.Response response =
        await http.post(Uri.parse(ConstRes.aUpdateSavedProfile), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aProfiles: savedProfile
    });
    // print(response.body);
    UpdateSavedProfile updateSavedProfile =
        UpdateSavedProfile.fromJson(jsonDecode(response.body));
    PrefService.saveUser(updateSavedProfile.data);
    return updateSavedProfile;
  }

  Future<FetchLiveStreamHistory> fetchAllLiveStreamHistory(int starting) async {
    http.Response response = await http
        .post(Uri.parse(ConstRes.aFetchAllLiveStreamHistory), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aStart: '$starting',
      ConstRes.aCount: ConstRes.aFifteen
    });
    return FetchLiveStreamHistory.fromJson(jsonDecode(response.body));
  }

  Future<Verification> applyForVerification(
      File? photo, File? docImage, String fullName, String docType) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.aApplyForVerification),
    );
    request.headers.addAll({
      ConstRes.aApiKeyName: ConstRes.aApiKey,
    });
    request.fields[ConstRes.aUserIdName] = ConstRes.aUserId.toString();
    request.fields[ConstRes.aDocumentType] = docType;
    if (photo != null) {
      request.files.add(
        http.MultipartFile(ConstRes.aSelfie, photo.readAsBytes().asStream(),
            photo.lengthSync(),
            filename: photo.path.split("/").last),
      );
    }
    if (docImage != null) {
      request.files.add(
        http.MultipartFile(ConstRes.aDocument,
            docImage.readAsBytes().asStream(), docImage.lengthSync(),
            filename: docImage.path.split("/").last),
      );
    }
    request.fields[ConstRes.aFullName] = fullName;

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    // print(respStr);
    final responseJson = jsonDecode(respStr);
    Verification applyForVerification = Verification.fromJson(responseJson);
    // print(applyForVerification.message);
    return applyForVerification;
  }

  Future<DeleteAccount> deleteAccount(int? deleteId) async {
    http.Response response = await http.post(
        Uri.parse(ConstRes.aDeleteMyAccount),
        headers: {ConstRes.aApiKeyName: ConstRes.aApiKey},
        body: {ConstRes.aUserIdName: deleteId.toString()});
    return DeleteAccount.fromJson(jsonDecode(response.body));
  }

  Future<StoreFileGivePath> getStoreFileGivePath({File? image}) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.aStorageFileGivePath),
    );
    request.headers.addAll({
      ConstRes.aApiKeyName: ConstRes.aApiKey,
    });
    if (image != null) {
      request.files.add(
        http.MultipartFile(
            ConstRes.aFile, image.readAsBytes().asStream(), image.lengthSync(),
            filename: image.path.split("/").last),
      );
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    StoreFileGivePath applyForVerification =
        StoreFileGivePath.fromJson(responseJson);
    return applyForVerification;
  }

  Future<MinusCoinFromWallet> minusCoinFromWallet(int? amount) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aMinusCoinsFromWallet), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aAmount: amount.toString()
    });
    return MinusCoinFromWallet.fromJson(jsonDecode(response.body));
  }

  Future<MinusCoinFromWallet> addCoinFromWallet(int? amount) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aAddCoinsToWallet), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aAmount: amount.toString()
    });
    return MinusCoinFromWallet.fromJson(jsonDecode(response.body));
  }

  Future<GetDiamondPack> getDiamondPack() async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aGetDiamondPacks), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aStart: '0',
      ConstRes.aCount: ConstRes.aFifteen
    });
    return GetDiamondPack.fromJson(jsonDecode(response.body));
  }

  Future<AddLiveStreamHistory> addLiveStreamHistory(
      {required String streamFor,
      required String startedAt,
      required String amountCollected}) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aAddLiveStreamHistory), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aStreamedFor: streamFor,
      ConstRes.aStartedAt: startedAt,
      ConstRes.aAmountCollected: amountCollected
    });
    return AddLiveStreamHistory.fromJson(jsonDecode(response.body));
  }

  Future<GetProfile> getRandomProfile({required int gender}) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aGetRandomProfile), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aGender: gender.toString()
    });
    return GetProfile.fromJson(jsonDecode(response.body));
  }

  Future<GetExploreScreen> getExplorePageProfileList() async {
    http.Response response = await http.post(
        Uri.parse(ConstRes.aGetExplorePageProfileList),
        headers: {ConstRes.aApiKeyName: ConstRes.aApiKey},
        body: {ConstRes.aUserIdName: ConstRes.aUserId.toString()});
    return GetExploreScreen.fromJson(jsonDecode(response.body));
  }

  Future<FetchRedeemRequest> fetchRedeemRequest() async {
    http.Response response = await http.post(
        Uri.parse(ConstRes.aFetchMyRedeemRequests),
        headers: {ConstRes.aApiKeyName: ConstRes.aApiKey},
        body: {ConstRes.aUserIdName: ConstRes.aUserId.toString()});
    return FetchRedeemRequest.fromJson(jsonDecode(response.body));
  }

  Future<UserBlockList> userBlockList(int? blockProfileId) async {
    var userData = await PrefService.getUserData();
    String? blockProfile = userData?.blockedUsers;
    List<int> blockProfileList = [];
    if (blockProfile != null &&
        blockProfile.isNotEmpty &&
        !blockProfile.contains(blockProfileId.toString())) {
      blockProfile += ',$blockProfileId';
    } else {
      if (blockProfile == null || blockProfile.isEmpty) {
        blockProfile = blockProfileId.toString();
      } else if (blockProfile.contains(blockProfileId.toString())) {
        for (int i = 0; i < blockProfile.split(',').length; i++) {
          blockProfileList.add(int.parse(blockProfile.split(',')[i]));
        }
        for (int i = 0; i < blockProfile.split(',').length; i++) {
          if (blockProfile.split(',')[i] == blockProfileId.toString()) {
            blockProfileList.removeAt(i);
            break;
          }
        }
        blockProfile = blockProfileList.join(",");
      }
    }

    http.Response response =
        await http.post(Uri.parse(ConstRes.aUpdateBlockList), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: ConstRes.aUserId.toString(),
      ConstRes.aBlockedUsers: blockProfile
    });
    UserBlockList updateBlockProfile =
        UserBlockList.fromJson(jsonDecode(response.body));
    PrefService.saveUser(updateBlockProfile.data);
    return updateBlockProfile;
  }

  Future<FetchUserCoordinate> getUserByLatLong(
      {required double latitude,
      required double longitude,
      required int km}) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aFetchUsersByCoordinates), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aLat: latitude.toString(),
      ConstRes.aLong: longitude.toString(),
      ConstRes.aKm: km.toString()
    });
    return FetchUserCoordinate.fromJson(jsonDecode(response.body));
  }

  Future<GetProfile> getUserDetail({required String email}) async {
    http.Response response = await http.post(
        Uri.parse(ConstRes.aGetUserDetails),
        headers: {ConstRes.aApiKeyName: ConstRes.aApiKey},
        body: {ConstRes.aEmail: email});
    return GetProfile.fromJson(jsonDecode(response.body));
  }

  Future<NotifyLikeUser> notifyLikeUser(
      {required int userId, required int type}) async {
    http.Response response =
        await http.post(Uri.parse(ConstRes.aNotifyLikedUser), headers: {
      ConstRes.aApiKeyName: ConstRes.aApiKey
    }, body: {
      ConstRes.aUserIdName: userId.toString(),
      ConstRes.aDataUserId: ConstRes.aUserId.toString(),
      ConstRes.aType: type.toString()
    });
    return NotifyLikeUser.fromJson(jsonDecode(response.body));
  }

  Future pushNotification(
      {required String authorization,
      required String title,
      required String body,
      required String token}) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Authorization': 'key=$authorization',
        'content-type': 'application/json'
      },
      body: json.encode(
        {
          'notification': {
            'title': title,
            'body': body,
            "sound": "default",
            "badge": "1"
          },
          'to': '/token/$token',
        },
      ),
    );
  }

  Future<Report> logoutUser() async {
    http.Response response = await http.post(
        Uri.parse('${ConstRes.aBaseUrl}logOutUser'),
        headers: {ConstRes.aApiKeyName: ConstRes.aApiKey},
        body: {ConstRes.aUserIdName: ConstRes.aUserId.toString()});
    return Report.fromJson(jsonDecode(response.body));
  }
}
