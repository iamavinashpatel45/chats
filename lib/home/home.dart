import 'package:chats/authentication/pages/sign_up.dart';
import 'package:chats/home/account/pages/account.dart';
import 'package:chats/home/chat/pages/chat_list.dart';
import 'package:chats/home/status/pages/status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Column(
            children: [
              Text(
                "Ch@ts",
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Chats",
              ),
              Tab(
                text: "Status",
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => account(),
                  ),
                );
              },
              child: const Icon(Icons.account_box),
            ),
            const SizedBox(
              width: 50,
            ),
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const sign_up(),
                  ),
                  (route) => false,
                );
              },
              child: const Icon(Icons.logout),
            ),
            const SizedBox(
              width: 50,
            )
          ],
        ),
        body: const TabBarView(
          children: [
            chat_list(),
            status_page(),
          ],
        ),
      ),
    );
  }
}
