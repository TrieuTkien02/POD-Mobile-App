import 'package:flutter/material.dart';
import '../../constants/asset_images.dart';
import '../../widgets/primary_button.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          const Text(
            "Chào mừng đến với POD Market",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Mua bất cứ thứ gì bạn thích",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Center(
              child: Image.asset(
            AssetsImages.instance.logoDark,
            alignment: Alignment.center,
          )),
          
          const SizedBox(
            height: 30.0,
          ),
          PrimaryButton(
            title: "Đăng nhập",
            onPressed: () {
              //Routes.instance.push(widget: const Login(), context: context);
            },
          ),
          const SizedBox(
            height: 18.0,
          ),
          PrimaryButton(
            title: "Đăng ký",
            onPressed: () {
              //Routes.instance.push(widget: const SignUp(), context: context);
            },
          ),
        ],
      ),
    );
  }
}
