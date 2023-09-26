import 'package:chats/home/account/services/account_service.dart';
import 'package:flutter/material.dart';

class account_button extends StatelessWidget {
  final String text;

  const account_button({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(196, 211, 225, 1),
      ),
      width: 150,
      height: 50,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Color.fromRGBO(19, 105, 242, 1),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
