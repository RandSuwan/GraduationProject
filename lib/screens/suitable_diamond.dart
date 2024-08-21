import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/utilities/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lottie/lottie.dart';
import 'package:project1/widgets/ImageDrawPage.dart';
import 'package:project1/widgets/UserPreferences.dart';
import 'package:project1/widgets/background-image.dart';
import 'package:project1/widgets/handdetection.dart';

class SuitableDiamond extends StatefulWidget {
  const SuitableDiamond({Key? key}) : super(key: key);

  @override
  State<SuitableDiamond> createState() => _SuitableDiamondState();
}

class _SuitableDiamondState extends State<SuitableDiamond>
    with SingleTickerProviderStateMixin {
  File? selectedImage;
  Uint8List? _image;
  String imageUrl = " ";
  String? selectedImagePath;

  late AnimationController _animationController;
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: BackgroundImage(
              image: 'images/bg2.jpg',
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          size: 30,
                          Icons.arrow_back_ios,
                          color: Color(0xFFF1D2D4),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Lottie.network(
                    'https://lottie.host/beac8430-4aa1-4286-a6ff-eeff0c5bafb7/fjEUJlZNnq.json',
                    width: 200,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "PLEASE ENTER YOUR FINGER MEASURMENTS",
                  style: TextStyle(color: Color(0xFFF7CCFC), fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFF7CCFC),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(width: 2, color: Color(0xFFDFDED9)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Height...",
                              hintStyle: TextStyle(
                                  color: Color(0xFF946699), fontSize: 20),
                              border: InputBorder.none,
                            ),
                            controller: _heightController,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFF7CCFC),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(width: 2, color: Color(0xFFDFDED9)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Width...",
                              hintStyle: TextStyle(
                                  color: Color(0xFF946699), fontSize: 20),
                              border: InputBorder.none,
                            ),
                            controller: _widthController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      calculate(_heightController.text, _widthController.text);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFF7CCFC)),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: Text(
                      'Enter',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF946699),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () => uploadimage(context),
                  child: Container(
                    child: Text(
                        'DONT KNOW YOUR FINGER SIZE? \n              LETS HELP YOU!',
                        style: TextStyle(
                          color: Color(0xFFF7CCFC),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color(0xFFF7CCFC)))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void calculate(String height, String width) {
    double heightt = double.parse(height);
    double widthh = double.parse(width);

    double result = heightt / widthh;
    String imagePath = " ";

    if (result > 4.5) {
      imagePath = 'images/oval.jpeg';
    } else if (4.5 >= result && result > 4) {
      imagePath = 'images/Marquise.jpeg';
    } else if (result > 3.5 && result < 4) {
      imagePath = 'images/emerald.jpeg';
    } else if (result < 3.5) {
      imagePath = 'images/pear.jpeg';
    }

    setState(() {
      selectedImagePath = imagePath;
    });

    if (selectedImagePath != null) {
      showImageDialog(context, selectedImagePath!);
    }
  }

  void showImageDialog(BuildContext context, String imagePath) {
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
                      imagePath,
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

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color(0xFFF7CCFC),
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 8.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 70,
                          color: Color(0xFF946699),
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(color: Color(0xFF946699)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImageDrawPage(image: selectedImage!)),
    );
  }

  Future uploadimage(BuildContext context) async {
    showImagePickerOption(context);
  }
}
