import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput(
      {super.key,
      required this.icon,
      required this.hint,
      required this.inputType,
      required this.inputAction,
      required this.controller,
      String? validator,});

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    bool _obsecureText = true;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          // color: kcontentColor?.withOpacity(0.5) ?? kcontentColor,
          //color: Colors.grey[500].withOpacity(0.5),
          color: Color(0xA5FFFFFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          obscureText: _obsecureText,
          controller: widget.controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                widget.icon,
                size: 28,
                color: kourcolor1,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obsecureText = !_obsecureText;
                });
              },
              icon: Icon(
                _obsecureText ? Icons.visibility_off : Icons.visibility,
              ),

              /*  icon: Icon(_obsecureText
                        ? Icons.visibility
                        // ignore: dead_code
                        : Icons.visibility_off ), */
            ),
            hintText: widget.hint,
            hintStyle: kBodyText3,
          ),
          style: kBodyText,
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
        ),
      ),
    );
  }
}
