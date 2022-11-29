import 'package:dtnd/config/helper/app_service_helper.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  AppService._internal();

  static final AppService _instance = AppService._internal();
  static AppService get instance => _instance;

  late final SharedPreferences sharedPreferencesInstance;

  late final Rx<ThemeMode> _themeMode;

  late final Rx<Locale> _locale;

  Rx<ThemeMode> get themeMode => _themeMode;

  Rx<Locale> get locale => _locale;

  factory AppService() => _instance;

  Future<void> initialize(SharedPreferences sharedPreferences) async {
    sharedPreferencesInstance = sharedPreferences;
    final themeMode = sharedPreferencesInstance.getString("ThemeMode");
    print("themeMode $themeMode");
    if (themeMode == null) {
      await sharedPreferencesInstance.setString(
          "ThemeMode", ThemeMode.dark.name);
      _themeMode = Rx<ThemeMode>(ThemeMode.dark);
    } else {
      _themeMode = Rx<ThemeMode>(ThemeModeHelper.fromString(themeMode));
    }

    final languageCode = sharedPreferencesInstance.getString("Locale");
    if (languageCode == null) {
      await sharedPreferencesInstance.setString("Locale", "vi");
      _locale = Rx<Locale>(const Locale("vi", "VN"));
    } else {
      _locale = Rx<Locale>(LocaleHelper.fromLanguageCode(languageCode));
    }
  }

  /// change [ThemeMode] and return [ThemeMode] after change
  Future<ThemeMode> switchTheme() async {
    return _changeThemeMode(themeMode.value.switcher);
  }

  /// change [Locale] and return [Locale] after change
  Future<Locale> switchLanguage() async {
    return _changeLanguage(locale.value.next);
  }

  Future<ThemeMode> _changeThemeMode(ThemeMode themeMode) async {
    _themeMode.value = themeMode;
    print(themeMode.name);
    await sharedPreferencesInstance.setString("ThemeMode", themeMode.name);
    final getThemeMode = sharedPreferencesInstance.getString("ThemeMode");
    print("getThemeMode $getThemeMode");
    return themeMode;
  }

  Future<Locale> _changeLanguage(Locale locale) async {
    _locale.value = locale;
    await S.load(locale);
    return locale;
  }
}
