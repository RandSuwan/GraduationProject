import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/search_aboutD.dart';
import 'package:project1/widgets/search_aboutG.dart';
import 'package:project1/widgets/search_field.dart';

class G_AppBar extends StatefulWidget {
  const G_AppBar({super.key});

  @override
  State<G_AppBar> createState() => _G_AppBarState();
}

class _G_AppBarState extends State<G_AppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Color(0xFFDFDED9),
      backgroundColor: Colors.white,
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
        SizedBox(width: 90), // Add space here if needed
        Text(
          'Gold',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: kourcolor1,
          ),
        ),
        SizedBox(width: 80), // Add space here if needed
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
