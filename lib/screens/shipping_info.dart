import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/payment_info.dart';
import 'package:project1/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:project1/widgets/UserPreferences.dart';
import 'package:project1/models/ShippingInfo.dart';

class ShippingInformationPage extends StatefulWidget {
 // final List<CartItem> cartItems;
  const ShippingInformationPage({
    super.key,
    //required this.cartItems,
  });
  @override
  State<ShippingInformationPage> createState() =>
      _ShippingInformationPageState();
}

class _ShippingInformationPageState extends State<ShippingInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String userID = "";
  // ignore: prefer_typing_uninitialized_variables
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
      });
    } else {
      // Handle case when email is null, perhaps navigate to login or show an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '    Shipping Information',
        style: TextStyle(
          fontSize: 25,
          // fontWeight: FontWeight.bold,
          color: kourcolor1,
        ),
      )),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              controller: _nameController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
              controller: _addressController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'City'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your city';
                }
                return null;
              },
              controller: _cityController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'State'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your state';
                }
                return null;
              },
              controller: _stateController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Zip Code'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your zip code';
                }
                return null;
              },
              controller: _zipController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
              controller: _phoneController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                print(UserPreferences.getUserID());
                final shippingInfo = ShippingInfo(
                  name: _nameController.text,
                  address: _addressController.text,
                  city: _cityController.text,
                  state: _stateController.text,
                  zipCode: _zipController.text,
                  phoneNumber: _phoneController.text,
                );
                await shippingStoring(info: shippingInfo, userId: userID
                    // date: " ",
                    );
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentInformationPage(
                          shipping: shippingInfo),
                    ),
                  );
                }
              },
              child: Text(
                'Continue to Payment',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    kourcolor1, // Change this to your desired color
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> shippingStoring({
    required ShippingInfo info,
    required String userId,
    // required String date,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:5000/shippingStoring');
    String? email = UserPreferences.getEmail();
    UserPreferences.getName(email!);
    UserPreferences.getID(email);

    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(now);
    // String? emaill = UserPreferences.getEmail();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'user_id': userId,
          'name': UserPreferences.getUserName(),
          'address': info.address,
          'city': info.city,
          'state': info.state,
          'zipCode': info.zipCode,
          'phoneNumber': info.phoneNumber,
          'created_at': date,
          'updated_at': date
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Data sent successfully
        print('successful shipping storing ');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => PaymentInformationPage(shipping: shipping,)), //payment info
        // );
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }
}
