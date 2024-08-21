import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HandDetectionChannel {
  static const platform =
      MethodChannel('com.example.my_hand_detection_app/hand_detection');

  static Future<String> detectHand(String imagePath) async {
    try {
      final String result =
          await platform.invokeMethod('detectHand', {'imagePath': imagePath});
      return result;
    } on PlatformException catch (e) {
      return "Failed to detect hand: '${e.message}'.";
    }
  }
}
