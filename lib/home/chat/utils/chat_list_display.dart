import 'package:chats/home/chat/pages/chat_page.dart';
import 'package:chats/home/chat/services/contact_modul.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class chat_list_display extends StatelessWidget {
  final DataSnapshot chat;
  final contacts_modul contact;

  const chat_list_display({
    super.key,
    required this.chat,
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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              maxRadius: 30,
              backgroundImage: const AssetImage(
                "assets/avatar.jpg",
              ),
              foregroundImage: NetworkImage(
                contact.image!,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        contact.name!,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        chat.children.last.child("time").value.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat.children.last.child("message").value.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const Icon(Icons.arrow_circle_right),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
