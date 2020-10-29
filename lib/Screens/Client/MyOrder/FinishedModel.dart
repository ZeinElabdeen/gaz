// To parse this JSON data, do
//
//     final clientFinishedOrdersModel = clientFinishedOrdersModelFromJson(jsonString);

import 'dart:convert';

ClientFinishedOrdersModel clientFinishedOrdersModelFromJson(String str) =>
    ClientFinishedOrdersModel.fromJson(json.decode(str));

String clientFinishedOrdersModelToJson(ClientFinishedOrdersModel data) =>
    json.encode(data.toJson());

class ClientFinishedOrdersModel {
  ClientFinishedOrdersModel({
    this.data,
    this.message,
    this.status,
  });

  List<Datum> data;
  String message;
  int status;

  factory ClientFinishedOrdersModel.fromJson(Map<String, dynamic> json) =>
      ClientFinishedOrdersModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class Datum {
  Datum({
    this.id,
    this.createdAt,
    this.date,
    this.total,
    this.productCount,
  });

  int id;
  String createdAt;
  String date;
  String total;
  int productCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: json["created_at"],
        date: json["date"],
        total: json["total"],
        productCount: json["product_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "date": date,
        "total": total,
        "product_count": productCount,
      };
}
