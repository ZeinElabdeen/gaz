// To parse this JSON data, do
//
//     final addressesModel = addressesModelFromJson(jsonString);

import 'dart:convert';

AddressesModel addressesModelFromJson(String str) => AddressesModel.fromJson(json.decode(str));

String addressesModelToJson(AddressesModel data) => json.encode(data.toJson());

class AddressesModel {
  AddressesModel({
    this.data,
    this.message,
    this.status,
  });

  List<ClientAddressData> data;
  String message;
  int status;

  factory AddressesModel.fromJson(Map<String, dynamic> json) => AddressesModel(
    data: List<ClientAddressData>.from(json["data"].map((x) => ClientAddressData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class ClientAddressData {
  ClientAddressData({
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

  factory ClientAddressData.fromJson(Map<String, dynamic> json) => ClientAddressData(
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
