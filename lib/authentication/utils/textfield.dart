import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool pass;
  final IconData iconData;
  final TextInputType keyboardType;

  const textfield({
    super.key,
    required this.controller,
    required this.text,
    this.pass = false,
    this.keyboardType = TextInputType.name,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: pass,
      decoration: InputDecoration(
        hintText: text,
        labelText: text,
        prefixIcon: Icon(iconData),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
      ),
    );
  }
}
