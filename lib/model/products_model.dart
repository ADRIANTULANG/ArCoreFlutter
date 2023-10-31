import 'dart:convert';

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
  String id;
  String arFile;

  Products({
    required this.image,
    required this.price,
    required this.name,
    required this.description,
    required this.isNew,
    required this.specifications,
    required this.id,
    required this.arFile,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        image: json["image"],
        price: double.parse(json["price"].toString()),
        name: json["name"],
        description: json["description"],
        isNew: json["isNew"],
        specifications: List<String>.from(json["specifications"].map((x) => x)),
        id: json["id"],
        arFile: json["arFile"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "price": price,
        "name": name,
        "arFile": arFile,
        "description": description,
        "isNew": isNew,
        "specifications": List<dynamic>.from(specifications.map((x) => x)),
        "id": id,
      };
}
