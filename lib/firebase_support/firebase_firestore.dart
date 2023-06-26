// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pod_market/models/review_model.dart';
import 'package:pod_market/models/sale_model.dart';
import '../constants/constants.dart';
import '../models/category_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<SaleModel>> getSale() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("sale").get();

      List<SaleModel> saleList =
          querySnapshot.docs.map((e) => SaleModel.fromJson(e.data())).toList();

      return saleList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<ProductModel> productModelList = [];

      for (var categoryDoc in querySnapshot.docs) {
        QuerySnapshot<Map<String, dynamic>> productsSnapshot =
            await categoryDoc.reference.collection("products").get();

        productModelList.addAll(productsSnapshot.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList());
      }

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryViewProduct(String name) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(name)
              .collection("products")
              .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .get();

    return UserModel.fromJson(querySnapshot.data()!);
  }

  Future<bool> uploadOrderedProductFirebase(
      List<ProductModel> list,
      BuildContext context,
      String name,
      String phone,
      String address,
      String payment) async {
    try {
      showLoaderDialog(context);
      double totalPrice = 0.0;
      for (var element in list) {
        totalPrice += element.price * element.qty!;
      }
      DocumentReference documentReference = _firebaseFirestore
          .collection("usersOrders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .doc();
      DocumentReference admin = _firebaseFirestore.collection("orders").doc();

      admin.set({
        "products": list.map((e) => e.toJson()),
        "status": "Đang chờ",
        "totalPrice": totalPrice,
        "payment": payment,
        "orderId": documentReference.id,
        "nameUser": name,
        "phoneUser": phone,
        "addressUser": address,
      });
      documentReference.set({
        "products": list.map((e) => e.toJson()),
        "status": "Đang chờ",
        "totalPrice": totalPrice,
        "payment": payment,
        "orderId": documentReference.id,
        "nameUser": name,
        "phoneUser": phone,
        "addressUser": address,
      });
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Đặt hàng thành công");
      return true;
    } catch (e) {
      showMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }

  Stream<List<OrderModel>> getUserOrderStream() {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> queryStream =
          _firebaseFirestore
              .collection("usersOrders")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("orders")
              .snapshots();

      return queryStream.map((querySnapshot) {
        List<String> orderIdList = querySnapshot.docs
            .map((doc) => doc.data()["orderId"] as String)
            .toList();

        return _firebaseFirestore
            .collection("orders")
            .where("orderId", whereIn: orderIdList)
            .get()
            .then((orderSnapshot) {
          List<OrderModel> orderList = orderSnapshot.docs
              .map((element) => OrderModel.fromJson(element.data()))
              .toList();

          return orderList;
        });
      }).asyncMap((future) => future);
    } catch (e) {
      //showMessage(e.toString());
      return Stream.value([]); // Trả về một Stream rỗng trong trường hợp lỗi
    }
  }

  //Add Reviews
  Future<void> addReview(String productName, ReviewModel review) async {
    CollectionReference<Map<String, dynamic>> reviewsCollection =
        _firebaseFirestore.collection("reviews");

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await reviewsCollection
        .where("productName", isEqualTo: productName)
        .get();

    if (querySnapshot.docs.isEmpty) {
      await reviewsCollection.add({"productName": productName});
    }

    DocumentReference<Map<String, dynamic>> productDocument =
        reviewsCollection.doc(productName);

    await productDocument.collection("reviews").add(review.toJson());
  }

  //Get Reviews
  Future<List<ReviewModel>> getReviews(String productName) async {
    CollectionReference<Map<String, dynamic>> reviewsCollection =
        _firebaseFirestore.collection("reviews");

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await reviewsCollection.doc(productName).collection("reviews").get();

    List<ReviewModel> reviewsList = [];

    for (DocumentSnapshot<Map<String, dynamic>> reviewDoc
        in querySnapshot.docs) {
      ReviewModel review = ReviewModel.fromJson(reviewDoc.data()!);
      reviewsList.add(review);
    }

    return reviewsList;
  }

  // void updateTokenFromFirebase() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   if (token != null) {
  //     await _firebaseFirestore
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .update({
  //       "notificationToken": token,
  //     });
  //   }
  // }
}
