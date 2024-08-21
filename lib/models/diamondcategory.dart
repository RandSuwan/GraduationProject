import 'package:flutter/material.dart';
import 'package:project1/widgets/rounded-button1.dart';

class DCategory {
  final String title;
  final String image;
  // RoundedButton1 roundedButton1;

  DCategory({
    required this.title,
    required this.image,
    // required this.roundedButton1,
  });
}

final List<DCategory> dcategories = [
  DCategory(title: "Rings", image: "images/diamond-ring.png"),
  DCategory(title: "Necklaces", image: "images/necklace.png"),
  DCategory(title: "Bracelets", image: "images/bracelet.png"),
  DCategory(title: "Earrings", image: "images/earrings.png"),
  DCategory(title: "Sets", image: "images/set.png"),
];
