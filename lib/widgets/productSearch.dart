import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/category.dart';
import 'package:project1/screens/gold_items.dart';
import 'package:project1/screens/ring_page.dart';
import 'package:project1/search/searchItems.dart';
import 'package:project1/utilities/constants.dart';

class SearchP extends StatefulWidget {
  const SearchP({super.key, required this.category, required this.isDiamond});
  final String category;
  final bool isDiamond;

  @override
  State<SearchP> createState() => _SearchPState();
}

class _SearchPState extends State<SearchP> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(width: 1, color: Color(0x9F201E1E)), // Add black border
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container(
        height: 55,
        width: double.infinity,
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
              onPressed: () async {
                print("hiii*");
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => searchItems(),
                ));
              },
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
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                _display(context);
              },
              child: Container(
                child: Text('Sort    ',
                    style: TextStyle(
                      color: kourcolor1,
                      fontSize: 15,
                      // fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _display(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 5, color: kourcolor1.withOpacity(0.7)),
                  // borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(16.0),
                height: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'SORT BY',
                        style: TextStyle(
                          color: kourcolor1,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: Color(0x9F201E1E), thickness: 1.5),
                    _buildSortOption('Higher Price', Icons.arrow_upward),
                    Divider(color: Color(0x9F201E1E), thickness: 1.5),
                    _buildSortOption('Lower Price', Icons.arrow_downward),
                    Divider(color: Color(0x9F201E1E), thickness: 1.5),
                    _buildSortOption('Newest', Icons.new_releases),
                  ],
                ),
              ),
            ));
  }

  Widget _buildSortOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: kourcolor1),
      title: Text(
        title,
        style: TextStyle(
          color: kourcolor1,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        if (title == "Higher Price") {
          widget.isDiamond
              ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => RingPage(
                    category: widget.category,
                    title: '    ${widget.category}           ',
                    sort: "highest",
                  ),
                ))
              : Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => GoldItem(
                    category: widget.category,
                    title: '    ${widget.category}           ',
                    sort: "highest",
                  ),
                ));
        }
        if (title == "Lower Price") {
          widget.isDiamond
              ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => RingPage(
                    category: widget.category,
                    title: '    ${widget.category}           ',
                    sort: "lowest",
                  ),
                ))
              : Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => GoldItem(
                    category: widget.category,
                    title: '    ${widget.category}           ',
                    sort: "lowest",
                  ),
                ));
        }
        if (title == "Newest") {
          widget.isDiamond
              ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => RingPage(
                    category: widget.category,
                    title: '    ${widget.category}           ',
                    sort: "newest",
                  ),
                ))
              : Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => GoldItem(
                    category: widget.category,
                    title: '    ${widget.category}           ',
                    sort: "newest",
                  ),
                ));
        }
      },
    );
  }
}
