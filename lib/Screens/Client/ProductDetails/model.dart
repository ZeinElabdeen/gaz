import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  ProductDetailsModel({
    this.data,
    this.message,
    this.status,
  });

  Data data;
  String message;
  int status;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
