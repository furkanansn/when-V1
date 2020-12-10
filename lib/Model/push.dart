// To parse this JSON data, do
//
//     final push = pushFromJson(jsonString);

import 'dart:convert';

Push pushFromJson(String str) => Push.fromJson(json.decode(str));

String pushToJson(Push data) => json.encode(data.toJson());

class Push {
  Push({
    this.id,
    this.header,
    this.message,
    this.iosVersionName,
    this.iosVersionCode,
    this.andVersionName,
    this.andVersionCode,
  });

  String id;
  String header;
  String message;
  String iosVersionName;
  String iosVersionCode;
  String andVersionName;
  String andVersionCode;

  factory Push.fromJson(Map<String, dynamic> json) => Push(
    id: json["id"] == null ? null : json["id"],
    header: json["header"] == null ? null : json["header"],
    message: json["message"] == null ? null : json["message"],
    iosVersionName: json["ios_version_name"] == null ? null : json["ios_version_name"],
    iosVersionCode: json["ios_version_code"] == null ? null : json["ios_version_code"],
    andVersionName: json["and_version_name"] == null ? null : json["and_version_name"],
    andVersionCode: json["and_version_code"] == null ? null : json["and_version_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "header": header == null ? null : header,
    "message": message == null ? null : message,
    "ios_version_name": iosVersionName == null ? null : iosVersionName,
    "ios_version_code": iosVersionCode == null ? null : iosVersionCode,
    "and_version_name": andVersionName == null ? null : andVersionName,
    "and_version_code": andVersionCode == null ? null : andVersionCode,
  };
}
