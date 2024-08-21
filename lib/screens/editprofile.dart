import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:project1/widgets/UserPreferences.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  bool iseditingUsername = false;
  bool iseditingEmail = false;
  bool iseditingPhoneNumber = false;
  bool iseditingPassword = false;
  String userID = "";

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // late Future<bool> futureUsername;

  @override
  void initState() {
    super.initState();
    usernameController.text = UserPreferences.getUserName()!;
    emailController.text = UserPreferences.getEmail()!;
    phoneNumberController.text = UserPreferences.getUserPN()!;
    passwordController.text = "87654321";
    _initializeWishlist();

    // futureUsername = editUsername(UserPreferences.getUserID()!,usernameController.text);
  }

  void _initializeWishlist() async {
    String? email = await UserPreferences.getEmail();
    if (email != null) {
      String userId = await UserPreferences.getUserIdByEmail(email);
      if (mounted) {
        setState(() {
          userID = userId;
        });
      }
    } else {
      // Handle case when email is null, perhaps navigate to login or show an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: kourcolor1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFC1C0C0),
        iconTheme: IconThemeData(color: kourcolor1),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () async {
              String? username = usernameController.text;
              String? id = UserPreferences.getUserID();
              String? email = emailController.text;
              // await editUsername(id!, username);
              // await editEmail(id, email);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Changes saved successfully',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            child: Container(
              child: Text('Save    ',
                  style: TextStyle(
                    color: kourcolor1,
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFC1C0C0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            /*  SizedBox(
              height: 20,
            ), */
            editfield('Username', iseditingUsername, usernameController, false,
                () {
              setState(() {
                if (iseditingUsername) {
                  editUsername(userID, usernameController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Username is edited',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
                iseditingUsername = !iseditingUsername;
              });
            }),
            editfield('Email', iseditingEmail, emailController, false, () {
              setState(() {
                if (iseditingEmail) {
                  editEmail(userID, emailController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Email is edited',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
                iseditingEmail = !iseditingEmail;
              });
            }),
            editfield('Phone Number', iseditingPhoneNumber,
                phoneNumberController, false, () {
              setState(() {
                if (iseditingPhoneNumber) {
                  editPhoneNumber(userID, phoneNumberController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Phone number is edited',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
                iseditingPhoneNumber = !iseditingPhoneNumber;
              });
            }),
            editfield('Password', iseditingPassword, passwordController, true,
                () {
              setState(() {
                if (iseditingPassword) {
                  if (newpasswordController.text ==
                      confirmPasswordController.text) {
                    editPassword(userID, newpasswordController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Password is edited',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                    iseditingPassword = false;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Passwords do not match!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                } else {
                  iseditingPassword = true;
                }
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget editfield(String label, bool isEditing,
      TextEditingController controller, bool isPassword, VoidCallback onEdit) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kourcolor1,
                  ),
                ),
                IconButton(
                  icon: Icon(isEditing ? Icons.check : Icons.edit,
                      color: kourcolor1),
                  onPressed: onEdit,
                ),
              ],
            ),
            SizedBox(height: 8),
            if (isEditing)
              isPassword
                  ? Column(
                      children: [
                        TextField(
                          controller: controller,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Old Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: newpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'New Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                      ],
                    )
                  : TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    )
            else
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isPassword ? '••••••••' : controller.text,
                      style: TextStyle(fontSize: 16, color: kourcolor1),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> editUsername(String userId, String newUsername) async {
    final ipAddress = await getLocalIPv4Address();

    try {
      final response = await http.put(
        Uri.parse('http://$ipAddress:5000/editUsername/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{'newUsername': newUsername}),
      );

      if (response.statusCode == 200) {
        UserPreferences.setUserName(newUsername);
        print('Username updated successfully.');
      } else {
        print('Failed to update username: ${response.body}');
      }
    } catch (e) {
      print('Error updating username: $e');
    }
  }

  Future<void> editEmail(String userId, String newEmail) async {
    final ipAddress = await getLocalIPv4Address();

    try {
      final response = await http.put(
        Uri.parse('http://$ipAddress:5000/editEmail/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{'newEmail': newEmail}),
      );

      if (response.statusCode == 200) {
        UserPreferences.setEmail(newEmail);
        print('Email updated successfully.');
      } else {
        print('Failed to update email: ${response.body}');
      }
    } catch (e) {
      print('Error updating email: $e');
    }
  }

  Future<void> editPhoneNumber(String userId, String newPhoneNumber) async {
    final ipAddress = await getLocalIPv4Address();
    print("userr id: $userID");

    try {
      final response = await http.put(
        Uri.parse('http://$ipAddress:5000/editPhoneNumber/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{'newPhoneNumber': newPhoneNumber}),
      );

      if (response.statusCode == 200) {
        UserPreferences.setUserPN(newPhoneNumber);
        print('Phone number updated successfully.');
        // return true;
      } else {
        print('Failed to update phone number: ${response.body}');
        // return false;
      }
    } catch (e) {
      print('Error updating phone number: $e');
      // return false;
    }
  }

  Future<void> editPassword(String userId, String newPassword) async {
    final ipAddress = await getLocalIPv4Address();

    try {
      final response = await http.put(
        Uri.parse('http://$ipAddress:5000/editPassword/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{'newPassword': newPassword}),
      );

      if (response.statusCode == 200) {
        print('Password updated successfully.');
      } else {
        print('Failed to update password: ${response.body}');
      }
    } catch (e) {
      print('Error updating password: $e');
    }
  }
}
