// To parse this JSON data, do
//
//     final appInfoModel = appInfoModelFromJson(jsonString);

import 'dart:convert';

AppInfoModel appInfoModelFromJson(String str) => AppInfoModel.fromJson(json.decode(str));

String appInfoModelToJson(AppInfoModel data) => json.encode(data.toJson());

class AppInfoModel {
  AppInfoModel({
    this.data,
    this.message,
    this.status,
  });

  String data;
  String message;
  int status;

  factory AppInfoModel.fromJson(Map<String, dynamic> json) => AppInfoModel(
    data: json["data"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "message": message,
    "status": status,
  };
}
