import 'package:flutter/material.dart';
import 'package:partnerapp/Values/app_assets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:partnerapp/models/addproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(ThemSanPham());
}

class ThemSanPham extends StatefulWidget {
  @override
  _ThemSanPhamState createState() => _ThemSanPhamState();
}

class _ThemSanPhamState extends State<ThemSanPham> {
  late File? _selectedImage;
  String selectedProduct = 'Chọn loại sản phẩm';
  String selectedMaterial = 'Chọn chất liệu';
  @override
  void initState() {
    super.initState();
    _selectedImage = null; // Khởi tạo _selectedImage với giá trị null
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example',
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
                      image: AssetImage(AppAssets.anhbia),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child:
                  Column(

                    children : [
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
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
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
                              backgroundImage: AssetImage(AppAssets.anhdaidien),
                              radius: 50.0,
                            ),
                            SizedBox(height: 8.0),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child:Text(
                                    'BOYZ - Thời Trang Nam',
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
                                    Icon(Icons.star, color: Colors.yellow,),
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),

                child: Text(
                  'Cửa hàng',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Sản Phẩm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Thêm Sản Phẩm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(

                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text('1.Tệp thiết kế sản phẩm : ',
                          style: TextStyle(color: Colors.black, fontSize: 16),), // Widget Text
                        SizedBox(width: 10), // Khoảng cách giữa Text và Button
                        ElevatedButton(
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedImage =
                            await picker.getImage(source: ImageSource.gallery);
                            if (pickedImage != null) {
                              setState(() {
                                _selectedImage = File(pickedImage.path);
                              });
                            }
                          },
                          child: _selectedImage != null
                              ? Image.file(
                            _selectedImage!,
                            height: 100,
                            width: 100,
                          )
                              : Text(
                            '+ Thêm ',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ), // Hàng 1
                ),


                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          '2. Loại sản phẩm: ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return FutureBuilder<QuerySnapshot>(
                                  future: FirebaseFirestore.instance.collection('Danhmucsanpham').get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      List<Widget> children = [];
                                      snapshot.data!.docs.forEach((doc) {
                                        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                                        String documentId = doc.id;

                                        children.add(
                                          ElevatedButton(
                                            onPressed: () {
                                              // Xử lý khi người dùng chọn một loại sản phẩm
                                              setState(() {
                                                selectedProduct = documentId; // Update selectedProduct
                                              });
                                              Navigator.pop(context, documentId);
                                            },
                                            child: Text(
                                              documentId,
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                            ),
                                          ),
                                        );
                                      });

                                      return AlertDialog(
                                        title: Text('Chọn loại sản phẩm'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: children,
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            ).then((selectedProduct) {
                              // Xử lý khi người dùng đã chọn một loại sản phẩm
                              if (selectedProduct != null) {
                                // Thực hiện hành động khác với loại sản phẩm đã chọn
                              }
                            });
                          },
                          child: Text(
                            selectedProduct,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),




                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          '3. Chất liệu: ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return FutureBuilder<QuerySnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('Danhmucsanpham')
                                      .doc(selectedProduct)
                                      .collection('Chất liệu')
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      List<Widget> children = [];
                                      List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
                                      docs.forEach((doc) {
                                        String materialName = doc.id;

                                        children.add(
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedMaterial = materialName; // Update selectedProduct
                                              });
                                              // Xử lý khi người dùng chọn một chất liệu
                                              Navigator.pop(context, materialName);
                                            },
                                            child: Text(
                                              materialName,
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<Color>(Colors.white),
                                            ),
                                          ),
                                        );
                                      });

                                      return AlertDialog(
                                        title: Text('Chọn chất liệu'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: children,
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Đóng'),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          },
                          child: Text(
                            selectedMaterial,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),



                // ... Tiếp tục thêm các hàng còn lại tương tự
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text('4. Kích cỡ : ',
                          style: TextStyle(color: Colors.black, fontSize: 16),), // Widget Text
                        SizedBox(width: 10), // Khoảng cách giữa Text và Button
                        ElevatedButton(

                          onPressed: () {
                            // Xử lý sự kiện khi nhấn nút
                          },
                          child: Text('+ Thêm ',
                            style: TextStyle(color: Colors.black, fontSize: 16),),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // Màu nền trắng
                            onPrimary: Colors.black, // Màu chữ đen
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Viền đen bo tròn
                            ),
                          ),// Widget Button
                        ),

                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text('5. Màu sắc : ',
                          style: TextStyle(color: Colors.black, fontSize: 16),), // Widget Text
                        SizedBox(width: 10), // Khoảng cách giữa Text và Button
                        ElevatedButton(

                          onPressed: () {
                            // Xử lý sự kiện khi nhấn nút
                          },
                          child: Text('+ Thêm ',
                            style: TextStyle(color: Colors.black, fontSize: 16),),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // Màu nền trắng
                            onPrimary: Colors.black, // Màu chữ đen
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Viền đen bo tròn
                            ),
                          ),// Widget Button
                        ),

                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          '6. Mô tả sản phẩm: ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ), // Widget Text
                        SizedBox(width: 10), // Khoảng cách giữa Text và TextField
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Nhập mô tả',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          '7. Giá sản phẩm ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ), // Widget Text
                        SizedBox(width: 10), // Khoảng cách giữa Text và TextField
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Nhập giá ...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text('8. Chọn đơn vị sản suất : ',
                          style: TextStyle(color: Colors.black, fontSize: 16),), // Widget Text
                        SizedBox(width: 10), // Khoảng cách giữa Text và Button
                        ElevatedButton(

                          onPressed: () {
                            // Xử lý sự kiện khi nhấn nút
                          },
                          child: Text('Chọn đơn vị sản xuất',
                            style: TextStyle(color: Colors.black, fontSize: 16),),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // Màu nền trắng
                            onPrimary: Colors.black, // Màu chữ đen
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Viền đen bo tròn
                            ),
                          ),// Widget Button
                        ),

                      ],
                    ),
                  ), // Hàng 3
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        // Tạo một đối tượng Product từ dữ liệu nhập vào
                        Product newProduct = Product(
                          name: 'Tên sản phẩm',
                          description: 'Mô tả sản phẩm',
                          price: 10.0, // Giá sản phẩm
                          category: 'Quần Tây',
                          image: _selectedImage!,
                          material: 'Chất liệu',
                          size: 'Size',
                          productionunit: 'Đơn vị sản xuất',
                          color: 'Màu',
                        );

                        // Gọi hàm addProductToFirestore để đăng sản phẩm lên Firestore
                        addProductToFirestore(newProduct);
                      },
                      child: Text(
                        'Đăng bán',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Màu nền trắng
                        onPrimary: Colors.black, // Màu chữ đen
                        side: BorderSide(color: Colors.black), // Viền đen
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Viền đen bo tròn
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
                    SizedBox(height: 13.0,),
                    CircleAvatar(
                      backgroundImage: AssetImage(AppAssets.anhdaidien),
                      radius: 13.0,
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      'Trang cá nhân',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      )
    );
  }
}










