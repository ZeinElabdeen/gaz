// To parse this JSON data, do
//
//     final purchaseFollowingModel = purchaseFollowingModelFromJson(jsonString);

import 'dart:convert';

PurchaseFollowingModel purchaseFollowingModelFromJson(String str) => PurchaseFollowingModel.fromJson(json.decode(str));

String purchaseFollowingModelToJson(PurchaseFollowingModel data) => json.encode(data.toJson());

class PurchaseFollowingModel {
  PurchaseFollowingModel({
    this.data,
    this.message,
    this.status,
  });

  Data data;
  String message;
  int status;

  factory PurchaseFollowingModel.fromJson(Map<String, dynamic> json) => PurchaseFollowingModel(
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
    this.subTotal,
    this.delivery,
    this.tax,
    this.total,
  });

  String subTotal;
  int delivery;
  String tax;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    subTotal: json["sub_total"],
    delivery: json["delivery"],
    tax: json["tax"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "sub_total": subTotal,
    "delivery": delivery,
    "tax": tax,
    "total": total,
  };
}
