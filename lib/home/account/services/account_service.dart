import 'dart:io';
import 'package:chats/services/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:images_picker/images_picker.dart';

class accountService {
  List<Media>? images;
  final _storage = FirebaseStorage.instance.ref();
  final _update = FirebaseFirestore.instance;

  void updateImage(BuildContext context) async {
    String _url = await _uploadImage();
    await _update.collection('numbers').doc(LocalData.num).set({
      "uid": LocalData.uid,
      "name": LocalData.name,
      "image": _url,
    });
    final add = GetStorage();
    add.write("image", _url);
    LocalData.image=_url;
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  Future<String> _uploadImage() async {
    await _storage.child("image/${LocalData.uid}").putFile(
          File(images![0].path),
        );
    return _storage.child("image/${LocalData.uid}").getDownloadURL();
  }

  Future pickImage()async{
    images = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
    );
  }
}
