// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  ContactUsModel({
    this.data,
    this.message,
    this.status,
  });

  Data data;
  String message;
  int status;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status": status,
  };
}

class Data {
  Data({
    this.phone,
    this.whatsapp,
    this.email,
    this.facebook,
    this.twitter,
    this.instgram,
  });

  String phone;
  String whatsapp;
  String email;
  String facebook;
  String twitter;
  String instgram;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phone: json["phone"],
    whatsapp: json["whatsapp"],
    email: json["email"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    instgram: json["instgram"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "whatsapp": whatsapp,
    "email": email,
    "facebook": facebook,
    "twitter": twitter,
    "instgram": instgram,
  };
}
