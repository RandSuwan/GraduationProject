import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';

class AddGoldPrice extends StatefulWidget {
  const AddGoldPrice({super.key});

  @override
  State<AddGoldPrice> createState() => _AddGoldPriceState();
}

class _AddGoldPriceState extends State<AddGoldPrice> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _karat24Controller = TextEditingController();
  final TextEditingController _karat22Controller = TextEditingController();
  final TextEditingController _karat18Controller = TextEditingController();
  final TextEditingController _karat14Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter today\'s gold price:',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kourcolor1),
              ),
              SizedBox(height: 20),
              buildTextField('24 Karat', _karat24Controller),
              buildTextField('22 Karat', _karat22Controller),
              buildTextField('18 Karat', _karat18Controller),
              buildTextField('14 Karat', _karat14Controller),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Gold Price added successfully',
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
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: kourcolor1,
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the price';
          }
          return null;
        },
      ),
    );
  }
}
