import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/screens/diamond_page.dart';
import 'package:project1/screens/gold_page.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/utilities/constants.dart';

class RoundedButton1 extends StatefulWidget {
  const RoundedButton1({
    super.key,
    required this.buttonName,
  });

  final String buttonName;

  @override
  State<RoundedButton1> createState() => _RoundedButton1State();
}

class _RoundedButton1State extends State<RoundedButton1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.03,
      width: size.width * 0.5,
      decoration: BoxDecoration(
          //  borderRadius: BorderRadius.circular(16),
          // borderRadius: BorderRadius.horizontal(),

          ),
      child: ElevatedButton(
        onPressed: () async {
          if (widget.buttonName == "Diamond") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiamondScreen()),
            );
          } else if (widget.buttonName == "Gold") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GoldScreen()),
            );
          }
        },
        child: Text(
          widget.buttonName,
          style: kBodyText2.copyWith(
            // fontWeight: FontWeight.bold,
            // fontFamily: 'Cormorant_Garamond',
            fontSize: 12,
          ),
        ),
        /* style: ElevatedButton.styleFrom(
          backgroundColor: kourcolor1,
          
        ), */
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(kourcolor1),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: kourcolor1)))),
      ),
    );
  }
}
