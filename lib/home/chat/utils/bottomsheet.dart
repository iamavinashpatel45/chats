import 'package:chats/home/chat/services/chat.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:flutter/material.dart';

class bottomsheet extends StatelessWidget {
  final contacts_module contact;
  final TextEditingController _editingController = TextEditingController();
  final chat_services _chat_services = chat_services();

  bottomsheet({
    super.key,
    required this.contact,
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
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              if (_editingController.text.isNotEmpty) {
                _chat_services.send_message(_editingController.text,contact);
                _editingController.text="";
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
