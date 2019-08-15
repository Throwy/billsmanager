import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends Model {
  final SharedPreferences preferences;
  Brightness _brightness;

  AppState({Key key, @required this.preferences}) {
    try {
      if (preferences.containsKey("brightness")) {
        var brightnessIndex = preferences.getInt("brightness");
        _brightness = Brightness.values[brightnessIndex];
      } else {
        _brightness = Brightness.dark;
      }
    } catch (Exception) {
      _brightness = Brightness.dark;
    }
  }

  Brightness get brightness => _brightness;

  void changeBrightness(Brightness brightness) {
    _brightness = brightness;
    preferences.setInt("brightness", _brightness.index);
    notifyListeners();
  }

  static AppState of(BuildContext context) => ScopedModel.of<AppState>(context);
}
