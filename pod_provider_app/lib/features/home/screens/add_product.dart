import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class ProductListScreen extends StatefulWidget {
  static const routeName = '/add_product-screen';

  const ProductListScreen({super.key});
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<String> productList = [];
  bool _isDataLoaded = false;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    // getData();
    _loadData();
  }


  void _loadData()async {
    productList.clear();
    DocumentSnapshot snapshot = await firestore
        .collection("Provider")
        .doc(_auth.currentUser!.uid)
        .get();
    String name = snapshot.get('name');
    firestore
        .collection('Danhmucsanpham')
        .get()
        .then((QuerySnapshot querySnapshot) {
      productList.clear(); // Xóa danh sách hiện tại trước khi cập nhật mới
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        String category = document.id;
        firestore
            .collection('Danhmucsanpham/$category/Đơn vị sản xuất')
            .doc(name)
            .get()
            .then((DocumentSnapshot unitDocument) {
          if (!unitDocument.exists) {
            setState(() {
              productList.add(category);
            });
          }
        });
      });
      setState(() {
        _isDataLoaded = true;
      });
    });
  }

  void addDocumentToUnitCollection(String category) async {
    DocumentSnapshot snapshot = await firestore
        .collection("Provider")
        .doc(_auth.currentUser!.uid)
        .get();
    String name = snapshot.get('name');
    String uid = snapshot.get('uid');
    firestore
        .collection('Danhmucsanpham/$category/Đơn vị sản xuất')
        .doc(name)
        .set({'uid': uid}).then((value) {
      print('Thêm sản phẩm thành công');
      _loadData();
    }).catchError((error) {
      print('Có lỗi: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm sản phẩm công ty sản xuất'),
      ),
      body: _isDataLoaded
          ? ListView.builder(
              itemCount: productList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(productList[index]),
                  onTap: () {
                    addDocumentToUnitCollection(productList[index]);
                  },

                );
              },
            )
          :const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
