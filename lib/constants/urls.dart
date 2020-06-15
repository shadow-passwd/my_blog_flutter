class Urls {
  Urls._();
  // static const String BASE_URL = 'https://shadowblog.herokuapp.com/';
  static const String BASE_URL = 'http://127.0.0.1:8080/';
  static const String loginUrl = BASE_URL + "api/token/";
  static const String getPostUrl = BASE_URL + "api/post/";
  static const String getSinglePostUrl = BASE_URL + 'api/post/';
  static const String getUsersUrl = "";
  static const String getSingleUserUrl = BASE_URL + "api/accounts/profile/";
  static const String postUrl = BASE_URL + "api/post/";
  static const String createUserUrl = "";
  static const String createUserProfileUrl =
      BASE_URL + "api/accounts/allprofiles";
  static const String postImageUrl = BASE_URL + "api/images/";
  static const String getUserProfile = BASE_URL + "api/accounts/profile/";
  static const String registerUserUrl = BASE_URL + "auth/users/";

  static const String imageUrl = BASE_URL + "media/images/post_images/";
}
