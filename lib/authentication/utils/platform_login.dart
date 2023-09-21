import 'package:flutter/material.dart';

class platform_login extends StatelessWidget {
  final String iamgepath;
  final String text;

  const platform_login({
    super.key,
    required this.iamgepath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(iamgepath),
              fit: BoxFit.fill,
            ),
            // border: Border.all(
            //   color: Colors.black,
            //   width: 1,
            // ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color:  Color.fromRGBO(55, 65, 81, 1),
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
