import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';

enum Side { sell, buy }

extension SideX on Side {
  bool get isSell => this == Side.sell;
  bool get isBuy => this == Side.buy;

  String name(BuildContext context) {
    switch (this) {
      case Side.sell:
        return S.of(context).sell;
      case Side.buy:
        return S.of(context).buy;
    }
  }

  Color get kColor {
    switch (this) {
      case Side.sell:
        return AppColors.semantic_01;
      case Side.buy:
        return AppColors.semantic_03;
    }
  }

  Color kBGColor(ThemeMode themeMode) {
    switch (this) {
      case Side.sell:
        if (themeMode.isDark) return AppColors.accent_dark_01;
        return AppColors.accent_light_01;
      case Side.buy:
        if (themeMode.isDark) return AppColors.accent_dark_03;
        return AppColors.accent_light_03;
    }
  }
}
