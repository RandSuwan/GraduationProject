import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/ipaddress.dart';
import 'package:project1/screens/productDetails.dart';
import 'package:project1/models/product.dart';

class searchItems extends StatefulWidget {
  const searchItems({super.key});

  @override
  State<searchItems> createState() => _searchItemsState();
}

class _searchItemsState extends State<searchItems> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<dynamic> _founditems = [];
  bool isTextFieldFocused = true; // Track the focus state

  List<dynamic> allItems = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItemsSearch();
  }

  Future<void> fetchItemsSearch() async {
    final ipAddress =
        await getLocalIPv4Address(); // Implement this method to get the local IP address
    final response =
        await http.get(Uri.parse('http://$ipAddress:5000/fetchItemsSearch'));

    if (response.statusCode == 200) {
      setState(() {
        allItems = json.decode(response.body);
        _founditems = allItems;
      });
    } else {
      throw Exception('Failed to load items');
    }
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

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = allItems;
    } else {
      results = allItems
          .where((item) =>
              item["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _founditems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.all(10),
                    filled: true,
                    fillColor: Color(0xFFebedee).withOpacity(0.85),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 170, 170, 170),
                    ),
                  ),
                  style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
                  onTap: () {
                    setState(() {
                      isTextFieldFocused = true;
                    });
                  },
                  onFieldSubmitted: (_) {
                    setState(() {
                      isTextFieldFocused = false;
                    });
                  },
                ),
              ),
              isTextFieldFocused
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          _controller.clear();
                          _runFilter('');
                          FocusScope.of(context).unfocus();
                          isTextFieldFocused = false;
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF000000).withOpacity(0.7),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // Conditionally display the item list based on focus state
          if (isTextFieldFocused)
            Expanded(
              child: ListView.builder(
                itemCount: _founditems.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_founditems[index]["_id"]),
                  color: Color(0xFFffffff).withOpacity(0.8),
                  //Color(0xFFc0edda),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      Product product =
                          await fetchProductDetails(_founditems[index]["_id"]);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          isDiamond: true,
                          product: product,
                        ),
                      ));
                    },
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          _founditems[index]["image"],
                          width: 100,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        _founditems[index]['name'].replaceAll('\\n', '\n'),
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        '\$${_founditems[index]["price"].toString()} ',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
