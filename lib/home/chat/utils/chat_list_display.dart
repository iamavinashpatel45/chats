import 'package:chats/home/chat/pages/chat_page.dart';
import 'package:chats/home/chat/services/chat_services.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:chats/services/local_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class chat_list_display extends StatelessWidget {
  final DataSnapshot chat;
  final contacts_module contact;
  final chat_services _chat_service = chat_services();

  chat_list_display({
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
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
                width: 10,
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
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
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
                        SizedBox(
                          width: 250,
                          child: Text(
                            chat.children.last
                                    .child("image")
                                    .value
                                    .toString()
                                    .contains("false")
                                ? chat.children.last
                                        .child("type")
                                        .value
                                        .toString()
                                        .contains("false")
                                    ? _chat_service.mess_decrypt(
                                        chat.children.last
                                            .child("message")
                                            .value
                                            .toString(),
                                        local_data.uid!,
                                      )
                                    : _chat_service.mess_decrypt(
                                        chat.children.last
                                            .child("message")
                                            .value
                                            .toString(),
                                        contact.id!,
                                      )
                                : "📷 Photo",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
