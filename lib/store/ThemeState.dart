import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Models the app state regarding the theme.
///
/// This class holds the state of theme brightness.
class ThemeState extends Model {
  final SharedPreferences preferences;
  Brightness _brightness;

  ThemeState({Key key, @required this.preferences});

  /// Initializes the `ThemeState` class.
  ///
  /// This should only be called once, ie. when the app is being opened.
  initThemeState() async {
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
    return this;
  }

  /// Gets the app `Brightness`.
  Brightness get brightness => _brightness;

  /// Changes the brightness of the app to the given `Brightness`.
  /// This value is saved in the SharedPreferences location.
  void changeBrightness(Brightness brightness) {
    _brightness = brightness;
    preferences.setInt("brightness", _brightness.index);
    notifyListeners();
  }

  static ThemeState of(BuildContext context) =>
      ScopedModel.of<ThemeState>(context);
}
