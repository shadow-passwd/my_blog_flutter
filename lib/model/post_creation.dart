// To parse this JSON data, do
//
//     final postC = postCFromJson(jsonString);

import 'dart:convert';


String postCToJson(PostC data) => json.encode(data.toJson());

class PostC {
    String title;
    String genre;
    String description;
    int user;

    PostC({
        this.title,
        this.genre,
        this.description,
        this.user,
    });

    factory PostC.fromJson(Map<String, dynamic> json) => PostC(
        title: json["title"],
        genre: json["genre"],
        description: json["description"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "genre": genre,
        "description": description,
        "user": user,
    };
}
