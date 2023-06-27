import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  static const routeName = '/forgot_password-screen';
  const ForgotPassword({Key? key}) : super(key: key);

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
                  "images/forgotPassword.png",
                  height: 250,
                ),
                Container(
                  padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Nhập email',
                    ),
                  ),
                ),
                Container(
                  margin:const EdgeInsets.only(top: 30, bottom: 10),
                  child: Material(
                    child: InkWell(
                      onTap: () {},
                      child: Ink(
                        padding:
                          const  EdgeInsets.symmetric(horizontal: 140, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[800],
                        ),
                        child: const Text(
                          "Gửi OTP",
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
    );
  }
}