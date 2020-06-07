// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Post postCFromJson(String str) => Post.fromJson(json.decode(str));


class Post {
    int id;
    String title;
    String genre;
    String description;
    int likes;
    DateTime datePosted;
    DateTime updatedOn;
    int user;

    Post({
        this.id,
        this.title,
        this.genre,
        this.description,
        this.likes,
        this.datePosted,
        this.updatedOn,
        this.user,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        genre: json["genre"],
        description: json["description"],
        likes: json["likes"],
        datePosted: DateTime.parse(json["date_posted"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "genre": genre,
        "description": description,
        "likes": likes,
        "date_posted": datePosted.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "user": user,
    };
}
