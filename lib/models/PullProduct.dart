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
  final String imageUrl; // Image URL instead of File
  final String material;
  final String size;
  final String productionunit;
  final String color;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.material,
    required this.size,
    required this.productionunit,
    required this.color,
  });
}

Future<List<Product>> fetchProducts(String username, String Loaisanpham) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  // Replace 'partners' with your Firestore collection name
  // and 'Giày thể thao' with the desired category
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Partner')
      .doc(username)
      .collection('categories')
      .doc(Loaisanpham)
      .collection('products')
      .get();

  List<Product> products = [];

  for (QueryDocumentSnapshot doc in snapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Retrieve the necessary product properties from the data map
    String name = data['name'];
    String description = data['description'];
    double price = data['price'];
    String category = data['category'];
    String material = data['material'];
    String size = data['size'];
    String productionunit = data['productionunit'];
    String color = data['color'];

    // Retrieve the image URL from the 'image_url' field
    String imageUrl = data['image_url'];

    // Create a new Product instance with the retrieved properties and image URL
    Product product = Product(
      name: name,
      description: description,
      price: price,
      category: category,
      imageUrl: imageUrl,
      material: material,
      size: size,
      productionunit: productionunit,
      color: color,
    );

    products.add(product);
  }

  return products;
}

Future<List<Product>> fetchAllProducts(String username) async {
  List<Product> products = [];

  // Initialize Firebase
  await Firebase.initializeApp();

  try {
    QuerySnapshot categoriesSnapshot = await FirebaseFirestore.instance
        .collection('Partner')
        .doc(username)
        .collection('categories')
        .get();

    for (QueryDocumentSnapshot categoryDoc in categoriesSnapshot.docs) {
      QuerySnapshot productsSnapshot = await categoryDoc.reference
          .collection('products')
          .get();

      for (QueryDocumentSnapshot productDoc in productsSnapshot.docs) {
        Map<String, dynamic> productData = productDoc.data() as Map<String, dynamic> ;

        // Retrieve the necessary product properties from the data map
        String name = productData['name'];
        String description = productData['description'];
        double price = productData['price'];
        String category = productData['category'];
        String material = productData['material'];
        String size = productData['size'];
        String productionunit = productData['productionunit'];
        String color = productData['color'];

        // Retrieve the image URL from the 'image_url' field
        String imageUrl = productData['image_url'];

        // Create a new Product instance with the retrieved properties and image URL
        Product product = Product(
          name: name,
          description: description,
          price: price,
          category: category,
          imageUrl: imageUrl,
          material: material,
          size: size,
          productionunit: productionunit,
          color: color,
        );

        products.add(product);
      }
    }
  } catch (e) {
    print('Error fetching products: $e');
  }

  return products;
}
