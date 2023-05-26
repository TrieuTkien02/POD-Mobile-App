import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:252769608934:ios:dd359a062dfafdb2eb4727',
        apiKey: 'AIzaSyBs-QIK60uj7T9BNoW7gSwukimlBni30DM',
        projectId: 'pod-mobile-app-c9d53',
        messagingSenderId: '30048143757',
        iosBundleId: 'com.example.podMarket',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:252769608934:android:53a9783d5274bf03eb4727',
        apiKey: 'AIzaSyBs6UZFRzccqOCcGJpunHuw639t8Gw8Eno',
        projectId: 'pod-mobile-app-c9d53',
        messagingSenderId: '30048143757',
      );
    }
  }
}
