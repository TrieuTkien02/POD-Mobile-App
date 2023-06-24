import 'package:pod_market/models/product_model.dart';

class OrderModel {
  OrderModel({
    required this.totalPrice,
    required this.orderId,
    required this.payment,
    required this.products,
    required this.status,
    required this.nameUser,
    required this.phoneUser,
    required this.addressUser,
  });

  String payment;
  String status;
  String nameUser;
  String phoneUser;
  String addressUser;
  List<ProductModel> products;
  double totalPrice;
  String orderId;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
      orderId: json["orderId"],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
      totalPrice: json["totalPrice"],
      status: json["status"],
      payment: json["payment"],
      nameUser: json["nameUser"],
      phoneUser: json["phoneUser"],
      addressUser: json["addressUser"],
    );
  }
}
