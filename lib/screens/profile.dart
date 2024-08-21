import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/main.dart';
import 'package:project1/models/ShippingInfo.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/editprofile.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/login1.dart';
import 'package:project1/screens/order_review.dart';
import 'package:project1/screens/shipping_info.dart';
import 'package:project1/screens/wishlist.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/UserPreferences.dart';
import 'package:project1/widgets/navigation_drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  late final ShippingInfo shipping;

  @override
  void initState() {
    super.initState();
    _initializeShipping();
  }

  void _initializeShipping() async {
    String? email = await UserPreferences.getEmail();
    if (email != null) {
      String userId = await UserPreferences.getUserIdByEmail(email);
      try {
        ShippingInfo fetchedShipping = await fetchShippingInfo(userId);
        if (mounted) {
          setState(() {
            shipping = fetchedShipping;
          });
        }
      } catch (e) {
        // Handle error, possibly show a message to the user
        print('Failed to fetch shipping info: $e');
      }
    } else {
      // Handle case when email is null, perhaps navigate to login or show an error
    }
  }

  Future<ShippingInfo> fetchShippingInfo(String userId) async {
    final ipAddress =
        await getLocalIPv4Address(); // Implement this method to get the local IP address
    final url = 'http://$ipAddress:5000/getShippingInfo/$userId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return ShippingInfo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load shipping information');
    }
  }

  void _deleteaccount() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFFDFDED9),
            title: Text("Are you sure to delete your account?"),
            //content: Text("Please Try Again"),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("Delete"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }

  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => wishlist(isDiamond: true)),
          );
          break;
        case 3:
          // Handle account icon tap
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(color: kourcolor1, Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(color: kourcolor1, Icons.add_shopping_cart),
              label: 'Shop Now'),
          BottomNavigationBarItem(
              icon: Icon(color: kourcolor1, Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(color: kourcolor1, Icons.account_box),
              label: 'Account'),
        ],
      ),
      appBar: AppBar(
          title: Text(
            'My Account',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: kourcolor1,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            SizedBox(width: 2),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cart()),
                );
              },
              iconSize: 30,
              icon: const Icon(
                Icons.shopping_cart,
                color: kourcolor1,
              ),
            ),
          ]),
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 5,
              color: Color(0xDDF1EBEB),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                Text(
                  'I R I S',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: kourcolor1,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '    Hello ${UserPreferences.getUserName()}\nEmail: ${UserPreferences.getEmail()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kourcolor1,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0xDDF1EBEB),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderReviewPage(
                                    shipping: shipping,
                                  )),
                        );
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('  MY ORDERS    ',
                                  style: TextStyle(
                                    color: kourcolor1,
                                    fontSize: 20,
                                  )),
                              Icon(
                                Icons.chevron_right,
                                size: 30,
                              )
                            ]),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0xDDF1EBEB),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => wishlist(
                                  isDiamond:
                                      true)), // Navigate to ProfileDetailsPage
                        );
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('  MY FAVORITES    ',
                                  style: TextStyle(
                                    color: kourcolor1,
                                    fontSize: 20,
                                  )),
                              Icon(
                                Icons.chevron_right,
                                size: 30,
                              )
                            ]),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0xDDF1EBEB),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileDetailsPage()), // Navigate to ProfileDetailsPage
                        );
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('  PROFILE    ',
                                  style: TextStyle(
                                    color: kourcolor1,
                                    fontSize: 20,
                                  )),
                              Icon(
                                Icons.chevron_right,
                                size: 30,
                              )
                            ]),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0xDDF1EBEB),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _deleteaccount();
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('  ACCOUNT DELETION    ',
                                  style: TextStyle(
                                    color: kourcolor1,
                                    fontSize: 20,
                                  )),
                              Icon(
                                Icons.chevron_right,
                                size: 30,
                              )
                            ]),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0xDDF1EBEB),
                ),
              ],
            ),
            SizedBox(
              height: kIsWeb ? 70 : 180,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => loginpagee(),
                ));
              },
              child: Text(
                'SIGN OUT',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kourcolor1,
                shape: RoundedRectangleBorder(),
                minimumSize: Size(380, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
