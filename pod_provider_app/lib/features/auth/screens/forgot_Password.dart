import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pod_provider_app/components/text_field_input.dart';
import 'package:pod_provider_app/features/auth/screens/sign.dart';
import 'package:pod_provider_app/utils/utils.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/forgot_password-screen';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  Future resetpasword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showSnarBar('Đã gửi email đổi mật khẩu', context);
      Navigator.pushNamed(context, Sign.routeName);
    } on FirebaseAuthException catch (err) {
      showSnarBar(err.toString(), context);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _emailController.text = '';
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
                  "images/forgotPassword.png",
                  height: 250,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldInput(
                    textEditingController: _emailController,
                    isPass: false,
                    hintText: 'Nhập email',
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        resetpasword();
                      },
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 140, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[800],
                        ),
                        child: const Text(
                          "Quên mật khẩu",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
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
    );
  }
}
