import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

enum SStatus { ref, up, down, ceil, floor }

extension SStatusX on SStatus {
  Color get color {
    switch (this) {
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
}

class SStatusHelper {
  static SStatus fromString(String string) {
    switch (string) {
      case "i":
        return SStatus.up;
      case "d":
        return SStatus.down;
      case "f":
        return SStatus.floor;
      case "c":
        return SStatus.ceil;
      default:
        return SStatus.ref;
    }
  }
}

abstract class StockStatus {
  SStatus get sstatus;

  String get prefix {
    switch (sstatus) {
      case SStatus.ref:
        return "";
      case SStatus.up:
        return "+";
      case SStatus.down:
        return "-";
      case SStatus.ceil:
        return "+";
      case SStatus.floor:
        return "-";
    }
  }

  Widget prefixIcon({double? size, Color? color}) {
    String path;
    Color? _color;
    switch (sstatus) {
      case SStatus.ref:
        path = AppImages.prefix_ref_icon;
        break;
      case SStatus.up:
        path = AppImages.prefix_up_icon;
        break;
      case SStatus.down:
        path = AppImages.prefix_down_icon;
        break;
      case SStatus.ceil:
        path = AppImages.prefix_ref_icon;
        _color = AppColors.semantic_05;
        break;
      case SStatus.floor:
        path = AppImages.prefix_ref_icon;
        _color = AppColors.semantic_04;
        break;
    }
    return Image.asset(
      path,
      color: color ?? _color,
      width: size,
      height: size,
    );
  }

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
