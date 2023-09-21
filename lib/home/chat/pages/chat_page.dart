import 'package:chats/home/chat/pages/live_chat.dart';
import 'package:chats/home/chat/services/contact_modul.dart';
import 'package:chats/home/chat/utils/bottomsheet.dart';
import 'package:flutter/material.dart';

class chat_page extends StatefulWidget {
  final contacts_modul contact;

  const chat_page({
    super.key,
    required this.contact,
  });

  @override
  State<chat_page> createState() => _chat_pageState();
}

class _chat_pageState extends State<chat_page> {
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
            Text(widget.contact.name!),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: live_chat(
          contact: widget.contact,
        ),
      ),
      bottomSheet: bottomsheet(
        contact: widget.contact,
      ),
    );
  }
}
