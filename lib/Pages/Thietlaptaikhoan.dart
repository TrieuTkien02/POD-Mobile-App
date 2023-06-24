import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage, UploadTask;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:partnerapp/Values/app_assets.dart';
import 'package:path/path.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String avatarUrl = '';
  String coverImageUrl = '';
  String shopName = '';
  String newPassword = '';

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa thông tin'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chỉnh sửa ảnh đại diện',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  chooseAvatarImage();
                },
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _getAvatarImageProvider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'Chỉnh sửa ảnh bìa',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  chooseCoverImage();
                },
                child: Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _getCoverImageProvider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'Chỉnh sửa tên shop',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    shopName = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Nhập tên shop',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: shopName),
              ),
              SizedBox(height: 32.0),
              Text(
                'Đổi mật khẩu',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    newPassword = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Nhập mật khẩu mới',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  updateProfile();
                },
                child: Text('Cập nhật'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> chooseAvatarImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        avatarUrl = pickedFile.path;
      });
    }
  }

  Future<void> chooseCoverImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        coverImageUrl = pickedFile.path;
      });
    }
  }

  void updateProfile() {
    if (shopName.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('Partner')
          .doc('username') // Thay 'username' bằng giá trị thích hợp
          .update({
        'avatarUrl': avatarUrl,
        'coverImageUrl': coverImageUrl,
        'shopName': shopName,
      })
          .then((value) {
        if (avatarUrl.isNotEmpty) {
          uploadImageToFirestore('avatarUrl', avatarUrl);
        }
        if (coverImageUrl.isNotEmpty) {
          uploadImageToFirestore('coverImageUrl', coverImageUrl);
        }
        print('Cập nhật thông tin thành công');
      })
          .catchError((error) {
        print('Lỗi khi cập nhật thông tin: $error');
      });
    }
  }

  Future<void> uploadImageToFirestore(String fieldName, String filePath) async {
    File file = File(filePath);

    try {
      final String imageName = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      final Reference storageRef = FirebaseStorage.instance.ref().child(
          'images/$fieldName/$imageName.jpg');
      final UploadTask uploadTask = storageRef.putFile(file);
      final TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() {});
      final String imageUrl = await storageSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('Partner')
          .doc('username') // Thay 'username' bằng giá trị thích hợp
          .update({fieldName: imageUrl});

      print('Cập nhật thông tin thành công');
    } catch (error) {
      print('Lỗi khi cập nhật thông tin: $error');
    }
  }

  ImageProvider<Object> _getAvatarImageProvider() {
    if (avatarUrl.isNotEmpty) {
      if (avatarUrl.startsWith('http')) {
        return CachedNetworkImageProvider(avatarUrl);
      } else {
        return FileImage(File(avatarUrl));
      }
    } else {
      return AssetImage(AppAssets.anhdaidien);
    }
  }

  ImageProvider<Object> _getCoverImageProvider() {
    if (coverImageUrl.isNotEmpty) {
      if (coverImageUrl.startsWith('http')) {
        return CachedNetworkImageProvider(coverImageUrl);
      } else {
        return FileImage(File(coverImageUrl));
      }
    } else {
      return AssetImage(AppAssets.anhbia);
    }
  }
}
