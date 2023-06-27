
import 'package:flutter/material.dart';
import 'package:pod_provider_app/features/auth/screens/sign.dart';


class Started extends StatelessWidget {
  static const routeName = '/started-screen';
  const Started({super.key});

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
              margin:const EdgeInsets.only( bottom: 100,left: 30, right: 20),
              child:const Text(
                "Biến những ý tưởng\n và phong cách \n thành hiện thực.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Sign.routeName);
              },
              child: Ink(
                padding:const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color:const Color(0xFF34332D),
                ),
                child:const Text(
                  "Tiếp tục",
                  style: TextStyle(color: Colors.white,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
