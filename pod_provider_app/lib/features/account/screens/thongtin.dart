import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/info-screen';
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Thông tin của chúng tôi",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          textAlign: TextAlign.start,
          "\nỨng dụng POD Provider là 1 trong 3 ứng dụng của đồ án môn học Đồ án chuyên ngành - NT114.N21\n\nPOD Provider được thực hiện bởi sinh viên:\nNguyễn Minh Sơn - 20521844\n\nContact:\n1) PhoneNumber: 0797044929\n2) Email: 20521844@gm.uit.edu.vn",
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
