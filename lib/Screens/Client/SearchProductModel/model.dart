import 'dart:convert';

ClientHomeSearchModel clientHomeSearchModelFromJson(String str) => ClientHomeSearchModel.fromJson(json.decode(str));

String clientHomeSearchModelToJson(ClientHomeSearchModel data) => json.encode(data.toJson());

class ClientHomeSearchModel {
  ClientHomeSearchModel({
    this.data,
    this.message,
    this.status,
  });

  List<SearchItem> data;
  String message;
  int status;

  factory ClientHomeSearchModel.fromJson(Map<String, dynamic> json) => ClientHomeSearchModel(
    data: List<SearchItem>.from(json["data"].map((x) => SearchItem.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class SearchItem {
  SearchItem({
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

  factory SearchItem.fromJson(Map<String, dynamic> json) => SearchItem(
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
