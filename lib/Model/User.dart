// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.userId,
    this.userUsername,
    this.userFullName,
    this.userPassword,
    this.userPp,
    this.userRoleId,
    this.email,
    this.userShowMyFav,
    this.userInstagram,
    this.userTwitter,
    this.userFacebook,
    this.showProfile,
    this.userAbout,
    this.status,
    this.extension,
  });

  String userId;
  String userUsername;
  String userFullName;
  String userPassword;
  String userPp;
  String userRoleId;
  String email;
  String userShowMyFav;
  dynamic userInstagram;
  dynamic userTwitter;
  dynamic userFacebook;
  String showProfile;
  dynamic userAbout;
  bool status;
  String extension;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"] == null ? null : json["user_id"],
    userUsername: json["user_username"] == null ? null : json["user_username"],
    userFullName: json["user_fullName"] == null ? null : json["user_fullName"],
    userPassword: json["user_password"] == null ? null : json["user_password"],
    userPp: json["user_PP"] == null ? null : json["user_PP"],
    userRoleId: json["user_roleID"] == null ? null : json["user_roleID"],
    email: json["user_email"] == null ? null : json["user_email"],
    userShowMyFav: json["user_show_my_fav"] == null ? null : json["user_show_my_fav"],
    userInstagram: json["user_instagram"],
    userTwitter: json["user_twitter"],
    userFacebook: json["user_facebook"],
    showProfile: json["show_profile"] == null ? null : json["show_profile"],
    userAbout: json["user_about"],
    status: json["status"],
    extension: json["extension"],

  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "user_username": userUsername == null ? null : userUsername,
    "user_fullName": userFullName == null ? null : userFullName,
    "user_password": userPassword == null ? null : userPassword,
    "user_PP": userPp == null ? null : userPp,
    "user_roleID": userRoleId == null ? null : userRoleId,
    "user_email": email == null ? null : email,
    "user_show_my_fav": userShowMyFav == null ? null : userShowMyFav,
    "user_instagram": userInstagram,
    "user_twitter": userTwitter,
    "user_facebook": userFacebook,
    "show_profile": showProfile == null ? null : showProfile,
    "user_about": userAbout,
    "extension" : extension,
    "status" : status,
  };
}
