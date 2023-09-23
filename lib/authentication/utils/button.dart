import 'package:chats/authentication/services/auth_services.dart';
import 'package:flutter/material.dart';

class auth_button extends StatefulWidget {
  final Widget widget;
  final TextEditingController otpTextEditingController;
  final TextEditingController numTextEditingController;
  final TextEditingController nameTextEditingController;
  final auth_service service;

  const auth_button({
    super.key,
    required this.widget,
    required this.otpTextEditingController,
    required this.numTextEditingController,
    required this.nameTextEditingController,
    required this.service,
  });

  @override
  State<auth_button> createState() => _auth_buttonState();
}

class _auth_buttonState extends State<auth_button> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        setState(() {
          _loading = true;
        }),
        if (widget.service.otp_send)
          {
            widget.service.fun_otp_verify(
              context,
              widget.numTextEditingController.text,
              widget.otpTextEditingController.text,
              widget.nameTextEditingController.text,
              widget.widget,
            ),
          }
        else
          {
            widget.service.fun_otp_send(
              widget.numTextEditingController.text,
            ),
          },
        setState(() {
          _loading = false;
        }),
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(196, 211, 225, 1),
        ),
        width: 150,
        height: 50,
        child: Center(
          child: _loading
              ? const CircularProgressIndicator()
              : Text(
                  widget.service.otp_send ? "Log In" : "Send OTP",
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
