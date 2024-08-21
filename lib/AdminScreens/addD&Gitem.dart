import 'package:flutter/material.dart';
import 'package:project1/AdminScreens/addDiamonditem.dart';
import 'package:project1/AdminScreens/addGolditem.dart';
import 'package:project1/utilities/constants.dart';

class addDGitem extends StatefulWidget {
  const addDGitem({super.key});

  @override
  State<addDGitem> createState() => _addDGitemState();
}

class _addDGitemState extends State<addDGitem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addDiamonditem()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kourcolor1,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Add Diamond Item',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addGolditem()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kourcolor1,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Add Gold Item',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
