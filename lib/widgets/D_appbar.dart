import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/search_aboutD.dart';
import 'package:project1/widgets/search_field.dart';

class D_AppBar extends StatefulWidget {
  const D_AppBar({super.key});

  @override
  State<D_AppBar> createState() => _D_AppBarState();
}

class _D_AppBarState extends State<D_AppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Color(0xA5FFFFFF),
      backgroundColor: Color(0xFFDFDED9),
      leading: IconButton(
        onPressed: () {},
        iconSize: 30,
        icon: const Icon(
          Icons.more_vert_outlined,
          color: kourcolor1,
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          iconSize: 30,
          icon: const Icon(
            Icons.wechat_outlined,
            color: kourcolor1,
          ),
        ),
        SizedBox(width: 40), // Add space here if needed
        Text(
          'Diamond',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Libre_Baskerville",
            color: kourcolor1,
          ),
        ),
        SizedBox(width: 60), // Add space here if needed
        IconButton(
          onPressed: () {},
          iconSize: 30,
          icon: const Icon(
            Icons.notifications_active,
            color: kourcolor1,
          ),
        ),
        SizedBox(width: 2), // Add space here if needed
        IconButton(
          onPressed: () {},
          iconSize: 30,
          icon: const Icon(
            Icons.shopping_cart,
            color: kourcolor1,
          ),
        ),
      ],
    );
  }
}
