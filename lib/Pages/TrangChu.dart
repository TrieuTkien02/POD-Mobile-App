import 'package:flutter/material.dart';
import 'package:partnerapp/Values/app_assets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(

            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.anhbia),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child:
                  Column(

                    children : [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.0, top: 16.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Tìm kiếm',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),


                        Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 45.0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(AppAssets.anhdaidien),
                                radius: 50.0,
                              ),
                              SizedBox(height: 8.0),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child:Text(
                                    'BOYZ - Thời Trang Nam',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '4.6',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,

                                        ),
                                      ),
                                      Icon(Icons.star, color: Colors.yellow,),
                                      SizedBox(width: 20.0),
                                      Text(
                                        '100 người theo dõi',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,

                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),

                    ],
                  ),

                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),

                child: Text(
                  'Cửa hàng',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Sản Phẩm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Thêm Sản Phẩm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(10, (index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      'Product ${index + 1}',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.home),
                      color: Colors.blue,
                      onPressed: () {},
                    ),
                    Text(
                      'Trang chủ',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chat),
                      color: Colors.black,
                      onPressed: () {},
                    ),
                    Text(
                      'Trò chuyện',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_bag),
                      color: Colors.black,
                      onPressed: () {},
                    ),
                    Text(
                      'Đơn hàng',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 13.0,),
                    CircleAvatar(
                      backgroundImage: AssetImage(AppAssets.anhdaidien),
                      radius: 13.0,
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      'Trang cá nhân',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}