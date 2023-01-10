import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/typedef.dart';
import 'package:flutter/material.dart';

class ActiveButton extends StatelessWidget {
  const ActiveButton({
    super.key,
    required this.icon,
    required this.isActive,
    this.size = 20,
    this.activeButtonColor,
    this.inactiveButtonColor,
    this.activeIconColor,
    this.inactiveIconColor,
    this.onActive,
    this.onInactive,
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });
  final ColorOnThemeMode? activeButtonColor;
  final ColorOnThemeMode? inactiveButtonColor;
  final ColorOnThemeMode? activeIconColor;
  final ColorOnThemeMode? inactiveIconColor;
  final VoidCallback? onActive;
  final VoidCallback? onInactive;
  final IsActive isActive;
  final String icon;
  final double size;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    late final Color buttonColor;
    late final Color iconColor;
    late final VoidCallback onTap;
    if (isActive.call()) {
      buttonColor = activeButtonColor?.call(themeMode) ?? AppColors.primary_01;
      iconColor = activeIconColor?.call(themeMode) ?? AppColors.neutral_07;
      onTap = () => onInactive?.call();
    } else {
      onTap = () => onActive?.call();
      switch (themeMode.isLight) {
        case true:
          buttonColor = AppColors.primary_03;
          iconColor = AppColors.neutral_03;
          break;
        case false:
          buttonColor = AppColors.neutral_01;
          iconColor = AppColors.neutral_07;
          break;
      }
    }

    return Material(
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Ink(
          padding: padding,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: borderRadius,
          ),
          child: Image.asset(
            icon,
            color: iconColor,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
