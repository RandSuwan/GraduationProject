import 'package:flutter/material.dart';
import 'package:project1/models/product.dart';
import 'package:project1/utilities/constants.dart';

class ProductDescription extends StatefulWidget {
  final Product product;
  const ProductDescription({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Description',
                    style: TextStyle(
                      color: kourcolor1,
                      fontSize: 20,
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: kourcolor1,
                  ),
                ],
              ),
              SizedBox(height: 10),
              AnimatedCrossFade(
                duration: Duration(milliseconds: 300),
                firstChild: Text(
                  widget.product.rate!.substring(0, 100) + '...',
                  style: TextStyle(
                    color: kourcolor1,
                    fontSize: 16,
                  ),
                ),
                secondChild: Text(
                  widget.product.rate.toString(),
                  style: TextStyle(
                    color: kourcolor1,
                    fontSize: 16,
                  ),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
