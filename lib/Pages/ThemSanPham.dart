import 'dart:ffi';
import 'package:partnerapp/Pages/TrangChu.dart';
import 'package:flutter/material.dart';
import 'package:partnerapp/Values/app_assets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:partnerapp/models/addproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:partnerapp/Pages/Sanpham.dart';
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
  List<String> sizes = [];
  List<String> colors = [];
  String? price ='Nhập giá';
  String selectedUnit ="";
  String description = '';
  String nameProduct = '';
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
              InkWell(
                onTap: () {
                  Navigator.push(
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
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Sanpham()),
                    );
                  },
                  child: Text(
                    'Sản Phẩm',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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



      // Chọn chất liệu (lấy từ database)
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




                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // Căn lề bên trái
                        children: [
                          Text(
                            '4. Kích cỡ: ',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  TextEditingController sizeController = TextEditingController();
                                  return AlertDialog(
                                    title: Text('Thêm kích cỡ'),
                                    content: TextFormField(
                                      controller: sizeController,
                                      decoration: InputDecoration(labelText: 'Kích cỡ'),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text('Hủy'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text('Thêm'),
                                        onPressed: () {
                                          if (sizeController.text.isNotEmpty) {
                                            setState(() {
                                              sizes.add(sizeController.text);
                                            });
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              '+ Thêm',
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
                          SizedBox(width: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: sizes
                                .map(
                                  (size) => Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  size,
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                              ),
                            )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),



                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            '5. Màu sắc: ',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  Color selectedColor = Colors.transparent; // Màu mặc định

                                  return AlertDialog(
                                    title: Text('Chọn màu sắc'),
                                    content: SingleChildScrollView(
                                      child: MaterialPicker(
                                        pickerColor: selectedColor,
                                        onColorChanged: (Color color) {
                                          selectedColor = color;
                                        },
                                        enableLabel: true, // Hiển thị tên màu
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text('Hủy'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text('Thêm'),
                                        onPressed: () {
                                          setState(() {
                                            String hex = '#${selectedColor.value.toRadixString(16).substring(2)}';
                                            colors.add(hex);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              '+ Thêm',
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
                          SizedBox(width: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: colors
                                .map(
                                  (color) => Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  color,
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                              ),
                            )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '6. Tên sản phẩm: ',
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Nhập tên',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    nameProduct = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),




                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '7. Mô tả sản phẩm: ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          minLines: 5,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Nhập mô tả',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          textInputAction: TextInputAction.newline,
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 5),


                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          '8. Giá sản phẩm ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  TextEditingController priceController = TextEditingController();
                                  return AlertDialog(
                                    title: Text('Nhập giá sản phẩm'),
                                    content: TextField(
                                      controller: priceController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Nhập giá tiền (VNĐ)',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text('Hủy'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text('Lưu'),
                                        onPressed: () {
                                          setState(() {
                                            price = priceController.text;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    TextEditingController priceController = TextEditingController(text: price);
                                    return AlertDialog(
                                      title: Text('Nhập giá sản phẩm'),
                                      content: TextField(
                                        controller: priceController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'Nhập giá tiền (VNĐ)',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text('Hủy'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text('Lưu'),
                                          onPressed: () {
                                            setState(() {
                                              price = priceController.text;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                price != null ? '$price VNĐ' : 'Chọn giá tiền (VNĐ)',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


        // Chọn đơn vị sản xuât ( lấy từ firebase)

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          '9. Chọn đơn vị sản xuất: ',
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
                                      .collection('Đơn vị sản xuất')
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
                                        String unitName = doc.id;

                                        children.add(
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedUnit = unitName; // Update selectedProduct
                                              });
                                              // Xử lý khi người dùng chọn một chất liệu
                                              Navigator.pop(context, unitName);
                                            },
                                            child: Text(
                                              unitName,
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
                                        title: Text('Chọn đơn vị sản xuất'),
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
                            selectedUnit,
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





                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        String sizesString = sizes.join(' ');
                        String colorString = colors.join(' ');
                        double pri = double.parse(price!);
                        // Tạo một đối tượng Product từ dữ liệu nhập vào
                        Product newProduct = Product(
                          name: nameProduct,
                          description: description,
                          price: pri, // Giá sản phẩm
                          category: selectedProduct,
                          image: _selectedImage!,
                          material: selectedMaterial,
                          size: sizesString,
                          productionunit: selectedUnit,
                          color: colorString,
                        );

                        // Gọi hàm addProductToFirestore để đăng sản phẩm lên Firestore
                        addProductToFirestore(newProduct);
                        addProductToPartner(newProduct,'username');
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
                        color: Colors.blue,
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
                            color: Colors.blue,
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










