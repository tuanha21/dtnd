import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class ColorUtil {
  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    /// if [500] is the default color, there are at LEAST five
    /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
    /// divisor of 5 would mean [50] is a lightness of 1.0 or
    /// a color of #ffffff. A value of six would be near white
    /// but not quite.
    const lowDivisor = 6;

    /// if [500] is the default color, there are at LEAST four
    /// steps above [500]. A divisor of 4 would mean [900] is
    /// a lightness of 0.0 or color of #000000
    const highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }

  static Color fromString(String string) {
    switch (string.toLowerCase()) {
      case "green":
        return AppColors.semantic_01;
      case "red":
        return AppColors.semantic_03;
      case "purpil":
        return AppColors.semantic_05;
      case "blue":
        return AppColors.semantic_04;
      default:
        return AppColors.semantic_02;
    }
  }
}

Map<int, Color> greenColorSwatch = {
  50: AppColors.semantic_01.withOpacity(0.1),
  100: AppColors.semantic_01.withOpacity(0.2),
  200: AppColors.semantic_01.withOpacity(0.3),
  300: AppColors.semantic_01.withOpacity(0.4),
  400: AppColors.semantic_01.withOpacity(0.5),
  500: AppColors.semantic_01.withOpacity(0.6),
  600: AppColors.semantic_01.withOpacity(0.7),
  700: AppColors.semantic_01.withOpacity(0.8),
  800: AppColors.semantic_01.withOpacity(0.9),
  900: AppColors.semantic_01.withOpacity(1.0),
};

Map<int, Color> yellowColorSwatch = {
  50: AppColors.semantic_02.withOpacity(0.1),
  100: AppColors.semantic_02.withOpacity(0.2),
  200: AppColors.semantic_02.withOpacity(0.3),
  300: AppColors.semantic_02.withOpacity(0.4),
  400: AppColors.semantic_02.withOpacity(0.5),
  500: AppColors.semantic_02.withOpacity(0.6),
  600: AppColors.semantic_02.withOpacity(0.7),
  700: AppColors.semantic_02.withOpacity(0.8),
  800: AppColors.semantic_02.withOpacity(0.9),
  900: AppColors.semantic_02.withOpacity(1.0),
};

Map<int, Color> redColorSwatch = {
  50: AppColors.semantic_03.withOpacity(0.1),
  100: AppColors.semantic_03.withOpacity(0.2),
  200: AppColors.semantic_03.withOpacity(0.3),
  300: AppColors.semantic_03.withOpacity(0.4),
  400: AppColors.semantic_03.withOpacity(0.5),
  500: AppColors.semantic_03.withOpacity(0.6),
  600: AppColors.semantic_03.withOpacity(0.7),
  700: AppColors.semantic_03.withOpacity(0.8),
  800: AppColors.semantic_03.withOpacity(0.9),
  900: AppColors.semantic_03.withOpacity(1.0),
};

Map<int, Color> purpilColorSwatch = {
  50: AppColors.semantic_05.withOpacity(0.1),
  100: AppColors.semantic_05.withOpacity(0.2),
  200: AppColors.semantic_05.withOpacity(0.3),
  300: AppColors.semantic_05.withOpacity(0.4),
  400: AppColors.semantic_05.withOpacity(0.5),
  500: AppColors.semantic_05.withOpacity(0.6),
  600: AppColors.semantic_05.withOpacity(0.7),
  700: AppColors.semantic_05.withOpacity(0.8),
  800: AppColors.semantic_05.withOpacity(0.9),
  900: AppColors.semantic_05.withOpacity(1.0),
};

Map<int, Color> blueColorSwatch = {
  50: AppColors.semantic_04.withOpacity(0.1),
  100: AppColors.semantic_04.withOpacity(0.2),
  200: AppColors.semantic_04.withOpacity(0.3),
  300: AppColors.semantic_04.withOpacity(0.4),
  400: AppColors.semantic_04.withOpacity(0.5),
  500: AppColors.semantic_04.withOpacity(0.6),
  600: AppColors.semantic_04.withOpacity(0.7),
  700: AppColors.semantic_04.withOpacity(0.8),
  800: AppColors.semantic_04.withOpacity(0.9),
  900: AppColors.semantic_04.withOpacity(1.0),
};

MaterialColor greenColor =
    MaterialColor(AppColors.semantic_01.value, greenColorSwatch);
MaterialColor yellowColor =
    MaterialColor(AppColors.semantic_02.value, yellowColorSwatch);
MaterialColor redColor =
    MaterialColor(AppColors.semantic_03.value, redColorSwatch);
MaterialColor purpilColor =
    MaterialColor(AppColors.semantic_05.value, purpilColorSwatch);
MaterialColor blueColor =
    MaterialColor(AppColors.semantic_04.value, blueColorSwatch);
