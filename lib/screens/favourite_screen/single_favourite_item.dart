import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../constants/routes.dart';
import '../../models/product_model.dart';
import '../../provider/app_provider.dart';
import '../product_details/product_details.dart';

class SingleFavouriteItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleFavouriteItem({super.key, required this.singleProduct});
  @override
  State<SingleFavouriteItem> createState() => _SingleFavouriteItemState();
}

class _SingleFavouriteItemState extends State<SingleFavouriteItem> {
  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat("#,###");
    final formattedPrice = priceFormat
        .format(widget.singleProduct.price.toInt())
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
                padding: const EdgeInsets.all(12.0),
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
                                widget.singleProduct.name,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "$formattedPrice VNĐ",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    AppProvider appProvider =
                                        Provider.of<AppProvider>(context,
                                            listen: false);
                                    appProvider.removeFavouriteProduct(
                                        widget.singleProduct);
                                    showMessage("Bỏ yêu thích");
                                  },
                                  child: const Text(
                                    "Bỏ yêu thích",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 35,
                                  width: 80,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Routes.instance.push(
                                          widget: ProductDetails(
                                              singleProduct:
                                                  widget.singleProduct),
                                          context: context);
                                    },
                                    child: const Text(
                                      'Mua',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
    );
  }
}
