import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

class chat_display extends StatelessWidget {
  final String mes;
  final bool is_send;

  const chat_display({
    super.key,
    required this.mes,
    required this.is_send,
  });

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: mes,
      tail: false,
      isSender: is_send,
      color: Colors.blue,
    );
  }
}
