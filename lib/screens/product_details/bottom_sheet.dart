// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pod_market/constants/constants.dart';
import 'package:pod_market/screens/check_out.dart';
import 'package:provider/provider.dart';
import '../../constants/routes.dart';
import '../../models/product_model.dart';
import '../../provider/app_provider.dart';
import 'color_dot.dart';

class CustomBottomSheet extends StatefulWidget {
  final ProductModel singleProduct;

  const CustomBottomSheet({super.key, required this.singleProduct});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int qty = 1;
  List sizes = ['S', 'M', 'L', 'XL'];
  String selectedSize = '';
  bool validateSize = false;
  bool validateColor = false;

  void handleSizeSelected(String size) {
    setState(() {
      selectedSize = size;
      widget.singleProduct.size = size;
    });
  }

  Color selectedColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 233, 221, 221),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Size",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 30,
              ),
              for (int i = 0; i < sizes.length; i++)
                GestureDetector(
                  onTap: () {
                    handleSizeSelected(sizes[i]);
                    validateSize = true;
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: sizes[i] == selectedSize
                          ? Colors.red.withOpacity(0.5)
                          : Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      sizes[i],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Màu sắc:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 30,
              ),
              ColorDot(
                color: Colors.red,
                isSelected: selectedColor == Colors.red,
                onColorSelected: (color) {
                  setState(() {
                    selectedColor = color;
                    widget.singleProduct.color = color.value.toRadixString(16);
                    validateColor = true;
                  });
                },
              ),
              ColorDot(
                color: Colors.black,
                isSelected: selectedColor == Colors.black,
                onColorSelected: (color) {
                  setState(() {
                    selectedColor = color;
                    widget.singleProduct.color = color.value.toRadixString(16);
                    validateColor = true;
                  });
                },
              ),
              ColorDot(
                color: Colors.blue,
                isSelected: selectedColor == Colors.blue,
                onColorSelected: (color) {
                  setState(() {
                    selectedColor = color;
                    widget.singleProduct.color = color.value.toRadixString(16);
                    validateColor = true;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Số lượng:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 30,
              ),
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
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  if (validateColor == true && validateSize == true) {
                    Navigator.pop(context);
                    ProductModel productModel =
                        widget.singleProduct.copyWith(qty: qty);
                    appProvider.addCartProduct(productModel);
                  } else {
                    showMessage("Vui lòng chọn Size và Màu sắc");
                  }
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
                    if (validateColor == true && validateSize == true) {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      Routes.instance.push(
                          widget: Checkout(singleProduct: productModel),
                          context: context);
                    } else {
                      showMessage("Vui lòng chọn Size và Màu sắc");
                    }
                  },
                  child: const Text("Mua"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
