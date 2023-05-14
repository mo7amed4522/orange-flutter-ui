import 'package:intl/intl.dart';
import 'package:orange_ui/model/setting.dart';

class ConstRes {
  static int aUserId = -1;
  static const String base = 'https://helnay.com/orange/';
  static const String aBaseUrl = '${base}api/';
  static const String authKey =
      'AAAAbPTHzOo:APA91bGoU5lhkc8p-VbEbcGt6px4elIXRazIe92lK1_TJryQgjjpEb9kuJrtRARVn8jTVaWeHReUTYm00yRsOHxF4kqE4TCn8UJrR8i0ag0hR8_6XeBGqPxKXGhS5XeYSiIus9BqM0hX';

  /// image base url
  static const String aImageBaseUrl = '${base}public/storage/';

  /// api credential
  static const String aApiKeyName = 'apikey';
  static const String aApiKey = '123';

  /// Orange Api url
  static const String aGetProfile = '${aBaseUrl}getProfile';
  static const String aRegister = '${aBaseUrl}register';
  static const String aGetInterests = '${aBaseUrl}getInterests';
  static const String aGetPackage = '${aBaseUrl}getPackage';
  static const String aUpdateProfile = '${aBaseUrl}updateProfile';
  static const String aGetUserNotification = '${aBaseUrl}getUserNotifications';
  static const String aOnOffAnonymous = '${aBaseUrl}onOffAnonymous';
  static const String aOnOffShowMeOnMap = '${aBaseUrl}onOffShowMeOnMap';
  static const String aOnOffNotification = '${aBaseUrl}onOffNotification';
  static const String aAddReport = '${aBaseUrl}addReport';
  static const String aGetAdminNotification =
      '${aBaseUrl}getAdminNotifications';
  static const String aApplyForLive = '${aBaseUrl}applyForLive';
  static const String aApplyForVerification = '${aBaseUrl}applyForVerification';
  static const String aPlaceRedeemRequest = '${aBaseUrl}placeRedeemRequest';
  static const String aGetSettingData = '${aBaseUrl}getSettingData';
  static const String aSearchUsers = '${aBaseUrl}searchUsers';
  static const String aSearchUsersForInterest =
      '${aBaseUrl}searchUsersForInterest';
  static const String aUpdateSavedProfile = '${aBaseUrl}updateSavedProfile';
  static const String aUpdateLikedProfile = '${aBaseUrl}updateLikedProfile';
  static const String aUpdateBlockList = '${aBaseUrl}updateUserBlockList';
  static const String aFetchAllLiveStreamHistory =
      '${aBaseUrl}fetchAllLiveStreamHistory';
  static const String aMinusCoinsFromWallet = '${aBaseUrl}minusCoinsFromWallet';
  static const String aStorageFileGivePath = '${aBaseUrl}storeFileGivePath';
  static const String aAddCoinsToWallet = '${aBaseUrl}addCoinsToWallet';
  static const String aGetDiamondPacks = '${aBaseUrl}getDiamondPacks';
  static const String aDeleteMyAccount = '${aBaseUrl}deleteMyAccount';
  static const String aAddLiveStreamHistory = '${aBaseUrl}addLiveStreamHistory';
  static const String aFetchUsersByCoordinates =
      '${aBaseUrl}fetchUsersByCordinates';
  static const String aGetUserDetails = '${aBaseUrl}getUserDetails';
  static const String aFetchMyRedeemRequests =
      '${aBaseUrl}fetchMyRedeemRequests';
  static const String aGetExplorePageProfileList =
      '${aBaseUrl}getExplorePageProfileList';
  static const String aGetRandomProfile = '${aBaseUrl}getRandomProfile';
  static const String aNotifyLikedUser = '${aBaseUrl}notifyLikedUser';

