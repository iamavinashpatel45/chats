import 'package:chats/home/chat/modules/chat_module.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:chats/local_data.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_database/firebase_database.dart';

class chat_services {
  void send_message(String text, contacts_module contact) async {
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
            seen: false,
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
            seen: false,
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

  String mess_decript(String enc_mess, String uid) {
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

}
