import 'package:chats/services/local_data.dart';
import 'package:chats/services/main_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  String _verificationId = "";
  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;
  bool otpSend = false;


  Future<bool> FunOtpVerify(BuildContext context, String num, String otp,
      String name, Widget widget) async {
    try {
      await auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: otp,
        ),
      );
      if (auth.currentUser != null) {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        String image = "";
        try {
          image = await FirebaseStorage.instance
              .ref()
              .child("image/$uid")
              .getDownloadURL();
        } catch (e) {
          Fluttertoast.showToast(msg: "Somethig Went Wrong");
          return false;
        }
        await store.collection('numbers').doc(num).set({
          "uid": uid,
          "name": name,
          "image": image,
        });
        final MainServices mainServices = MainServices();
        await mainServices.setOnline(uid);
        if (await _setData(name, uid, num, image)) {
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

  Future<void> FunOtpSend(String num) async {
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
      otpSend = true;
    } catch (e) {
      Fluttertoast.showToast(msg: "Somethig Went Wrong");
    }
  }

  Future<bool> _setData(
      String name, String uid, String num, String image) async {
    final add = GetStorage();
    add.write("name", name);
    add.write("uid", uid);
    add.write("num", num);
    add.write("image", image);
    LocalData.name = name;
    LocalData.uid = uid;
    LocalData.num = num;
    LocalData.image = image;
    return true;
  }
}
