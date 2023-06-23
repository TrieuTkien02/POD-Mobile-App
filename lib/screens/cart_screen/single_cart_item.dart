import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pod_market/provider/app_provider.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../models/product_model.dart';
import 'package:intl/intl.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});
  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;
  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    setState(() {});
    super.initState();
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(color: Theme.of(context).primaryColor, width: 3),
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
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "   Size: ${widget.singleProduct.size}",
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
                                  padding: const EdgeInsets.all(16 / 4),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    if (qty > 1) {
                                      setState(() {
                                        qty--;
                                      });
                                      appProvider.updateQty(
                                          widget.singleProduct, qty);
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  qty.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CupertinoButton(
                                  onPressed: () {
                                    setState(() {
                                      qty++;
                                    });
                                    appProvider.updateQty(
                                        widget.singleProduct, qty);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "$formattedPrice VNĐ",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              appProvider
                                  .removeCartProduct(widget.singleProduct);
                              showMessage("Xóa khỏi giỏ hàng");
                            },
                            child: const CircleAvatar(
                              maxRadius: 13,
                              child: Icon(
                                Icons.delete,
                                size: 17,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
