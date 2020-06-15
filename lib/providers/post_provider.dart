// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../model/post.dart';
// import '../constants/urls.dart';

// class Posts with ChangeNotifier {
//   List<Post> _posts = [];
//   bool isPostFetched = false;

//   List<Post> get items {
//     return [..._posts];
//   }

//   Post getParticularPost(int id) {
//     print("--------------------- ${_posts.length}");
//     print("----------------------------- START");
//     print("ID $id");
//     Post post = _posts.firstWhere((p) {
//       if (p.id == id)
//         return true;
//       else
//         return false;
//     }, orElse: () => null);
//     print("----------------------------- Stop");
//     print("------------------ " + post.toString());
//     isPostFetched = true;
//     return post;
//   }

//   // Future<Post>(int id) async {
//   //   String url = "";
//   //   Map<String, dynamic> headers = {
//   //     "id": id,
//   //   };

//   //   final response = http.post(
//   //     url,
//   //     headers: {'Content-Type': 'application/json'},
//   //     body: JsonEncoder().convert(headers),
//   //   );
//   //   if (response.statusCode != 200) {
//   //     print(r.body);
//   //     //add error return
//   //   } else return jsonToPost(response.body);
//   // }

//   Future<List<Post>> getPost() async {
//     String url = Urls.getPostUrl;
//     final response = await http.get(
//       Uri.encodeFull(url),
//     );
//     print(response.body);
//     for (Post post in postFromJson(response.body)) {
//       print("----------****** ${_posts.length}");
//       addPost(post);
//     }
//     return postFromJson(response.body);
//   }

//   void addPost(Post post) {
//     // _items.add(value);
//     _posts.add(post);
//     print("*/*/*/*/*/*/*/*/*/*/*/*/ ${post.description}");
//     notifyListeners();
//   }
// }
