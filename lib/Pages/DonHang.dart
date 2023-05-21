import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Column Example'),
      ),
      body: Column(
        children: [
                Container(
                child: Image.asset(
                'assets/images/POD-removebg-preview.png',
                  fit: BoxFit.cover,
                ),
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(
                  'Đơn chờ xử lý',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Đơn đang in',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Đơn vận chuyển',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Đơn hoàn thành',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Đơn đã bị hủy',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 2,
              children: List.generate(6, (index) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  child: Card(
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Mã kiển hàng : FX570 \n Mã sản phẩm  1 - số lượng - size \n Mã sản phẩm 2 - số lượng - size',
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Đặt bởi : ABC \n Địa chỉ : Tân lập 1 , Hiệp phú , TP Thủ Đức',
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Xử lý sự kiện khi button được nhấn
                                      },
                                      child: Text('Xác Nhận'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),


                          Row(
                            children: [
                              Text(
                                'Tổng giá: 2.000.000đ - Doanh thu tạm tính: 400.000đ',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Spacer(), // Hoặc Expanded()
                              ElevatedButton(
                                onPressed: () {
                                  // Xử lý sự kiện khi button được nhấn
                                },
                                child: Text('Hủy'),
                              ),
                            ],
                          ),


                        ],
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
                      color: Colors.black,
                      onPressed: () {},
                    ),
                    Text(
                      'Trang chủ',
                      style: TextStyle(
                        color: Colors.black,
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
                      color: Colors.blue,
                      onPressed: () {},
                    ),
                    Text(
                      'Đơn hàng',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 13.0,),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/AnhDaiDien.jpg'),
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

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}