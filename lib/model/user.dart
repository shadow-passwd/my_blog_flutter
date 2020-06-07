// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.id,
    this.user,
    this.profilePicBase64,
    this.description,
    this.location,
    this.dateJoined,
    this.updatedOn,
  });

  int id;
  String user;
  String profilePicBase64;
  String description;
  String location;
  DateTime dateJoined;
  DateTime updatedOn;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        user: json["user"],
        profilePicBase64: json["profile_pic_base64"],
        description: json["description"],
        location: json["location"],
        dateJoined: DateTime.parse(json["date_joined"]),
        updatedOn: DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "profile_pic_base64": profilePicBase64,
        "description": description,
        "location": location,
        "date_joined": dateJoined.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
      };
}
