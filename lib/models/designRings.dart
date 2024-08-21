//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:project1/screens/design_ring.dart';
import 'package:project1/widgets/rounded-button1.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project1/ipaddress.dart';

class design {
  //final String title;
  final String id;
  final String image;
  final String price;
  final String rname;

  // RoundedButton1 roundedButton1;

  design({
    // required this.title,
    required this.id,
    required this.image,
    required this.price,
    required this.rname,
    //   required this.menuArr,
    // required this.roundedButton1,
  });

  factory design.fromJson(Map<String, dynamic> json) {
    return design(
      id: json['_id'],
      image: json['image'],
      price: json['price'],
      rname: json['rname'],
      //  menuArr:
    );
  }

  static Future<List<design>> DYRfetching(String name) async {
    final ipAddress =
        await getLocalIPv4Address(); // Implement this method to get the local IP address
    final url = 'http://$ipAddress:5000/fetchDYR/$name';
    print('Requesting: $url'); // Debug: log the URL being requested

    try {
      final response = await http.get(Uri.parse(url));
      print(
          'Status code: ${response.statusCode}'); // Debug: log the status code
      print(
          'Response Body: ${response.body}'); // Debug: log the full response body

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        // Ensure the jsonResponse is a List
        return jsonResponse.map((item) => design.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to load data, Status code: ${response.statusCode}');
      }
    } on FormatException catch (e) {
      print('Error parsing JSON: $e');
      throw Exception('Error parsing JSON: $e');
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('An error occurred: $e');
    }
  }
}
