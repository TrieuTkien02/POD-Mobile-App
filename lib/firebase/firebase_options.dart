import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:30048143757:ios:bf95f9656c403bc18815c4',
        apiKey: 'AIzaSyBs-QIK60uj7T9BNoW7gSwukimlBni30DM',
        projectId: 'pod-mobile-app-c9d53',
        messagingSenderId: '30048143757',
        iosBundleId: 'com.example.partnerapp',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:30048143757:android:26b76c4533ba35288815c4',
        apiKey: 'AIzaSyBs6UZFRzccqOCcGJpunHuw639t8Gw8Eno',
        projectId: 'pod-mobile-app-c9d53',
        messagingSenderId: '30048143757',
      );
    }
  }
}
