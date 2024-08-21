import 'package:flutter/material.dart';
import 'package:project1/widgets/rounded-button1.dart';

class GCategory {
  final String title;
  final String image;
  // RoundedButton1 roundedButton1;

  GCategory({
    required this.title,
    required this.image,
    // required this.roundedButton1,
  });
}

final List<GCategory> gcategories = [
  GCategory(title: "Rings", image: "images/diamond-ring.png"),
  GCategory(title: "Necklaces", image: "images/necklace.png"),
  GCategory(title: "Bracelets", image: "images/bracelet.png"),
  GCategory(title: "Earrings", image: "images/earrings.png"),
  GCategory(title: "Sets", image: "images/set.png"),
];
