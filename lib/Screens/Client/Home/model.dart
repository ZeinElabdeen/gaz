// To parse this JSON data, do
//
//     final clientHomeModel = clientHomeModelFromJson(jsonString);

import 'dart:convert';

ClientHomeModel clientHomeModelFromJson(String str) =>
    ClientHomeModel.fromJson(json.decode(str));

String clientHomeModelToJson(ClientHomeModel data) =>
    json.encode(data.toJson());

class ClientHomeModel {
  ClientHomeModel({
    this.data,
    this.message,
    this.status,
  });

  Data data;
  String message;
  int status;

  factory ClientHomeModel.fromJson(Map<String, dynamic> json) =>
      ClientHomeModel(
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
    this.categories,
    this.sliders,
  });

  List<Category> categories;
  List<Slider> sliders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        sliders:
            List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.desc,
    this.image,
    this.backImage,
  });

  int id;
  String name;
  String desc;
  String image;
  String backImage;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
        image: json["image"],
        backImage: json["back_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "image": image,
        "back_image": backImage,
      };
}

class Slider {
  Slider({
    this.name,
    this.content,
    this.image,
  });

  String name;
  String content;
  String image;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        name: json["name"],
        content: json["content"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "content": content,
        "image": image,
      };
}
