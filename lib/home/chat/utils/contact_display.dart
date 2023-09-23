import 'package:chats/home/chat/pages/chat_page.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:flutter/material.dart';

class contacts_display extends StatelessWidget {
  final contacts_module contact;

  const contacts_display({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => chat_page(
              contact: contact,
            ),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(
            maxRadius: 30,
            backgroundImage: AssetImage("assets/avatar.jpg"),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(contact.name!),
          )
        ],
      ),
    );
  }
}
