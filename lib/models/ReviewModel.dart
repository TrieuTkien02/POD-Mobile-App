import 'dart:convert';

ReviewModel reviewModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  String reviewerName;
  String comment;
  String rating;

  ReviewModel(
      {required this.reviewerName,
      required this.comment,
      required this.rating});

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        reviewerName: json["reviewerName"],
        comment: json["comment"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "reviewerName": reviewerName,
        "comment": comment,
        "rating": rating,
      };
}
