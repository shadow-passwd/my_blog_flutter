// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
    UserProfile({
        this.id,
        this.user,
        this.profileCoverImage,
        this.profilePic,
        this.description,
        this.location,
        this.githubIdUrl,
        this.twitterIdUrl,
        this.facebookIdUrl,
        this.dateJoined,
        this.updatedOn,
    });

    int id;
    String user;
    String profileCoverImage;
    String profilePic;
    String description;
    String location;
    String githubIdUrl;
    String twitterIdUrl;
    String facebookIdUrl;
    DateTime dateJoined;
    DateTime updatedOn;

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        user: json["user"],
        profileCoverImage: json["profile_cover_image"],
        profilePic: json["profile_pic"],
        description: json["description"],
        location: json["location"],
        githubIdUrl: json["github_id_url"],
        twitterIdUrl: json["twitter_id_url"],
        facebookIdUrl: json["facebook_id_url"],
        dateJoined: DateTime.parse(json["date_joined"]),
        updatedOn: DateTime.parse(json["updated_on"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "profile_cover_image": profileCoverImage,
        "profile_pic": profilePic,
        "description": description,
        "location": location,
        "github_id_url": githubIdUrl,
        "twitter_id_url": twitterIdUrl,
        "facebook_id_url": facebookIdUrl,
        "date_joined": dateJoined.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
    };
}
