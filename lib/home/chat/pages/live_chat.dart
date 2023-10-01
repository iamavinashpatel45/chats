import 'package:chats/home/chat/services/chat_services.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:chats/home/chat/utils/chat_display.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:chats/services/local_data.dart';

class live_chat extends StatefulWidget {
  final contacts_module contact;
  final chat_services chat_service;

  live_chat({
    super.key,
    required this.contact,
    required this.chat_service,
  });

  @override
  State<live_chat> createState() => _live_chatState();
}

class _live_chatState extends State<live_chat> {
  var chats;
  List<String> forward=[];

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
        var isSend = snapshot.child("type").value;
        var isimage = snapshot.child("image").value;
        String mes = isSend.toString().contains("true")
            ? widget.chat_service.mess_decrypt(
                snapshot.child("message").value.toString(),
                widget.contact.id!,
              )
            : widget.chat_service.mess_decrypt(
                snapshot.child("message").value.toString(),
                local_data.uid!,
              );
        return chat_display(
          mes: mes,
          is_send: isSend.toString().contains("true"),
          is_image: isimage.toString().contains("true"),
        );
      },
    );
  }
}
