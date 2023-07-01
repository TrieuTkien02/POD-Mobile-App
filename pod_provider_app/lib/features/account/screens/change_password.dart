import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pod_provider_app/components/primary_button.dart';
import 'package:pod_provider_app/features/account/screens/account_screen.dart';
import 'package:pod_provider_app/utils/utils.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = '/change_password-screen';
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController currentpassword = TextEditingController();

  final _auth = FirebaseAuth.instance;

  changePassword({oldpassword, newpassword}) async {
    var cred = EmailAuthProvider.credential(
        email: _auth.currentUser!.email.toString(), password: oldpassword);

    await _auth.currentUser!.reauthenticateWithCredential(cred).then((value) {
      _auth.currentUser!.updatePassword(newpassword);
      Navigator.pushNamed(context, AccountScreen.routeName);
    }).catchError((err) {
      showSnarBar(err.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Đổi mật khẩu",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: currentpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "Mật khẩu hiện tại",
              prefixIcon: const Icon(
                Icons.password_sharp,
              ),
              suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Icon(
                    isShowPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  )),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration:const InputDecoration(
              hintText: "Mật khẩu mới",
              prefixIcon: const Icon(
                Icons.password_sharp,
              ),
              
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassword,
            decoration: const InputDecoration(
              hintText: "Xác nhận mật khẩu",
              prefixIcon: Icon(
                Icons.password_sharp,
              ),
              
            ),
          ),
          const SizedBox(
            height: 36.0,
          ),
          PrimaryButton(
            title: "Cập nhật",
            onPressed: () async {
              if (newpassword.text.isEmpty) {
                showSnarBar("Chưa nhập mật khẩu mới", context);
              } else if (confirmpassword.text.isEmpty) {
                showSnarBar("Chưa xác nhận mật khẩu", context);
              } else if (confirmpassword.text == newpassword.text) {
                await changePassword(
                    oldpassword: currentpassword.text, newpassword: newpassword.text);
                showSnarBar("Đổi mật khẩu thành công", context);
              } else {
                showSnarBar("Mật khẩu chưa trùng khớp", context);
              }
            },
          ),
        ],
      ),
    );
  }
}
