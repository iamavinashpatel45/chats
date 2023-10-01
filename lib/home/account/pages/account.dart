import 'dart:io';
import 'package:chats/home/account/services/account_service.dart';
import 'package:chats/home/account/utils/button.dart';
import 'package:chats/services/local_data.dart';
import 'package:flutter/material.dart';

class account extends StatefulWidget {
  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  bool _isimageload = false;
  bool _isupdate = false;
  final accountService _accountService = accountService();

  void _getimage() async {
    await _accountService.pickImage();
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
                      ? LocalData.image!.isEmpty
                          ? const CircleAvatar(
                              radius: 100,
                              foregroundImage: AssetImage("assets/avatar.jpg"),
                            )
                          : CircleAvatar(
                              radius: 100,
                              foregroundImage: NetworkImage(LocalData.image!),
                            )
                      : CircleAvatar(
                          foregroundImage: FileImage(
                            File(
                              _accountService.images![0].path,
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
                ? _isupdate
                    ? const CircularProgressIndicator(
                      color: Colors.blue,
                    )
                    : InkWell(
                        onTap: () {
                          _accountService.updateImage(context);
                          setState(() {
                            _isupdate = true;
                          });
                        },
                        child: const accountButton(
                          text: "Update",
                        ),
                      )
                : Container(),
          ],
        ),
      ),
    );
  }
}
