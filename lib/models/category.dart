import 'package:flutter/material.dart';
import 'package:project1/widgets/rounded-button1.dart';

class Category {
  //final String title;
  final String image;
  // RoundedButton1 roundedButton1;

  Category({
    // required this.title,
    required this.image,
    // required this.roundedButton1,
  });
}

final List<Category> categories = [
  Category(
      /*roundedButton1:  RoundedButton1(buttonName: 'Diamond'),*/ image:
          "images/DHPnew.png"),
  Category(
      /*roundedButton1:  RoundedButton1(buttonName: 'Gold'),*/ image:
          "images/GHPnew.png"),
];
