import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Donhang(),
  ));
}

class Donhang extends StatefulWidget {
  @override
  _DonhangState createState() => _DonhangState();
}

class _DonhangState extends State<Donhang> {
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
                child: Text(
                  'Đơn chờ xử lý',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Đơn đang in',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Đang vận chuyển',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Đơn đã hoàn thành',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
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
                    order.data()['status'] == 'Đang chờ' &&
                    order.data()['products'][0]?['partner'] == 'username')
                    .toList();

                if (_pendingOrders.isEmpty) {
                  return Center(child: Text('Không có đơn hàng đang chờ.'));
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
                                  Expanded(
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            _updateOrderStatus(order.id, 'Đã xác nhận');
                                          },
                                          child: Text('Xác Nhận'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      _updateOrderStatus(order.id, 'Đã Hủy');
                                    },
                                    child: Text('Hủy'),
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
        ],
      ),
    );
  }
}
