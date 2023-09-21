import 'package:chats/home/chat/services/contact_modul.dart';
import 'package:chats/local_data.dart';
import 'package:firebase_database/firebase_database.dart';

class chat_services {
  void send_message(String text, contacts_modul contact) async {
    String str = contact.id!;
    await FirebaseDatabase.instance
        .ref("chats/${local_data.uid}/$str")
        .push()
        .set({
      "type": true,
      "message": text,
      "date": DateTime.now().toString(),
      "time": "${DateTime.now().hour}:${DateTime.now().minute}"
    });
    await FirebaseDatabase.instance
        .ref("chats/$str/${local_data.uid}")
        .push()
        .set({
      "type": false,
      "message": text,
      "date": DateTime.now().toString(),
      "time": "${DateTime.now().hour}:${DateTime.now().minute}"
    });
  }
}
