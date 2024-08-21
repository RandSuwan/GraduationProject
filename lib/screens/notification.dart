import 'package:flutter/material.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/profile.dart';
import 'package:project1/screens/wishlist.dart';
import 'package:project1/utilities/constants.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  List notificationArr = [
    {
      "title": "Your orders has been picked up",
      "time": "Now",
    },
    {
      "title": "Your order has been delivered",
      "time": "1 h ago",
    },
  ];
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    MainScreen(),
  ];
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
            MaterialPageRoute(
                builder: (context) => wishlist(
                      isDiamond: true,
                    )),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => profile()),
          );
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
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            size: 30,
            Icons.arrow_back_ios,
            color: kourcolor1,
          ),
        ),
        actions: <Widget>[
          SizedBox(width: 25), // Add space here if needed
          Text(
            '       Notifications       ',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              // fontFamily: "Libre_Baskerville",
              color: kourcolor1,
            ),
          ),
          SizedBox(width: 10), // Add space here if needed
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
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: notificationArr.length,
                separatorBuilder: ((context, index) => Divider(
                      indent: 25,
                      endIndent: 25,
                      color: Colors.grey.withOpacity(0.4),
                      height: 1,
                    )),
                itemBuilder: ((context, index) {
                  var cObj = notificationArr[index] as Map? ?? {};
                  return Container(
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.white
                            : const Color.fromARGB(255, 222, 214, 214)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color: kourcolor1,
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cObj["title"].toString(),
                                style: TextStyle(
                                    color: kourcolor1,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                cObj["time"].toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
