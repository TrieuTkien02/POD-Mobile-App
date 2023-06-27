import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pod_provider_app/features/don_hang/screens/don_hang_screens.dart';
import 'package:pod_provider_app/features/home/screens/add_product.dart';

class Home extends StatefulWidget {
  static const routeName = '/home-screen';
  const Home({super.key});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  List<String> productList = [];
  bool _isDataLoaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
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
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        String category = document.id;
        firestore
            .collection('Danhmucsanpham/$category/Đơn vị sản xuất')
            .get()
            .then((QuerySnapshot unitSnapshot) {
          unitSnapshot.docs.forEach((DocumentSnapshot unitDocument) {
            if (unitDocument.exists && unitDocument.id == name) {
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
    });
  }

  void _deleteDocument(String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Bạn có muốn xóa sản phẩm?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Xóa'),
              onPressed: () async {
                DocumentSnapshot snapshot = await firestore
                    .collection("Provider")
                    .doc(_auth.currentUser!.uid)
                    .get();
                String name = snapshot.get('name');
                firestore
                    .collection('Danhmucsanpham/$category/Đơn vị sản xuất')
                    .doc(name)
                    .delete()
                    .then((_) {
                  print('Document deleted successfully');
                  getData();
                  Navigator.of(context).pop();
                }).catchError((error) {
                  print('Failed to delete document: $error');
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sản phẩm đang bán'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: getData,
          ),
          IconButton(
            icon: Icon(Icons.density_medium),
            onPressed: () {
              // Hiện thị thêm chức năng trong tương lai
            },
          ),
        ],
      ),
      body: _isDataLoaded
          ? ListView.builder(
              itemCount: productList.length,
              itemBuilder: (BuildContext context, int index) {
                String category = productList[index];
                return ListTile(
                  tileColor: Colors.grey[300],
                  title: Text(productList[index]),
                  onLongPress: () {
                    _deleteDocument(category);
                    getData();
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductListScreen()),
          );
        },
        child:const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  currentIndex: 0,
  onTap: (index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, Home.routeName); 
    } else if (index == 1) {
      
    } else if (index == 2) {
     Navigator.pushReplacementNamed(context, OrderStatusScreen.routeName);
    } else if (index == 3) {
     
    }
  },
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Trò chuyện'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Đơn hàng'),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_outline_outlined), label: 'Tài khoản'),
  ],
),
    );
  }
}
