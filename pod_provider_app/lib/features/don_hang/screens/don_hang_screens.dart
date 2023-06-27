import 'package:flutter/material.dart';
import 'package:pod_provider_app/features/don_hang/screens/cho_xac_nhan.dart';
import 'package:pod_provider_app/features/don_hang/screens/da_giao_hang.dart';
import 'package:pod_provider_app/features/don_hang/screens/da_huy.dart';
import 'package:pod_provider_app/features/don_hang/screens/dang_giao_hang.dart';
import 'package:pod_provider_app/features/don_hang/screens/dang_san_xuat.dart';
import 'package:pod_provider_app/features/home/screens/home.dart';

class OrderStatusScreen extends StatelessWidget {
  static const routeName = '/order-screen';
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trạng thái đơn hàng'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(
                Icons.timer,
                color: Colors.white,
              ),
            ),
            title: const Text('Chờ xác nhận'),
            subtitle: const Text('Thông tin chi tiết về trạng thái'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, OrderScreen.routeName);
            },
          ),

          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
            ),
            title: const Text('Chờ sản xuất'),
            subtitle: const Text('Thông tin chi tiết về trạng thái'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, SanXuatScreen.routeName);
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(
                Icons.delivery_dining,
                color: Colors.white,
              ),
            ),
            title: const Text('Đang giao hàng'),
            subtitle: const Text('Thông tin chi tiết về trạng thái'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, DangGiaoScreen.routeName);
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
            ),
            title: const Text('Đã giao hàng'),
            subtitle: const Text('Thông tin chi tiết về trạng thái'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, DaGiaoHangScreen.routeName);
            },
          ),
          
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
            ),
            title: const Text('Đã hủy'),
            subtitle: const Text('Thông tin chi tiết về trạng thái'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, DaHuyScreen.routeName);
            },
          ),
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Home.routeName);
          } else if (index == 1) {
          } else if (index == 2) {
            Navigator.pushReplacementNamed(
                context, OrderStatusScreen.routeName);
          } else if (index == 3) {}
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Trò chuyện'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Đơn hàng'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined), label: 'Tài khoản'),
        ],
      ),
    );
  }

  Widget buildOrderStatusTile(
      {required String status, required IconData icon, required Color color}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(status),
      subtitle: Text('Thông tin chi tiết về trạng thái'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {},
    );
  }
}
