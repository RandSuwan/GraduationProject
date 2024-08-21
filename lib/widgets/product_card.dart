// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:project1/models/product.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/necklace_page.dart';
import 'package:project1/screens/productDetails.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/rounded-button1.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isDiamond;
  const ProductCard(
      {super.key, required this.product, required this.isDiamond});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurSize: 4,
      blurBackgroundColor: Colors.black,
      menuWidth: MediaQuery.of(context).size.width * 0.5,
      animateMenuItems: false,
      duration: Duration(milliseconds: 200),
      menuBoxDecoration: BoxDecoration(
        color: kourcolor1,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              product: widget.product,
              isDiamond: widget.isDiamond,
            ),
          ),
        );
      },
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
            title: Text("Open"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetails(
                    product: widget.product,
                    isDiamond: widget.isDiamond,
                  ),
                ),
              );
            },
            trailingIcon: Icon(Icons.open_in_new)),
        FocusedMenuItem(
            title: Text("Share"),
            onPressed: () {},
            trailingIcon: Icon(Icons.share)),
        FocusedMenuItem(
            backgroundColor: kourcolor1,
            title: Text(
              "Favorite",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
            trailingIcon: Icon(
              Icons.favorite_border,
              color: Colors.white,
            )),
      ],
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kourcolor1), // Add border here
          borderRadius: BorderRadius.circular(
              16.0), // Adjust border radius as per your design
        ),
        height: 300,
        width: 200,
        padding: const EdgeInsets.all(1),
        //  color: Colors.white,
        child: Stack(
          children: [
            /*  ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              /* child: Image.network(
                widget.product.image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ), */
            ), */
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              // child: Image.network(
              //   widget.product.image,
              //   height: 220,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              child: CachedNetworkImage(
                imageUrl: widget.product.image.toString(),
                height: kIsWeb ? 850 : 220,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: double.infinity,
                  height: 220,
                  color: Colors.grey[300],
                  child: Center(
                    child: CircularProgressIndicator(color: kourcolor1),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Positioned(
              bottom: 28,
              left: 10,
              child: Text(
                "${widget.product.title.toString().replaceAll('\\n', '\n')}",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Color(0xFF7B7B7B)),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 12,
              child: Text(
                '\$${widget.product.price.toString()}',
                style: Theme.of(context).textTheme.subtitle2!.merge(
                      TextStyle(
                        fontWeight: FontWeight.w700,
                        color: kourcolor1,
                      ),
                    ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 50,
                height: 50,
                child: IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: kourcolor1,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
