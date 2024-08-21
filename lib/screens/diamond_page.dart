import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/product.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/chat.dart';
import 'package:project1/screens/design_ring.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/newarrivals.dart';
import 'package:project1/screens/notification.dart';
import 'package:project1/screens/profile.dart';
import 'package:project1/screens/ring_page.dart';
import 'package:project1/screens/suitable_diamond.dart';
import 'package:project1/screens/wishlist.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/D_appbar.dart';
import 'package:project1/widgets/diamondCategories.dart';
import 'package:project1/widgets/navigation_drawer_widget.dart';
import 'package:project1/widgets/product_card.dart';
import 'package:project1/widgets/search_aboutD.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DiamondScreen extends StatefulWidget {
  const DiamondScreen({super.key});

  @override
  State<DiamondScreen> createState() => _DiamondScreenState();
}

class _DiamondScreenState extends State<DiamondScreen>
    with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();

  List<String> assets = [
    'images/na2.jpg',
    'images/bs.jpg',
   // 'images/dis.jpg',
  ];
  final color = [
    Color(0xA5FFFFFF),
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
              builder: (context) => RingPage(
                  category: "Ring",
                  title: kIsWeb
                      ? "New Arrivals                                                       "
                      : "New Arrivals     ",
                      sort: "new",)),
        );
        break;
      case 1: //best sellers
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RingPage(
                  category: "Ring",
                  title: kIsWeb
                      ? "Best Sellers                                                       "
                      : "Best Sellers     ",
                      sort: "best",)),
        );
        break;
      case 2: //discounts

        break;
      default:
        break;
    }
  }

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
            icon: Icon(color: kourcolor1, Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(color: kourcolor1, Icons.add_shopping_cart),
            label: 'Shop Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(color: kourcolor1, Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(color: kourcolor1, Icons.account_box),
            label: 'Account',
          ),
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
                    'Diamond',
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Chat(isAdmin: false, userId: "",),
                  ));
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Chat(isAdmin: false, userId: "",),
                  ));
                },
                iconSize: iconSize,
                icon: const Icon(
                  Icons.wechat_outlined,
                  color: kourcolor1,
                ),
              ),
              SizedBox(width: 50),
              Text(
                'Diamond',
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
              height: kIsWeb ? 500 : 300,
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
                      ),
                    ),
                  );
                },
              ),
            ),
            TabPageSelector(
              controller: TabController(
                length: assets.length,
                initialIndex: currentindex,
                vsync: this,
              ),
              selectedColor: kourcolor1,
              color: Color(0xA5FFFFFF),
              borderStyle: BorderStyle.none,
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: kIsWeb ? 25 : 20,
                  fontWeight: FontWeight.bold,
                  color: kourcolor1,
                ),
              ),
            ),
            DCategories(),
            SizedBox(height: 15),
            Container(
              height: kIsWeb ? 600 : 400,
              width: kIsWeb ? 600 : 400,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DesignRing(name: 'round diamond'),
                    ),
                  );
                },
                child: ClipOval(
                  child: Ink.image(
                    image: AssetImage("images/DYR.png"),
                    height: kIsWeb ? 300 : 200,
                    width: kIsWeb ? 300 : 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: kIsWeb ? 600 : 400,
              width: kIsWeb ? 600 : 400,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuitableDiamond(),
                    ),
                  );
                },
                child: ClipOval(
                  child: Ink.image(
                    image: AssetImage("images/sd.jpg"),
                    height: kIsWeb ? 300 : 200,
                    width: kIsWeb ? 300 : 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
