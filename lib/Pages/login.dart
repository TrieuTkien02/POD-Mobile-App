import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:partnerapp/Pages/sign_up.dart';
import '../../constants/constants.dart';
import '../../constants/routes.dart';
import '../../firebase/firebase_auth_helper.dart';
import 'package:partnerapp/Pages/primary_button.dart';
import 'package:partnerapp/Pages/TrangChu.dart';
import 'package:partnerapp/provider/user_provider.dart';

import '../Values/app_assets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kToolbarHeight + 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                "Đăng nhập",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 46.0,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                  hintText: "Mật khẩu",
                  prefixIcon: const Icon(
                    Icons.password_sharp,
                  ),
                  suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: Icon(
                      isShowPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 36.0,
              ),
              PrimaryButton(
                title: "Đăng nhập",
                onPressed: () async {
                  bool isVaildated = loginVaildation(email.text, password.text);
                  if (isVaildated) {
                    bool isLogined = await FirebaseAuthHelper.instance.login(email.text, password.text, context);
                    if (isLogined) {
                      final userProvider = Provider.of<UserProvider>(context, listen: false);
                      userProvider.setUsername(email.text); // Lưu username vào UserProvider

                      // Kiểm tra xem trong bộ sưu tập "Partner" đã có tài liệu nào có tên giống email.text chưa
                      final partnerSnapshot = await FirebaseFirestore.instance
                          .collection('Partner')
                          .doc(email.text)
                          .get();

                      if (!partnerSnapshot.exists) {
                        await Firebase.initializeApp();

                        // Tạo đường dẫn cho tệp tạm
                        final Directory tempDir = await getTemporaryDirectory();
                        final String tempPath = tempDir.path;

                        // Lưu hình ảnh đại diện vào tệp tạm
                        final File avatarFile = File('$tempPath/anhdaidien.jpg');
                        final ByteData avatarByteData = await rootBundle.load(AppAssets.anhdaidien);
                        await avatarFile.writeAsBytes(avatarByteData.buffer.asUint8List());

                        // Lưu hình ảnh bìa vào tệp tạm
                        final File coverImageFile = File('$tempPath/anhbia.jpg');
                        final ByteData coverImageByteData = await rootBundle.load(AppAssets.anhbia);
                        await coverImageFile.writeAsBytes(coverImageByteData.buffer.asUint8List());

                        // Tải lên hình ảnh đại diện lên Firebase Storage
                        final Reference avatarStorageRef = FirebaseStorage.instance.ref().child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
                        final UploadTask avatarUploadTask = avatarStorageRef.putFile(avatarFile);
                        final TaskSnapshot avatarStorageSnapshot = await avatarUploadTask.whenComplete(() {});
                        final String avatarImageUrl = await avatarStorageSnapshot.ref.getDownloadURL();

                        // Tải lên hình ảnh bìa lên Firebase Storage
                        final Reference coverImageStorageRef = FirebaseStorage.instance.ref().child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
                        final UploadTask coverImageUploadTask = coverImageStorageRef.putFile(coverImageFile);
                        final TaskSnapshot coverImageStorageSnapshot = await coverImageUploadTask.whenComplete(() {});
                        final String coverImageUrl = await coverImageStorageSnapshot.ref.getDownloadURL();

                        // Xóa tệp tạm sau khi đã tải lên thành công
                        await avatarFile.delete();
                        await coverImageFile.delete();

                        // Nếu không có tài liệu nào có tên giống email.text, thêm một tài liệu mới
                        await FirebaseFirestore.instance.collection('Partner').doc(email.text).set({
                          'shopName': email.text,
                          'avatarUrl': avatarImageUrl,
                          'coverImageUrl': coverImageUrl,
                        });
                      }

                      Routes.instance.pushAndRemoveUntil(
                        widget: MyHomePage(),
                        context: context,
                      );
                    }
                  }
                },
              ),

              const SizedBox(
                height: 24.0,
              ),
              const Center(child: Text("Chưa có tài khoản?")),
              const SizedBox(
                height: 12.0,
              ),
              Center(
                child: CupertinoButton(
                  onPressed: () {
                    Routes.instance.push(
                      widget: const SignUp(),
                      context: context,
                    );
                  },
                  child: const Text(
                    "Tạo tài khoản",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
