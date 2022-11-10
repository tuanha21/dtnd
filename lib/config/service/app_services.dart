import 'package:dtnd/config/helper/app_service_helper.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appServiceProvider = StateProvider<AppService>((ref) {
  return AppService();
});

final themeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(appServiceProvider.select((value) => value._themeMode));
});

class AppService {
  static late final SharedPreferences sharedPreferencesInstance;

  AppService._internal();

  static final AppService _instance = AppService._internal();

  late ThemeMode _themeMode;

  late Locale _locale;

  ThemeMode get themeMode => _themeMode;

  Locale get locale => _locale;

  factory AppService() {
    return _instance;
  }

  static Future<AppService> initialize() async {
    sharedPreferencesInstance = await SharedPreferences.getInstance();
    final themeMode = sharedPreferencesInstance.getString("ThemeMode");
    if (themeMode == null) {
      await sharedPreferencesInstance.setString(
          "ThemeMode", ThemeMode.dark.name);
      _instance._themeMode = ThemeMode.dark;
    } else {
      _instance._themeMode = ThemeModeHelper.fromString(themeMode);
    }

    final languageCode = sharedPreferencesInstance.getString("Locale");
    if (languageCode == null) {
      await sharedPreferencesInstance.setString("Locale", "vi");
      _instance._locale = const Locale("vi", "VN");
    } else {
      _instance._locale = LocaleHelper.fromLanguageCode(languageCode);
    }
    return _instance;
  }

  /// change [ThemeMode] and return [ThemeMode] after change
  Future<ThemeMode> switchTheme() async {
    return _changeThemeMode(themeMode.switcher);
  }

  /// change [Locale] and return [Locale] after change
  Future<Locale> switchLanguage() async {
    return _changeLanguage(locale.next);
  }

  Future<ThemeMode> _changeThemeMode(ThemeMode themeMode) async {
    print(_instance._themeMode);
    _instance._themeMode = themeMode;
    print(_instance._themeMode);
    await sharedPreferencesInstance.setString("ThemeMode", themeMode.name);
    return themeMode;
  }

  Future<Locale> _changeLanguage(Locale locale) async {
    _instance._locale = locale;
    await S.load(locale);
    return locale;
  }
}
