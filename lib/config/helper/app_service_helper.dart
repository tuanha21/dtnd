import 'package:flutter/material.dart';

class ThemeModeHelper {
  static ThemeMode fromString(String themeModeString) {
    final String themeModeStringToUpperCase = themeModeString.toUpperCase();
    if (themeModeStringToUpperCase.contains("DARK")) {
      return ThemeMode.dark;
    } else if (themeModeStringToUpperCase.contains("LIGHT")) {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}

class LocaleHelper {
  static Locale fromLanguageCode(String? code) {
    final String? countryCode = _codeMap[code ?? "vi"];
    return Locale(code ?? "vi", countryCode ?? "VN");
  }

  static const Map<String, String> _codeMap = {
    "vi": "VN",
    "en": "EN",
  };
}

extension ThemeModeX on ThemeMode {
  String get name {
    switch (this) {
      case ThemeMode.dark:
        return "DARK";
      case ThemeMode.light:
        return "LIGHT";
      default:
        return "SYSTEM";
    }
  }

  ThemeMode get switcher {
    switch (this) {
      case ThemeMode.dark:
        return ThemeMode.light;
      case ThemeMode.light:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

extension LocaleX on Locale {
  Locale get next {
    final String languageCode = this.languageCode;
    final List<String> listKey = LocaleHelper._codeMap.keys.toList();
    final int index = listKey.indexOf(languageCode);
    int nextIndex;
    if ((index == -1) || index == (listKey.length - 1)) {
      nextIndex = 0;
    } else {
      nextIndex = index + 1;
    }
    final String nextLanguageCode = listKey[nextIndex];
    final String nextLanguageCountryCode =
        LocaleHelper._codeMap[nextLanguageCode]!;
    return Locale(nextLanguageCode, nextLanguageCountryCode);
  }
}
