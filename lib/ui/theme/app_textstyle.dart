import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static const _defaulTextStyle = TextStyle(
    fontStyle: FontStyle.normal,
  );

  static final displayLarge_57 = _defaulTextStyle.copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w700,
  );
  static final displayMedium_45 = _defaulTextStyle.copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w700,
  );
  static final displaySmall_36 = _defaulTextStyle.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );
  static final headlineLarge_32 = _defaulTextStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );
  static final headlineMedium_28 = _defaulTextStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );
  static final headlineSmall_24 = _defaulTextStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static final titleLarge_22 = _defaulTextStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  static final titleMedium_16 = _defaulTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final titleSmall_14 = _defaulTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static final bodyLarge_16 = _defaulTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static final bodyMedium_14 = _defaulTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static final bodySmall_12 = _defaulTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static final bodySmall_8 = _defaulTextStyle.copyWith(
    fontSize: 8,
    fontWeight: FontWeight.w600,
  );
  static final labelLarge_18 = _defaulTextStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static final labelMedium_12 = _defaulTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static final labelSmall_11 = _defaulTextStyle.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );

  static final labelSmall_10 = _defaulTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static final textButtonTextStyle = _defaulTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static final bottomNavLabel = _defaulTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static final inputErrorText = _defaulTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.error_text,
  );
}
