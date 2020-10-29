import 'dart:convert';

CitiesModel citiesModelFromJson(String str) => CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  CitiesModel({
    this.data,
    this.message,
    this.status,
  });

  List<CitiesData> data;
  String message;
  int status;

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
    data: List<CitiesData>.from(json["data"].map((x) => CitiesData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class CitiesData {
  CitiesData({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory CitiesData.fromJson(Map<String, dynamic> json) => CitiesData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
