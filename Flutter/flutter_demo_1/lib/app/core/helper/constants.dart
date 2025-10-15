class Global {
  // static const baseURL = "https://api.growy.app/api/v2/"; // live url
  //static const baseURL = "https://stagingapi.growy.app/api/v2/"; // local url

  static const baseHttpUrl = "https://uat.tussly.com/";
  static const httpUrl = "https://uat.tussly.com/tussly-backend/public/";
  static const baseUrl = "${httpUrl}api/v1/";

  static const region = "eu";
  static const login = "login";
  static const signUp = "signUp";
  static const getUserDetail = "getUserDetail2";
  static const getGames = "getGames";
}

class SessionKeys {
  static String keyLoginProfile = "User Data";
  static String keyLogin = "isLoggedIn";
  static String accessToken = "accessToken";
}
