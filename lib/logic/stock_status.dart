import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';

enum SStatus { ref, up, down, ceil, floor }

abstract class StockStatus {
  SStatus get sstatus;

  Color get color {
    switch (sstatus) {
      case SStatus.ref:
        return AppColors.semantic_02;
      case SStatus.up:
        return AppColors.semantic_01;
      case SStatus.down:
        return AppColors.semantic_03;
      case SStatus.ceil:
        return AppColors.semantic_05;
      case SStatus.floor:
        return AppColors.semantic_04;
    }
  }

  Color bgColor(ThemeMode themeMode) {
    if (themeMode.isDark) {
      switch (sstatus) {
        // case SStatus.ref:
        //   return AppColors.ac;
        case SStatus.up:
          return AppColors.accent_dark_01;
        case SStatus.down:
          return AppColors.accent_dark_03;
        // case SStatus.ceil:
        //   return AppColors.accent_light_05;
        // case SStatus.floor:
        //   return AppColors.accent_light_04;
        default:
          return AppColors.neutral_01;
      }
    } else {
      switch (sstatus) {
        case SStatus.ref:
          return AppColors.accent_light_02;
        case SStatus.up:
          return AppColors.accent_light_01;
        case SStatus.down:
          return AppColors.accent_light_03;
        case SStatus.ceil:
          return AppColors.accent_light_05;
        case SStatus.floor:
          return AppColors.accent_light_04;
      }
    }
  }
}
