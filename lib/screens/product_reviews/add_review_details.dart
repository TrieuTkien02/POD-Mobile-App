// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pod_market/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../firebase_support/firebase_firestore.dart';
import '../../models/review_model.dart';
import '../../provider/app_provider.dart';
import '../../widgets/primary_button.dart';

class AddReviewDetails extends StatefulWidget {
  final String productName;
  final String partnerName;

  AddReviewDetails({required this.productName, required this.partnerName});

  @override
  _AddReviewPageState createState() =>
      _AddReviewPageState(productName: productName, partnerName: partnerName);
}

class _AddReviewPageState extends State<AddReviewDetails> {
  final TextEditingController _reviewerNameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  int _rating = 1;
  final String productName;
  final String partnerName;

  _AddReviewPageState({required this.productName, required this.partnerName});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Thêm đánh giá",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Đánh giá của bạn',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Nhập đánh giá...',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Rating (Từ 1 đến 5 sao)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (_rating > 1) {
                      setState(() {
                        _rating--;
                      });
                    }
                  },
                  icon: Icon(Icons.remove),
                ),
                Text(
                  '$_rating',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_rating < 5) {
                      setState(() {
                        _rating++;
                      });
                    }
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 16),
            PrimaryButton(
              title: "Thêm đánh giá",
              onPressed: () async {
                if (!_commentController.text.isEmpty) {
                  String comment = _commentController.text;
                  String name = appProvider.getUserInformation.name;
                  ReviewModel review = ReviewModel(
                    reviewerName: name,
                    comment: comment,
                    rating: _rating.toString(),
                    partner: partnerName,
                  );
                  await FirebaseFirestoreHelper.instance
                      .addReview(productName, review);
                  Navigator.pop(context);
                  showMessage("Thêm đánh giá thành công");
                } else {
                  showMessage("Vui lòng nhập đánh giá");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
