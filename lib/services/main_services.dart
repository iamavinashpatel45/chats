import 'package:chats/authentication/pages/sign_up.dart';
import 'package:chats/services/local_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:chats/home/chat/services/contacts_services.dart';
import 'package:chats/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainServices {
  Future setOnline(String uid) async {
    await FirebaseDatabase.instance
        .ref("online-status/$uid")
        .set({"online": true, "lastseen": ""});
  }

  Future setOffine(String uid) async {
    await FirebaseDatabase.instance.ref("online-status/$uid").set({
      "online": false,
      "lastseen": "${DateTime.now().hour}:${DateTime.now().minute}"
    });
  }

  void navigation(BuildContext context) async {
    if (await InternetConnectionChecker().hasConnection) {
      if (await Permission.contacts.request().isGranted) {
        final contacts_service contactsService = contacts_service();
        await contactsService.get_contacts();
      }
      if (FirebaseAuth.instance.currentUser == null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUp(),
          ),
          (route) => false,
        );
      } else {
        final get = GetStorage();
        LocalData.name = get.read("name");
        LocalData.uid = get.read("uid");
        LocalData.num = get.read("num");
        LocalData.image = get.read("image");
        await setOnline(LocalData.uid!);
        //ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
      }
    } else {
      final get = GetStorage();
      List contactList = get.read("contact");
      for (int i = 0; i < contactList.length; i++) {
        LocalData.contact.add(contacts_module.fromJson(contactList[i]));
      }
      LocalData.contact = get.read("contact");
    }
  }
}
