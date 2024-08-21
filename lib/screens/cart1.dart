import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/ipaddress.dart';
import 'dart:convert';

import 'package:project1/models/product.dart'; // Ensure this model is correctly set up for JSON parsing
import 'package:project1/screens/shipping_info.dart';
import 'package:project1/utilities/constants.dart'; // Contains constant values used in the app
import 'package:project1/widgets/UserPreferences.dart'; // Manages user preferences, like userID

class Cart extends StatefulWidget {
  const Cart({Key? key})
      : super(key: key); // updated to current Dart null-safety standard

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double _totalPrice = 0.0;
  late List<CartItem> cartItems;

  @override
  void initState() {
    super.initState();
    futureCartItems = fetchCartItem(UserPreferences.getUserID());
    futureCartItems.then((_) => _calculateTotalPrice());
  }

  void _calculateTotalPrice() async {
    try {
      List<dynamic> cartItemsJson =
          await fetchCartItem(UserPreferences.getUserID());
      cartItems = cartItemsJson.map((itemJson) {
        int parsedPrice =
            int.tryParse(itemJson['productPrice'].toString()) ?? 0;
        int parsedQuantity =
            int.tryParse(itemJson['productQuantity'].toString()) ?? 0;
        return CartItem(
          name: itemJson['productName'],
          price: parsedPrice,
          quantity: parsedQuantity,
          productId: itemJson['productId'],
        );
      }).toList();

      double totalPrice = cartItems.fold(0.0,
          (previousValue, item) => previousValue + item.price * item.quantity);

      setState(() {
        _totalPrice = totalPrice;
      });
    } catch (e) {
      print('Error calculating total price: $e');
      setState(() {
        _totalPrice = 0.0; // Reset or handle error state
      });
    }
  }

  late Future<List<dynamic>> futureCartItems;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureCartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item['productImage'] ??
                        'default_image_url'), // Provide a default image URL if none is available
                    radius: 25, // You can adjust the size
                  ),
                  title: Text(
                      item['productName'].toString().replaceAll('\\n', '\n') ??
                          'No product name'), // Product name
                  subtitle: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Size: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                '${item['productSize'].toString()} '), //modify this to be dynamic
                        TextSpan(
                            text: 'Quantity: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                '${item['productQuantity'].toString()}'), ////modify this to be dynamic
                      ],
                    ),
                  ),
                  trailing: Text(
                      '\$${(item['productPrice'] * item['productQuantity']).toString()}'), // Product price
                );
              },
            );
          } else {
            return const Center(child: Text('No items in your cart'));
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Total: \$${_totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Checkout logic here
                  /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShippingInformationPage(cartItems: cartItems))); */
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      kourcolor1, // Using the primary color from theme
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
      ),
    );
  }

  Future<List<dynamic>> fetchCartItem(String? userId) async {
    final ipAddress = await getLocalIPv4Address();
    try {
      final response = await http
          .get(Uri.parse('http://$ipAddress:5000/fetchCartItems/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response
            .body); // Assuming the response body is already the items array

        print(data); // Check the simplified structure

        return data['items'];
      } else {
        throw Exception(
            'Failed to load cart products, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching cart items: $e');
      throw Exception('Failed to load cart products: $e');
    }
  }
}

class CartItem {
  final String name;
  final int price;
  final int quantity;
  final String productId;

  CartItem(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.productId});

  // Assuming a static method is useful here if needed
  factory CartItem.fromJson(Map<String, dynamic> json) {
    print("inside from json");
    return CartItem(
      name: json['product_name'] as String? ??
          'default-name', // Since 'name' isn't provided
      productId: json['product_id'] as String? ??
          'default-product-id', // Adjust as necessary
      quantity: json['quantity'] as int? ?? 0,
      price: json['price'] as int? ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'product_name': name,
      'product_id': productId,
      'price': price,
      'quantity': quantity,
};
}
}