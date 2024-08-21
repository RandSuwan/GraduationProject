import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/background-image.dart';
import 'package:project1/widgets/rounded-button.dart';
import 'package:project1/widgets/text-field-input.dart';

class verifyemail extends StatefulWidget {
  const verifyemail({super.key});

  @override
  State<verifyemail> createState() => _verifyemailState();
}

class _verifyemailState extends State<verifyemail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
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
            title: Text('Verify Your Email',
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
                      height: size.height * 0.1,
                    ),
                    Container(
                      width: size.width * 0.8,
                      child: Text(
                          'Please Enter The 4 Digit Code Sent To Your Email.',
                          style: TextStyle(
                            color: Color(0xA5FFFFFF),
                            fontSize: 22,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Verification Code',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      buttonName: 'Verify',
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
