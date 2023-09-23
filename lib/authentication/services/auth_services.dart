import 'package:chats/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class auth_service {
  String _verificationId = "";
  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;
  bool otp_send = false;

  // ignore: non_constant_identifier_names
  Future<bool> fun_otp_verify(BuildContext context, String num, String otp,
      String name, Widget widget) async {
    try {
      await auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: otp,
        ),
      );
      if (auth.currentUser != null) {
        String _uid = FirebaseAuth.instance.currentUser!.uid;
        String _image = "";
        try {
          _image = await FirebaseStorage.instance
              .ref()
              .child("image/$_uid")
              .getDownloadURL();
        } catch (e) {
          Fluttertoast.showToast(msg: "Somethig Went Wrong");
          return false;
        }
        await store.collection('numbers').doc(num).set({
          "uid": _uid,
          "name": name,
          "image": _image,
        });
        if (await _set_data(name, _uid, num, _image)) {
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => widget,
            ),
            (route) => false,
          );
        }
      }
      return true;
    } on FirebaseAuthException {
      Fluttertoast.showToast(msg: "Somethig Went Wrong");
      return false;
    }
  }

// ignore: non_constant_identifier_names
  Future<void> fun_otp_send(String num) async {
    try {
      await auth
          .verifyPhoneNumber(
            phoneNumber: "+91 $num",
            timeout: const Duration(minutes: 1),
            codeAutoRetrievalTimeout: (String verificationId) {},
            codeSent: (String verificationId, int? forceResendingToken) {
              _verificationId = verificationId;
            },
            verificationFailed: (FirebaseAuthException error) {},
            verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
          )
          .then((value) => () {});
      otp_send = true;
    } catch (e) {
      Fluttertoast.showToast(msg: "Somethig Went Wrong");
    }
  }

  Future<bool> _set_data(
      String name, String uid, String num, String image) async {
    final add = GetStorage();
    add.write("name", name);
    add.write("uid", uid);
    add.write("num", num);
    add.write("image", image);
    local_data.name = name;
    local_data.uid = uid;
    local_data.num = num;
    local_data.image = image;
    return true;
  }
}
