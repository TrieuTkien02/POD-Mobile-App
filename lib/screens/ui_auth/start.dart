import 'package:flutter/material.dart';
import 'package:pod_market/screens/ui_auth/sign_up.dart';
import '../../constants/asset_images.dart';
import '../../constants/routes.dart';
import '../../widgets/primary_button.dart';
import 'login.dart';

class Start extends StatelessWidget {
  const Start({super.key});
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
                  child: const Icon(Icons.arrow_back)),
          Center(
              child: Image.asset(
            AssetsImages.instance.logoDark,
            alignment: Alignment.center,
          )),
          const Text(
            textAlign: TextAlign.center,
            "Để bắt đầu mua sắm vui lòng đăng nhập hoặc đăng ký tài khoản",
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
