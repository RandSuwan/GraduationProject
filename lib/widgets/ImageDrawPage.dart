import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/FingerDrawPainter.dart';
import 'package:image/image.dart' as img;
import 'package:project1/widgets/UserPreferences.dart';

class ImageDrawPage extends StatefulWidget {
  final File image;

  ImageDrawPage({required this.image});

  @override
  _ImageDrawPageState createState() => _ImageDrawPageState();
}

class _ImageDrawPageState extends State<ImageDrawPage> {
  String? selectedDiamondPath;
  String? selectedImagePath;
  List<Offset?> points = [];
  Rect? cropRect;
  Uint8List?
      displayedImage; // This will hold the image data for the cropped image

  void updateCropRect(Offset point) {
    if (cropRect == null) {
      cropRect = Rect.fromPoints(point, point);
    } else {
      double left = min(cropRect!.left, point.dx);
      double top = min(cropRect!.top, point.dy);
      double right = max(cropRect!.right, point.dx);
      double bottom = max(cropRect!.bottom, point.dy);
      cropRect = Rect.fromLTRB(left, top, right, bottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  title: Text("Draw and Crop Image"),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: cropAndSaveImage, // Triggers cropping
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Please draw around the finger you want to wear the ring on',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kourcolor1.withOpacity(0.7)),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset localPosition =
                      renderBox.globalToLocal(details.globalPosition);
                  points.add(localPosition);
                  updateCropRect(localPosition);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  points.add(null); // End of drawing segment
                });
              },
              child: Stack(
                children: [
                  PhotoView(
                    imageProvider: FileImage(widget.image),
                  ),
                  CustomPaint(
                    painter: FingerDrawPainter(points),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                  if (displayedImage != null)
                    Center(
                      child: Image.memory(displayedImage!),
                    ),
                ],
              ),
            ),
          ),
          /*  Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                cropAndSaveImage();
                // Call the cropAndSaveImage method
                //  cropAndSaveImage();
                //  Navigator.pop(context); // Go back to the previous screen
              },
              child: Text('Done'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ), */
        ],
      ),
    );
  }

  void cropAndSaveImage() async {
    if (cropRect != null) {
      final originalImage = await loadImage(widget.image);
      final croppedImage = img.copyCrop(
        originalImage,
        x: cropRect!.left.toInt(),
        y: cropRect!.top.toInt(),
        width: cropRect!.width.toInt(),
        height: cropRect!.height.toInt(),
      );

      // Convert cropped image to a format Flutter can display
      Uint8List pngBytes = Uint8List.fromList(img.encodePng(croppedImage));
      /* setState(() {
        displayedImage = pngBytes; // Set the state to display the new image
      }); */
    }

    // Calculate dimensions in centimeters
    const double ppi = 97.0;
    double widthIncm = (cropRect!.width.toInt() / ppi) * 2.54;
    double heightIncm = (cropRect!.height.toInt() / ppi) * 2.54;

    // Save dimensions using UserPreferences
    UserPreferences.setWidthandheight(heightIncm, widthIncm);

    // Calculate aspect ratio
    double ratio = heightIncm / widthIncm;

    if (ratio > 4.5) {
      selectedDiamondPath = 'images/oval.jpeg';
    } else if (4.5 >= ratio && ratio > 4) {
      selectedDiamondPath = 'images/Marquise.jpeg';
    } else if (ratio > 3.5 && ratio < 4) {
      selectedDiamondPath = 'images/emerald.jpeg';
    } else if (ratio < 3.5) {
      selectedDiamondPath = 'images/pear.jpeg';
    }

    // Determine the suitable diamond shape based on the ratio
    /*  if (ratio > 4.5) {
      selectedDiamondPath = 'images/oval.jpeg'; // Tall and thin
    } else if (ratio > 4) {
      selectedDiamondPath = 'images/Marquise.jpeg'; // Short and thin
    } else if (ratio > 3.5) {
      selectedDiamondPath = 'images/emerald.jpeg'; // Tall and chubby
    } else {
      selectedDiamondPath = 'images/pear.jpeg'; // Short and chubby
    } */

    // Update state to show the suitable diamond
    setState(() {
      selectedImagePath = selectedDiamondPath;
    });

    // Show dialog with the selected diamond image
    if (selectedImagePath != null) {
      showImageDialog(context, selectedImagePath!);
    }

    print('Cropped rectangle width in pixels: ${cropRect!.width.toInt()}');
    print('Cropped rectangle height in pixels: ${cropRect!.height.toInt()}');
    print('Cropped rectangle width in cm: $widthIncm');
    print('Cropped rectangle height in cm: $heightIncm');
  }

  void showImageDialog(BuildContext context, String selectedDiamondPath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: kourcolor1.withOpacity(0.7),
                width: 7,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  height: 300,
                  width: 340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      selectedDiamondPath,
                      width: 340,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<img.Image> loadImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return img.decodeImage(bytes)!; // Ensure this does not return null
  }
}
