import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pod_provider_app/components/primary_button.dart';
import 'package:pod_provider_app/features/account/screens/account_screen.dart';
import 'package:pod_provider_app/features/auth/repository/auth_repository.dart';
import 'package:pod_provider_app/utils/utils.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit_profile-screen';

  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  Uint8List? _image;
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  var userData = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void editprofile() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthRepository().editprofile(
      name: _nameController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });
    if (res == 'success') {
      showSnarBar(res, context);
      Navigator.pushNamed(context, AccountScreen.routeName);
    } else {
      showSnarBar(res, context);
    }
  }

  void getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var snapshot = await firestore
          .collection('Provider')
          .doc(_auth.currentUser!.uid)
          .get();
      userData = snapshot.data()!;

      setState(() {});
    } catch (e) {
      showSnarBar(e.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }


  void takePicture() async {
   Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                "Chỉnh sửa hồ sơ",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                _image == null
                    ? CupertinoButton(
                        onPressed: () {
                          takePicture();
                        },
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              userData['photoUrl'],
                            ),
                            radius: 55,
                            child: Icon(Icons.camera_alt)),
                      )
                    : CupertinoButton(
                        onPressed: () {
                          takePicture();
                        },
                        child: CircleAvatar(
                          backgroundImage: MemoryImage(_image!),
                          radius: 55,
                        ),
                      ),
                const SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: userData['name'],
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                PrimaryButton(
                  title: "Cập nhật",
                  onPressed: () async {
                    editprofile();
                  },
                ),
              ],
            ),
          );
  }
}
