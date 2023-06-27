import 'package:flutter/material.dart';
import 'package:partnerapp/Pages/sign_up.dart';
import '../../constants/routes.dart';
import 'package:partnerapp/Pages/primary_button.dart';
import 'package:partnerapp/Pages/login.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back),
          ),
          Center(
            child: Image.asset(
              'assets/images/POD-removebg-preview.png',
              alignment: Alignment.center,
            ),
          ),
          const Text(
            "Để bắt đầu mua sắm vui lòng đăng nhập hoặc đăng ký tài khoản",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          PrimaryButton(
            title: "Đăng nhập",
            onPressed: () {
              Routes.instance.push(widget: const Login(), context: context);
            },
          ),
          const SizedBox(
            height: 18.0,
          ),
          PrimaryButton(
            title: "Đăng ký",
            onPressed: () {
              Routes.instance.push(widget: const SignUp(), context: context);
            },
          ),
        ],
      ),
    );
  }
}
