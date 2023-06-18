import 'package:flutter/material.dart';
import 'package:pod_market/provider/app_provider.dart';
import 'package:pod_market/screens/custom_bottom_bar.dart';
import 'package:pod_market/screens/ui_auth/welcome.dart';
import 'package:provider/provider.dart';
import 'constants/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_support/firebase_auth_helper.dart';
import 'firebase_support/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'POD Market',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomBar();
            }
            return const Welcome();
          },
        ),
      ),
    );
  }
}
