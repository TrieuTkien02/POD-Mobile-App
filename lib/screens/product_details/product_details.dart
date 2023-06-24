// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:pod_market/provider/app_provider.dart';
import 'package:provider/provider.dart';
import '../../constants/routes.dart';
import '../../models/product_model.dart';
import '../cart_screen/cart_screen.dart';
import '../product_reviews/get_product_reviews.dart';
import 'bottom_sheet.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isLoading = false;

  int qty = 1;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    final priceFormat = NumberFormat("#,###");
    final formattedPrice = priceFormat
        .format(widget.singleProduct.price.toInt())
        .replaceAll(',', '.');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const CartScreen(), context: context);
            },
            icon: const Icon(
              Icons.shopping_cart_checkout,
              color: Colors.red,
            ),
            iconSize: 35.0,
          ),
          IconButton(
            alignment: Alignment.center,
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_active,
              color: Colors.red,
            ),
            iconSize: 35.0,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.singleProduct.imageUrl,
                height: 400,
                width: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.singleProduct.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 60.00,
                  ),
                  Text(
                    "$formattedPrice VNĐ",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.00,
              ),
              Row(
                children: [
                  RatingBar.builder(
                    unratedColor: const Color.fromARGB(255, 223, 221, 221),
                    itemSize: 28,
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    onRatingUpdate: (rating) {},
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(
                    width: 150,
                  ),
                  IconButton(
                    onPressed: () {
                      if (appProvider.isFavourite(widget.singleProduct,
                              appProvider.getFavouriteProductList) ==
                          false) {
                        appProvider.addFavouriteProduct(widget.singleProduct);
                      } else {
                        appProvider
                            .removeFavouriteProduct(widget.singleProduct);
                      }
                    },
                    icon: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(
                          appProvider.isFavourite(widget.singleProduct,
                                  appProvider.getFavouriteProductList)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.00,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return CustomBottomSheet(
                                singleProduct: productModel);
                          });
                    },
                    child: const Text("Thêm vào giỏ hàng"),
                  ),
                  const SizedBox(
                    width: 24.0,
                  ),
                  SizedBox(
                    height: 38,
                    width: 160,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: () {
                        ProductModel productModel =
                            widget.singleProduct.copyWith(qty: qty);
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return CustomBottomSheet(
                                  singleProduct: productModel);
                            });
                      },
                      child: const Text("Mua"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.00,
              ),
              const Text(
                "Mô tả sản phẩm:",
                textAlign: TextAlign.left,
                softWrap: true,
                textScaleFactor: 1.2,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    wordSpacing: 1.5,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.00,
              ),
              Container(
                child: Text(
                  isExpanded
                      ? widget.singleProduct.description
                      : '${widget.singleProduct.description.substring(0, 1)}...',
                  textAlign: TextAlign.left,
                  softWrap: true,
                  textScaleFactor: 1.2,
                  style: const TextStyle(fontSize: 14, wordSpacing: 1.5),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  textAlign: TextAlign.right,
                  isExpanded ? 'Thu gọn' : 'Xem thêm',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Đánh giá sản phẩm:",
                    textAlign: TextAlign.left,
                    softWrap: true,
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        wordSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Routes.instance.push(
                        widget: ProductReviewsPage(
                            productName: widget.singleProduct.name),
                        context: context,
                      );
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: const Text(
                      "Xem đánh giá sản phẩm",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
