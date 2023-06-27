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

Future<void> addProductToFirestore(Product product,String username) async {
  try {
    // Khởi tạo Firebase
    await Firebase.initializeApp();

    // Upload hình ảnh lên Firebase Storage
    final String imageName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final Reference storageRef = FirebaseStorage.instance.ref().child(
        'product_images/$imageName.jpg');
    final UploadTask uploadTask = storageRef.putFile(product.image);
    final TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() {});
    final String imageUrl = await storageSnapshot.ref.getDownloadURL();

    // Tạo một tham chiếu đến collection 'categories'
    final CollectionReference productsRef = FirebaseFirestore.instance
        .collection('categories');

    // Cập nhật tài liệu sản phẩm vào trường "categories"
    final categoriesRef = FirebaseFirestore.instance.collection('categories');
    final categoryDoc = await categoriesRef.doc(product.category).get();
    if (categoryDoc.exists) {
      // Nếu tài liệu category đã tồn tại, thêm sản phẩm vào collection của category
      final newProductDoc = await categoryDoc.reference.collection('products')
          .add({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'image_url': imageUrl,
        'category': product.category,
        'material': product.material,
        'size': product.size,
        'productionunit': product.productionunit,
        'color': product.color,
        'partner':username,
      });

      print('Thêm sản phẩm vào collection của category thành công!');
    } else {
      // Nếu tài liệu category chưa tồn tại, tạo mới và thêm sản phẩm vào collection của category
      await categoriesRef.doc(product.category).set({});
      final newProductDoc = await categoriesRef.doc(product.category)
          .collection('products')
          .add({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'image_url': imageUrl,
        'category': product.category,
        'material': product.material,
        'size': product.size,
        'productionunit': product.productionunit,
        'color': product.color,
      });

      print(
          'Tạo mới tài liệu category và thêm sản phẩm vào collection thành công!');
    }
  } catch (error) {
    print('Lỗi khi thêm sản phẩm: $error');
  }
}




Future<void> addProductToPartner(Product product, String username) async {
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

    final CollectionReference partnerRef =
    FirebaseFirestore.instance.collection('Partner');

    final partnerDoc = await partnerRef.doc(username).get();
    if (partnerDoc.exists) {
      final categoryCollectionRef =
      partnerDoc.reference.collection('categories');
      final categoryDoc = await categoryCollectionRef.doc(product.category).get();
      if (categoryDoc.exists) {
        await categoryDoc.reference
            .collection('products')
            .add({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'image_url': imageUrl,
          'category': product.category,
          'material': product.material,
          'size': product.size,
          'productionunit': product.productionunit,
          'color': product.color,
        });

        print('Thêm sản phẩm vào collection của category thành công!');
      } else {
        // Nếu tài liệu category chưa tồn tại, tạo mới và thêm sản phẩm vào collection của category
        await categoryCollectionRef.doc(product.category).set({});
        final CollectionReference productsCollectionRef =
        categoryCollectionRef.doc(product.category).collection('products');
        await productsCollectionRef.add({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'image_url': imageUrl,
          'category': product.category,
          'material': product.material,
          'size': product.size,
          'productionunit': product.productionunit,
          'color': product.color,
        });

        print('Tạo mới tài liệu category và thêm sản phẩm vào collection thành công!');
      }
    } else {
      // Nếu tài liệu partner chưa tồn tại, tạo mới và thêm sản phẩm vào collection của partner
      await partnerRef.doc(username).set({});
      final CollectionReference categoriesCollectionRef =
      partnerRef.doc(username).collection('categories');
      await categoriesCollectionRef.doc(product.category).set({});
      final CollectionReference productsCollectionRef =
      categoriesCollectionRef.doc(product.category).collection('products');
      await productsCollectionRef.add({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'image_url': imageUrl,
        'category': product.category,
        'material': product.material,
        'size': product.size,
        'productionunit': product.productionunit,
        'color': product.color,
      });

      print('Tạo mới tài liệu partner và category, và thêm sản phẩm vào collection thành công!');
    }
  } catch (error) {
    print('Lỗi khi thêm sản phẩm: $error');
    throw error; // Throw the error to handle it in the calling code
  }
}





