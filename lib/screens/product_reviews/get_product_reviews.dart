import 'package:flutter/material.dart';

import '../../firebase_support/firebase_firestore.dart';
import '../../models/ReviewModel.dart';

class ProductReviewsPage extends StatefulWidget {
  final String productName;

  ProductReviewsPage({required this.productName});

  @override
  _ProductReviewsPageState createState() => _ProductReviewsPageState();
}

class _ProductReviewsPageState extends State<ProductReviewsPage> {
  List<ReviewModel> reviews = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getReview();
  }

  void getReview() async {
    List<ReviewModel> fetchedReviews =
        await FirebaseFirestoreHelper.instance.getReviews(widget.productName);

    setState(() {
      reviews = fetchedReviews;
      isLoading = false;
    });
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              Text(
                widget.productName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : reviews.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Chưa có đánh giá nào',
                            style: TextStyle(
                                fontSize: 15, color: Colors.red, fontWeight: FontWeight.w500),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            ReviewModel review = reviews[index];
                            return ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    review.reviewerName,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 5),
                                  Row(
                                    children: List.generate(
                                      int.parse(review.rating),
                                      (index) => const Icon(Icons.star,
                                          color: Colors.yellow),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(review.comment),
                                ],
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
