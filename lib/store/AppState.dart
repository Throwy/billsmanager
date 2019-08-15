import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class AppState extends Model {
  Brightness _brightness = Brightness.dark;

  Brightness get brightness => _brightness;

  void changeBrightness(Brightness brightness) {
    _brightness = brightness;
    notifyListeners();
  }
}