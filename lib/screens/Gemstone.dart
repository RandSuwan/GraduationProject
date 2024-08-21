import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';

class Gemstone extends StatefulWidget {
  const Gemstone({super.key});

  @override
  State<Gemstone> createState() => _GemstoneState();
}

class _GemstoneState extends State<Gemstone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(221, 248, 246, 246),
        title: Text(
          '           Gemstones ',
          style: TextStyle(
              color: kourcolor1, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GemstoneCard(
                image: 'images/diamgemstone.jpg',
                name: 'Diamond',
                description:
                    'Revered for their brilliance and durability, hold a timeless allure. Composed of pure carbon, these gems form under intense heat and pressure deep within the Earth, emerging through volcanic activity. Their exquisite clarity and color, often colorless but occasionally vividly hued, make each diamond unique.',
              ),
              SizedBox(height: 20),
              GemstoneCard(
                image: 'images/sapphire.jpg',
                name: 'Sapphire',
                description:
                    'Formed from corundum, the same mineral as rubies, sapphires exhibit remarkable durability and brilliance. Revered for centuries, these gemstones symbolize truth, sincerity, and faithfulness, making them a popular choice for engagement rings and heirloom jewelry.',
              ),
              SizedBox(height: 20),
              GemstoneCard(
                image: 'images/ruby.jpg',
                name: 'Ruby',
                description:
                    'Radiant and captivating, rubies symbolize passion and vitality. These precious gems, prized for their deep red hues, are formed from the mineral corundum, imbuing them with remarkable durability. Associated with love and courage, rubies have adorned royalty and nobility throughout history, gracing crowns, rings, and other regal ornaments. ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GemstoneCard extends StatefulWidget {
  final String image;
  final String name;
  final String description;

  GemstoneCard(
      {required this.image, required this.name, required this.description});

  @override
  State<GemstoneCard> createState() => _GemstoneCardState();
}

class _GemstoneCardState extends State<GemstoneCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 700,
      child: Card(
        margin: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Color.fromARGB(255, 183, 182, 178), width: 3),
        ),
        child: Column(
          children: [
            Image.asset(
              widget.image,
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kourcolor1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 16, color: kourcolor1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
