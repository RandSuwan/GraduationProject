/* import 'package:flutter/material.dart';
import 'package:project1/models/category.dart';
import 'package:project1/screens/diamond_page.dart';
import 'package:project1/screens/gold_page.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/rounded-button1.dart';
import 'package:project1/models/designRings.dart';

class Designs extends StatefulWidget {
  const Designs({
    Key? key,
  }) : super(key: key);

  @override
  State<Designs> createState() => _DesignsState();
}

class _DesignsState extends State<Designs> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 500, // Adjust the height according to your requirement
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: designs.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 17, right: 20, top: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
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
                                designs[index].image,
                              ),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        /*   decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ), */
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 100,
                        width: 100,
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
                                designs[index].image1,
                              ),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        /*   decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ), */
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 100,
                        width: 100,
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
                                designs[index].image2,
                              ),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        /*   decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ), */
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 100,
                        width: 100,
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
                                designs[index].image3,
                              ),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        /*   decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ), */
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
 */