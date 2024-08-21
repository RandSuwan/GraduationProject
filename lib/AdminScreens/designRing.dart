/* // ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:project1/ipaddress.dart';
import 'package:project1/AdminScreens/admin_page.dart';
import 'package:project1/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:project1/widgets/text-field-input.dart';
import 'package:intl/intl.dart';

class designRing extends StatefulWidget {
  const designRing({super.key});

  @override
  State<designRing> createState() => _designRingState();
}

class _designRingState extends State<designRing> {
  String image_url = " ";
  Uint8List? _image;
  File? selectedImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 200),
            GestureDetector(
              onTap: () {
                showImagePickerOption(context);
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(8.0),
                strokeWidth: 2,
                dashPattern: [15, 15],
                color: kourcolor1, // Change color to your desired color
                child: Container(
                  width: 340,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.memory(
                              _image!,
                              width: 340,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                size: 100,
                                color: kourcolor1, // Change color
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Add Image here',
                                style: TextStyle(
                                  color: kourcolor1, // Change color
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Item Name...',
              ),
              controller: _nameController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Item Price...',
              ),
              controller: _priceController,
            ),
            ElevatedButton(
              onPressed: () {
                storeInDB(
                  _nameController.text,
                  _priceController.text,
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  kourcolor1,
                ),
                fixedSize: MaterialStateProperty.all(
                  const Size(160, 50),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(),
                ),
              ),
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
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
                          color: kourcolor1, // Change color
                        ),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 70,
                          color: kourcolor1, // Change color
                        ),
                        Text("Camera"),
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
      uploadImage();
    });
    Navigator.of(context).pop();
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
      uploadImage();
    });
    Navigator.of(context).pop();
  }

  void uploadImage() async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    // var random = Random();
    // int randomNumber = random.nextInt(10000);
    if (selectedImage == null) {
      return;
    }

    try {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('items')
          .child('item_${uniqueFileName}_100.jpg');

      await storageRef.putFile(selectedImage!);

      String downloadURL = await storageRef.getDownloadURL();

      print('Image uploaded successfully. Download URL: $downloadURL');

      image_url = downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  //////////////////////////////Edit///////////////////////////////////
  void storeInDB(String name, String price) async {
    if (image_url == null) {
      print("Failed to upload image or no image was selected.");
      return;
    }

    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(now);

    // Assuming itemStoring is defined to take all these parameters and store them in MongoDB
    await DYRStoring(name: name, price: price, image: image_url, date: date);

    print("DYR Item information and image URL stored successfully.");
  }

  //////////////////////////////////////////////////////////////////////
  Future<void> DYRStoring({
    required String name,
    required String price,
    required String image,
    required String date,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:5000/DYRStoring');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'name': name,
          'price': price,
          'image': image_url,
          'date': date,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('successful DYR item storing ');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }
}
 */