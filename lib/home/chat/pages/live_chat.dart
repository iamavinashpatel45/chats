import 'package:chats/home/chat/services/contact_modul.dart';
import 'package:chats/home/chat/utils/chat_display.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:chats/local_data.dart';

class live_chat extends StatefulWidget {
  final contacts_modul contact;

  live_chat({
    super.key,
    required this.contact,
  });

  @override
  State<live_chat> createState() => _live_chatState();
}

class _live_chatState extends State<live_chat> {
  var chats;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    chats = FirebaseDatabase.instance
        .ref("chats/${local_data.uid}/${widget.contact.id}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FirebaseAnimatedList(
          controller: _scrollController,
          query: chats,
          itemBuilder: (context, snapshot, animation, index) {
            var is_send = snapshot.child("type").value;
            return chat_display(
              mes: snapshot.child("message").value.toString(),
              is_send: is_send.toString().contains("true"),
            );
          },
        ),
      ],
    );
  }
}
