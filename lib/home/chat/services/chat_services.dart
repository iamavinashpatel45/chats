import 'dart:io';
import 'package:chats/home/chat/modules/chat_module.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:chats/services/local_data.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:images_picker/images_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';

class chat_services {

  void send_message(String text, contacts_module contact, bool image) async {
    String str = contact.id!;
    text = mess_encrypt(text, str);
    await FirebaseDatabase.instance
        .ref("chats/${local_data.uid}/$str")
        .push()
        .set(
          chat_module(
            type: true,
            message: text,
            date: DateTime.now().toString(),
            time: "${DateTime.now().hour}:${DateTime.now().minute}",
            image: image,
          ).toJson(),
        );
    await FirebaseDatabase.instance
        .ref("chats/$str/${local_data.uid}")
        .push()
        .set(
          chat_module(
            type: false,
            message: text,
            date: DateTime.now().toString(),
            time: "${DateTime.now().hour}:${DateTime.now().minute}",
            image: image,
          ).toJson(),
        );
  }

  String mess_encrypt(String mes, String uid) {
    final iv = IV.fromUtf8(uid.substring(0, 16));
    final encrypter = Encrypter(
      AES(
        Key.fromUtf8(uid + uid.substring(12, 16)),
        padding: null,
      ),
    );
    return encrypter.encrypt(mes, iv: iv).base64;
  }

  String mess_decrypt(String enc_mess, String uid) {
    final iv = IV.fromUtf8(uid.substring(0, 16));
    final encrypter = Encrypter(
      AES(
        Key.fromUtf8(uid + uid.substring(12, 16)),
        padding: null,
      ),
    );
    return encrypter
        .decrypt(
          Encrypted.fromBase64(
            enc_mess,
          ),
          iv: iv,
        )
        .toString();
  }

  Future image_picker(contacts_module contact) async {
    List<Media>? _image = [];
    if (await Permission.storage.request().isGranted) {
      _image = await ImagesPicker.pick(
        count: 1,
        pickType: PickType.image,
      );
    }
    if (_image!.isNotEmpty) {
      final _storage = FirebaseStorage.instance.ref();
      String name = randomString(20);
      await _storage
          .child("chat-images/${local_data.uid}/${contact.id}/$name")
          .putFile(
            File(_image[0].path),
          );
      String link = await _storage
          .child("chat-images/${local_data.uid}/${contact.id}/$name")
          .getDownloadURL();
      send_message(link, contact, true);
    }
  }

  void forward_mess(){

  }
}
