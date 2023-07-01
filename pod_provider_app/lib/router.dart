import 'package:flutter/material.dart';
import 'package:pod_provider_app/components/error_screen.dart';
import 'package:pod_provider_app/features/account/screens/account_screen.dart';
import 'package:pod_provider_app/features/account/screens/change_password.dart';
import 'package:pod_provider_app/features/account/screens/edit_profile.dart';
import 'package:pod_provider_app/features/account/screens/thongtin.dart';
import 'package:pod_provider_app/features/auth/screens/forgot_Password.dart';
import 'package:pod_provider_app/features/auth/screens/sign.dart';
import 'package:pod_provider_app/features/auth/screens/sign_in.dart';
import 'package:pod_provider_app/features/auth/screens/sign_up.dart';
import 'package:pod_provider_app/features/auth/screens/started_screen.dart';
import 'package:pod_provider_app/features/don_hang/screens/cho_xac_nhan.dart';
import 'package:pod_provider_app/features/don_hang/screens/da_giao_hang.dart';
import 'package:pod_provider_app/features/don_hang/screens/da_huy.dart';
import 'package:pod_provider_app/features/don_hang/screens/don_hang_screens.dart';
import 'package:pod_provider_app/features/home/screens/add_product.dart';
import 'package:pod_provider_app/features/home/screens/home.dart';

import 'features/don_hang/screens/dang_giao_hang.dart';
import 'features/don_hang/screens/dang_san_xuat.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Started.routeName:
      return MaterialPageRoute(
        builder: (context) => const Started(),
      );

    case Sign.routeName:
      return MaterialPageRoute(
        builder: (context) => const Sign(),
      );

    case Signin.routeName:
      return MaterialPageRoute(
        builder: (context) => const Signin(),
      );

    case Signup.routeName:
      return MaterialPageRoute(
        builder: (context) => const Signup(),
      );

    case ForgotPassword.routeName:
      return MaterialPageRoute(
        builder: (context) => const ForgotPassword(),
      );
      
      case EditProfile.routeName:
      return MaterialPageRoute(
        builder: (context) => const EditProfile(),
      );
      
      case Home.routeName:
      return MaterialPageRoute(
        builder: (context) => const Home(),
      );

      case ProductListScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>const  ProductListScreen(),
      );

      case OrderStatusScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const OrderStatusScreen(),
      );

case OrderScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>  OrderScreen(),
      );

      case DaGiaoHangScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>  DaGiaoHangScreen(),
      );

      case DaHuyScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>  DaHuyScreen(),
      );

      case DangGiaoScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>  DangGiaoScreen(),
      );

      case SanXuatScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>  SanXuatScreen(),
      );
      

       case AccountScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>  AccountScreen(),
      );

      case AboutUs.routeName:
      return MaterialPageRoute(
        builder: (context) =>  AboutUs(),
      );

      case ChangePassword.routeName:
      return MaterialPageRoute(
        builder: (context) =>  ChangePassword(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
