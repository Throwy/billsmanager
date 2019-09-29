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
  Color _primaryColorDark;
  Color _primaryColorLight;
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
        var primaryColorDarkValue = _preferences.getInt("primaryColorDark");
        var primaryColorLightValue = _preferences.getInt("primaryColorLight");
        _primaryColor = Color(primaryColorValue);
        _primaryColorDark = Color(primaryColorDarkValue);
        _primaryColorLight = Color(primaryColorLightValue);
      } else {
        _primaryColor = Colors.deepPurple;
        _primaryColorDark = Colors.deepPurple[700];
        _primaryColorLight = Colors.deepPurple[200];
      }
    } catch (Exception) {
      _primaryColor = Colors.deepPurple;
      _primaryColorDark = Colors.deepPurple[700];
      _primaryColorLight = Colors.deepPurple[200];
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

  /// Gets the app's primaryLight `Color`.
  Color get primaryColorDark => _primaryColorDark;

  /// Gets the app's primaryDarl `Color`.
  Color get primaryColorLight => _primaryColorLight;

  /// Gets the app's accent `Color`.
  Color get accentColor => _accentColor;

  /// Changes the brightness of the app to the given `Brightness`.
  void changeBrightness(Brightness brightness) {
    _brightness = brightness;
    _preferences.setInt("brightness", _brightness.index);
    notifyListeners();
  }

  /// Changes the primary color of the app to the given `Color`.
  void changePrimaryColor(ColorSwatch color) {
    _primaryColor = color[500];
    _primaryColorDark = color[700];
    _primaryColorLight = color[200];
    _preferences.setInt("primaryColor", _primaryColor.value);
    _preferences.setInt("primaryColorDark", _primaryColorDark.value);
    _preferences.setInt("primaryColorLight", _primaryColorLight.value);
    notifyListeners();
  }

  void changeAccentColor(Color color) {
    _accentColor = color;
    _preferences.setInt("accentColor", _accentColor.value);
    notifyListeners();
  }

  void resetToDefault() {
    _brightness = Brightness.dark;
    _primaryColor = Colors.deepPurple;
    _primaryColorDark = Colors.deepPurple[700];
    _primaryColorLight = Colors.deepPurple[200];
    _accentColor = Colors.tealAccent;
    _preferences.setInt("brightness", _brightness.index);
    _preferences.setInt("primaryColor", _primaryColor.value);
    _preferences.setInt("primaryColorDark", _primaryColorDark.value);
    _preferences.setInt("primaryColorLight", _primaryColorLight.value);
    _preferences.setInt("accentColor", _accentColor.value);
    notifyListeners();
  }

  static ThemeState of(BuildContext context) =>
      ScopedModel.of<ThemeState>(context);
}
