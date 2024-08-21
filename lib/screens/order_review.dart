import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/models/ShippingInfo.dart';
import 'package:project1/models/order.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/checkout_message_view.dart';
import 'package:project1/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:project1/widgets/UserPreferences.dart';

class OrderReviewPage extends StatefulWidget {
  final ShippingInfo shipping;
  const OrderReviewPage({
    super.key,
    required this.shipping,
  });
  @override
  State<OrderReviewPage> createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  String orderStatus = "Processing";
  late Order order;
  late Future<Order> futureOrder;
  String userID = "";
  List<CartItem> cartItems = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    futureOrder = _initializeOrder();
  }

  Future<Order> _initializeOrder() async {
    String? email = await UserPreferences.getEmail();
    if (email != null) {
      String userId = await UserPreferences.getUserIdByEmail(email);
      List<CartItem> fetchedCartItems = await fetchCartItems(userId);
      setState(() {
        userID = userId;
        cartItems = fetchedCartItems;
      });
      await fetchTotalPrice(userID);
      try {
        return fetchOrder(userId);
      } catch (e) {
        // Handle error, possibly show a message to the user
        print('Failed to fetch order info: $e');
        throw e; // Re-throw the error so the Future completes with an error
      }
    } else {
      // Handle case when email is null, perhaps navigate to login or show an error
      throw Exception('Email is null');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '           Order Review',
        style: TextStyle(
          fontSize: 25,
          // fontWeight: FontWeight.bold,
          color: kourcolor1,
        ),
      )),
      body: FutureBuilder<Order>(
        future: futureOrder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            // Use snapshot.data to access your order data
            Order order = snapshot.data!;
            return buildOrderDetails(order);
          } else {
            return Center(child: Text("No order found"));
          }
        },
      ),
    );
  }

  Widget buildOrderDetails(Order order) {
    // print(order.paymentMethod);
    List<Widget> itemWidgets = cartItems.map((item) {
      return ListTile(
        leading: Image.network(item.image, width: 50, height: 50),
        title: Text(
          item.productName.replaceAll('\\n', '\n'),
          style: TextStyle(height: 1.5),
        ),
        subtitle: Text(
          'Quantity: ${item.quantity}',
        ),
        trailing: Text(
          '\$${item.price.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }).toList();

    // Add a SizedBox for spacing
    SizedBox(height: 10);
    // Add the total amount at the end of the list
    // itemWidgets.add(Text(
    //   'Total: \$${order.totalAmount.toStringAsFixed(2)}', // Ensure the total amount is formatted to two decimal places
    //   style: TextStyle(
    //       fontWeight: FontWeight.bold,
    //       fontSize: 16), // Make total amount bold and slightly larger
    // ));

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        ListTile(
          title: const Text('Shipping Address'),
          subtitle: Text(order.shippingAddress),
        ),
        ListTile(
          title: const Text('Payment Method'),
          subtitle: Text(order.paymentMethod.toString()),
        ),
        ListTile(
          title: const Text('Order Number'),
          subtitle: Text(order.orderNumber.toString()),
        ),
        ListTile(
          title: const Text('Order Status'),
          subtitle: Text(order.orderStatus),
        ),
        ListTile(
          title: const Text('Order Summary'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: itemWidgets,
          ),
        ),
        ListTile(
          title: const Text('Total Price'),
          subtitle: Text(totalPrice.toString()),
        ),
        ListTile(
          title: const Text('Estimated Delivery Date'),
          subtitle: const Text('3-5 working days'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => DraggableScrollableSheet(
                initialChildSize: 0.65, // 80% of screen height
                minChildSize: 0.4, // Minimum height of 40% of screen height
                maxChildSize: 0.9, // Maximum height of 90% of screen height
                expand: false,
                builder: (context, scrollController) => SingleChildScrollView(
                  controller: scrollController,
                  child: CheckoutMessageView(),
                ),
              ),
            );
          },
          child:
              const Text('Place Order', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: kourcolor1),
        ),
        const SizedBox(height: 10), // Add some space between the buttons
        ElevatedButton(
          onPressed: () {
            // Implement the cancel order functionality here
            _cancelOrder(order.orderNumber.toString());
          },
          child:
              const Text('Cancel Order', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: kourcolor1),
        ),
      ],
    );
  }

  static Future<Order> fetchOrder(String userId) async {
    final ipAddress =
        await getLocalIPv4Address(); // Ensure this function is correctly implemented
    try {
      final response =
          await http.get(Uri.parse('http://$ipAddress:5000/order/$userId'));
      print('Response body in fetchOrder: ${response.body}');
      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        return Order.fromJson(decoded);
      } else {
        print('Failed to load order, Status code: ${response.statusCode}');
        throw Exception(
            'Failed to load order, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making request: $e');
      rethrow;
    }
  }

  Future<List<CartItem>> fetchCartItems(String userId) async {
    final ipAddress = await getLocalIPv4Address();

    final response = await http
        .get(Uri.parse('http://$ipAddress:5000/fetchOnlyCartItems/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data is List<dynamic>) {
        return data.map((item) => CartItem.fromJson(item)).toList();
      } else {
        throw Exception('Unexpected data format: ${data.runtimeType}');
      }
    } else {
      throw Exception('Failed to load cart items');
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

  void _cancelOrder(String orderNumber) async {
    final ipAddress = await getLocalIPv4Address();
    try {
      final response = await http.delete(
        Uri.parse('http://$ipAddress:5000/cancelOrder/$orderNumber'),
      );

      if (response.statusCode == 200) {
        setState(() {
          orderStatus = "Cancelled";
        });
        // Show a message or navigate to another screen
      } else {
        throw Exception(
            'Failed to cancel order, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error cancelling order: $e');
      throw Exception('Failed to cancel order: $e');
    }
  }
}
