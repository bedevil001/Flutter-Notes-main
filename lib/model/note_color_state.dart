import 'package:flutter/material.dart';
import 'package:notes_app/utils/const.dart';

class NoteColor with ChangeNotifier {
  Color _color = Color(kColors[0]);

  Color get color => _color;

  set color(Color color) {
    _color = color;
  }

  NoteColor() {
    color = Color(kColors[0]);
  }

  void changeColor(Color color) {
    this.color = color;
    print("change");
    notifyListeners();
  }
}
