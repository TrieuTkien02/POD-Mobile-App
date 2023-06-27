import 'package:flutter/material.dart';
import 'package:pod_provider_app/features/auth/screens/sign_in.dart';
import 'package:pod_provider_app/features/auth/screens/sign_up.dart';

class Sign extends StatelessWidget {
  static const routeName = '/sign-screen';
  const Sign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/LogoProvider.png",
              height: 300,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 100, left: 30, right: 20),
              child: const Text(
                " Đăng nhập và tạo ra \nnhững sản phẩm tuyệt vời",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 10),
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Signin.routeName);
                  },
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 140, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[800],
                    ),
                    child: const Text(
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
            Material(
              child: InkWell(
                onTap: () {
                    Navigator.pushNamed(context, Signup.routeName);
                },
                child: Ink(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 145, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green, // Màu sắc đường viền
                      width: 2.0, // Độ dày đường viền
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Đăng kí",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
