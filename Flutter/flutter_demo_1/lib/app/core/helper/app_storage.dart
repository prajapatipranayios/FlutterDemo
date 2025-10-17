import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constants.dart';

class AppStorages {
  static late GetStorage box;
  static String deviceID = "";
  static var appVersion = "";
  // static UserDetail userData = UserDetail();
  static String accessToken = "";

  static int isSniptCreate = 0;
  static int roleId = 0;
  static var isCometChat = 0.obs;
  static var notificationCount = 0.obs;
  static String darkLogo = "";
  static String lightLogo = "";
  static String isStaging = "";
  static String conversationBaseUrl = "";
  static int conversationCallEndPopUp = 30;
  static int conversationAPICallTime = 300;
  static RxList recentSearch = [].obs;
  static var isPurchase = false;

  // static RxList<Interest>? interest = <Interest>[].obs;
  // static List<CameraDescription> cameras = [];
  static var isCoursePlayerZoomed = false.obs;
  static var isDoubleTap = false.obs;
  static var deepLink = [].obs;
  static var isQualityChanged = false.obs;
  static var videoUploadProgress = 0.0.obs;
  // static RxList<Course> courses = <Course>[].obs;
  static var isInternetConnected = true.obs;
  // static UserProfileModel myUserModel = UserProfileModel();
  static var chatID = "";
  static var isTapChatHeader = false;
  static var isTimesUp = false.obs;
  static var timerTime = 120.obs;
  static var timerRemainForUnlock = 120.obs;
  static var freeTime = 120.obs;
  static var accountCount = 0.obs;
  static var isPremium = 0.obs;
  static var currency = "".obs;
  static var showFeedBack = 0.obs;
  static var isFeedBackTimerStarted = false.obs;
  static var isDark = false.obs;
  static var inAppController;
  static var permission = [].obs;

  static var isTimerCount = true.obs;
  // static Plan plan = Plan();

  static initializeApp() async {
    await GetStorage.init('Demo1');
    box = GetStorage('Demo1');
  }

  /* to set user data */
  // static setLoginProfileModel(UserDetail model) {
  //   box.write(SessionKeys.keyLoginProfile, userDetailToJson(model));
  // }

  /* to get user data */
  // static getLoginProfileModel() {
  //   if (box.hasData(SessionKeys.keyLoginProfile)) {
  //     var json = box.read(SessionKeys.keyLoginProfile);
  //     return json;
  //   }
  //   return null;
  // }

  /* to set user data */
  static setTheme(int v) {
    box.write("theme", v);
  }

  /* to get user data */
  static getTheme() {
    if (box.hasData("theme")) {
      var json = box.read("theme");
      return json;
    }
    return 2;
  }

  /* to set user token */
  static setAccessToken(String accessToken) {
    box.write(SessionKeys.accessToken, accessToken);
  }

  /* get user token */
  static getAccessToken() {
    if (box.hasData(SessionKeys.accessToken)) {
      return box.read(SessionKeys.accessToken);
    }
    return "";
  }

  /* to set user token */
  static setRolId(int showAssessment) {
    box.write(SessionKeys.rolId, showAssessment);
  }

  /* get user token */
  static getRolId() {
    if (box.hasData(SessionKeys.rolId)) {
      return box.read(SessionKeys.rolId);
    }
    return 0;
  }

  /* to set user token */
  static setDarkAppLogo(String showAssessment) {
    box.write(SessionKeys.darkLogo, showAssessment);
  }

  /* get user token */
  static getDarkAppLogo() {
    if (box.hasData(SessionKeys.darkLogo)) {
      return box.read(SessionKeys.darkLogo);
    }
    return "";
  }

  /* to set user token */
  static setLightAppLogo(String showAssessment) {
    box.write(SessionKeys.lightLogo, showAssessment);
  }

  /* get user token */
  static getLightAppLogo() {
    if (box.hasData(SessionKeys.lightLogo)) {
      return box.read(SessionKeys.lightLogo);
    }
    return "";
  }

  /* to set interest data */
  // static setInterest(List<Interest> model) {
  //   box.write(
  //     SessionKeys.interest,
  //     jsonEncode(model.map((e) => e.toJson()).toList()),
  //   );
  // }

  // static getInterestData() {
  //   if (box.hasData(SessionKeys.interest)) {
  //     interest = RxList<Interest>.from(
  //       json
  //           .decode(box.read(SessionKeys.interest))
  //           .map((model) => Interest.fromJson(model)),
  //     );
  //   }
  //   return interest;
  // }

  /* to set user is login */
  static setAppLogin(bool isUserLoggedIn) {
    box.write(SessionKeys.keyLogin, isUserLoggedIn);
  }

  /* to find user is login */
  static isLogin() {
    if (box.hasData(SessionKeys.keyLogin)) {
      return box.read(SessionKeys.keyLogin);
    }
    return false;
  }

  static setIsFirstTime(bool isFirstTime) {
    box.write(SessionKeys.isFirstTime, isFirstTime);
  }

  static getIsFirstTime() {
    if (box.hasData(SessionKeys.isFirstTime)) {
      return box.read(SessionKeys.isFirstTime);
    }
    return true;
  }

  // "Set Firebase Push token"
  static setFcmToken(String fcmToken) {
    box.write(SessionKeys.fcmToken, fcmToken);
  }

  // "Get Firebase Push token" //
  static getFcmToken() {
    if (box.hasData(SessionKeys.fcmToken)) {
      return box.read(SessionKeys.fcmToken);
    }
    return '';
  }

  /* to set user downloaded courses */
  // static setCourseDownload(CourseDownloadModel model) {
  //   box.write(
  //     SessionKeys.courseDownload,
  //     getLearnerCoursesDownloadToJson(model),
  //   );
  // }

  /* to get user downloaded courses */
  // static getCourseDownload() {
  //   if (box.hasData(SessionKeys.courseDownload)) {
  //     var json = box.read(SessionKeys.courseDownload);
  //     return getLearnerCoursesDownloadFromJson(json);
  //   }
  //   return null;
  // }

  // "Set Firebase Push token"
  static setFirstConnection(bool isFirstConnection) {
    box.write(SessionKeys.firstConnection, isFirstConnection);
  }

  // "Get Firebase Push token" //
  static getFirstConnection() {
    if (box.hasData(SessionKeys.firstConnection)) {
      return box.read(SessionKeys.firstConnection);
    }
    return true;
  }

  /* to set user recent search */
  static setRecentSearch(List recentSearchData) {
    box.write(SessionKeys.recentSearch, recentSearchData);
  }

  /* to find user recent search */
  static getRecentSearch() {
    if (box.hasData(SessionKeys.recentSearch)) {
      return box.read(SessionKeys.recentSearch);
    }
    return [];
  }
}
