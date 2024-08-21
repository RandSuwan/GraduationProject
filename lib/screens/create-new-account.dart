import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/background-image.dart';
import 'package:project1/widgets/confirm-password.dart';
import 'package:project1/widgets/password-input.dart';
import 'package:project1/widgets/rounded-button.dart';
import 'package:project1/widgets/text-field-input.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'images/IRIS3.jpeg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    // height: size.width * 0.1,
                    ),
                SizedBox(
                  height: size.width * 0.5,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextInputField(
                        icon: Icons.account_circle,
                        hint: 'User',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        controller: usernameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      TextInputField(
                        icon: Icons.email,
                        hint: 'Email',
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      TextInputField(
                        icon: Icons.phone,
                        hint: 'Phone Number',
                        inputType: TextInputType.phone,
                        inputAction: TextInputAction.next,
                        controller: phoneNumberController,
                        // validator: _validatePhoneNumber(phoneNumberController.text)
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      PasswordInput(
                          icon: Icons.lock,
                          hint: 'Password',
                          inputType: TextInputType.name,
                          inputAction: TextInputAction.next,
                          controller: passwordController,
                          validator:
                              _validatePassword(passwordController.text)),
                      ConfirmPassword(
                          icon: Icons.lock,
                          hint: 'Confirm Password',
                          inputType: TextInputType.name,
                          inputAction: TextInputAction.done,
                          controller: confirmpasswordController,
                          validator: _validateConfirmPassword(
                              confirmpasswordController.text)),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedButton(
                        buttonName: 'Register',
                        emailController: emailController,
                        passwordController: passwordController,
                        usernameController: usernameController,
                        phoneNumberController: phoneNumberController,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Color(0xA5FFFFFF),
                              fontSize: 22,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Text(
                              ' Login',
                              /* style: kBodyText.copyWith(
                                  color: kBlue, fontWeight: FontWeight.bold), */
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                fontWeight: FontWeight.bold,
                                //  color: Color.fromARGB(180, 192, 187, 187),
                                color: Color(0xA5FFFFFF),
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Regular Expression for email validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // Regular Expression for phone number validation
    // This regex checks for a sequence of 10-15 digits (which covers most international phone numbers)
    if (!RegExp(r'^\+?[\d\s]{10,15}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    // Password must be at least 8 characters
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // Password must contain at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    String? password = passwordController.text;

    if (password == null || value == null || password != value) {
      return 'Passwords do not match';
    }
    return null;
  }
}
