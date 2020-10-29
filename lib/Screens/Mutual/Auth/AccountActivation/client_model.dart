// To parse this JSON data, do
//
//     final clientAccountActivationModel = clientAccountActivationModelFromJson(jsonString);

import 'dart:convert';

ClientAccountActivationModel clientAccountActivationModelFromJson(String str) => ClientAccountActivationModel.fromJson(json.decode(str));

String clientAccountActivationModelToJson(ClientAccountActivationModel data) => json.encode(data.toJson());

class ClientAccountActivationModel {
  ClientAccountActivationModel({
    this.data,
    this.message,
    this.status,
  });

  Data data;
  String message;
  int status;

  factory ClientAccountActivationModel.fromJson(Map<String, dynamic> json) => ClientAccountActivationModel(
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
    this.name,
    this.email,
    this.token,
    this.phone,
    this.image,
    this.cityId,
    this.cityName,
  });

  int id;
  String name;
  String email;
  String token;
  String phone;
  String image;
  int cityId;
  String cityName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    token: json["token"],
    phone: json["phone"],
    image: json["image"],
    cityId: json["city_id"],
    cityName: json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "token": token,
    "phone": phone,
    "image": image,
    "city_id": cityId,
    "city_name": cityName,
  };
}
