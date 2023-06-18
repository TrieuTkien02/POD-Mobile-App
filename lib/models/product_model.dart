import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {required this.imageUrl,
      required this.category,
      required this.name,
      required this.price,
      required this.description,
      required this.isFavourite,
      required this.material,
      required this.size,
      required this.productionunit,
      required this.color,
      this.qty,
      });

  String imageUrl;
  String category;
  bool isFavourite;
  String name;
  double price;
  String description;
  String material;
  String size;
  String productionunit;
  String color;
  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        category: json["category"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        isFavourite: false,
        qty: json["qty"],
        price: double.parse(json["price"].toString()),
        material: json["material"],
        size: json["size"],
        productionunit: json["productionunit"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "name": name,
        "image_url": imageUrl,
        "description": description,
        "isFavourite": isFavourite,
        "price": price,
        "qty": qty,
        "material": material,
        "size": size,
        "productionunit": productionunit,
        "color": color,
      };
  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
        category: category,
        name: name,
        description: description,
        imageUrl: imageUrl,
        isFavourite: isFavourite,
        qty: qty ?? this.qty,
        price: price,
        material: material,
        size: size,
        productionunit: productionunit,
        color: color,
      );
}
