class Urls {
  Urls._();
  static const String BASE_URL = 'https://shadowblog.herokuapp.com/';
  static const String loginUrl = BASE_URL + "api/token/";
  static const String getPostUrl = BASE_URL + "api/post/";
  static const String getSinglePostUrl = BASE_URL + 'api/post/';
  static const String getUsersUrl = "";
  static const String getSingleUserUrl = "";
  static const String postPostUrl = BASE_URL + "api/post/";
  static const String createUserUrl = "";
  static const String createUserProfileUrl =
      BASE_URL + "api/accounts/allprofiles";
  static const String postImageUrl = BASE_URL + "api/get/";
  static const String getUserProfile = BASE_URL + "api/accounts/profile/";
  static const String registerUserUrl = BASE_URL + "auth/users/";
  static const String imageUrl = BASE_URL + "images/post_images/";
}
