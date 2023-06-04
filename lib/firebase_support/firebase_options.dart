import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:30048143757:ios:384529b86e3be0cc8815c4',
        apiKey: 'AIzaSyBs-QIK60uj7T9BNoW7gSwukimlBni30DM',
        projectId: 'pod-mobile-app-c9d53',
        messagingSenderId: '30048143757',
        iosBundleId: 'com.example.podMarket',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:30048143757:android:ef3afc8c1d92c3238815c4',
        apiKey: 'AIzaSyBs6UZFRzccqOCcGJpunHuw639t8Gw8Eno',
        projectId: 'pod-mobile-app-c9d53',
        messagingSenderId: '30048143757',
      );
    }
  }
}
