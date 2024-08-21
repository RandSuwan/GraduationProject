import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Notify all listening widgets to rebuild.
  }
}
