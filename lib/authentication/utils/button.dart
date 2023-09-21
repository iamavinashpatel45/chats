import 'package:chats/authentication/services/auth_services.dart';
import 'package:flutter/material.dart';

class auth_button extends StatelessWidget {
  final String text;
  final Widget widget;
  final TextEditingController otpTextEditingController;
  final TextEditingController numTextEditingController;
  final TextEditingController nameTextEditingController;
  final auth_service service;

  auth_button({
    super.key,
    required this.text,
    required this.widget,
    required this.otpTextEditingController,
    required this.numTextEditingController,
    required this.nameTextEditingController,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (service.otp_send)
          {
            service.fun_otp_verify(
              context,
              numTextEditingController.text,
              otpTextEditingController.text,
              nameTextEditingController.text,
              widget,
            ),
          }
        else
          {
            service.fun_otp_send(
              numTextEditingController.text,
            ),
          }
      },
      child: Container(
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
      ),
    );
  }
}
