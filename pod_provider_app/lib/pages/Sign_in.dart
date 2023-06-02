import 'package:flutter/material.dart';
import 'package:pod_provider_app/components/SquareTile.dart';


class Sign_in extends StatelessWidget {
  const Sign_in({super.key});


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
          title: Text('Đăng nhập'),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Nhập email',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Nhập password',
                ),
              ),
            ),

            // not a member? register now
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                'Chưa có tài khoản?',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(width: 4),
              const Text(
                'Đăng kí',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: const Text(
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
              margin: const EdgeInsets.only(top: 30, bottom: 10),
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // google button
                SquareTile(imagePath: 'images/google.png'),
                SizedBox(width: 25),
              ],
            ),


          ]),
        )))));
  }
}