  /// api keyWord
  static const String aFullName = 'fullname';
  static const String aInstagram = 'instagram';
  static const String aFacebook = 'facebook';
  static const String aYoutube = 'youtube';
  static const String aDeviceToken = 'device_token';
  static const String aDeviceType = 'device_type';
  static const String aLoginType = 'login_type';
  static const String aLatitude = 'lattitude';
  static const String aLongitude = 'longitude';
  static const String aDeleteImagesId = 'deleteimageids[]';
  static const String aImages = 'image[]';
  static const String aIdentity = 'identity';
  static const String aInterests = 'interests';
  static const String aPassword = 'password';
  static const String aPost = 'POST';
  static const String aUserIdName = 'user_id';
  static const String aLive = 'live';
  static const String aBio = 'bio';
  static const String aAge = 'age';
  static const String aGender = 'gender';
  static const String aType = 'type';
  static const String aAbout = 'about';
  static const String aBubblyCamera = 'bubbly_camera';
  static const String aSettingData = 'settingData';
  static const String aState = 'state';
  static const String aReason = 'reason';
  static const String aDescription = 'description';
  static const String aCount = 'count';
  static const String aAboutYou = 'about_you';
  static const String aSocialLink = 'social_links';
  static const String aIntroVideo = 'intro_video';
  static const String aLanguages = 'languages';
  static const String aPaymentGateway = 'payment_gateway';
  static const String aAccountDetails = 'account_details';
  static const String aStart = 'start';
  static const String aProfiles = 'profiles';
  static const String aBlockUser = 'blocked_users';
  static const String aDocumentType = 'document_type';
  static const String aSelfie = 'selfie';
  static const String aFile = 'file';
  static const String aDocument = 'document';
  static const String aAmount = 'amount';
  static const String aOne = '1';
  static const String aTwo = '2';
  static const String aFifteen = '15';
  static const String aKeyword = 'keyword';
  static const String aInterestId = 'interest_id';
  static const String aAmountCollected = 'amount_collected';
  static const String aStreamedFor = 'streamed_for';
  static const String aStartedAt = 'started_at';
  static const String aPrivacyPolicy = 'privacypolicy';
  static const String aTermsOfUse = 'termsOfUse';
  static const String aBlockedUsers = 'blocked_users';
  static const String aLat = 'lat';
  static const String aLong = 'long';
  static const String aKm = 'km';
  static const String aEmail = 'email';
  static const String aUserInfo = 'userInfo';
  static const String aIsBroadcasting = 'isBroadcasting';
  static const String aChannelId = 'channelId';
  static const String aTopicName = 'orange';
  static const String aDataUserId = 'data_user_id';

  ///_____________________________ setting data_______________________///

  static String currency = '';
  static String coinRate = '';
  static int minThreshold = 0;
  static int reverseSwipePrice = 0;
  static int liveWatchingPrice = 0;
  static int messagePrice = 0;
  static int minimumUserLive = 0;
  static int maximumMinutes = 0;
  static String iosBannerAd = "";
  static String androidBannerAd = "";
  static String iosInterstitialAd = "";
  static String androidInterstitialAd = "";
  static int isDating = 0;
  static SettingData? settingData;

  ///_____________________________ firebase data_______________________///

  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"}";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"}";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"}";
    }
    if (diff.inDays > 0) {
      if (diff.inDays == 1) {
        return "Yesterday";
      }
      return "${diff.inDays}days";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"}";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"}";
    }
    return "just now";
  }

  static String readTimestamp(double timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp.toInt() * 1000);
    // var diff = date.difference(now);
    var time = '';
    if (now.day == date.day) {
      time = DateFormat('hh:mm a')
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt()));
      return time;
    }
    if (now.weekday > date.weekday) {
      time = DateFormat('EEEE')
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt()));
      return time;
    }
    if (now.month == date.month) {
      time = DateFormat('dd/MMM/yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt()));
      return time;
    }
    return time;
  }
}

class FirebaseConst {
  static const String userChatList = 'userchatlist';
  static const String userList = 'userlist';
  static const String chat = 'chat';
  static const String liveHostList = 'liveHostList';
  static const String comments = 'comments';
  static const String noDeleteIdentity = 'not_deleted_identities';
  static const String user = 'user';
  static const String time = 'time';
  static const String msg = 'msg';
  static const String image = 'image';
  static const String video = 'video';
  static const String watchingCount = 'watchingCount';
  static const String joinedUser = 'joinedUser';
  static const String lastMsg = 'lastMsg';
  static const String fullName = 'fullName';
  static const String city = 'city';
  static const String userImage = 'userImage';
  static const String age = 'age';
  static const String collectedDiamond = 'collectedDiamond';
  static const String id = 'id';
  static const String block = 'block';
  static const String blockFromOther = 'blockFromOther';
  static const String isDeleted = 'isDeleted';
  static const String deletedId = 'deletedId';
  static const String isMute = 'isMute';
}

class FontRes {
  static const String regular = 'gilroy';
  static const String bold = 'gilroy_bold';
  static const String extraBold = 'gilroy_extra_bold';
  static const String heavy = 'gilroy_heavy';
  static const String light = 'gilroy_light';
  static const String medium = 'gilroy_medium';
  static const String semiBold = 'gilroy_semibold';
}

class PrefConst {
  static const String liveStream = 'liveStream';
  static const String isLogin = 'isLogin';
  static const String fullName = 'fullName';
  static const String email = 'email';
  static const String address = 'address';
  static const String bioText = 'bioText';
  static const String age = 'age';
  static const String gender = 'gender';
  static const String firstProfile = 'firstProfile';
  static const String firstInterest = 'firstInterest';
  static const String instagram = 'instagram';
  static const String youtube = 'youtube';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String onOffNotification = 'onOffNotification';
  static const String onOffShowMeMap = 'onOffShowMeMap';
  static const String onOffAnonymous = 'onOffAnonymous';
  static const String settingData = 'settingData';
  static const String registrationUser = 'registrationUser';
  static const String isMessageDialog = 'isMessageDialog';
  static const String isDialogDialog = 'isDialogShow';
  static const String date = 'date';
  static const String userImage = 'userImage';
  static const String diamond = 'diamond';
  static const String watching = 'watching';
}
