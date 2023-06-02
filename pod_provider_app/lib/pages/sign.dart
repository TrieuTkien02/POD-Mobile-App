import 'package:flutter/material.dart';

class Sign extends StatelessWidget {
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
              margin: EdgeInsets.only(bottom: 100, left: 30, right: 20),
              child: Text(
                " Đăng nhập và tạo ra \nnhững sản phẩm tuyệt vời",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 10),
              child: Material(
                child: InkWell(
                  onTap: () {},
                  child: Ink(
                    padding:
                        EdgeInsets.symmetric(horizontal: 140, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[800],
                    ),
                    child: Text(
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
            Container(
              child: Material(
                child: InkWell(
                  onTap: () {},
                  child: Ink(
                    padding:
                        EdgeInsets.symmetric(horizontal: 145, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green, // Màu sắc đường viền
                        width: 2.0, // Độ dày đường viền
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
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
            ),
          ],
        ),
      ),
    );
  }
}
