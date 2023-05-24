import 'package:flutter/material.dart';
import 'package:pod_market/screens/ui_auth/welcome.dart';
import 'constants/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'E Mart',
        theme: themeData,
        home: StreamBuilder(
          //stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Welcome();
            }
            return const Welcome();
          },
        ),
    );
  }
}
