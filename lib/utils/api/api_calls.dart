import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker_web/image_picker_web.dart';

import 'package:http_parser/http_parser.dart';

import '../../model/post.dart';
import '../../model/post_creation.dart';
import '../../providers/post_provider.dart';
import '../../model/user_login.dart';
import '../../constants/urls.dart';
import '../../model/user.dart';

Future<http.Response> login(String email, String username, String profile_pic,
    String description, String location) async {
  String url = Urls.loginUrl;
  try {
    Map<String, dynamic> headers = {
      'email': email,
      'usernmae': username,
    };
    return await http.post(
      url + 'auth/users/',
      body: JsonEncoder().convert(headers),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    print(e);
    return null;
  }
}

Future<Post> postCreation(PostC post) async {
  String url = Urls.postPostUrl;
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: postCToJson(post),
  );
  return postCFromJson(response.body);
}

Future<List<Post>> getPost() async {
  String url = Urls.getPostUrl;
  final response = await http.get(
    Uri.encodeFull(url),
  );
  print(response.body);
  return postFromJson(response.body);
}

pickImage(var provider) async {
  var mediaData = await ImagePickerWeb.getImageInfo;
  String filename = mediaData.fileName;

  // String t = mediaData.base64;
  // create(t);
  print(mediaData.fileName.toString());

  provider.addMediaData(filename, mediaData);
}

Future<MediaInfo> pickProfileImage() async {
  var mediaData = await ImagePickerWeb.getImageInfo;
  String filename = mediaData.fileName;

  // String t = mediaData.base64;
  // create(t);
  print(mediaData.fileName.toString());
  return mediaData;
}

Future<http.Response> imageCreation(
    String filename, MediaInfo mediaData, int id) async {
  String url = Urls.postImageUrl;
  Map<String, dynamic> headers = {
    "user": User.userId,
    "base64data": mediaData.base64,
    "filename": "$id/" + filename,
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

void create(Map<String, MediaInfo> data, int id) async {
  List<http.Response> resp = List<http.Response>();
  data.forEach((filename, mediaData) async {
    var r = await imageCreation(filename, mediaData, id);
    resp.add(r);
  });
  resp.forEach((r) {
    if (r.statusCode != 200) {
      print("NO USER FOUND");
      print(r.body);
    } else {
      print('Created!!!');
    }
  });
  // var token = jsonDecode(r.body)['auth_token'];
  // addStringToSF(token);
  // Navigator.of(context).pushReplacementNamed('/mainPage');
}

Future<Post> creation(String title, String genre, String description) async {
  PostC post =
      PostC(title: title, genre: genre, description: description, user: 2);
  //TODO:ADD USER
  var resp = await postCreation(post);
  //Posts().addPost(resp);
  return resp;
}

void createPost(String title, String genre, String description,
    Map<String, MediaInfo> data) async {
  String filenames = "";
  String base64data = "";
  data.forEach((filename, mediaData) {
    filenames += filename + ":";
    base64data += mediaData.base64 + ":";
  });
  var r = await futurePostCreation(
      title, genre, description, filenames, base64data);
}

futurePostCreation(String title, String genre, String description,
    String filenames, String base64data) async {
  String url = Urls.postImageUrl;

  Map<String, dynamic> headers = {
    "user": User.userId,
    "base64data": base64data,
    "filename": filenames,
    "title": title,
    "description": description,
    "genre": genre,
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
  print(r['userid'].toString() + ':' + username + ":" + r['access'].toString());
  return r['userid'].toString() + ':' + username + ":" + r['access'].toString();
}

Future<Post> singlePost(String blogId) async {
  int id = int.parse(blogId);
  String url = Urls.getSinglePostUrl + '$id';
  var r = await http.get(url);
  return postCFromJson(r.body);
}

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

void userRegistration(String username, String email, String password) async {
  var r = await futureUserRegistration(username, email, password);
  print(r.body);
}

Future<http.Response> futureUserProfile(
    int userId,
    String base64Image,
    String location,
    String description,
    String token,
    bool isRequestGet) async {
  String url = Urls.getUserProfile + '$userId';
  Map<String, dynamic> headers = {
    "description": description,
    "location": location,
  };
  if (base64Image.length != 0) headers["profile_pic_base64"] = base64Image;
  try {
    print("TOKEN+++++++++++" + token);

    if (isRequestGet) {
      return await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
    } else {
      return await http.put(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: JsonEncoder().convert(headers),
      );
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<UserProfile> userProfile(
  int userId,
  String token,
  bool isRequestGet, {
  String base64Image = "",
  String location = "",
  String description = "",
}) async {
  var r = await futureUserProfile(
      userId, base64Image, location, description, token, isRequestGet);
  print("STATUS CODE+++++ ${r.statusCode}");
  if (r.statusCode == 404) {
    return null;
  } else {
    return userProfileFromJson(r.body);
  }
}

// Future<UserProfile> getUserProfile(int id, String token) async {
//   String url = Urls.getUserProfile + '$id';
//   print("TOKEN+++++----" + token);

//   final r = await http.get(
//     url,
//     headers: {
//       HttpHeaders.contentTypeHeader: "application/json",
//       HttpHeaders.authorizationHeader: "Bearer $token"
//     },
//   );
//   print(r.body);
//   print("TOKEn_________________" + token);
//   print(userProfileFromJson(r.body).location);
//   return userProfileFromJson(r.body);
// }

Future regsiterUser(String username, String email, String password) async {
  String url = Urls.registerUserUrl;
  Map<String, dynamic> headers = {
    "email": email,
    "username": username,
    "password": password,
  };
  try {
    return await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: JsonEncoder().convert(headers),
    );
  } catch (e) {
    print(e);
    return null;
  }
}

upload(MediaInfo mediaData) {
//    var stream=http.ByteStream.fromBytes(mediaData.data);
//    var xx=mediaData.data.length;
  List<int> bytes = List.from(mediaData.data);
  //var stream=http.ByteStream.fromBytes(bytes);
  var url = 'http://127.0.0.1:8080/api/test/';
  var request = http.MultipartRequest("POST", Uri.parse(url));
  request.fields['user'] = '1';
  request.files.add(http.MultipartFile.fromBytes(
    'image',
    bytes,
    filename: mediaData.fileName,
    contentType: MediaType('application', 'png'),
  ));
  request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
  request
      .send()
      .then((value) => print("++++++++++++++" + value.toString()))
      .catchError((error) => print("+++++++GOT ERROT" + error.toString()));
}
