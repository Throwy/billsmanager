import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Models the app state regarding the theme.
///
/// This class holds the state of theme brightness.
mixin ThemeState on Model {
  SharedPreferences _preferences;
  Brightness _brightness;

  /// Initializes the `ThemeState` class.
  ///
  /// This should only be called once, ie. when the app is being opened.
  Future<ThemeState> initThemeState(SharedPreferences preferences) async {
    _preferences = preferences;
    try {
      if (_preferences.containsKey("brightness")) {
        var brightnessIndex = _preferences.getInt("brightness");
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
    _preferences.setInt("brightness", _brightness.index);
    notifyListeners();
  }

  static ThemeState of(BuildContext context) =>
      ScopedModel.of<ThemeState>(context);
}
