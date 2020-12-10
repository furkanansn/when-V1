// To parse this JSON data, do
//
//     final error = errorFromJson(jsonString);

import 'dart:convert';

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

String errorToJson(Error data) => json.encode(data.toJson());

class Error {
  Error({
    this.the0,
    this.status,
    this.errCode,
    this.errMsg,
  });

  int the0;
  bool status;
  int errCode;
  String errMsg;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    the0: json["0"] == null ? null : json["0"],
    status: json["status"] == null ? null : json["status"],
    errCode: json["errCode"] == null ? null : json["errCode"],
    errMsg: json["errMsg"] == null ? null : json["errMsg"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0 == null ? null : the0,
    "status": status == null ? null : status,
    "errCode": errCode == null ? null : errCode,
    "errMsg": errMsg == null ? null : errMsg,
  };
}
