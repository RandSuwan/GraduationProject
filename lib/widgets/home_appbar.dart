import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/search_field.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
     // backgroundColor: const Color.fromARGB(255, 37, 37, 37),
     backgroundColor: kourcolor1,
      elevation: 0,
      leading: IconButton(
        onPressed: () {},

        iconSize: 30,
        icon: const Icon(
          Icons.grid_view,
          color: kcontentColor,
        ),
      ),
      actions: [
        SearchField(),
        IconButton(
          onPressed: () {},

          iconSize: 30,
          icon: const Icon(
            Icons.notifications,
            color: kcontentColor,
          ),
        ),
     //   SearchField(), // Add the SearchField widget here
      ],
    );
  }
}