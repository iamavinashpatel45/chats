import 'dart:io';
import 'package:chats/services/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:images_picker/images_picker.dart';

class account_service {
  List<Media>? images;
  final _storage = FirebaseStorage.instance.ref();
  final _update = FirebaseFirestore.instance;

  void update_image(BuildContext context) async {
    String _url = await _upload_image();
    await _update.collection('numbers').doc(local_data.num).set({
      "uid": local_data.uid,
      "name": local_data.name,
      "image": _url,
    });
    final add = GetStorage();
    add.write("image", _url);
    local_data.image=_url;
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  Future<String> _upload_image() async {
    await _storage.child("image/${local_data.uid}").putFile(
          File(images![0].path),
        );
    return _storage.child("image/${local_data.uid}").getDownloadURL();
  }

  Future pick_image()async{
    images = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
    );
  }
}
