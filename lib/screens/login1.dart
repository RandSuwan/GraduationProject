import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/screens/screen.dart';
import 'package:project1/widgets/widgets.dart';
import 'package:project1/widgets/rounded-button.dart';
import 'package:project1/ipaddress.dart';
import 'package:http/http.dart' as http;

class loginpagee extends StatefulWidget {
  @override
  State<loginpagee> createState() => _loginpageeState();
}

class _loginpageeState extends State<loginpagee> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: 'images/IRIS3.jpeg',
        ),

        //   Image.network("https://pin.it/HsuA10h0T"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Flexible(
                child: Center(
                  child: Text(
                    '',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextInputField(
                      icon: Icons.email,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      controller: emailController,
                      validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
                    ),
                    PasswordInput(
                      icon: Icons.lock,
                      hint: 'Password',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                      controller: passwordController,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, 'ForgetPassword'),
                      child: Text('Forgot Password?',
                          style: TextStyle(
                            color: Color(0xA5FFFFFF),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      buttonName: 'Login',
                      emailController: emailController,
                      passwordController: passwordController,
                      usernameController: usernameController,
                      phoneNumberController: phoneNumberController,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'CreateNewAccount'),
                child: Container(
                  child: Text('Create New Account',
                      style: TextStyle(
                        color: Color(0xA5FFFFFF),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 1, color: kWhite))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}













/* import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/screens/screen.dart';
import 'package:project1/widgets/widgets.dart';

class loginpagee extends StatefulWidget {
  const loginpagee({super.key});

  @override
  State<loginpagee> createState() => _loginpageeState();
}

class _loginpageeState extends State<loginpagee> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: 'images/IRIS2.png',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextInputField(
                    icon: Icons.email,
                    hint: 'Email',
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    controller: emailController,
                  ),
                  PasswordInput(
                    icon: Icons.lock,
                    hint: 'Password',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.done,
                    controller: passwordController,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'ForgetPassword'),
                    child: Text(
                      'Forgot Password?',
                      style: kBodyText,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                   buttonName: 'Login',
                    email: emailController.text,
                    password: passwordController.text,
                    username: usernameController.text,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'CreateNewAccount'),
                child: Container(
                  child: Text(
                    'Create New Account',
                    style: kBodyText,
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 1, color: kWhite))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}
 */