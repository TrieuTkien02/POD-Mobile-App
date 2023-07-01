import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pod_provider_app/features/account/screens/change_password.dart';
import 'package:pod_provider_app/features/account/screens/edit_profile.dart';
import 'package:pod_provider_app/features/account/screens/thongtin.dart';
import 'package:pod_provider_app/features/auth/repository/auth_repository.dart';
import 'package:pod_provider_app/features/auth/screens/sign_in.dart';
import 'package:pod_provider_app/features/don_hang/screens/don_hang_screens.dart';
import 'package:pod_provider_app/features/home/screens/home.dart';
import 'package:pod_provider_app/utils/utils.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account-screen';

  AccountScreen({super.key});
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  var userData = {};
   bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var snapshot = await firestore
          .collection('Provider')
          .doc(_auth.currentUser!.uid)
          .get();
      userData = snapshot.data()!;
      
      setState(() {});
    } catch (e) {
      showSnarBar(e.toString(), context);
    }
     setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
      appBar: AppBar(
        title:const Text('Tài khoản'),
      ),
      body: Container(
        padding:const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userData['photoUrl'],),
                  radius: 50.0,
                ),
               const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData['name'],
                      style:const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userData['uid'],
                      style:const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              title: const Text('Thay đổi thông tin'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                 Navigator.pushNamed(context, EditProfile.routeName);
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                ),
              ),
              title: const Text('Cài đặt ứng dụng'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                
              },
            ),
              ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(
                  Icons.change_circle_outlined,
                  color: Colors.white,
                ),
              ),
              title: const Text('Đổi mật khẩu'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                 Navigator.pushNamed(context, ChangePassword.routeName);
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
              ),
              title: const Text('Thông tin về chúng tôi'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                 Navigator.pushNamed(context, AboutUs.routeName);
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.amber,
                child: Icon(
                  Icons.help_outline,
                  color: Colors.white,
                ),
              ),
              title: const Text('Trung tâm trợ giúp'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Navigator.pushNamed(context, SanXuatScreen.routeName);
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
              title: const Text('Đăng xuất'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                AuthRepository().signOut();
                Navigator.pushNamed(context, Signin.routeName);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Home.routeName);
          } else if (index == 1) {
          } else if (index == 2) {
            Navigator.pushReplacementNamed(
                context, OrderStatusScreen.routeName);
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, AccountScreen.routeName);
          }
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
}
