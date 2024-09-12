import 'package:flutter/material.dart';
import 'light_mode.dart';
import 'dark_mode.dart';
import 'dart:async';

enum ThemeType { Light, Dark }

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = lightMode;
  ThemeType _currentThemeType = ThemeType.Light;
  Timer? _timer;

  ThemeData get currentTheme => _currentTheme;
  ThemeType get currentThemeType => _currentThemeType;

  ThemeProvider() {
    _initializeThemeBasedOnTime();
  }

  void _initializeThemeBasedOnTime() {
    DateTime now = DateTime.now();
    if (now.hour >= 19 || now.hour < 6) {
      _currentTheme = lightMode;
      _currentThemeType = ThemeType.Dark;
    } else {
      _currentTheme = lightMode;
      _currentThemeType = ThemeType.Light;
    }

    Duration durationUntilNextThemeChange;
    if (now.hour >= 19) {
      durationUntilNextThemeChange = DateTime(now.year, now.month, now.day + 1, 6, 0, 0)
          .difference(now);
    } else if (now.hour >= 6) {
      durationUntilNextThemeChange = DateTime(now.year, now.month, now.day, 19, 0, 0)
          .difference(now);
    } else {
      durationUntilNextThemeChange = DateTime(now.year, now.month, now.day, 6, 0, 0)
          .difference(now);
    }
    _timer = Timer(durationUntilNextThemeChange, _initializeThemeBasedOnTime);
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  void setLightMode() {
    _currentTheme = lightMode;
    _currentThemeType = ThemeType.Light;
    notifyListeners();
  }

  void setDarkMode() {
    _currentTheme = darkMode;
    _currentThemeType = ThemeType.Dark;
    notifyListeners();
  }
}
