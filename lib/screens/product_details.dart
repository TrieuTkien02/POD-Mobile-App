// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pod_market/provider/app_provider.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../constants/routes.dart';
import '../models/product_model.dart';
import 'cart_screen/cart_screen.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const CartScreen(), context: context);
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.red,
            ),
            iconSize: 35.0,
          ),
          IconButton(
            alignment: Alignment.center,
            onPressed: () {
              // TODO: Xử lý khi nhấn biểu tượng thông báo
            },
            icon: const Icon(
              Icons.notifications,
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
                ],
              ),
              const SizedBox(
                height: 30.00,
              ),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      if (qty >= 1) {
                        setState(() {
                          qty--;
                        });
                      }
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    qty.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(
                    width: 200,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavourite =
                            !widget.singleProduct.isFavourite;
                      });
                      if (widget.singleProduct.isFavourite) {
                        appProvider.addFavouriteProduct(widget.singleProduct);
                      } else {
                        appProvider
                            .removeFavouriteProduct(widget.singleProduct);
                      }
                    },
                    icon: Icon(appProvider.getFavouriteProductList
                            .contains(widget.singleProduct)
                        ? Icons.favorite
                        : Icons.favorite_border),
                    iconSize: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 30.00,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      appProvider.addCartProduct(productModel);
                      showMessage("Đã thêm vào giỏ hàng");
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
                        // Routes.instance.push(
                        //     widget: Checkout(singleProduct: productModel),
                        //     context: context);
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
                //padding: EdgeInsets.all(16),
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
                height: 10.0,
              ),
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
