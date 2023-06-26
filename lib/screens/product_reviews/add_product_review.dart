import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/routes.dart';
import '../../firebase_support/firebase_firestore.dart';
import '../../models/order_model.dart';
import 'add_review_details.dart';

class AddReviews extends StatelessWidget {
  const AddReviews({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Đánh giá sản phẩm",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: FirebaseFirestoreHelper.instance.getUserOrderStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Không tìm thấy đơn đặt hàng",
                style: TextStyle(fontSize: 15),
              ),
            );
          }

          List<OrderModel> orderList = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ListView.builder(
              itemCount: orderList.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                OrderModel orderModel = orderList[index];
                final priceFormat = NumberFormat("#,###");
                final formattedPrice = priceFormat
                    .format(orderModel.products[0].price.toInt())
                    .replaceAll(',', '.');
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.3)),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.3)),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          child: Image.network(
                            orderModel.products[0].imageUrl,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderModel.products[0].name,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                "Giá: ${formattedPrice} VNĐ",
                                style: const TextStyle(
                                  fontSize: 13.0,
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Routes.instance.push(
                                      widget: AddReviewDetails(productName: orderModel.products[0].name, partnerName: orderModel.products[0].partner),
                                      context: context);
                                },
                                child: const Text("Thêm đánh giá"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    children: orderModel.products.length > 1
                        ? [
                            const Text(
                              "Chi tiết",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Divider(color: Theme.of(context).primaryColor),
                            ...orderModel.products.map((singleProduct) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 6.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          height: 120,
                                          width: 100,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.5),
                                          child: Image.network(
                                            singleProduct.imageUrl,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                singleProduct.name,
                                                style: const TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "Giá: ${priceFormat.format(singleProduct.price.toInt()).replaceAll(',', '.')} VNĐ",
                                                style: const TextStyle(
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  Routes.instance.push(
                                                      widget:
                                                          AddReviewDetails(productName: singleProduct.name, partnerName: singleProduct.partner),
                                                      context: context);
                                                },
                                                child:
                                                    const Text("Thêm đánh giá"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                        color: Theme.of(context).primaryColor),
                                  ],
                                ),
                              );
                            }).toList()
                          ]
                        : [],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
