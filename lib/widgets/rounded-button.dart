import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/AdminScreens/admin_page.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/login1.dart';
import 'package:project1/screens/newpassword.dart';
import 'package:project1/screens/verifyEmail.dart';
import 'package:project1/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:project1/widgets/UserPreferences.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({
    super.key,
    required this.buttonName,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneNumberController,
  });

  final String buttonName;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumberController;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _newpassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFDFDED9),
          title: Text("Password Changed!"),
          content: Text("Your Password has been changed successfully."),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loginpagee()),
                );
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  void _incorrectpassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFDFDED9),
          title: Text("Wrong Password!"),
          content: Text("Please Try Again"),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Ok"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _usernotfound() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFDFDED9),
          title: Text("User Not Found!"),
          content: Text("Please create an account"),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Ok"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _errorinregister() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFDFDED9),
          title: Text("Error!"),
          content: Text("Please Try Again"),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Ok"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showEmptyFieldsError() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFDFDED9),
          title: Text("Empty Fields!"),
          content: Text("Please fill in all fields."),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  bool _validateFields() {
    return widget.emailController.text.isNotEmpty &&
        widget.passwordController.text.isNotEmpty &&
        widget.usernameController.text.isNotEmpty &&
        widget.phoneNumberController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: () async {
          final email = widget.emailController.text;
          final password = widget.passwordController.text;
          final username = widget.usernameController.text;
          final phoneNumber = widget.phoneNumberController.text;

          if (widget.buttonName == "Register") {
            if (_validateFields()) {
              await signUp(
                email: email,
                password: password,
                username: username,
                phoneNumber: phoneNumber,
              );
            } else {
              _showEmptyFieldsError();
            }
          } else if (widget.buttonName == "Login") {
            //if (_validateFields()) {
            await logIn(
              email: email,
              password: password,
              context: context,
            );
            /* } 
            else {
              _showEmptyFieldsError();
            } */
          } else if (widget.buttonName == "Send") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => verifyemail()),
            );
          } else if (widget.buttonName == "Verify") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => newpassword()),
            );
          } else if (widget.buttonName == "Save") {
            _newpassword();
          }
        },
        child: Text(
          widget.buttonName,
          style: TextStyle(
            color: Color(0xA5FFFFFF),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ), //kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kourcolor1,
        ),
      ),
    );
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:5000/signup');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': username,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        print('Signup successful');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => loginpagee()),
        );
      } else {
        _errorinregister();
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> logIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    print("email");
    print(email);

    print("password");
    print(password);

    final ipAddress = await getLocalIPv4Address();
    print("*ipAddress:" + ipAddress);
    final url = Uri.parse('http://$ipAddress:5000/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        UserPreferences.setEmail(email);
        UserPreferences.getName(email);
        UserPreferences.getID(email);
        UserPreferences.getPN(email);

        if (email == "zeina.fawziad@gmail.com" && password == "1234" ||
            email == "rand.nabil.2019@gmail.com" && password == "12345678") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminPage()),
          );
          print("admin");
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
          print("normal user");
        }
        print('Login successful');
      } else if (response.statusCode == 401) {
        print('Incorrect password');
        _incorrectpassword();
      } else if (response.statusCode == 404) {
        print('User not found');
        _usernotfound();
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
