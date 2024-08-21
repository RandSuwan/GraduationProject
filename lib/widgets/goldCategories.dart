import 'package:flutter/material.dart';
import 'package:project1/models/category.dart';
import 'package:project1/models/diamondcategory.dart';
import 'package:project1/models/goldcategory.dart';
import 'package:project1/screens/diamond_page.dart';
import 'package:project1/screens/gold_page.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/rounded-button1.dart';

class GCategories extends StatelessWidget {
  const GCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 130, // Adjust the height according to your requirement
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: gcategories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: kourcolor1, // Specify the border color here
                          width: 2, // Specify the border width here
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            gcategories[index].image,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        // Navigate to another screen based on the category index
                        if (index == 0) {
                          Navigator.pushNamed(context, 'GoldItem');
                        } else if (index == 1) {
                          Navigator.pushNamed(context, 'GNecklacePage');
                        } else if (index == 2) {
                          Navigator.pushNamed(context, 'GBraceletPage');
                        } else if (index == 3) {
                          Navigator.pushNamed(context, 'GEarringPage');
                        } else if (index == 4) {
                          Navigator.pushNamed(context, 'GSetPage');
                        }
                      },
                      child: Text(
                        gcategories[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
