import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

///================ TEXT ===================
const _lightTextColor = AppColors.neutral_01;
const _darkTextColor = Colors.white;

final TextTheme lightTextTheme = TextTheme(
  displayLarge: AppTextStyle.displayLarge_57.copyWith(color: _lightTextColor),
  displayMedium: AppTextStyle.displayMedium_45.copyWith(color: _lightTextColor),
  displaySmall: AppTextStyle.displaySmall_36.copyWith(color: _lightTextColor),
  headlineLarge: AppTextStyle.headlineLarge_32.copyWith(color: _lightTextColor),
  headlineMedium:
      AppTextStyle.headlineMedium_28.copyWith(color: _lightTextColor),
  headlineSmall: AppTextStyle.headlineSmall_24.copyWith(color: _lightTextColor),
  titleLarge: AppTextStyle.titleLarge_22.copyWith(color: _lightTextColor),
  titleMedium: AppTextStyle.titleMedium_16.copyWith(color: _lightTextColor),
  titleSmall: AppTextStyle.titleSmall_14.copyWith(color: AppColors.neutral_02),
  bodyLarge: AppTextStyle.bodyLarge_16.copyWith(color: _lightTextColor),
  bodyMedium: AppTextStyle.bodyMedium_14.copyWith(color: _lightTextColor),
  bodySmall: AppTextStyle.bodySmall_12.copyWith(color: _lightTextColor),
  labelLarge: AppTextStyle.labelLarge_18.copyWith(color: _lightTextColor),
  labelMedium: AppTextStyle.labelMedium_12.copyWith(color: _lightTextColor),
  labelSmall: AppTextStyle.labelSmall_11.copyWith(color: _lightTextColor),
);

final TextTheme darkTextTheme = TextTheme(
  displayLarge: AppTextStyle.displayLarge_57.copyWith(color: _darkTextColor),
  displayMedium: AppTextStyle.displayMedium_45.copyWith(color: _darkTextColor),
  displaySmall: AppTextStyle.displaySmall_36.copyWith(color: _darkTextColor),
  headlineLarge: AppTextStyle.headlineLarge_32.copyWith(color: _darkTextColor),
  headlineMedium:
      AppTextStyle.headlineMedium_28.copyWith(color: _darkTextColor),
  headlineSmall: AppTextStyle.headlineSmall_24.copyWith(color: _darkTextColor),
  titleLarge: AppTextStyle.titleLarge_22.copyWith(color: _darkTextColor),
  titleMedium: AppTextStyle.titleMedium_16.copyWith(color: _darkTextColor),
  titleSmall: AppTextStyle.titleSmall_14.copyWith(color: AppColors.neutral_03),
  bodyLarge: AppTextStyle.bodyLarge_16.copyWith(color: _darkTextColor),
  bodyMedium: AppTextStyle.bodyMedium_14.copyWith(color: _darkTextColor),
  bodySmall: AppTextStyle.bodySmall_12.copyWith(color: _darkTextColor),
  labelLarge: AppTextStyle.labelLarge_18.copyWith(color: _darkTextColor),
  labelMedium: AppTextStyle.labelMedium_12.copyWith(color: _darkTextColor),
  labelSmall: AppTextStyle.labelSmall_11.copyWith(color: _darkTextColor),
);

///================ INPUT DECORATION ===================

const InputBorder _defaulBorder = OutlineInputBorder(
  borderSide: BorderSide(color: AppColors.neutral_03, width: 1),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

final TextStyle labelStyle =
    AppTextStyle.labelLarge_18.copyWith(color: AppColors.text_main);

final InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  labelStyle: AppTextStyle.labelMedium_12.copyWith(color: AppColors.neutral_01),
  filled: true,
  fillColor: Colors.transparent,
  focusColor: Colors.transparent,
  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  floatingLabelAlignment: FloatingLabelAlignment.start,
  floatingLabelBehavior: FloatingLabelBehavior.always,
  hintStyle: AppTextStyle.titleSmall_14.copyWith(
    color: AppColors.neutral_03,
  ),
  border: _defaulBorder,
  enabledBorder: _defaulBorder,
  disabledBorder: _defaulBorder,
  focusedBorder: _defaulBorder.copyWith(
    borderSide: const BorderSide(color: AppColors.primary_01, width: 1),
  ),
  errorBorder: _defaulBorder.copyWith(
    borderSide: const BorderSide(color: AppColors.error_input_border, width: 1),
  ),
  focusedErrorBorder: _defaulBorder.copyWith(
    borderSide: const BorderSide(color: AppColors.error_input_border, width: 1),
  ),
);

final InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  labelStyle: AppTextStyle.labelMedium_12.copyWith(color: AppColors.neutral_05),
  filled: true,
  fillColor: Colors.transparent,
  focusColor: Colors.transparent,
  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  floatingLabelAlignment: FloatingLabelAlignment.start,
  floatingLabelBehavior: FloatingLabelBehavior.always,
  hintStyle: AppTextStyle.titleSmall_14.copyWith(
    color: AppColors.neutral_02,
  ),
  border: _defaulBorder,
  enabledBorder: _defaulBorder,
  disabledBorder: _defaulBorder,
  focusedBorder: _defaulBorder.copyWith(
    borderSide: const BorderSide(color: AppColors.primary_01, width: 1),
  ),
  errorBorder: _defaulBorder.copyWith(
    borderSide: const BorderSide(color: AppColors.error_input_border, width: 1),
  ),
  focusedErrorBorder: _defaulBorder.copyWith(
    borderSide: const BorderSide(color: AppColors.error_input_border, width: 1),
  ),
);

final ButtonStyle _lightTextButtonThemeData = ButtonStyle(
  backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
    if (states.contains(MaterialState.disabled)) {
      return AppColors.neutral_05;
    } else {
      return AppColors.primary_01;
    }
  }),
  foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
    if (states.contains(MaterialState.disabled)) {
      return AppColors.neutral_03;
    } else {
      return AppColors.neutral_07;
    }
  }),
  padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
);

final ButtonStyle _darkTextButtonThemeData = ButtonStyle(
  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)))),
  backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
    if (states.contains(MaterialState.disabled)) {
      return AppColors.neutral_02;
    } else {
      return AppColors.primary_01;
    }
  }),
  foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
    return AppColors.neutral_07;
  }),
  padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
);

///================ BottomAppBar ===================

const BottomAppBarTheme _lightBottomAppBarTheme = BottomAppBarTheme(
  color: Colors.white,
);

const BottomAppBarTheme _darkBottomAppBarTheme = BottomAppBarTheme(
  color: Colors.black,
);

///================ Color Scheme ===================

const ColorScheme _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary_01,
  onPrimary: Colors.white,
  secondary: AppColors.secondary,
  onSecondary: Colors.white,
  error: AppColors.error_text,
  onError: Colors.white,
  background: Colors.white,
  onBackground: Colors.black,
  surface: AppColors.primary_01,
  onSurface: Colors.white,
);
const ColorScheme _darkColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary_01,
  onPrimary: Colors.white,
  secondary: AppColors.secondary,
  onSecondary: Colors.white,
  error: AppColors.error_text,
  onError: Colors.white,
  background: Colors.black,
  onBackground: Colors.white,
  surface: AppColors.primary_01,
  onSurface: Colors.white,
);

///================ THEME DATA ===================

final ThemeData lightThemeData = ThemeData(
  textTheme: lightTextTheme,
  inputDecorationTheme: lightInputDecorationTheme,
  colorScheme: _lightColorScheme,
  textButtonTheme: TextButtonThemeData(style: _lightTextButtonThemeData),
);

final ThemeData darkThemeData = ThemeData(
  textTheme: darkTextTheme,
  inputDecorationTheme: darkInputDecorationTheme,
  colorScheme: _darkColorScheme,
  textButtonTheme: TextButtonThemeData(style: _darkTextButtonThemeData),
);
