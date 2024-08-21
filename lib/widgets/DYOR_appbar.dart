import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/search_aboutD.dart';
import 'package:project1/widgets/search_field.dart';

class DYOR_AppBar extends StatefulWidget {
  const DYOR_AppBar({super.key});

  @override
  State<DYOR_AppBar> createState() => _DYOR_AppBarState();
}

class _DYOR_AppBarState extends State<DYOR_AppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Color(0xA5FFFFFF),
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        iconSize: 35,
        icon: const Icon(
          Icons.more_vert_outlined,
          color: kourcolor1,
        ),
      ),
      actions: <Widget>[
        /* IconButton(
          onPressed: () {},
          iconSize: 25,
          icon: const Icon(
            Icons.wechat_outlined,
            color: kourcolor1,
          ),
        ), */
        SizedBox(width: 30), // Add space here if needed
        Text(
          'IRIS          ',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontFamily: "Libre_Baskerville",
            color: kourcolor1,
          ),
        ),
        SizedBox(width: 10), // Add space here if needed
        IconButton(
          onPressed: () {},
          iconSize: 35,
          icon: const Icon(
            Icons.notifications_active,
            color: kourcolor1,
          ),
        ),
        // SizedBox(width: 5), // Add space here if needed
        /* IconButton(
          onPressed: () {},
          iconSize: 25,
          icon: const Icon(
            Icons.shopping_cart,
            color: kourcolor1,
          ),
        ), */
      ],
    );
  }
}
