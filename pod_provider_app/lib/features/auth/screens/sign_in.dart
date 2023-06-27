import 'package:flutter/material.dart';
import 'package:pod_provider_app/components/SquareTile.dart';
import 'package:pod_provider_app/components/text_field_input.dart';
import 'package:pod_provider_app/features/auth/repository/auth_repository.dart';
import 'package:pod_provider_app/features/auth/screens/sign_up.dart';
import 'package:pod_provider_app/features/auth/screens/forgot_Password.dart';
import 'package:pod_provider_app/features/home/screens/home.dart';
import 'package:pod_provider_app/utils/utils.dart';

class Signin extends StatefulWidget {
  static const routeName = '/Sign_in-screen';
  const Signin({Key? key}) : super(key: key);
  @override
  _SiginState createState() => _SiginState();
}

class _SiginState extends State<Signin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isload = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController;
  }

  void signInUser() async {
    setState(() {
      _isload = true;
    });
    String res = await AuthRepository().SignInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == 'success') {
      showSnarBar(res, context);
      
      Navigator.pushNamed(context, Home.routeName);
    } else {
      showSnarBar(res, context);
    }
    setState(() {
      _isload = false;
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
        title: const Text('Đăng nhập'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //logo
                Image.asset(
                  "images/LogoProvider.png",
                  height: 250,
                ),
                //Enter email
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
                  height: 20,
                ),
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Chưa có tài khoản?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Signup.routeName);
                      },
                      child: const Text(
                        'Đăng kí',
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
                  margin: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Material(
                    child: InkWell(
                      onTap: signInUser,
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 140, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[800],
                        ),
                        child: _isload
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Đăng nhập",
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'images/google.png'),
                    SizedBox(width: 25),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
