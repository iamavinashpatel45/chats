import 'dart:io';
import 'package:chats/home/account/services/account_service.dart';
import 'package:chats/home/account/utils/button.dart';
import 'package:chats/local_data.dart';
import 'package:flutter/material.dart';


class account extends StatefulWidget {
  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  bool _isimageload = false;
  final account_service _account_service = account_service();

  void _getimage() async {
    await _account_service.pick_image();
    setState(() {
      _isimageload = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Center(
                  child: !_isimageload
                      ? local_data.image!.isEmpty
                          ? const CircleAvatar(
                              radius: 100,
                              foregroundImage: AssetImage("assets/avatar.jpg"),
                            )
                          : CircleAvatar(
                              radius: 100,
                              foregroundImage: NetworkImage(local_data.image!),
                            )
                      : CircleAvatar(
                          foregroundImage: FileImage(
                            File(
                              _account_service.images![0].path,
                            ),
                          ),
                          radius: 100,
                        ),
                ),
                Positioned(
                  right: 120,
                  top: 130,
                  child: InkWell(
                    onTap: () {
                      _getimage();
                    },
                    child: const CircleAvatar(
                      child: Icon(
                        Icons.camera_alt_rounded,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _isimageload
                ? account_button(
                    text: "Update",
                    service: _account_service,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
