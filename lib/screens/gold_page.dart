import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/models/product.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/chat.dart';
import 'package:project1/screens/design_ring.dart';
import 'package:project1/screens/gold_items.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/notification.dart';
import 'package:project1/screens/profile.dart';
import 'package:project1/screens/wishlist.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/D_appbar.dart';
import 'package:project1/widgets/G_appbar.dart';
import 'package:project1/widgets/background-image.dart';
import 'package:project1/widgets/diamondCategories.dart';
import 'package:project1/widgets/goldCategories.dart';
import 'package:project1/widgets/navigation_drawer_widget.dart';
import 'package:project1/widgets/product_card.dart';
import 'package:project1/widgets/search_aboutD.dart';
import 'package:project1/widgets/search_aboutG.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

void sendGoldPrices(List<GoldPrice> goldPrices) async {
  final ipAddress = await getLocalIPv4Address();
  final url = Uri.parse('http://$ipAddress:5000/update-prices');
  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(
        {'goldPrices': goldPrices.map((gp) => gp.toJson()).toList()}),
  );

  if (response.statusCode == 200) {
    print('Prices updated successfully');
  } else {
    print('Failed to update prices');
  }
}

class GoldScreen extends StatefulWidget {
  const GoldScreen({super.key});

  @override
  State<GoldScreen> createState() => _GoldScreenState();
}

class _GoldScreenState extends State<GoldScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendGoldPrices(goldPrices);
  }

  List<String> assets = [
    'images/gna.png',
    'images/gbs.png',
  ];
  final color = [
    Color(0xA5FFFFFF),
    Color(0xA5FFFFFF),
  ];
  int currentindex = 0;
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
          // Handle shopping cart icon tap
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

  void _onImageTap(int index) {
    switch (index) {
      case 0: //new arrivals
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GoldItem(
                      category: "Ring",
                      title: kIsWeb
                          ? "New Arrivals                                                       "
                          : '      New Arrivals  ',
                      sort: 'new',
                    )));
        break;
      case 1: //best sellers
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GoldItem(
                      category: "Ring",
                      title: kIsWeb
                          ? "Best Sellers                                                       "
                          : '        Best Sellers    ',
                      sort: 'best',
                    )));
        break;
      case 2: //discounts
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Discounts()));
        break;
      default:
        break;
    }
  }

  List<GoldPrice> goldPrices = [
    GoldPrice(karat: "24K", price: "\$50.00"),
    GoldPrice(karat: "22K", price: "\$45.00"),
    GoldPrice(karat: "18K", price: "\$40.00"),
    GoldPrice(karat: "14K", price: "\$35.00"),
  ];

  @override
  Widget build(BuildContext context) {
    double iconSize = kIsWeb ? 40 : 30;
    double fontSize = kIsWeb ? 30 : 25;
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
                icon: Icon(color: kourcolor1, Icons.favorite),
                label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(color: kourcolor1, Icons.account_box),
                label: 'Account'),
          ],
        ),
        drawer: NavigationDrawerWidget(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: Color(0xFFEBEBE7),
            flexibleSpace: Stack(
              children: [
                if (kIsWeb)
                  Center(
                    child: Text(
                      'Gold',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: kourcolor1,
                      ),
                    ),
                  ),
              ],
            ),
            actions: [
              if (kIsWeb) ...[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Chat(
                                isAdmin: false,
                                userId: "",
                              )),
                    );
                  },
                  iconSize: iconSize,
                  icon: const Icon(
                    Icons.wechat_outlined,
                    color: kourcolor1,
                  ),
                ),
                SizedBox(width: 2),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => notification()),
                    );
                  },
                  iconSize: iconSize,
                  icon: const Icon(
                    Icons.notifications_active,
                    color: kourcolor1,
                  ),
                ),
                SizedBox(width: 2),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cart()),
                    );
                  },
                  iconSize: iconSize,
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: kourcolor1,
                  ),
                ),
                SizedBox(width: 20),
              ] else ...[
                SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Chat(
                                isAdmin: false,
                                userId: "",
                              )),
                    );
                  },
                  iconSize: iconSize,
                  icon: const Icon(
                    Icons.wechat_outlined,
                    color: kourcolor1,
                  ),
                ),
                SizedBox(width: 90),
                Text(
                  'Gold   ',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: kourcolor1,
                  ),
                ),
                SizedBox(width: 60),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => notification()),
                    );
                  },
                  iconSize: iconSize,
                  icon: const Icon(
                    Icons.notifications_active,
                    color: kourcolor1,
                  ),
                ),
                SizedBox(width: 2),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cart()),
                    );
                  },
                  iconSize: iconSize,
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: kourcolor1,
                  ),
                ),
              ],
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: kIsWeb ? 500 : 250,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: assets.length,
                  physics: BouncingScrollPhysics(),
                  controller:
                      PageController(initialPage: 0, viewportFraction: 0.9),
                  onPageChanged: (value) {
                    currentindex = value;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => _onImageTap(index),
                      child: Container(
                          margin: const EdgeInsets.all(8),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Image.asset(
                            assets[index],
                            fit: BoxFit.cover,
                          )),
                    );
                  },
                ),
              ),
              TabPageSelector(
                controller: TabController(
                    length: assets.length,
                    initialIndex: currentindex,
                    vsync: this),
                selectedColor: kourcolor1,
                color: Color(0xA5FFFFFF),
                borderStyle: BorderStyle.none,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kourcolor1,
                  ),
                ),
              ),
              kIsWeb
                  ? Center(child: DCategories())
                  : Container(
                      alignment: Alignment.centerLeft,
                      child: GCategories(),
                    ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Gold Karats & Prices',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kourcolor1,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Table(
                  border: TableBorder.all(
                    color: kourcolor1,
                    width: 1.5,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Color(0xFFD3D3D3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Karat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: kourcolor1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Price',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: kourcolor1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    for (var goldPrice in goldPrices)
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              goldPrice.karat,
                              style: TextStyle(
                                fontSize: 15,
                                color: kourcolor1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              goldPrice.price,
                              style: TextStyle(
                                fontSize: 15,
                                color: kourcolor1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }
}

class GoldPrice {
  final String karat;
  final String price;

  GoldPrice({required this.karat, required this.price});

  Map<String, dynamic> toJson() => {
        'karat': karat,
        'price': price.replaceAll('\$', ''), // Remove the dollar sign
      };
}
