import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:project1/AdminScreens/addD&Gitem.dart';
import 'package:project1/AdminScreens/addgemstone.dart';
import 'package:project1/AdminScreens/addDiamonditem.dart';
import 'package:project1/AdminScreens/admin_page.dart';
import 'package:project1/AdminScreens/chatAllUsers.dart';
import 'package:project1/AdminScreens/goldprice.dart';
import 'package:project1/AdminScreens/homepage.dart';
import 'package:project1/AdminScreens/search.dart';
import 'package:project1/screens/chat.dart';
import 'package:project1/screens/login1.dart';
import 'package:project1/utilities/constants.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home Page',
          baseStyle: TextStyle(
              color: Color(0xFFffffff),
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
          selectedStyle: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18.0),
          colorLineSelected: Colors.grey,
        ),
        homepage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Search',
          baseStyle: TextStyle(
              color: Color(0xFFffffff),
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
          selectedStyle: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18.0),
          colorLineSelected: Colors.grey,
        ),
        Search(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Add Item',
          baseStyle: TextStyle(
              color: Color(0xFFffffff),
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
          selectedStyle: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18.0),
          colorLineSelected: Colors.grey,
        ),
        addDGitem(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Add today\'s gold price',
          baseStyle: TextStyle(
              color: Color(0xFFffffff),
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
          selectedStyle: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18.0),
          colorLineSelected: Colors.grey,
        ),
        AddGoldPrice(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Add New Gemstone',
          baseStyle: TextStyle(
              color: Color(0xFFffffff),
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
          selectedStyle: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18.0),
          colorLineSelected: Colors.grey,
        ),
        addgemstone(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HiddenDrawerMenu(
        backgroundColorMenu: kourcolor1,
        screens: _pages,
        initPositionSelected: 0,
        tittleAppBar: Center(
          child: Text(
            "I R I S",
            style: TextStyle(
                color: kourcolor1, fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
        ),
        actionsAppBar: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatAllUsers()),
              );
            },
            icon: Icon(Icons.wechat, size: 30, color: kourcolor1),
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: kourcolor1,
            ),
            onPressed: _logout,
          ),
        ],
      ),
    );
  }

  void _logout() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => loginpagee(),
    ));
  }
}
