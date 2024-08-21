import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/models/wishlistProduct.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/UserPreferences.dart';
import 'package:project1/widgets/wishlist_card.dart';
import 'package:project1/models/product.dart';
import 'package:project1/widgets/product_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class wishlist extends StatefulWidget {
  final bool isDiamond;
  const wishlist({Key? key, required this.isDiamond}) : super(key: key);

  @override
  State<wishlist> createState() => _wishlistState();
}

class _wishlistState extends State<wishlist> {
  late Future<List<dynamic>> futureWishlist = Future.value([]);
  @override
  void initState() {
    super.initState();
    // futureWishlist = Future.value([]); // Initialize with an empty list
    _initializeWishlist();
  }

  void _initializeWishlist() async {
    String? email = await UserPreferences.getEmail();
    if (email != null) {
      String userId = await UserPreferences.getUserIdByEmail(email);
      setState(() {
        futureWishlist = fetchWishlistItem(userId);
      });
    } else {
      // Handle case when email is null, perhaps navigate to login or show an error
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //   backgroundColor: Color.fromARGB(187, 22, 21, 21),
          elevation: 0,
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
          title: Text('WishList',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: kourcolor1,
              )),
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Text('Edit    ',
                    style: TextStyle(
                      color: kourcolor1,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ]),
      body: FutureBuilder<dynamic>(
        future: futureWishlist,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product1 = Product.fromJson(snapshot.data![index]);
                return WishlistCard(
                  product: product1,
                  isDiamond: widget.isDiamond,
                );
              },
            );
          } else {
            return Center(child: Text("No items found."));
          }
        },
      ),
    );
  }

  Future<List<dynamic>> fetchWishlistItem(String? userId) async {
    final ipAddress = await getLocalIPv4Address();
    print("User ID: $userId");
    print("User Email: ${UserPreferences.getEmail()}");

    try {
      
      final response = await http
          .get(Uri.parse('http://$ipAddress:5000/fetchWishlistItems/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is String && data == 'No items added to wishlist') {
          print('No items added to wishlist');
          return []; // Return an empty list if the wishlist is empty
        }

        if (data is List<dynamic>) {
          print(data); // Check the simplified structure
          return data;
        } else {
          print('Unexpected data format: $data');
          return [];
        }
      } else {
        throw Exception(
            'Failed to load wishlist products, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching wishlist items: $e');
      return []; // Return an empty list in case of an error
    }
  }
}
