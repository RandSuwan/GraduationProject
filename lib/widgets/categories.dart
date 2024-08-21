import 'package:flutter/material.dart';
import 'package:project1/models/category.dart';
import 'package:project1/screens/diamond_page.dart';
import 'package:project1/screens/gold_page.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/rounded-button1.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*   Text(
          'Categories', // Text before the categories
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kourcolor1,
          ),
        ), 
        const SizedBox(height: 20),
        */
        Container(
          height: 300, // Adjust the height according to your requirement
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50, top: 20),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      child: InkWell(
                        onTap: () {
                          print("Tapped index: $index");
                          if (index == 0) {
                            print("Navigating to DiamondScreen");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiamondScreen()),
                            );
                          } else if (index == 1) {
                            print("Navigating to GoldScreen");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoldScreen()),
                            );
                          }
                        },
                        child: ClipOval(
                          child: Ink.image(
                            image: AssetImage(
                              categories[index].image,
                            ),
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      /*  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.1),
                      ), */
                    ),
                    const SizedBox(height: 10),
                    //     categories[index].roundedButton1,
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
