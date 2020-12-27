import 'package:flutter/cupertino.dart';

class CurrentView with ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void setView(index) {
    _index = index;
    notifyListeners();
  }
}
