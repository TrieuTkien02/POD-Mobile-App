import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pod_market/constants/constants.dart';
import 'package:provider/provider.dart';
import '../constants/routes.dart';
import '../firebase_support/firebase_firestore.dart';
import '../models/product_model.dart';
import '../provider/app_provider.dart';
import '../stripe_helper/stripe_helper.dart';
import '../widgets/primary_button.dart';
import 'custom_bottom_bar.dart';

class Checkout extends StatefulWidget {
  final ProductModel singleProduct;
  const Checkout({Key? key, required this.singleProduct}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int groupValue = 1;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    final priceFormat = NumberFormat("#,###");
    final formattedPrice = priceFormat
        .format(appProvider.price1Product(widget.singleProduct).toInt())
        .replaceAll(',', '.');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Thanh toán",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "1) Thông tin đơn hàng",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 140,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        child: Image.network(
                          widget.singleProduct.imageUrl,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 140,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          widget.singleProduct.name.length > 15
                                              ? '${widget.singleProduct.description.substring(0, 15)}...'
                                              : widget.singleProduct.name,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "  Size: ${widget.singleProduct.size}",
                                            style: const TextStyle(
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 50.0,
                                          ),
                                          const Text(
                                            "  Màu:",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.all(16 / 4),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Color(int.parse(
                                                  widget.singleProduct.color,
                                                  radix: 16)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "  Số lượng: ${widget.singleProduct.qty}",
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        "  $formattedPrice VNĐ",
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                "2) Điền thông tin nhận hàng",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Họ tên người nhận',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại người nhận',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ nhận hàng',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              const Text(
                "3) Phương thức thanh toán",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3.0,
                  ),
                ),
                width: double.infinity,
                child: Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      },
                    ),
                    const Icon(Icons.money),
                    const SizedBox(
                      width: 12.0,
                    ),
                    const Text(
                      "Thanh toán khi giao hàng",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3.0,
                  ),
                ),
                width: double.infinity,
                child: Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      },
                    ),
                    const Icon(Icons.money),
                    const SizedBox(
                      width: 12.0,
                    ),
                    const Text(
                      "Thanh toán Online",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              PrimaryButton(
                title: "Đặt hàng",
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      addressController.text.isEmpty) {
                    showMessage("Vui lòng điền đầy đủ thông tin nhận hàng");
                  } else {
                    appProvider.clearBuyProduct();
                    appProvider.addBuyProduct(widget.singleProduct);

                    if (groupValue == 1) {
                      bool value = await FirebaseFirestoreHelper.instance
                          .uploadOrderedProductFirebase(
                        appProvider.getBuyProductList,
                        context,
                        nameController.text,
                        phoneController.text,
                        addressController.text,
                        "Thanh toán khi giao hàng",
                      );

                      appProvider.clearBuyProduct();
                      if (value) {
                        Future.delayed(const Duration(seconds: 2), () {
                          Routes.instance.push(
                            widget: const CustomBottomBar(),
                            context: context,
                          );
                        });
                      }
                    } else {
                      int value = double.parse(
                        appProvider.totalPriceBuyProductList().toString(),
                      ).round().toInt();
                      String totalPrice = (value * 100).toString();
                      await StripeHelper.instance.makePayment(
                        totalPrice.toString(),
                        nameController.text,
                        phoneController.text,
                        addressController.text,
                        context,
                      );
                    }
                  }
                },
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
