import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';

class SearchG extends StatefulWidget {
  const SearchG({Key? key}) : super(key: key);

  @override
  State<SearchG> createState() => _SearchGState();
}

class _SearchGState extends State<SearchG> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: kourcolor1), // Add black border
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 55,
        width: 400,
        decoration: BoxDecoration(
          // color: Color(0xFFDFDED9),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(
                Icons.search,
                color: kourcolor1,
              ),
            ),
            const SizedBox(width: 10),
            const Flexible(
              flex: 4,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search ...",
                  hintStyle: TextStyle(color: kourcolor1),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 25,
              width: 1.5,
              color: kourcolor1,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.filter_list_outlined,
                color: kourcolor1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
