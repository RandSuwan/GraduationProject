import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/product.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/profile.dart';
import 'package:project1/screens/screen.dart';
import 'package:project1/screens/wishlist.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/productSearch.dart';
import 'package:project1/widgets/product_card.dart';
import 'package:project1/widgets/rounded-button1.dart';
import 'package:video_player/video_player.dart';

class GoldItem extends StatefulWidget {
  const GoldItem({
    super.key,
    required this.category,
    required this.title,
    required this.sort,
  });
  final String category;
  final String title;
  final String sort;

  // @override
  // State<RingPage> createState() => _RingPageState();

  @override
  State<GoldItem> createState() {
    print("GoldItem Constructor - Category: ${category}");
    return _GoldItemState();
  }
}

class _GoldItemState extends State<GoldItem> {
  late Future<List<Product>> futureProducts;
  // late Future<List<Product>> futureBest;

  @override
  void initState() {
    super.initState();

    print("widget: " + widget.sort);
    if (widget.sort == 'best') {
      futureProducts = Product
          .fetchGBestSellers(); // Use fetchBestSellers when category is 'all'
    } else if (widget.sort == 'new') {
      futureProducts = Product.fetchGNewArrivals();
    } else if (widget.sort == 'newest') {
      print("Goldddd");
      futureProducts = Product.fetchNewestGItems(widget.category);
    } else if (widget.sort == 'highest') {
      futureProducts = Product.fetchByHighestPriceGItems(widget.category);
    } else if (widget.sort == 'lowest') {
      futureProducts = Product.fetchByLowestPriceGItems(widget.category);
    } else {
      futureProducts = Product.fetchGProducts(
          widget.category); // Use fetchProducts for other categories
    }
  }

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
            MaterialPageRoute(builder: (context) => wishlist(isDiamond: true)),
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
            // '   Ring             ',
            widget.title,
            style: TextStyle(
              fontSize: 35,
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
      backgroundColor: Colors.white,
      /////////////////////////////////////////
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                SearchP(
                  category: widget.category,isDiamond: false,
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: FutureBuilder<List<Product>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                      child: Center(child: Text("Error: ${snapshot.error}")));
                }
                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    mainAxisExtent: 325,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ProductCard(
                        product: snapshot.data![index], isDiamond: false),
                    childCount: snapshot.data!.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
