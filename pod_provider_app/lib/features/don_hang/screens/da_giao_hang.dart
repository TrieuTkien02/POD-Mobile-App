import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DaGiaoHangScreen extends StatefulWidget {
  static const routeName = '/da_giao_hang-screen';

  const DaGiaoHangScreen({super.key});
 @override
  _DaGiaoHangScreenState createState() => _DaGiaoHangScreenState();
}

class _DaGiaoHangScreenState extends State<DaGiaoHangScreen> {
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
        title:const Text('Đã giao hàng'),
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
                      document['status'] == 'Giao thành công')
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