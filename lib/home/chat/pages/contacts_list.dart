import 'package:chats/home/chat/services/contacts_services.dart';
import 'package:chats/home/chat/utils/contact_display.dart';
import 'package:chats/services/local_data.dart';
import 'package:flutter/material.dart';

class contacts_list extends StatefulWidget {
  const contacts_list({super.key});

  @override
  State<contacts_list> createState() => _contacts_listState();
}

class _contacts_listState extends State<contacts_list> {
  bool getcontacts = false;
  final contacts_service _contacts_service = contacts_service();

  void _get_contacts() async {
    if (await _contacts_service.get_contacts()) {
      setState(() {
        getcontacts = true;
      });
    }
  }

  @override
  void initState() {
    _get_contacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contact"),
      ),
      body: getcontacts
          ? ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    contacts_display(
                      contact:LocalData.contact[index],
                    ),
                  ],
                );
              },
              itemCount: LocalData.contact.length,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
