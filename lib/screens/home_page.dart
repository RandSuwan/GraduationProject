import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project1/models/product.dart';
import 'package:project1/screens/diamond_page.dart';
import 'package:project1/screens/gold_page.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/categories.dart';
import 'package:project1/widgets/home_appbar.dart';
import 'package:project1/widgets/home_slider.dart';
import 'package:project1/widgets/product_card.dart';
import 'package:project1/widgets/rounded-button1.dart';
import 'package:project1/widgets/search_field.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kourcolor1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Color(0xFFDFDED9)),
              ),
              height: kIsWeb ? 380 : 450,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiamondScreen()),
                  );
                },
                child: ClipOval(
                  child: Ink.image(
                    image: AssetImage("images/ds.jpg"),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Color(0xFFDFDED9)),
              ),
              height: kIsWeb ? 380 : 393,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GoldScreen()),
                  );
                },
                child: ClipOval(
                  child: Ink.image(
                    image: AssetImage("images/gs.jpg"),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
