import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel extends ChangeNotifier {
  static final ThemeModel _instance = ThemeModel._internal();
  factory ThemeModel() => _instance;
  ThemeModel._internal();

  ThemeMode _themeMode = ThemeMode.light;
  SharedPreferencesWithCache? _prefs;
  static const String themeKey = 'THEME_KEY';

  ThemeMode get themeMode => _themeMode;

  Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
                cacheOptions: const SharedPreferencesWithCacheOptions(
                  allowList: <String>{themeKey}),  
              );
    final String themeModeString = _prefs?.getString(themeKey) ?? ThemeMode.light.toString();
    _themeMode = themeModeString == ThemeMode.light.toString() ? ThemeMode.light : ThemeMode.dark;
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    saveThemeMode();
    notifyListeners();
  } 

  void saveThemeMode() async {
    await _prefs?.setString(themeKey, _themeMode.toString());
  }
}