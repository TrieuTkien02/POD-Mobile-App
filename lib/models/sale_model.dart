import 'dart:convert';

SaleModel saleModelFromJson(String str) => SaleModel.fromJson(json.decode(str));

String saleModelToJson(SaleModel data) => json.encode(data.toJson());

class SaleModel {
  SaleModel({
    required this.image,
    required this.id,
    required this.info,
  });

  String image;
  String info;
  String id;

  factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
        id: json["id"],
        image: json["image"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "info": info,
      };
}
