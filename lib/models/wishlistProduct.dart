import 'package:flutter/material.dart';
import 'package:project1/widgets/rounded-button1.dart';

class wishlistProduct {
  final String title;
  final String image;
  final double price;
  final double rate;

  wishlistProduct({
    required this.title,
    required this.image,
    required this.price,
    required this.rate,
  });
}

final List<wishlistProduct> Wproducts = [
  wishlistProduct(
    title: "Ring1",
    image: "images/ring1.jpg",
    price: 1120,
    rate: 4.8,
  ),
  wishlistProduct(
    title: "Ring2",
    image: "images/ring2.jpg",
    price: 2120,
    rate: 4.8,
    //addtocart: RoundedButton1(buttonName: 'Add To Cart'),
  ),
  wishlistProduct(
    title: "Ring3",

    image: "images/ring3.jpg",
    price: 1255,
    rate: 4.8,
    //addtocart: RoundedButton1(buttonName: 'Add To Cart'),
  ),
 
];
