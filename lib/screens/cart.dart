import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/ipaddress.dart';
import 'dart:convert';

import 'package:project1/models/product.dart'; // Ensure this model is correctly set up for JSON parsing
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/productDetails.dart';
import 'package:project1/screens/profile.dart';
import 'package:project1/screens/shipping_info.dart';
import 'package:project1/screens/wishlist.dart';
import 'package:project1/utilities/constants.dart'; // Contains constant values used in the app
import 'package:project1/widgets/UserPreferences.dart'; // Manages user preferences, like userID

class Cart extends StatefulWidget {
  const Cart({Key? key})
      : super(key: key); // updated to current Dart null-safety standard

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String userID = "";

  //double _totalPrice = 0.0;
  double totalPrice = 0.0;
  late List<CartItem> cartItems = [];
  //late Future<List<dynamic>> futureCartItems;
  late Future<List<dynamic>> futureCartItems = Future.value([]);

//By Ghena
  void processFutureCartItems(List<dynamic> items) {
    setState(() {
      cartItems = items.map((item) => CartItem.fromJson(item)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeWishlist();
  }

  void _initializeWishlist() async {
    String? email = await UserPreferences.getEmail();
    if (email != null) {
      String userId = await UserPreferences.getUserIdByEmail(email);
      setState(() {
        userID = userId;
        futureCartItems = fetchCartItem(userId);
      });
      await fetchTotalPrice(userID);
    } else {
      // Handle case when email is null, perhaps navigate to login or show an error
    }
  }

  //late Future<List<dynamic>> futureCartItems;
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
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: kourcolor1,
          ),
        ),
        title: Text(
          'Cart',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: kourcolor1,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: kourcolor1,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => wishlist(isDiamond: true),
              ));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureCartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                bool hasSize = item.containsKey('productSize') &&
                    item['productSize'] != "N/A";

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xDDF1EBEB), width: 5),
                    ),
                    child: CartItemWidget(
                        item: item,
                        hasSize: hasSize,
                        deleteCartItem: _deleteCartItem),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/shopping.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text('No items in your cart'),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: kourcolor1),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart, color: kourcolor1),
            label: 'Shop Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: kourcolor1),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box, color: kourcolor1),
            label: 'Account',
          ),
        ],
      ),
      persistentFooterButtons: [
        Container(
          padding: const EdgeInsets.all(8.0),
          color: kourcolor1.withOpacity(0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Checkout logic here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShippingInformationPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: kourcolor1,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('CHECKOUT', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<List<dynamic>> fetchCartItem(String? userId) async {
    final ipAddress = await getLocalIPv4Address();
    try {
      final response = await http
          .get(Uri.parse('http://$ipAddress:5000/fetchCartItems/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is Map<String, dynamic> &&
            data.containsKey('message') &&
            data['message'] == 'Cart is empty') {
          print('Cart is empty');
          return []; // Return an empty list if the cart is empty
        }

        print(data); // Check the simplified structure
        return data['items'];
      } else {
        throw Exception(
            'Failed to load cart products, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching cart items: $e');
      throw Exception('Failed to load cart products:$e');
    }
  }

  Future<void> fetchTotalPrice(String userId) async {
    final ipAddress = await getLocalIPv4Address();
    final url = 'http://$ipAddress:5000/calculateTotalPrice/$userId';
    print('Requesting: $url');
    print('UserIDtotal: $userID');

    try {
      final response = await http.get(Uri.parse(url));
      print('Status code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          totalPrice = (jsonResponse['totalPrice'] as num).toDouble();
        });
      } else {
        throw Exception(
            'Failed to load total price, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('An error occurred: $e');
    }
  }

  void _deleteCartItem(String productId) async {
    final ipAddress = await getLocalIPv4Address();
    print("user id: $userID");
    print("producttttt $productId");
    try {
      final response = await http.delete(
        Uri.parse('http://$ipAddress:5000/deleteCartItem/$userID/$productId'),
      );

      if (response.statusCode == 200) {
        setState(() {
          futureCartItems = fetchCartItem(userID);
          fetchTotalPrice(userID);
        });
      } else {
        throw Exception(
            'Failed to delete cart item, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting cart item: $e');
      throw Exception('Failed to delete cart item: $e');
    }
  }
}

class CartItemWidget extends StatefulWidget {
  final Map<String, dynamic> item;
  final bool hasSize;
  final Function(String) deleteCartItem;

  const CartItemWidget({
    required this.item,
    required this.hasSize,
    required this.deleteCartItem,
    Key? key,
  }) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.item['productQuantity'] ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    print('Item: ${widget.item}');
    print('Has size: ${widget.hasSize}');
    return GestureDetector(
      onTap: () async {
        print("Items iddddd: ");
        print(widget.item["_id"]);
        Product product = await fetchProductDetails(widget.item["_id"]);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetails(
            isDiamond: true,
            product: product,
          ),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.item['productImage'] ?? 'default_image_url',
                      ),
                      fit: BoxFit.contain,
                    ),
                    color: kourcolor1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      widget.item['productName']
                              ?.toString()
                              .replaceAll('\\n', '\n') ??
                          'No product name',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          '\$${(widget.item['productPrice'] is int ? (widget.item['productPrice'] as int).toDouble() : double.parse(widget.item['productPrice'] ?? '0.00')).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kourcolor1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    if (widget.hasSize) // Conditionally show size container
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                "   Size: ",
                                style: TextStyle(
                                  color: kourcolor1,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.item['productSize']?.toString() ?? '',
                                style: TextStyle(
                                  color: kourcolor1,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                        height: widget.hasSize
                            ? 5
                            : 0), // Spacer when size is not shown
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_quantity > 1) _quantity--;
                            });
                          },
                          icon: Icon(Icons.remove_circle),
                        ),
                        Text(
                          '$_quantity',
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                          icon: Icon(Icons.add_circle),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.deleteCartItem(widget.item['productId']);
                  });
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Product> fetchProductDetails(String id) async {
    final ipAddress =
        await getLocalIPv4Address(); // Implement this method to get the local IP address
    final response = await http
        .get(Uri.parse('http://$ipAddress:5000/fetchProductDetails/$id'));

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product details');
    }
  }
}

class CartItem {
  final String productId;
  final String productName;
  final String image;
  final int quantity;
  final int price;

  CartItem({
    required this.productId,
    required this.productName,
    required this.image,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      image: json['image'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'image': image,
      'quantity': quantity,
      'price': price,
    };
  }
}
