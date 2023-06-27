import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pod_provider_app/components/text_field_input.dart';
import 'package:pod_provider_app/features/auth/repository/auth_repository.dart';
import 'package:pod_provider_app/features/auth/screens/sign_in.dart';
import 'package:pod_provider_app/features/auth/screens/forgot_Password.dart';
import 'package:pod_provider_app/utils/utils.dart';

class Signup extends StatefulWidget {
  static const routeName = '/sign_up-screen';
  const Signup({Key? key}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthRepository().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });
    if (res == 'success') {
      showSnarBar(res, context);
      Navigator.pushNamed(context, Signin.routeName);
    } else {
      showSnarBar(res, context);
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Đăng ký'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //logo
                  // Image.asset(
                  //   "images/LogoProvider.png",
                  //   height: 250,
                  // ),
                  //avatar
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2017/02/25/22/04/user-icon-2098873_960_720.png'),
                            ),
                      Positioned(
                        bottom: -9,
                        left: 70,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldInput(
                    textEditingController: _emailController,
                    isPass: false,
                    hintText: 'Nhập email',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldInput(
                    textEditingController: _passwordController,
                    isPass: true,
                    hintText: 'Nhập mật khẩu',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldInput(
                    textEditingController: _nameController,
                    isPass: false,
                    hintText: 'Nhập tên công ty',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Đã có tài khoản?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Signin.routeName);
                        },
                        child: const Text(
                          '   Đăng nhập',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ForgotPassword.routeName);
                            },
                            child: const Text(
                              'Quên mật khẩu?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 30),
                    child: Material(
                      child: InkWell(
                        onTap: signUpUser,
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 140, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey[800],
                          ),
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
