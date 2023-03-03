import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

enum Side { sell, buy }

extension SideX on Side {
  bool get isSell => this == Side.sell;
  bool get isBuy => this == Side.buy;

  String get code => isBuy ? "B" : "S";

  String nameShort(BuildContext context) {
    switch (this) {
      case Side.sell:
        return S.of(context).sell_short;
      case Side.buy:
        return S.of(context).buy_short;
    }
  }

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
        return AppColors.semantic_03;
      case Side.buy:
        return AppColors.semantic_01;
    }
  }

  Color kBGColor(ThemeMode themeMode) {
    switch (this) {
      case Side.sell:
        if (themeMode.isDark) return AppColors.accent_dark_03;
        return AppColors.accent_light_01;
      case Side.buy:
        if (themeMode.isDark) return AppColors.accent_dark_01;
        return AppColors.accent_light_03;
    }
  }
}

class SideHelper {
  static Side fromString(String string) {
    switch (string) {
      case "B":
        return Side.buy;
      case "S":
        return Side.sell;
      default:
        throw Exception();
    }
  }
}
