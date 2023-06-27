import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pod_provider_app/features/auth/repository/storage_image.dart';
import 'package:pod_provider_app/models/user_model.dart' as model;

class AuthRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required Uint8List file,
  }) async {
    String res = "Có lỗi sảy ra";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl =
            await StorageImage().uploadImageToStorage('profilePic', file);

        model.UserModel user = model.UserModel(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          name: name,
        );
        await _firestore
            .collection('Provider')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = 'success';
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  //Sign in user
  Future<String> SignInUser({
    required String email,
    required String password,
  }) async {
    String res = 'có lỗi sảy ra';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Hãy nhập thông tin đầy đủ.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<Future<List<void>>> signOut() async {
    return Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
