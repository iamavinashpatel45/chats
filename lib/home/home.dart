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
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_box,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Account"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Log Out"),
                      ],
                    ),
                  ),
                ];
              },
              onSelected: (value) async {
                if (value == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => account(),
                    ),
                  );
                } else {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const sign_up(),
                    ),
                    //(route) => false,
                  );
                }
              },
            ),
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
