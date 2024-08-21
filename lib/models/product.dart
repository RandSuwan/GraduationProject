import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';

class Product {
  final String? id;
  final String? title;
  final String image;
  final String? price;
  final String? rate;
  final String? category;

  Product({
    required this.id,
    required this.title, // name
    required this.image,
    this.price,
    this.rate,
    this.category,
    // required id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['_id'],
        title: json['name'],
        image: json['image'],
        rate: json['description'],
        price: json['price'].toString(), // convert num to double
        category: json['category']);
  }

  static Future<List<Product>> fetchProducts(String category) async {
    final ipAddress = await getLocalIPv4Address();
    // Update your API endpoint URL to include the category as a query parameter
    final response = await http
        .get(Uri.parse('http://$ipAddress:5000/fetchItems/$category'));

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchBestSellers() async {
    print("inside fetch best sellers future function");
    final ipAddress = await getLocalIPv4Address();
    // Update your API endpoint URL to include the category as a query parameter
    final response =
        await http.get(Uri.parse('http://$ipAddress:5000/fetchBestSellers'));

    print('Raw JSON response: ${response.body}');

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchNewArrivals() async {
    print("inside fetch new sellers future function");
    final ipAddress = await getLocalIPv4Address();
    // Update your API endpoint URL to include the category as a query parameter
    final response =
        await http.get(Uri.parse('http://$ipAddress:5000/fetchNewArrivals'));

    print('Raw JSON response: ${response.body}');

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchGProducts(String category) async {
    final ipAddress = await getLocalIPv4Address();
    // Update your API endpoint URL to include the category as a query parameter
    final response = await http
        .get(Uri.parse('http://$ipAddress:5000/fetchGItems/$category'));

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchGBestSellers() async {
    print("inside fetch best sellers future function");
    final ipAddress = await getLocalIPv4Address();
    // Update your API endpoint URL to include the category as a query parameter
    final response =
        await http.get(Uri.parse('http://$ipAddress:5000/fetchGBestSellers'));

    print('Raw JSON response: ${response.body}');

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchGNewArrivals() async {
    print("inside fetch new sellers future function");
    final ipAddress = await getLocalIPv4Address();
    // Update your API endpoint URL to include the category as a query parameter
    final response =
        await http.get(Uri.parse('http://$ipAddress:5000/fetchGNewArrivals'));

    print('Raw JSON response: ${response.body}');

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchNewestItems(String category) async {
    print("Inside fetch newest items function");
    final ipAddress = await getLocalIPv4Address();
    final response = await http
        .get(Uri.parse('http://$ipAddress:5000/fetchNewestItems/$category'));

    print('Raw JSON response: ${response.body}');

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'Products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchByHighestPriceItems(String category) async {
    print("Inside fetch highest items function");
    final ipAddress = await getLocalIPv4Address();
    final response = await http.get(
        Uri.parse('http://$ipAddress:5000/fetchItemsByHighestPrice/$category'));

    print('Raw JSON response: ${response.body}');

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'Products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchByLowestPriceItems(String category) async {
    print("Inside fetch lowest items function $category");
    final ipAddress = await getLocalIPv4Address();
    final response = await http.get(
        Uri.parse('http://$ipAddress:5000/fetchItemsByLowestPrice/$category'));

    print('Raw JSON response: ${response.body}');

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'Products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }


    static Future<List<Product>> fetchNewestGItems(String category) async {
    print("Inside fetch newest items function");
    final ipAddress = await getLocalIPv4Address();
    final response = await http
        .get(Uri.parse('http://$ipAddress:5000/fetchNewestGItems/$category'));

    print('Raw JSON response: ${response.body}');

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'Products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchByHighestPriceGItems(String category) async {
    print("Inside fetch highest items function");
    final ipAddress = await getLocalIPv4Address();
    final response = await http.get(
        Uri.parse('http://$ipAddress:5000/fetchGItemsByHighestPrice/$category'));

    print('Raw JSON response: ${response.body}');

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'Products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchByLowestPriceGItems(String category) async {
    print("Inside fetch lowest items function $category");
    final ipAddress = await getLocalIPv4Address();
    final response = await http.get(
        Uri.parse('http://$ipAddress:5000/fetchGItemsByLowestPrice/$category'));

    print('Raw JSON response: ${response.body}');

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      products.forEach((product) {
        print('Product ID: ${product.id}');
      });

      print(
          'Products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }
}
