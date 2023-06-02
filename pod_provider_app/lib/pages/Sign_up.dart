import 'package:flutter/material.dart';

class Sign_up extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Đăng ký'),
        ),
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Center(
                child: Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              //logo
              Image.asset(
                "images/LogoProvider.png",
                height: 250,
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10)),
                    ),
                    labelText: 'Nhập email',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10)),
                    ),
                    labelText: 'Nhập mật khẩu',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10)),
                    ),
                    labelText: 'Nhập lại mật khẩu',
                  ),
                ),
              ),
              // not a member? register now
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  'Đã có tài khoản?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const Text(
                  '   Đăng nhập',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]),
              Container(
                margin: EdgeInsets.only(top: 50, bottom: 30),
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
                        "Đăng ký",
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
            ]),
          ),
        ))));
  }
}
