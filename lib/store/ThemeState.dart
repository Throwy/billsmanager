import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Models the app state regarding the theme.
///
/// All theme settings are saved in the `SharedPreferences` key value store.
mixin ThemeState on Model {
  SharedPreferences _preferences;
  Brightness _brightness;
  Color _primaryColor;
  Color _accentColor;

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

    try {
      if (_preferences.containsKey("primaryColor")) {
        var primaryColorValue = _preferences.getInt("primaryColor");
        _primaryColor = Color(primaryColorValue);
      } else {
        _primaryColor = Colors.teal;  
      }
    } catch (Exception) {
      _primaryColor = Colors.teal;
    }

    try {
      if (_preferences.containsKey("accentColor")) {
        var accentColorValue = _preferences.getInt("accentColor");
        _accentColor = Color(accentColorValue);
      } else {
        _accentColor = Colors.tealAccent;  
      }
    } catch (Exception) {
      _accentColor = Colors.tealAccent;
    }
    return this;
  }

  /// Gets the app's `Brightness`.
  Brightness get brightness => _brightness;

  /// Gets the app's primary `Color`.
  Color get primaryColor => _primaryColor;

  /// Gets the app's accent `Color`.
  Color get accentColor => _accentColor;

  /// Changes the brightness of the app to the given `Brightness`.
  void changeBrightness(Brightness brightness) {
    _brightness = brightness;
    _preferences.setInt("brightness", _brightness.index);
    notifyListeners();
  }

  /// Changes the primary color of the app to the given `Color`.
  void changePrimaryColor(Color color) {
    _primaryColor = color;
    _preferences.setInt("primaryColor", color.value);
    notifyListeners();
  }

  void changeAccentColor(Color color) {
    _accentColor = color;
    _preferences.setInt("accentColor", color.value);
    notifyListeners();
  }

  static ThemeState of(BuildContext context) =>
      ScopedModel.of<ThemeState>(context);
}
