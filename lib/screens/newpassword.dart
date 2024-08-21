import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/background-image.dart';
import 'package:project1/widgets/confirm-password.dart';
import 'package:project1/widgets/password-input.dart';
import 'package:project1/widgets/rounded-button.dart';
import 'package:project1/widgets/text-field-input.dart';

class newpassword extends StatefulWidget {
  const newpassword({super.key});

  @override
  State<newpassword> createState() => _newpasswordState();
}

class _newpasswordState extends State<newpassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // BackgroundImage(image: 'images/IRIS3.jpeg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(187, 22, 21, 21),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xA5FFFFFF),
              ),
            ),
            title: Text('Create New Password',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xA5FFFFFF),
                )),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      width: size.width * 0.8,
                      child: Text(
                          'Your New Password Must Be Different From Previously Used Password.',
                          style: TextStyle(
                            color: Color(0xA5FFFFFF),
                            fontSize: 22,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PasswordInput(
                      icon: Icons.lock,
                      hint: 'Password',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controller: passwordController,
                    ),
                    ConfirmPassword(
                      icon: Icons.lock,
                      hint: 'Confirm Password',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                      controller: confirmpasswordController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      buttonName: 'Save',
                      emailController: emailController,
                      passwordController: passwordController,
                      usernameController: usernameController,
                      phoneNumberController: phoneNumberController,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
