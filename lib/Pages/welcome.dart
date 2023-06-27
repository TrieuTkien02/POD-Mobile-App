import 'package:flutter/material.dart';
import 'package:partnerapp/Pages/start.dart';
import '../../constants/routes.dart';
import 'package:partnerapp/Pages/primary_button.dart';
class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/images/POD-removebg-preview.png',
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            "\"Mua sắm là một cách để kết nối với chính mình, để tận hưởng khoảnh\nkhắc và tìm thấy niềm vui trong\nnhững điều nhỏ bé\"",
            textAlign: TextAlign.center,
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

