import 'package:chats/authentication/services/auth_services.dart';
import 'package:chats/authentication/utils/button.dart';
import 'package:chats/authentication/utils/platform_login.dart';
import 'package:chats/authentication/utils/textfield.dart';
import 'package:chats/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  final auth_service _auth_service = auth_service();
  final TextEditingController _numTextEditingController =
      TextEditingController();
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _otpTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Image(
                image: AssetImage(
                  "assets/logo_bg_remove.png",
                ),
                width: 200,
                height: 250,
              ),
              // textfield(
              //   controller: _emailTextEditingController,
              //   text: "Email",
              //   keyboardType: TextInputType.emailAddress,
              //   iconData: Icons.email_rounded,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              textfield(
                controller: _numTextEditingController,
                text: "Number",
                keyboardType: TextInputType.phone,
                iconData: Icons.phone,
              ),
              const SizedBox(
                height: 20,
              ),
              textfield(
                controller: _nameTextEditingController,
                text: "Name",
                iconData: Icons.person_2_rounded,
              ),
              const SizedBox(
                height: 20,
              ),
              OtpTextField(
                fieldWidth: 50,
                hasCustomInputDecoration: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
                numberOfFields: 6,
                onCodeChanged: (String otp) {
                  _otpTextEditingController.text =
                      _otpTextEditingController.text + otp;
                },
                keyboardType: TextInputType.number,
              ),
              // textfield(
              //   controller: _passTextEditingController,
              //   text: "Password",
              //   pass: true,
              //   iconData: Icons.security,
              // ),
              const SizedBox(
                height: 20,
              ),
              auth_button(
                widget: const home_page(),
                otpTextEditingController: _otpTextEditingController,
                numTextEditingController: _numTextEditingController,
                nameTextEditingController: _nameTextEditingController,
                service: _auth_service,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  platform_login(
                    iamgepath: "assets/login_logos/google.png",
                    text: "Google",
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  platform_login(
                    iamgepath: "assets/login_logos/fb.png",
                    text: "Facebook",
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  platform_login(
                    iamgepath: "assets/login_logos/twitter.png",
                    text: "Twitter",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
