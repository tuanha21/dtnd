import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

///================ TEXT ===================
const _lightTextColor = AppColors.neutral_01;
const _darkTextColor = Colors.white;

final TextTheme lightTextTheme = TextTheme(
  displayLarge: AppTextStyle.displayLarge_57.copyWith(color: _lightTextColor),
  displayMedium: AppTextStyle.displayMedium_45.copyWith(color: _lightTextColor),
  displaySmall:
      AppTextStyle.displaySmall_36.copyWith(color: AppColors.neutral_03),
  headlineLarge: AppTextStyle.headlineLarge_32.copyWith(color: _lightTextColor),
  headlineMedium:
      AppTextStyle.headlineMedium_28.copyWith(color: _lightTextColor),
  headlineSmall: AppTextStyle.headlineSmall_24.copyWith(color: _lightTextColor),
  titleLarge: AppTextStyle.titleLarge_22.copyWith(color: _lightTextColor),
  titleMedium: AppTextStyle.titleMedium_16.copyWith(color: _lightTextColor),
  titleSmall: AppTextStyle.titleSmall_14.copyWith(color: _lightTextColor),
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
  displaySmall:
      AppTextStyle.displaySmall_36.copyWith(color: AppColors.neutral_04),
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
  floatingLabelStyle:
      AppTextStyle.labelMedium_12.copyWith(color: AppColors.neutral_01),
  hintStyle: AppTextStyle.bodyMedium_14.copyWith(color: AppColors.neutral_04),
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
  suffixStyle: AppTextStyle.labelSmall_10.copyWith(
    color: AppColors.neutral_03,
  ),
);

final InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  labelStyle: AppTextStyle.labelMedium_12.copyWith(color: AppColors.neutral_05),
  filled: true,
  fillColor: Colors.transparent,
  focusColor: Colors.transparent,
  iconColor: Colors.white,
  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  floatingLabelAlignment: FloatingLabelAlignment.start,
  floatingLabelBehavior: FloatingLabelBehavior.always,
  floatingLabelStyle:
      AppTextStyle.labelMedium_12.copyWith(color: AppColors.neutral_05),
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
  suffixStyle: AppTextStyle.labelSmall_10.copyWith(
    color: AppColors.neutral_03,
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
  padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),
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
  padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),
);

final BottomNavigationBarThemeData _lightBottomNavigationBarThemeData =
    BottomNavigationBarThemeData(
  backgroundColor: AppColors.neutral_07,
  elevation: 4.0,
  type: BottomNavigationBarType.fixed,
  showSelectedLabels: true,
  showUnselectedLabels: true,
  selectedIconTheme: const IconThemeData(
    color: AppColors.primary_01,
    opacity: 1.0,
    size: 20,
  ),
  unselectedIconTheme: const IconThemeData(
    color: AppColors.neutral_03,
    opacity: 1.0,
    size: 20,
  ),
  selectedLabelStyle:
      AppTextStyle.bottomNavLabel.copyWith(color: AppColors.primary_01),
  unselectedLabelStyle:
      AppTextStyle.bottomNavLabel.copyWith(color: AppColors.neutral_03),
);
final BottomNavigationBarThemeData _darkBottomNavigationBarThemeData =
    BottomNavigationBarThemeData(
  backgroundColor: AppColors.text_black_1,
  elevation: 4.0,
  type: BottomNavigationBarType.fixed,
  showSelectedLabels: true,
  showUnselectedLabels: true,
  selectedItemColor: AppColors.primary_01,
  unselectedItemColor: AppColors.neutral_03,
  selectedIconTheme: const IconThemeData(
    color: AppColors.primary_01,
    opacity: 1.0,
    size: 20,
  ),
  unselectedIconTheme: const IconThemeData(
    color: AppColors.neutral_03,
    opacity: 1.0,
    size: 20,
  ),
  selectedLabelStyle:
      AppTextStyle.bottomNavLabel.copyWith(color: AppColors.primary_01),
  unselectedLabelStyle:
      AppTextStyle.bottomNavLabel.copyWith(color: AppColors.neutral_03),
);

final AppBarTheme _lightAppBarTheme = AppBarTheme(
  elevation: 0.0,
  titleSpacing: 16.0,
  backgroundColor: AppColors.bg_1,
  foregroundColor: AppColors.neutral_01,
  centerTitle: false,
  titleTextStyle: AppTextStyle.headlineSmall_24.copyWith(
    color: AppColors.neutral_01,
    fontWeight: FontWeight.w700,
  ),
);

