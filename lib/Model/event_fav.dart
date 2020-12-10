// To parse this JSON data, do
//
//     final getWhoFavsEvent = getWhoFavsEventFromJson(jsonString);

import 'dart:convert';

List<GetWhoFavsEvent> getWhoFavsEventFromJson(String str) => List<GetWhoFavsEvent>.from(json.decode(str).map((x) => GetWhoFavsEvent.fromJson(x)));

String getWhoFavsEventToJson(List<GetWhoFavsEvent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetWhoFavsEvent {
  GetWhoFavsEvent({
    this.userId,
    this.eventId,
    this.eventHangout,
    this.eventEventName,
    this.eventEventDate,
    this.eventLocationX,
    this.eventLocationY,
    this.eventPhoto,
    this.eventUserId,
    this.urlIframe,
    this.userUsername,
    this.userFullName,
    this.userPassword,
    this.userPp,
    this.userRoleId,
    this.userCreatedAt,
    this.userEmail,
    this.userLastLogin,
    this.userIp,
    this.userLastLogout,
    this.userDevice,
    this.userGender,
    this.userHash,
    this.userPhone,
    this.userBoard,
    this.userBrand,
    this.userHardware,
    this.userHost,
    this.userPhoneModel,
    this.userProduct,
    this.userAndroidId,
    this.userShowMyFav,
  });

  String userId;
  String eventId;
  String eventHangout;
  String eventEventName;
  DateTime eventEventDate;
  String eventLocationX;
  String eventLocationY;
  String eventPhoto;
  String eventUserId;
  String urlIframe;
  String userUsername;
  String userFullName;
  String userPassword;
  String userPp;
  String userRoleId;
  DateTime userCreatedAt;
  String userEmail;
  DateTime userLastLogin;
  String userIp;
  dynamic userLastLogout;
  String userDevice;
  dynamic userGender;
  String userHash;
  dynamic userPhone;
  dynamic userBoard;
  dynamic userBrand;
  dynamic userHardware;
  dynamic userHost;
  dynamic userPhoneModel;
  dynamic userProduct;
  dynamic userAndroidId;
  String userShowMyFav;

  factory GetWhoFavsEvent.fromJson(Map<String, dynamic> json) => GetWhoFavsEvent(
    userId: json["user_id"] == null ? null : json["user_id"],
    eventId: json["event_id"] == null ? null : json["event_id"],
    eventHangout: json["event_hangout"] == null ? null : json["event_hangout"],
    eventEventName: json["event_eventName"] == null ? null : json["event_eventName"],
    eventEventDate: json["event_eventDate"] == null ? null : DateTime.parse(json["event_eventDate"]),
    eventLocationX: json["event_locationX"] == null ? null : json["event_locationX"],
    eventLocationY: json["event_locationY"] == null ? null : json["event_locationY"],
    eventPhoto: json["event_photo"] == null ? null : json["event_photo"],
    eventUserId: json["event_userID"] == null ? null : json["event_userID"],
    urlIframe: json["url_iframe"] == null ? null : json["url_iframe"],
    userUsername: json["user_username"] == null ? null : json["user_username"],
    userFullName: json["user_fullName"] == null ? null : json["user_fullName"],
    userPassword: json["user_password"] == null ? null : json["user_password"],
    userPp: json["user_PP"] == null ? null : json["user_PP"],
    userRoleId: json["user_roleID"] == null ? null : json["user_roleID"],
    userCreatedAt: json["user_createdAt"] == null ? null : DateTime.parse(json["user_createdAt"]),
    userEmail: json["user_email"] == null ? null : json["user_email"],
    userLastLogin: json["user_lastLogin"] == null ? null : DateTime.parse(json["user_lastLogin"]),
    userIp: json["user_IP"] == null ? null : json["user_IP"],
    userLastLogout: json["user_lastLogout"],
    userDevice: json["user_device"] == null ? null : json["user_device"],
    userGender: json["user_gender"],
    userHash: json["user_hash"] == null ? null : json["user_hash"],
    userPhone: json["user_phone"],
    userBoard: json["user_board"],
    userBrand: json["user_brand"],
    userHardware: json["user_hardware"],
    userHost: json["user_host"],
    userPhoneModel: json["user_phoneModel"],
    userProduct: json["user_product"],
    userAndroidId: json["user_androidID"],
    userShowMyFav: json["user_show_my_fav"] == null ? null : json["user_show_my_fav"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "event_id": eventId == null ? null : eventId,
    "event_hangout": eventHangout == null ? null : eventHangout,
    "event_eventName": eventEventName == null ? null : eventEventName,
    "event_eventDate": eventEventDate == null ? null : eventEventDate.toIso8601String(),
    "event_locationX": eventLocationX == null ? null : eventLocationX,
    "event_locationY": eventLocationY == null ? null : eventLocationY,
    "event_photo": eventPhoto == null ? null : eventPhoto,
    "event_userID": eventUserId == null ? null : eventUserId,
    "url_iframe": urlIframe == null ? null : urlIframe,
    "user_username": userUsername == null ? null : userUsername,
    "user_fullName": userFullName == null ? null : userFullName,
    "user_password": userPassword == null ? null : userPassword,
    "user_PP": userPp == null ? null : userPp,
    "user_roleID": userRoleId == null ? null : userRoleId,
    "user_createdAt": userCreatedAt == null ? null : userCreatedAt.toIso8601String(),
    "user_email": userEmail == null ? null : userEmail,
    "user_lastLogin": userLastLogin == null ? null : userLastLogin.toIso8601String(),
    "user_IP": userIp == null ? null : userIp,
    "user_lastLogout": userLastLogout,
    "user_device": userDevice == null ? null : userDevice,
    "user_gender": userGender,
    "user_hash": userHash == null ? null : userHash,
    "user_phone": userPhone,
    "user_board": userBoard,
    "user_brand": userBrand,
    "user_hardware": userHardware,
    "user_host": userHost,
    "user_phoneModel": userPhoneModel,
    "user_product": userProduct,
    "user_androidID": userAndroidId,
    "user_show_my_fav": userShowMyFav == null ? null : userShowMyFav,
  };
}
