import 'package:chats/services/local_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chats/authentication/pages/sign_up.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:chats/home/chat/services/contacts_services.dart';
import 'package:chats/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class main_services {
  Future set_online(String uid) async {
    await FirebaseDatabase.instance
        .ref("online-status/$uid")
        .set({"online": true, "lastseen": ""});
  }

  Future set_offine(String uid) async {
    await FirebaseDatabase.instance.ref("online-status/$uid").set({
      "online": false,
      "lastseen": "${DateTime.now().hour}:${DateTime.now().minute}"
    });
  }

  void navigation(BuildContext context) async {
    if (await InternetConnectionChecker().hasConnection) {
      if (await Permission.contacts.request().isGranted) {
        final contacts_service _contacts_service = contacts_service();
        await _contacts_service.get_contacts();
      }
      if (FirebaseAuth.instance.currentUser == null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const sign_up(),
          ),
          (route) => false,
        );
      } else {
        final get = GetStorage();
        local_data.name = get.read("name");
        local_data.uid = get.read("uid");
        local_data.num = get.read("num");
        local_data.image = get.read("image");
        await set_online(local_data.uid!);
        //ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const home_page(),
          ),
          (route) => false,
        );
      }
    } else {
      final get = GetStorage();
      List contact_list = get.read("contact");
      for (int i = 0; i < contact_list.length; i++) {
        local_data.contact.add(contacts_module.fromJson(contact_list[i]));
      }
      local_data.contact = get.read("contact");
    }
  }
}
