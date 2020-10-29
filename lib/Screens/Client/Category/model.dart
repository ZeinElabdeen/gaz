// To parse this JSON data, do
//
//     final clientCategoryProductsModel = clientCategoryProductsModelFromJson(jsonString);

import 'dart:convert';

ClientCategoryProductsModel clientCategoryProductsModelFromJson(String str) => ClientCategoryProductsModel.fromJson(json.decode(str));

String clientCategoryProductsModelToJson(ClientCategoryProductsModel data) => json.encode(data.toJson());

class ClientCategoryProductsModel {
  ClientCategoryProductsModel({
    this.data,
    this.message,
    this.status,
  });

  List<Datum> data;
  String message;
  int status;

  factory ClientCategoryProductsModel.fromJson(Map<String, dynamic> json) => ClientCategoryProductsModel(
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
    this.name,
    this.desc,
    this.image,
    this.price,
    this.categoryId,
    this.categoryName,
  });

  int id;
  String name;
  String desc;
  String image;
  String price;
  int categoryId;
  String categoryName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    desc: json["desc"],
    image: json["image"],
    price: json["price"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "desc": desc,
    "image": image,
    "price": price,
    "category_id": categoryId,
    "category_name": categoryName,
  };
}
