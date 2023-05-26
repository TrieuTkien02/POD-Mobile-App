import 'package:flutter/material.dart';
import 'package:pod_market/screens/ui_auth/start.dart';
import '../../constants/asset_images.dart';
import '../../constants/routes.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: Image.asset(
            AssetsImages.instance.logoDark,
          )),
          const Text(
            textAlign: TextAlign.center,
            "\"Mua sắm là một cách để kết nối với chính mình, để tận hưởng khoảnh khắc và tìm thấy niềm vui trong những điều nhỏ bé\"",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 80.0,
          ),
          SizedBox(
            height: 80,
            width: 400,
            child: ElevatedButton(
              onPressed: () {
                Routes.instance.push(widget: const Start(), context: context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Tiếp tục",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
