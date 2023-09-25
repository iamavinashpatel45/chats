import 'package:chats/home/chat/services/chat_services.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:flutter/material.dart';

class bottomsheet extends StatelessWidget {
  final contacts_module contact;
  final TextEditingController _editingController = TextEditingController();
  final chat_services chat_service;

  bottomsheet({
    super.key,
    required this.contact,
    required this.chat_service,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 130,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _editingController,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      chat_service.image_picker(contact);
                    },
                    child: const Icon(Icons.image),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              if (_editingController.text.isNotEmpty) {
                chat_service.send_message(
                    _editingController.text, contact, false);
                _editingController.text = "";
              }
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.send_sharp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
