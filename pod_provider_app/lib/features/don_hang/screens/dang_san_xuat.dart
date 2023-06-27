import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SanXuatScreen extends StatelessWidget {
  static const routeName = '/dang_san_xuat-screen';

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    String nameuser = '';

    // Lấy giá trị nameuser từ Firestore
    void getNameUser() async {
      DocumentSnapshot snapshot = await firestore
          .collection("Provider")
          .doc(_auth.currentUser!.uid)
          .get();
      nameuser = snapshot.get('name');
    }
    getNameUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn hàng đang sản xuất'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;
            List<Widget> orderWidgets = [];

            for (var document in documents) {
              final productionUnit = document['products']
                  .where((product) =>
                      product['productionunit'] == nameuser &&
                      document['status'] == 'Đang sản xuất')
                  .toList();

              if (productionUnit.isNotEmpty) {
                final addressUser = document['addressUser'] ?? '';
                final nameUser = document['nameUser'] ?? '';
                final orderId = document['orderId'] ?? '';
                final payment = document['payment'] ?? '';
                final phoneUser = document['phoneUser'] ?? '';
                final totalPrice = document['totalPrice'] ?? 0;

                final products = productionUnit.map<Widget>((product) {
                  final category = product['category'] ?? '';
                  final color = product['color'] ?? '';
                  final description = product['description'] ?? '';
                  final imageUrl = product['image_url'] ?? '';
                  final isFavourite = product['isFavourite'] ?? false;
                  final material = product['material'] ?? '';
                  final name = product['name'] ?? '';
                  final partner = product['partner'] ?? '';
                  final price = product['price'] ?? '';
                  final productionUnit = product['productionunit'] ?? '';
                  final qty = product['qty'] ?? 0;
                  final size = product['size'] ?? '';

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    title: Text('Tên sản phẩm: $name'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Danh mục: $category'),
                        Text('Màu sắc: $color'),
                        Text('Kích thước: $size'),
                        Text('Chất liệu: $material'),
                        Text('Parner: $partner'),
                        Text('Giá: $price'),
                        Text('Số lượng: $qty'),
                      ],
                    ),
                  trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Hoàn thành'),
                                content: Text('Bạn có chắc chắn đang vận chuyển đơn hàng này?'),
                                actions: [
                                  TextButton(
                                    child: Text('Hủy'),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Xác nhận'),
                                    onPressed: () {
                                      // Thay đổi trạng thái đơn hàng thành 'Đang sản xuất'
                                      FirebaseFirestore.instance
                                          .collection('orders')
                                          .doc(document.id)
                                          .update({'status': 'Đang giao hàng'});

                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text('Hoàn thành'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Hủy đơn hàng'),
                                content: Text('Bạn có chắc chắn muốn hủy đơn hàng này?'),
                                actions: [
                                  TextButton(
                                    child: Text('Hủy'),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Hủy đơn hàng'),
                                    onPressed: () {
                                      // Thay đổi trạng thái đơn hàng thành 'Đã hủy'
                                      FirebaseFirestore.instance
                                          .collection('orders')
                                          .doc(document.id)
                                          .update({'status': 'Đã hủy'});

                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text('Hủy'),
                        ),
                      ],
                    ),
                  );
                }).toList();

                final orderWidget = ExpansionTile(
                  title: Text('Địa chỉ: $addressUser'),
                  subtitle: Text('Tên người dùng: $nameUser'),
                  trailing: Text('Số điện thoại: $phoneUser'),
                  children: products,
                );

                orderWidgets.add(orderWidget);
              }
            }

            return ListView(
              children: orderWidgets,
            );
          } else if (snapshot.hasError) {
            return Text('Đã xảy ra lỗi: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}