import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
     // width: double.infinity,
     width: 275,
     
      decoration: BoxDecoration(
        color: kourcolor1,
        borderRadius: BorderRadius.circular(20),
       // borderRadius: BorderRadius.horizontal(),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 5,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: kcontentColor,
          ),
          const SizedBox(width: 10),
          const Flexible(
            flex: 4,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: kcontentColor), 
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 25,
            width: 1.5,
            color: kcontentColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.keyboard_option_key_sharp,
              color: kcontentColor,
            ),
          ),
        ],
      ),
    );
  }
}