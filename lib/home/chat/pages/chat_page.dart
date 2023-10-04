import 'package:chats/home/chat/pages/live_chat.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:chats/home/chat/services/chat_services.dart';
import 'package:chats/home/chat/utils/bottomsheet.dart';
import 'package:chats/home/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class chat_page extends StatefulWidget {
  final contacts_module contact;

  const chat_page({
    super.key,
    required this.contact,
  });

  @override
  State<chat_page> createState() => _chat_pageState();
}

class _chat_pageState extends State<chat_page> {
  bool _isonline = false;
  bool _isload = false;
  String _lastseen = "";
  final chat_services _chat_service = chat_services();

  void _set_sataus(DataSnapshot dataSnapshot) {
    _isonline = dataSnapshot.child("online").value.toString().contains("true");
    _lastseen = dataSnapshot.child("lastseen").value.toString();
    setState(() {
      _isload = true;
    });
  }

  @override
  void initState() {
    FirebaseDatabase.instance
        .ref("online-status/${widget.contact.id}")
        .onValue
        .listen((event) {
      _set_sataus(event.snapshot);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 20,
              backgroundImage: const AssetImage(
                "assets/avatar.jpg",
              ),
              foregroundImage: NetworkImage(
                widget.contact.image!,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.contact.name!),
                _isload
                    ? Text(
                        _isonline ? "Online" : "lastseen: $_lastseen",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: live_chat(
          contact: widget.contact,
          chat_service: _chat_service,
        ),
      ),
      bottomSheet: bottomsheet(
        contact: widget.contact,
        chat_service: _chat_service,
      ),
    );
  }
}
