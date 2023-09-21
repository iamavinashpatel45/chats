import 'package:chats/home/chat/pages/contacts_list.dart';
import 'package:chats/home/chat/services/contact_modul.dart';
import 'package:chats/home/chat/utils/chat_list_display.dart';
import 'package:chats/local_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class chat_list extends StatefulWidget {
  const chat_list({super.key});

  @override
  State<chat_list> createState() => _chat_listState();
}

class _chat_listState extends State<chat_list> {
  final chats = FirebaseDatabase.instance.ref("chats/${local_data.uid}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const contacts_list(),
            ),
          );
        },
        child: const Icon(Icons.chat),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: FirebaseAnimatedList(
            query: chats,
            defaultChild: const Center(
              child: CircularProgressIndicator(),
            ),
            itemBuilder: (context, snapshot, animation, index) {
              contacts_modul contacts = local_data.contact[0];
              for (var element in local_data.contact) {
                if (snapshot.key == element.id) {
                  contacts = element;
                  break;
                }
              }
              return chat_list_display(
                chat: snapshot,
                contact: contacts,
              );
            }),
      ),
    );
  }
}