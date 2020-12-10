// To parse this JSON data, do
//
//     final eventNew = eventNewFromJson(jsonString);

import 'dart:convert';

List<EventNew> eventNewFromJson(String str) => List<EventNew>.from(json.decode(str).map((x) => EventNew.fromJson(x)));

String eventNewToJson(List<EventNew> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventNew {
  EventNew({
    this.eventId,
    this.eventHangout,
    this.eventEventName,
    this.eventEventDate,
    this.eventLocationX,
    this.eventLocationY,
    this.eventPhoto,
    this.eventUserId,
    this.userId,
    this.email,
    this.password,
    this.name,
    this.mobile,
    this.roleId,
    this.isDeleted,
    this.createdBy,
    this.createdDtm,
    this.updatedBy,
    this.updatedDtm,
    this.url_iframe,
  });
  String url_iframe;
  String eventId;
  String eventHangout;
  String eventEventName;
  String eventEventDate;
  String eventLocationX;
  String eventLocationY;
  String eventPhoto;
  String eventUserId;
  String userId;
  String email;
  String password;
  String name;
  String mobile;
  String roleId;
  String isDeleted;
  String createdBy;
  DateTime createdDtm;
  String updatedBy;
  DateTime updatedDtm;

  factory EventNew.fromJson(Map<String, dynamic> json) => EventNew(
    eventId: json["event_id"] == null ? null : json["event_id"],
    eventHangout: json["event_hangout"] == null ? null : json["event_hangout"],
    eventEventName: json["event_eventName"] == null ? null : json["event_eventName"],
    eventEventDate: json["event_eventDate"] == null ? null : json["event_eventDate"],
    eventLocationX: json["event_locationX"] == null ? null : json["event_locationX"],
    eventLocationY: json["event_locationY"] == null ? null : json["event_locationY"],
    eventPhoto: json["event_photo"] == null ? null : json["event_photo"],
    eventUserId: json["event_userID"] == null ? null : json["event_userID"],
    userId: json["userId"] == null ? null : json["userId"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    name: json["name"] == null ? null : json["name"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    roleId: json["roleId"] == null ? null : json["roleId"],
    isDeleted: json["isDeleted"] == null ? null : json["isDeleted"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdDtm: json["createdDtm"] == null ? null : DateTime.parse(json["createdDtm"]),
    updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
    updatedDtm: json["updatedDtm"] == null ? null : DateTime.parse(json["updatedDtm"]),
    url_iframe: json["url_iframe"] == null ? null : json["url_iframe"],

  );

  Map<String, dynamic> toJson() => {
    "event_id": eventId == null ? null : eventId,
    "event_hangout": eventHangout == null ? null : eventHangout,
    "event_eventName": eventEventName == null ? null : eventEventName,
    "event_eventDate": eventEventDate == null ? null : eventEventDate,
    "event_locationX": eventLocationX == null ? null : eventLocationX,
    "event_locationY": eventLocationY == null ? null : eventLocationY,
    "event_photo": eventPhoto == null ? null : eventPhoto,
    "event_userID": eventUserId == null ? null : eventUserId,
    "userId": userId == null ? null : userId,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "name": name == null ? null : name,
    "mobile": mobile == null ? null : mobile,
    "roleId": roleId == null ? null : roleId,
    "isDeleted": isDeleted == null ? null : isDeleted,
    "createdBy": createdBy == null ? null : createdBy,
    "createdDtm": createdDtm == null ? null : createdDtm.toIso8601String(),
    "updatedBy": updatedBy == null ? null : updatedBy,
    "updatedDtm": updatedDtm == null ? null : updatedDtm.toIso8601String(),
    "url_iframe": url_iframe == null ? null : url_iframe,
  };
}
