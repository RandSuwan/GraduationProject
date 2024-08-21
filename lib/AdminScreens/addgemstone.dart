import 'dart:io';
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

class addgemstone extends StatefulWidget {
  const addgemstone({Key? key}) : super(key: key);

  @override
  State<addgemstone> createState() => _addgemstoneState();
}

class _addgemstoneState extends State<addgemstone> {
  String image_url = " ";
  Uint8List? _image;
  File? selectedImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showImagePickerOption(context);
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12.0),
                  strokeWidth: 2,
                  dashPattern: [10, 10],
                  color: kourcolor1,
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.memory(
                                _image!,
                                width: double.infinity,
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
                                  color: kourcolor1,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Add Image here',
                                  style: TextStyle(
                                    color: kourcolor1,
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
              SizedBox(height: 20),
              SizedBox(height: 10),
              buildTextField(_nameController, 'Gemstone Name...'),
              SizedBox(height: 10),
              buildTextField(_descriptionController, 'Gemstone Description...'),
              SizedBox(height: 10),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButton(
                    context,
                    "Cancel",
                    Colors.grey,
                    () {
                      //   Navigator.of(context).pop();
                    },
                  ),
                  buildButton(
                    context,
                    "Save",
                    kourcolor1,
                    () {
                      storeInDB(
                          _nameController.text, _descriptionController.text);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField buildTextField(TextEditingController controller, String hint,
      {bool isNumeric = false}) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[200],
      ),
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters:
          isNumeric ? [FilteringTextInputFormatter.digitsOnly] : [],
    );
  }

  ElevatedButton buildButton(
      BuildContext context, String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 18),
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
                          color: kourcolor1,
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
                          color: kourcolor1,
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

      setState(() {
        image_url = downloadURL;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void storeInDB(String name, String description) async {
    if (image_url == null) {
      print("Failed to upload image or no image was selected.");
      return;
    }

    await itemStoring(name: name, image: image_url, description: description);

    print("Item information and image URL stored successfully.");
  }

  Future<void> itemStoring({
    required String name,
    required String image,
    required String description,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:5000/itemStoring');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'name': name,
          'image': image,
          'description': description,
        },
      );

      if (response.statusCode == 200) {
        print('successful item storing ');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
