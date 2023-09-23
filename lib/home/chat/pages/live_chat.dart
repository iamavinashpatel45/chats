import 'package:chats/home/chat/services/chat.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:chats/home/chat/utils/chat_display.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:chats/local_data.dart';

class live_chat extends StatefulWidget {
  final contacts_module contact;

  live_chat({
    super.key,
    required this.contact,
  });

  @override
  State<live_chat> createState() => _live_chatState();
}

class _live_chatState extends State<live_chat> {
  var chats;
  final chat_services _chat_service = chat_services();

  @override
  void initState() {
    chats = FirebaseDatabase.instance
        .ref("chats/${local_data.uid}/${widget.contact.id}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      query: chats,
      itemBuilder: (context, snapshot, animation, index) {
        var is_send = snapshot.child("type").value;
        String mes = is_send.toString().contains("true")
            ? _chat_service.mess_decript(
                snapshot.child("message").value.toString(),
                widget.contact.id!,
              )
            : _chat_service.mess_decript(
                snapshot.child("message").value.toString(),
                local_data.uid!,
              );
              print(snapshot.child("seen").value.toString().contains("false"));
        return chat_display(
          mes: mes,
          is_send: is_send.toString().contains("true"),
        );
      },
    );
  }
}
