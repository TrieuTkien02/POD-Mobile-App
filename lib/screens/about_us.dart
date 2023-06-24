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
        padding: EdgeInsets.all(20.0),
        child: Text(
          textAlign: TextAlign.start,
          "\nỨng dụng POD Market là 1 trong 3 ứng dụng của đồ án môn học Đồ án chuyên ngành - NT114.N21\n\nPOD Market được thực hiện bởi sinh viên:\nTrần Triệu Thiên - 20521954\n\nContact:\n1) PhoneNumber: 0338027429\n2) Email: trieuthien16102002@gmail.com",
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
