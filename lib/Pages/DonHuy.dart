import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '../Values/app_assets.dart';
import '../constants/routes.dart';
import '../provider/user_provider.dart';
import 'DangIn.dart';
import 'DangVanChuyen.dart';
import 'DonHang.dart';
import 'DonHoanThanh.dart';
import 'TrangCaNhan.dart';
import 'TrangChu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: DonHuy(),
  ));
}

class DonHuy extends StatefulWidget {
  @override
  _DonHuyState createState() => _DonHuyState();
}

class _DonHuyState extends State<DonHuy> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _ordersStream;
  List<DocumentSnapshot> _pendingOrders = [];

  @override
  void initState() {
    super.initState();
    // Initialize the stream with the filtered orders
    _ordersStream = FirebaseFirestore.instance.collection('orders').snapshots();
  }

  Future<void> _updateOrderStatus(String orderId, String status) async {
    try {
      final orderRef = FirebaseFirestore.instance.collection('orders').doc(orderId);
      await orderRef.update({'status': status});
      print('Cập nhật trạng thái đơn hàng thành công');
    } catch (error) {
      print('Lỗi khi cập nhật trạng thái đơn hàng: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String username = Provider.of<UserProvider>(context).username;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Column Example'),
      ),
      body: Column(
        children: [
          Container(
            child: Image.asset(
              'assets/images/POD-removebg-preview.png',
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 2),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Donhang()),
                    );
                  },
                  child: Text(
                    'Đơn chờ xử lý',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DonDangIn()),
                    );
                  },
                  child: Text(
                    'Đơn đang in',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DangVanChuyen()),
                    );
                  },
                  child: Text(
                    'Đang vận chuyển',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DonHoanThanh()),
                    );
                  },
                  child: Text(
                    'Đơn đã hoàn thành',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  'Đơn đã hủy',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // ...Other Expanded widgets for different order statuses
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _ordersStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final orders = snapshot.data!.docs;
                _pendingOrders = orders
                    .where((order) =>
                order.data().containsKey('status') &&
                    order.data()['status'] == 'Đã Hủy' &&
                    order.data()['products'][0]?['partner'] == username)
                    .toList();

                if (_pendingOrders.isEmpty) {
                  return Center(child: Text('Không có đơn hàng đã hủy.'));
                }

                return GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 2,
                  children: _pendingOrders.map((order) {
                    final orderData = order.data()! as Map<String, dynamic>;
                    final productsData = orderData['products'][0];

                    final productName = productsData?['name'] ?? '';
                    final productQty = productsData?['qty'] != null ? int.tryParse(productsData['qty'].toString()) ?? 0 : 0;
                    final productSize = productsData?['size'] ?? '';
                    final productColor = productsData?['color'] ?? '';

                    final totalPrice = orderData['totalPrice'];
                    final nameUser = orderData['nameUser'] != null ? orderData['nameUser'] as String : '';
                    final addressUser = orderData['addressUser'] != null ? orderData['addressUser'] as String : '';
                    final phoneUser = orderData['phoneUser'] != null ? orderData['phoneUser'] as String : '';

                    return Container(
                      height: 100,
                      width: double.infinity,
                      child: Card(
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Tên sản phẩm: $productName \n Số lượng: ${productQty.toString()} - Size: $productSize - Màu: $productColor\nTổng giá: ${totalPrice.toString()}',
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Đặt bởi: $nameUser\nĐịa chỉ: $addressUser\nĐiện thoại: $phoneUser',
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),

          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.home),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        },
                        child: Text(
                          'Trang chủ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),





                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chat),
                      color: Colors.black,
                      onPressed: () {},
                    ),
                    Text(
                      'Trò chuyện',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [

                    IconButton(
                      icon: Icon(Icons.shopping_bag),
                      color: Colors.blue,
                      onPressed: (

                          ) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Donhang()),
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Donhang()),
                        );
                      },
                      child:
                      Text(
                        'Đơn hàng',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    SizedBox(
                      height: 13.0,
                    ),
                    InkWell(
                      onTap: () {
                        // Xử lý sự kiện khi nhấp vào ảnh
                        Routes.instance.push(widget: Trangcanhan(), context: context ); // Gọi hàm để chuyển đến trang cá nhân
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage(AppAssets.anhdaidien),
                        radius: 13.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        // Xử lý sự kiện khi nhấp vào chữ
                        Routes.instance.push(widget: Trangcanhan(), context: context ); // Gọi hàm để chuyển đến trang cá nhân
                      },
                      child: Text(
                        'Trang cá nhân',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
