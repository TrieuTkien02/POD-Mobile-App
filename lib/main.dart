import 'package:flutter/material.dart';
import 'package:partnerapp/Pages/ThemSanPham.dart';
import 'constants/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_auth_helper.dart';
import 'firebase/firebase_options.dart';
import 'package:partnerapp/models/pullcategorylist.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POD Partner',
      theme: themeData,
      home: StreamBuilder(
        stream: FirebaseAuthHelper.instance.getAuthChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ThemSanPham();
          }
          return ThemSanPham();
        },
      ),
    );
  }
}
