import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.image,
    required this.name,
    required this.email,
  });

  String? image;
  String name;
  String email;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        image: json["image"],
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "email": email,
      };

  UserModel copyWith({
    String? name,
    image,
  }) =>
      UserModel(
        name: name ?? this.name,
        email: email,
        image: image ?? this.image,
      );
}
