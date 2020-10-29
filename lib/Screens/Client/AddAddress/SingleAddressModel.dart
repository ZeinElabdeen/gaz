// To parse this JSON data, do
//
//     final singleAddressDetailsModel = singleAddressDetailsModelFromJson(jsonString);

import 'dart:convert';

SingleAddressDetailsModel singleAddressDetailsModelFromJson(String str) => SingleAddressDetailsModel.fromJson(json.decode(str));

String singleAddressDetailsModelToJson(SingleAddressDetailsModel data) => json.encode(data.toJson());

class SingleAddressDetailsModel {
  SingleAddressDetailsModel({
    this.data,
    this.message,
    this.status,
  });

  Data data;
  String message;
  int status;

  factory SingleAddressDetailsModel.fromJson(Map<String, dynamic> json) => SingleAddressDetailsModel(
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
    this.id,
    this.lat,
    this.long,
    this.type,
    this.number,
    this.nearPlace,
    this.details,
  });

  int id;
  String lat;
  String long;
  String type;
  String number;
  String nearPlace;
  String details;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    lat: json["lat"],
    long: json["long"],
    type: json["type"],
    number: json["number"],
    nearPlace: json["near_place"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lat": lat,
    "long": long,
    "type": type,
    "number": number,
    "near_place": nearPlace,
    "details": details,
  };
}
