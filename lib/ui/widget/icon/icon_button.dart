import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/typedef.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.buttonColor,
    this.iconColor,
    this.onPressed,
    this.size = 16.0,
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });
  final String icon;
  final ColorOnThemeMode? buttonColor;
  final ColorOnThemeMode? iconColor;
  final VoidCallback? onPressed;
  final double size;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    late final Color buttonC;
    late final Color iconC;
    late final VoidCallback onTap;

    buttonC = buttonColor?.call(themeMode) ??
        (themeMode.isLight ? AppColors.primary_03 : AppColors.neutral_01);
    iconC = iconColor?.call(themeMode) ?? AppColors.primary_01;
    onTap = () => onPressed?.call();

    return Material(
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Ink(
          padding: padding,
          decoration: BoxDecoration(
            color: buttonC,
            borderRadius: borderRadius,
          ),
          child: Image.asset(
            icon,
            color: iconC,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
