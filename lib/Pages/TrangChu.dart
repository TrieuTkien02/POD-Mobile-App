import 'package:flutter/material.dart';
import 'package:partnerapp/Pages/TrangCaNhan.dart';
import 'package:partnerapp/Values/app_assets.dart';
import '../../constants/routes.dart';
import 'package:partnerapp/Pages/ThemSanPham.dart';
import 'package:partnerapp/models/PullProduct.dart';
import 'package:partnerapp/Pages/Sanpham.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

void _showProductDialog(BuildContext context, Product product) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              product.imageUrl,
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Description: ${product.description}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Price: \$${product.price.toStringAsFixed(2)} VNĐ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Category: ${product.category}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Material: ${product.material}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Size: ${product.size}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Production Unit: ${product.productionunit}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Color: ${product.color}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  // Hiển thị các trường khác của product tương tự
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}


class _MyHomePageState extends State<MyHomePage> {

  String avatarUrl = '';
  String coverImageUrl = '';
  String shopName = '';

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }
  
  Future<void> fetchUserProfile() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Partner')
        .doc('username') // Thay 'username' bằng giá trị tương ứng
        .get();

    if (snapshot.exists) {
      setState(() {
        avatarUrl = snapshot.data()?['avatarUrl'] ?? '';
        coverImageUrl = snapshot.data()?['coverImageUrl'] ?? '';
        shopName = snapshot.data()?['shopName'] ?? '';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trang Chủ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(coverImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 25.0, top: 16.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Container(
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Tìm kiếm',
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 45.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                AssetImage(avatarUrl),
                                radius: 50.0,
                              ),
                              SizedBox(height: 8.0),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      shopName,
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '4.6',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(width: 20.0),
                                      Text(
                                        '100 người theo dõi',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    // Thực hiện logic reload trang ở đây
                    // Ví dụ: bạn có thể sử dụng Navigator để chuyển đến trang hiện tại để reload
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Cửa hàng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    // Thực hiện logic reload trang ở đây
                    // Ví dụ: bạn có thể sử dụng Navigator để chuyển đến trang hiện tại để reload
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Sanpham()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Sản phẩm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Routes.instance.push(widget: ThemSanPham(), context: context );
                    },
                    child: Text(
                      'Thêm Sản Phẩm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        Expanded(
          child: FutureBuilder<List<Product>>(
            future: fetchAllProducts('username'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        _showProductDialog(context, product);
                      },
                      child: Card(
                        elevation: 4.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              product.imageUrl,
                              width: double.infinity,
                              height: 135.0,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)} VNĐ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("Error fetching products: ${snapshot.error}");
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),




        Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.home),
                        color: Colors.blue,
                        onPressed: () {},
                      ),
                      Text(
                        'Trang chủ',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
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
                        color: Colors.black,
                        onPressed: () {},
                      ),
                      Text(
                        'Đơn hàng',
                        style: TextStyle(
                          color: Colors.black,
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
      ),
    );
  }
}
