import 'package:chats/authentication/pages/sign_up.dart';
import 'package:chats/home/chat/modules/contact_module.dart';
import 'package:chats/home/chat/services/contacts.dart';
import 'package:chats/home/home.dart';
import 'package:chats/local_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: myapp(),
    ),
  );
}

class myapp extends StatefulWidget {
  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  Future<void> navigation() async {
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

  @override
  void initState() {
    navigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/logo_bg_remove.png',
              width: 250,
              height: 250,
            ),
          ),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}
