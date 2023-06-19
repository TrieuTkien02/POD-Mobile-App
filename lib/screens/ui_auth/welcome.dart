import 'package:flutter/material.dart';
import 'package:pod_market/screens/ui_auth/start.dart';
import '../../constants/asset_images.dart';
import '../../constants/routes.dart';
import '../../widgets/primary_button.dart';

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
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            textAlign: TextAlign.center,
            "\"Mua sắm là một cách để kết nối với chính mình, để tận hưởng khoảnh\nkhắc và tìm thấy niềm vui trong\nnhững điều nhỏ bé\"",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 80.0,
          ),
          PrimaryButton(
            title: "Tiếp tục",
            onPressed: () {
                Routes.instance.push(widget: const Start(), context: context);
            },
          ),
        ],
      ),
    );
  }
}
