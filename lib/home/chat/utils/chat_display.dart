import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

class chat_display extends StatelessWidget {
  final String mes;
  final bool is_send;
  final bool is_image;

  const chat_display({
    super.key,
    required this.mes,
    required this.is_send,
    required this.is_image,
  });

  @override
  Widget build(BuildContext context) {
    return is_image
        ? BubbleNormalImage(
            id: "1",
            isSender: is_send,
            image: FadeInImage.assetNetwork(
              placeholder: "assets/image_loading.gif",
              image: mes,
            ),
          )
        : BubbleSpecialThree(
            text: mes,
            tail: false,
            isSender: is_send,
            color: Colors.blue,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          );
  }
}