final AppBarTheme _darkAppBarTheme = AppBarTheme(
  elevation: 0.0,
  titleSpacing: 16.0,
  backgroundColor: AppColors.bg_2,
  foregroundColor: AppColors.neutral_07,
  centerTitle: false,
  titleTextStyle: AppTextStyle.headlineSmall_24.copyWith(
    color: AppColors.neutral_07,
    fontWeight: FontWeight.w700,
  ),
);

final TabBarTheme _lightTabBarTheme = TabBarTheme(
  indicator: const UnderlineTabIndicator(
    borderSide: BorderSide(
      width: 2.0,
      color: AppColors.primary_01,
    ),
  ),
  indicatorSize: TabBarIndicatorSize.tab,
  labelColor: AppColors.neutral_01,
  unselectedLabelColor: AppColors.neutral_04,
  labelStyle: AppTextStyle.titleSmall_14.copyWith(fontWeight: FontWeight.w600),
  unselectedLabelStyle:
      AppTextStyle.titleSmall_14.copyWith(fontWeight: FontWeight.w600),
);

final TabBarTheme _darkTabBarTheme = TabBarTheme(
  indicator: const UnderlineTabIndicator(
    borderSide: BorderSide(
      width: 2.0,
      color: AppColors.primary_01,
    ),
  ),
  indicatorSize: TabBarIndicatorSize.tab,
  labelColor: AppColors.neutral_07,
  unselectedLabelColor: AppColors.neutral_04,
  labelStyle: AppTextStyle.titleSmall_14.copyWith(fontWeight: FontWeight.w600),
  unselectedLabelStyle:
      AppTextStyle.titleSmall_14.copyWith(fontWeight: FontWeight.w600),
);

const IconThemeData _lightIconThemeData =
    IconThemeData(color: AppColors.primary_01);

const IconThemeData _darkIconThemeData =
    IconThemeData(color: AppColors.neutral_07);

///================ BottomAppBar ===================

const BottomAppBarTheme lightBottomAppBarTheme = BottomAppBarTheme(
  color: Colors.white,
);

const BottomAppBarTheme darkBottomAppBarTheme = BottomAppBarTheme(
  color: Colors.black,
);

const BottomSheetThemeData _lightBottomSheetTheme = BottomSheetThemeData(
  modalBackgroundColor: AppColors.bg_1,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.vertical(
      top: Radius.circular(24),
    ),
  ),
);

const BottomSheetThemeData _darkBottomSheetTheme = BottomSheetThemeData(
  modalBackgroundColor: AppColors.bg_2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.vertical(
      top: Radius.circular(24),
    ),
  ),
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
  surface: AppColors.neutral_03,
  onSurface: Colors.white,
);
const ColorScheme _darkColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary_01,
  onPrimary: AppColors.neutral_07,
  secondary: AppColors.secondary,
  onSecondary: Colors.white,
  error: AppColors.error_text,
  onError: Colors.white,
  background: Colors.black,
  onBackground: Colors.white,
  surface: Colors.black,
  onSurface: Colors.white,
);

final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))));

///================ THEME DATA ===================

final ThemeData lightThemeData = ThemeData(
    scaffoldBackgroundColor: AppColors.bg_1,
    textTheme: lightTextTheme,
    inputDecorationTheme: lightInputDecorationTheme,
    colorScheme: _lightColorScheme,
    textButtonTheme: TextButtonThemeData(style: _lightTextButtonThemeData),
    bottomNavigationBarTheme: _lightBottomNavigationBarThemeData,
    appBarTheme: _lightAppBarTheme,
    iconTheme: _lightIconThemeData,
    tabBarTheme: _lightTabBarTheme,
    bottomSheetTheme: _lightBottomSheetTheme,
    elevatedButtonTheme: _elevatedButtonTheme);

final ThemeData darkThemeData = ThemeData(
  scaffoldBackgroundColor: AppColors.bg_2,
  textTheme: darkTextTheme,
  inputDecorationTheme: darkInputDecorationTheme,
  colorScheme: _darkColorScheme,
  textButtonTheme: TextButtonThemeData(style: _darkTextButtonThemeData),
  bottomNavigationBarTheme: _darkBottomNavigationBarThemeData,
  appBarTheme: _darkAppBarTheme,
  iconTheme: _darkIconThemeData,
  tabBarTheme: _darkTabBarTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  bottomSheetTheme: _darkBottomSheetTheme,
);
