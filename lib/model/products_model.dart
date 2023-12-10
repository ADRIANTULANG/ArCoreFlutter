import 'dart:convert';

import 'package:get/get.dart';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  String image;
  double price;
  String name;
  String description;
  dynamic isNew;
  List<String> specifications;
  List<String> woodTypes;
  List<String> colors;
  RxInt quantity;
  String id;
  String arFile;
  String stocks;
  List<Rate> rate;

  Products({
    required this.image,
    required this.price,
    required this.name,
    required this.description,
    required this.isNew,
    required this.specifications,
    required this.quantity,
    required this.id,
    required this.woodTypes,
    required this.colors,
    required this.arFile,
    required this.rate,
    required this.stocks,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        image: json["image"],
        price: double.parse(json["price"].toString()),
        name: json["name"],
        description: json["description"],
        quantity: 0.obs,
        isNew: json["isNew"],
        stocks: json["stocks"],
        specifications: List<String>.from(json["specifications"].map((x) => x)),
        woodTypes: List<String>.from(json["woodTypes"].map((x) => x)),
        colors: List<String>.from(json["colors"].map((x) => x)),
        id: json["id"],
        arFile: json["arFile"],
        rate: List<Rate>.from(json["rate"].map((x) => Rate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "price": price,
        "name": name,
        "stocks": stocks,
        "arFile": arFile,
        "quantity": quantity,
        "description": description,
        "isNew": isNew,
        "specifications": List<dynamic>.from(specifications.map((x) => x)),
        "woodTypes": List<dynamic>.from(specifications.map((x) => x)),
        "colors": List<dynamic>.from(specifications.map((x) => x)),
        "id": id,
        "rate": List<dynamic>.from(rate.map((x) => x.toJson())),
      };
}

class Rate {
  double rate;
  String comment;
  String userid;
  String email;
  String id;

  Rate({
    required this.rate,
    required this.comment,
    required this.userid,
    required this.email,
    required this.id,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        rate: double.parse(json["rate"].toString()),
        comment: json["comment"],
        userid: json["userid"],
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "comment": comment,
        "userid": userid,
        "email": email,
        "id": id,
      };
}
