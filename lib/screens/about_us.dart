import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
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
        padding: EdgeInsets.all(12.0),
        child: Text(
          textAlign: TextAlign.start,
          "\nỨng dụng POD Market là đồ án môn học Đồ án chuyên ngành - NT114.N21\n\nĐược thực hiện bởi sinh viên: Trần Triệu Thiên - 20521954",
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
