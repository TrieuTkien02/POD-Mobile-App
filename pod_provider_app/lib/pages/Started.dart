
import 'package:flutter/material.dart';


class Started extends StatelessWidget {
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
              margin: EdgeInsets.only( bottom: 100,left: 30, right: 20),
              child: Text(
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
                Navigator.pushReplacementNamed(context, "Sign");
              },
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFF34332D),
                ),
                child: Text(
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
