import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:partnerapp/Pages/ThemSanPham.dart';
import 'package:partnerapp/Pages/TrangChu.dart';
import 'package:partnerapp/constants/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:partnerapp/firebase/firebase_auth_helper.dart';
import 'package:partnerapp/firebase/firebase_options.dart';
import 'package:partnerapp/models/pullcategorylist.dart';
import 'package:partnerapp/Pages/welcome.dart';
import 'package:partnerapp/provider/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
            return Welcome();
          }
          return Welcome();
        },
      ),
    );
  }
}
