import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final String category;
  final File image;
  final String material;
  final String size;
  final String productionunit;
  final String color;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.material,
    required this.size,
    required this.productionunit,
    required this.color,
  });
}

Future<void> addProductToFirestore(Product product) async {
  try {
    // Khởi tạo Firebase
    await Firebase.initializeApp();

    // Upload hình ảnh lên Firebase Storage
    final String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageRef =
    FirebaseStorage.instance.ref().child('product_images/$imageName.jpg');
    final UploadTask uploadTask = storageRef.putFile(product.image);
    final TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() {});
    final String imageUrl = await storageSnapshot.ref.getDownloadURL();

    // Tạo một tham chiếu đến collection 'products'
    final CollectionReference productsRef =
    FirebaseFirestore.instance.collection('categories');

// Thêm dữ liệu sản phẩm vào collection 'products'
    final newProductDoc = await productsRef.add({
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'image_url': imageUrl,
      'category': product.category,
      'material' : product.material,
      'size': product.size,
      'productionunit': product.productionunit,
      'color': product.color,
    });

// Lấy ID của tài liệu mới tạo
    final newProductId = newProductDoc.id;

// Cập nhật tài liệu sản phẩm vào trường "categories"
    final categoriesRef = FirebaseFirestore.instance.collection('categories');
    final categoryDoc = await categoriesRef.doc(product.category).get();
    if (categoryDoc.exists) {
      // Nếu tài liệu category đã tồn tại, thêm sản phẩm vào trường "products" của category
      await categoryDoc.reference.update({
        'products': FieldValue.arrayUnion([newProductDoc.id])
      });
    } else {
      // Nếu tài liệu category chưa tồn tại, tạo mới và thêm sản phẩm vào trường "products" của category
      await categoriesRef.doc(product.category).set({
        'products': [newProductDoc.id]
      });
    }







    print('Thêm sản phẩm thành công!');
  } catch (error) {
    print('Lỗi khi thêm sản phẩm: $error');
  }
}

