import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/cho_xac_nhan-screen';

  const OrderScreen({super.key});

  @override
  _OderScreenState createState() => _OderScreenState();
}

class _OderScreenState extends State<OrderScreen> {

 final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String nameuser = '';

  @override
  void initState() {
    super.initState();
    _reloadData();
  }

  Future<void> _reloadData() async {
    await getNameUser();
    setState(() {});
  }

  Future<void> getNameUser() async {
    DocumentSnapshot snapshot = await firestore
        .collection("Provider")
        .doc(_auth.currentUser!.uid)
        .get();
    nameuser = snapshot.get('name');
  }
    

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xác nhận đơn hàng'),
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
                      document['status'] == 'Đã xác nhận')
                  .toList();

              if (productionUnit.isNotEmpty) {
                final addressUser = document['addressUser'] ?? '';
                final nameUser = document['nameUser'] ?? '';
                final orderId = document['orderId'] ?? '';
                final phoneUser = document['phoneUser'] ?? '';

                final products = productionUnit.map<Widget>((product) {
                  final category = product['category'] ?? '';
                  final color = product['color'] ?? '';
                  final imageUrl = product['image_url'] ?? '';
                  final material = product['material'] ?? '';
                  final name = product['name'] ?? '';
                  final partner = product['partner'] ?? '';
                  final price = product['price'] ?? '';
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
                        Text('Order ID: $orderId'),
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
                                title:const Text('Xác nhận'),
                                content:const Text(
                                    'Bạn có chắc chắn muốn xác nhận đơn hàng này?'),
                                actions: [
                                  TextButton(
                                    child:const Text('Hủy'),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                  TextButton(
                                    child:const Text('Xác nhận'),
                                    onPressed: () {
                                      // Thay đổi trạng thái đơn hàng thành 'Đang sản xuất'
                                      FirebaseFirestore.instance
                                          .collection('orders')
                                          .doc(document.id)
                                          .update({'status': 'Đang sản xuất'});

                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child:const Text('Xác nhận'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title:const Text('Hủy đơn hàng'),
                                content:const Text(
                                    'Bạn có chắc chắn muốn hủy đơn hàng này?'),
                                actions: [
                                  TextButton(
                                    child:const Text('Hủy'),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                  TextButton(
                                    child:const Text('Hủy đơn hàng'),
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
                          child:const Text('Hủy'),
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
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
