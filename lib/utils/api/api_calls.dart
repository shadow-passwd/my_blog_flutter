import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
// import 'package:mime_type/mime_type.dart';
// import 'package:path/path.dart' as Path;

import 'package:image_picker_web/image_picker_web.dart';

import 'package:http_parser/http_parser.dart';
import 'package:my_awesome_blog/model/user_login.dart';

import '../../model/post.dart';
import '../../providers/editor_image_provider.dart';
import '../../model/single_post.dart';
import '../../constants/urls.dart';
import '../../model/user.dart';

///////////////////////////////////GET POST //////////////////////////////////////////

Future<List<Post>> getPosts() async {
  String url = Urls.postUrl;
  var resp;
  try {
    resp = await http.get(url);
  } catch (e) {
    print(e);
    resp = null;
  }
  if (resp != null) {
    return postFromJson(resp.body);
  }
  return null;
}

///////////////////////////////////post METADATA //////////////////////////////////////////

Future<int> postMetaData(
  String title,
  String genre,
  String email,
  String facebook,
  String twitter,
  String github,
  String tags,
) async {
  String url = Urls.postUrl;
  Map<String, dynamic> headers = {
    "title": title,
    "tags": tags,
    "genre": genre,
    "email_id_url": email,
    "github_id_url": github,
    "twitter_id_url": twitter,
    "facebook_id_url": facebook,
    'user': User.userId,
  };
  try {
    var resp = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${User.accessToken}"
      },
      body: JsonEncoder().convert(headers),
    );
    print(resp.body);
    print('POST ID+++++++++ ${jsonDecode(resp.body)['id']}');
    return jsonDecode(resp.body)['id'];
  } catch (e) {
    print(e);
    return null;
  }
}

///////////////////////////////////post CONTENTDATA //////////////////////////////////////////

Future postContentData(String content, int postId) async {
  String url = Urls.postUrl + '$postId/';
  Map<String, dynamic> headers = {
    'content': content,
    'user': User.userId,
  };

  try {
    var resp = await http.put(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${User.accessToken}"
      },
      body: JsonEncoder().convert(headers),
    );
    print(resp.body);
  } catch (e) {
    print(e);
  }
}

///////////////////////////////////post IMAGEDATA //////////////////////////////////////////

Future postImageData(Images provider, int postId) async {
  String url = Urls.postImageUrl;
  Map<String, MediaInfo> _images = provider.data;
  var request = http.MultipartRequest("POST", Uri.parse(url));

  _images.forEach((filename, mediaData) {
    // var x = mime(Path.basename(mediaData.fileName));

    request.files.add(http.MultipartFile.fromBytes(
      'post_image',
      List.from(mediaData.data),
      filename: mediaData.fileName,
      contentType: MediaType('application', 'png'),
    ));
  });
  request.fields['post'] = '$postId';
  request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
  request.headers[HttpHeaders.authorizationHeader] =
      "Bearer ${User.accessToken}";

  request
      .send()
      .then((value) => print("++++++++++++++" + value.toString()))
      .catchError((error) => print("+++++++GOT ERROT" + error.toString()));
}

///////////////////////////////////GET SINGLE POST //////////////////////////////////////////

Future<SinglePost> getSinglePost(int id) async {
  String url = Urls.postUrl + '$id/';
  var resp;
  try {
    resp = await http.get(url);
  } catch (e) {
    print(e);
    resp = null;
  }
  if (resp != null) {
    return singlePostFromJson(resp.body);
  }
  return null;
}

///////////////////////////////////GET USERPROFILE //////////////////////////////////////////

Future<UserProfile> getUserProfile(int id, String token) async {
  String url = Urls.getSingleUserUrl + '$id/';
  print("URL IS ++++++++++ " + url);
  var resp;
  try {
    resp = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
  } catch (e) {
    print(e);
    resp = null;
  }
  if (resp != null) {
    return userProfileFromJson(resp.body);
  }
  return null;
}

///////////////////////////////////CREATE USERPROFILE //////////////////////////////////////////

Future userProfileCreation(
    int id,
    String user,
    MediaInfo profilePic,
    MediaInfo profileCoverImage,
    String description,
    String location,
    String githubIdUrl,
    String twitterIdUrl,
    String facebookIdUrl,
    String token) async {
  String url = Urls.getSingleUserUrl + '$id/';
  var request = http.MultipartRequest("PUT", Uri.parse(url));
  request.fields['user'] = user;
  request.fields['id'] = '$id';
  if (description != null) request.fields['description'] = description;

  if (location != null) request.fields['location'] = location;
  if (githubIdUrl != null) request.fields['github_id_url'] = githubIdUrl;
  if (twitterIdUrl != null) request.fields['twitter_id_url'] = twitterIdUrl;
  if (facebookIdUrl != null) request.fields['facebook_id_url'] = facebookIdUrl;
  if (profileCoverImage != null)
    request.files.add(http.MultipartFile.fromBytes(
      'profile_cover_image',
      List.from(profileCoverImage.data),
      filename: profileCoverImage.fileName,
      contentType: MediaType('application', 'png'),
    ));
  if (profilePic != null)
    request.files.add(http.MultipartFile.fromBytes(
      'profile_pic',
      List.from(profilePic.data),
      filename: profilePic.fileName,
      contentType: MediaType('application', 'png'),
    ));

  request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
  request.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
  request
      .send()
      .then((value) => print("++++++++++++++" + value.toString()))
      .catchError((error) => print("+++++++GOT ERROT" + error.toString()));
}

///////////////////////////////////USER REGISTRATION //////////////////////////////////////////

Future futureUserRegistration(
    String username, String email, String password) async {
  String url = Urls.loginUrl;

  Map<String, dynamic> headers = {
    "username": username,
    "password": password,
    "email": email,
  };
  try {
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: JsonEncoder().convert(headers),
    );
  } catch (e) {
    print(e);
    return null;
  }
}

Future<String> userRegistration(
    String username, String email, String password) async {
  var r = await futureUserRegistration(username, email, password);
  print(r.body);
  return r.body;
}

///////////////////////////////////USER LOGIN //////////////////////////////////////////
futureLogin(String username, String password) async {
  String url = Urls.loginUrl;

  Map<String, dynamic> headers = {
    "username": username,
    "password": password,
  };
  try {
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: JsonEncoder().convert(headers),
    );
  } catch (e) {
    print(e);
    return null;
  }
}

Future<String> userLogin(String username, String password) async {
  var r = await futureLogin(username, password);
  r = JsonDecoder().convert(r.body);
  print(r['userid'].toString() +
      ':' +
      username +
      ":" +
      r['access'].toString() +
      ":" +
      r['expiry_time'].toString());
  return r['userid'].toString() +
      ':' +
      username +
      ":" +
      r['access'].toString() +
      ":" +
      r['expiry_time'].toString();
}

///////////////////////////////////PICK IMAGE //////////////////////////////////////////

pickImage(var provider) async {
  var mediaData = await ImagePickerWeb.getImageInfo;
  String filename = mediaData.fileName;
  print(mediaData.fileName.toString());
  provider.addMediaData(filename, mediaData);
}

///////////////////////////////////PICK PROFILE IMAGE //////////////////////////////////////////
Future<MediaInfo> pickProfileImage() async {
  var mediaData = await ImagePickerWeb.getImageInfo;
  print(mediaData.fileName.toString());
  return mediaData;
}
