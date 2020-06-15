// To parse this JSON data, do
//
//     final singlePost = singlePostFromJson(jsonString);

import 'dart:convert';

SinglePost singlePostFromJson(String str) => SinglePost.fromJson(json.decode(str));

String singlePostToJson(SinglePost data) => json.encode(data.toJson());

class SinglePost {
    SinglePost({
        this.id,
        this.postCoverImage,
        this.title,
        this.genre,
        this.tags,
        this.content,
        this.likes,
        this.emailIdUrl,
        this.githubIdUrl,
        this.twitterIdUrl,
        this.facebookIdUrl,
        this.datePosted,
        this.updatedOn,
        this.slug,
        this.user,
    });

    int id;
    String postCoverImage;
    String title;
    String genre;
    String tags;
    String content;
    int likes;
    String emailIdUrl;
    String githubIdUrl;
    String twitterIdUrl;
    String facebookIdUrl;
    DateTime datePosted;
    DateTime updatedOn;
    String slug;
    int user;

    factory SinglePost.fromJson(Map<String, dynamic> json) => SinglePost(
        id: json["id"],
        postCoverImage: json["post_cover_image"],
        title: json["title"],
        genre: json["genre"],
        tags: json["tags"],
        content: json["content"],
        likes: json["likes"],
        emailIdUrl: json["email_id_url"],
        githubIdUrl: json["github_id_url"],
        twitterIdUrl: json["twitter_id_url"],
        facebookIdUrl: json["facebook_id_url"],
        datePosted: DateTime.parse(json["date_posted"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        slug: json["slug"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "post_cover_image": postCoverImage,
        "title": title,
        "genre": genre,
        "tags": tags,
        "content": content,
        "likes": likes,
        "email_id_url": emailIdUrl,
        "github_id_url": githubIdUrl,
        "twitter_id_url": twitterIdUrl,
        "facebook_id_url": facebookIdUrl,
        "date_posted": datePosted.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "slug": slug,
        "user": user,
    };
}
