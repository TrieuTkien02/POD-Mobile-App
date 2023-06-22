// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../firebase_support/firebase_firestore.dart';
import '../firebase_support/firebase_storage_helper.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

class AppProvider with ChangeNotifier {
  final List<ProductModel> _cartProductList = [];
  List<ProductModel> get getCartProductList => _cartProductList;

  final List<ProductModel> _buyProductList = [];
  List<ProductModel> get getBuyProductList => _buyProductList;

  final List<ProductModel> _favouriteProductList = [];
  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  UserModel? _userModel;
  UserModel get getUserInformation => _userModel!;

  int findProductIndexById(
      ProductModel productId, List<ProductModel> productList) {
    for (int i = 0; i < productList.length; i++) {
      if (productList[i].name == productId.name) {
        return i;
      }
    }
    return -1;
  }

  //Cart
  void addCartProduct(ProductModel productModel) {
    int existingProductIndex =
        findProductIndexById(productModel, _cartProductList);
    if (existingProductIndex == -1) {
      _cartProductList.add(productModel);
      showMessage("Đã thêm vào giỏ hàng");
    } else {
      showMessage("Sản phẩm đã có trong giỏ hàng");
    }
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  //Favourite
  bool isFavourite(ProductModel product, List<ProductModel> listFavourite) {
    for (int i = 0; i < listFavourite.length; i++) {
      if (listFavourite[i].name == product.name) {
        return true;
      }
    }
    return false;
  }

  void addFavouriteProduct(ProductModel productModel) {
    int existingProductIndex =
        findProductIndexById(productModel, _favouriteProductList);
    if (existingProductIndex == -1) {
      _favouriteProductList.add(productModel);
      showMessage("Yêu thích");
      notifyListeners();
    }
  }

  void removeFavouriteProduct(ProductModel productModel) {
    if (isFavourite(productModel, _favouriteProductList) == true) {
      _favouriteProductList.remove(productModel);
      showMessage("Bỏ yêu thích");
      notifyListeners();
    }
  }

  //User Information
  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      showLoaderDialog(context);

      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.email)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);

      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.email)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    showMessage("Cập nhật thành công");

    notifyListeners();
  }

  //Total Price
  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    double totalPrice = 0.0;
    for (var element in _buyProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  double price1Product(ProductModel product) {
    double totalPrice = 0.0;
    totalPrice = product.price * product.qty!;
    return totalPrice;
  }

  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  //Buy Product
  void addBuyProduct(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }
}
