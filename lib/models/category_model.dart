import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String image;
  String name;

  CategoryModel({
    required this.image,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "image": image,
        "name": name,
      };
}
