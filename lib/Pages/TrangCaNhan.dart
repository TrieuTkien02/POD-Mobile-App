import 'package:flutter/material.dart';
import 'package:partnerapp/Pages/Thietlaptaikhoan.dart';
import '../Values/app_assets.dart';
import 'package:partnerapp/constants/routes.dart';
import 'package:partnerapp/Pages/TrangChu.dart';

import 'DonHang.dart';
import 'login.dart';
class Trangcanhan extends StatefulWidget {
  @override
  _Trangcanhanstate createState() => _Trangcanhanstate();
}

class _Trangcanhanstate extends State<Trangcanhan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Widget'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Doanh thu',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 130.0,
                        width: MediaQuery.of(context).size.width - 20.0,
                        color: Colors.blue,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                color: Colors.grey,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            'Hằng ngày',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            'Hằng tuần',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      color: Colors.white70,
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Center(
                                        child: Text(
                                          '1.250.000đ',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Expanded(
                              child: Container(
                                color: Colors.white70,
                                child: Center(
                                  child: Row(

                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Đơn đã hoàn thành',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 70.0,),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Xử lý sự kiện khi button được nhấn
                                        },
                                        child: Text(
                                          'Xem chi tiết',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),



                SizedBox(height : 10),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 140.0,
                        width: MediaQuery.of(context).size.width - 20.0,
                        color: Colors.white70,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        'Số dư tài khoản',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '10.000.000đ',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.white70,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.money_off,
                                      size: 40.0,
                                    ),

                                    ElevatedButton(
                                      onPressed: () {
                                        // Xử lý sự kiện khi button được nhấn
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white, // Màu nền của button
                                      ),
                                      child: Text(
                                        'Rút tiền',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ],
                ),


                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Routes.instance.push(widget: UserProfilePage(), context: context ); // Gọi hàm để chuyển đến trang Thongtincanhan
                            },
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Routes.instance.push(widget: UserProfilePage(), context: context ); // Gọi hàm để chuyển đến trang Thongtincanhan
                                    },
                                    child: Icon(
                                      Icons.person,
                                      size: 24.0,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Routes.instance.push(widget:UserProfilePage(), context: context ); // Gọi hàm để chuyển đến trang Thongtincanhan
                                    },
                                    child: Text(
                                      'Thiết lập tài khoản',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Routes.instance.push(widget: UserProfilePage(), context: context ); // Gọi hàm để chuyển đến trang Thongtincanhan
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),


                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 24.0,
                                ),
                                Text(
                                  'Đánh giá của khách hàng',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.settings,
                                  size: 24.0,
                                ),
                                Text(
                                  'Cài đặt ứng dụng',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.help,
                                  size: 24.0,
                                ),
                                Text(
                                  'Trung tâm trợ giúp',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Expanded(
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.logout,
                                    size: 24.0,
                                  ),
                                  Text(
                                    'Đăng xuất',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.home),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        },
                        child: Text(
                          'Trang chủ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      onPressed: (

                          ) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Donhang()),
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Donhang()),
                        );
                      },
                      child:
                      Text(
                        'Đơn hàng',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 13.0),
                    CircleAvatar(
                      backgroundImage: AssetImage(AppAssets.anhdaidien),
                      radius: 13.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Trang cá nhân',
                      style: TextStyle(
                        color: Colors.blue,
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
    home: Trangcanhan(),
  ));
}
