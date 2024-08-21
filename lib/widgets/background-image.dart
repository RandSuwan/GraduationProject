import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.image,
    this.overlayColor = Colors.black54,
  }) : super(key: key);

  final String image;
  final Color overlayColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(overlayColor, BlendMode.darken),
        ),
      ),
    );
  }
}
