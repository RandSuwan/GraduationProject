import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/models/ShippingInfo.dart';
import 'package:project1/screens/addcard.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/order_review.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/UserPreferences.dart';
import 'package:http/http.dart' as http;

class PaymentInformationPage extends StatefulWidget {
  final ShippingInfo shipping;

  const PaymentInformationPage({
    Key? key,
    required this.shipping,
  }) : super(key: key);

  @override
  State<PaymentInformationPage> createState() => _PaymentInformationPageState();
}

class _PaymentInformationPageState extends State<PaymentInformationPage> {
  List<Map<String, dynamic>> paymentArr = [
    {"name": "Cash on delivery", "icon": "images/cash.png"},
    {"name": "** ** ** 2187", "icon": "images/visa.png"},
  ];

  bool payment = false;
  String method = "";
  int selectMethod = -1;
  bool showAddCardView = false;
  String userID = "";
  late List<CartItem> cartItems = []; // Adjusted to hold List<CartItem>
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeCart();
  }

  void _initializeCart() async {
    String? email = await UserPreferences.getEmail();
    if (email != null) {
      try {
        String userId = await UserPreferences.getUserIdByEmail(email);
        setState(() {
          userID = userId;
        });

        // Fetch cart items directly
        List<CartItem> fetchedCartItems = await fetchCartItems(userId);
        setState(() {
          cartItems = fetchedCartItems;
        });

        print("CartItems $cartItems");
      } catch (e) {
        // Handle fetch error
        print('Failed to fetch cart items: $e');
        // Optionally, set cartItems to an empty list or handle the error state
      }
    } else {
      // Handle case when email is null
      // Optionally, set cartItems to an empty list or handle the error state
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Information',
          style: TextStyle(
            fontSize: 25,
            color: kourcolor1,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: kourcolor1),
            height: 8,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment method",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: paymentArr.length,
                  itemBuilder: (context, index) {
                    var pObj = paymentArr[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            pObj["icon"]!,
                            width: 50,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                          Expanded(
                            child: Text(
                              pObj["name"]!,
                              style: TextStyle(
                                color: kourcolor1,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectMethod = index;
                                showAddCardView =
                                    pObj["name"] == "** ** ** 2187";
                                payment = pObj["name"] == "Cash on delivery";
                                print(payment);
                                if (payment) {
                                  method = "Cash on delivery";
                                  print(method);
                                } else {
                                  method = "Credit Card";
                                  print(method);
                                }
                                // Handle other logic if needed
                              });
                            },
                            child: Icon(
                              selectMethod == index
                                  ? Icons.radio_button_on
                                  : Icons.radio_button_off,
                              color: kourcolor1,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(color: kourcolor1),
            height: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Visibility(
                    visible: showAddCardView,
                    child: AddCardView(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await orderStoring(
                          userId: userID,
                          shippingAddress:
                              '${widget.shipping.address}, ${widget.shipping.city}, ${widget.shipping.state}',
                          paymentMethod:
                              "Cash on delivery", // Update payment method as needed
                          items: cartItems, // Pass cart items directly
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderReviewPage(
                              shipping: widget.shipping,
                            ),
                          ),
                        );
                      } catch (e) {
                        print('Failed to store order: $e');
                        // Handle error gracefully
                      }
                    },
                    child: Text(
                      'Review Order',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kourcolor1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
}

Future<void> orderStoring({
  required String? userId,
  required String shippingAddress,
  required String paymentMethod,
  required List<CartItem> items,
}) async {
  try {
    // Get the IP address
    final ipAddress = await getLocalIPv4Address();

    // Convert items to JSON
    final List<Map<String, dynamic>> itemsJson =
        items.map((item) => item.toJson()).toList();

    // Calculate the total amount
    final int totalAmount = items.fold(
      0,
      (sum, current) => sum + current.price * current.quantity,
    );

    // Print debug information
    print("Items JSON: ${itemsJson.toString()}");
    print("Total Amount: $totalAmount");

    // Make the HTTP POST request
    final response = await http.post(
      Uri.parse('http://$ipAddress:5000/orderStoring'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'shipping_address': shippingAddress,
        'payment_method': paymentMethod,
        'items': itemsJson,
        'total_amount': totalAmount,
        'order_status': 'Processing',
      }),
    );

    // Handle the HTTP response
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Order created successfully!');
      print('Received response body: ${response.body}');
      // Handle JSON response if needed
      final responseData = json.decode(response.body);
      print('Response Data: $responseData');
    } else {
      print('Failed to create order. Status code: ${response.statusCode}');
      throw Exception(
          'Failed to create order. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to create order. Error: $e');
  }
}
