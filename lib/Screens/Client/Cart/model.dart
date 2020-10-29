// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.data,
    this.message,
    this.status,
  });

  Data data;
  String message;
  int status;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
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
    this.total,
    this.products,
  });

  String total;
  List<Product> products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    total: json["total"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.quantity,
    this.image,
    this.price,
    this.name,
    this.loading
  });

  int id;
  String quantity;
  String image;
  String price;
  String name;
bool loading;
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    quantity: json["quantity"],
    image: json["image"],
    price: json["price"],
    name:  json["name"],
    loading: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "image": image,
    "price": price,
    "name":name
  };
}
