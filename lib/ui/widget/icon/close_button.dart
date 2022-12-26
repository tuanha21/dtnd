import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class SheetCloseButton extends StatelessWidget {
  const SheetCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final color =
        themeMode.isDark ? AppColors.neutral_01 : AppColors.neutral_06;
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Ink(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: const Icon(
          Icons.close,
          size: 20,
        ),
      ),
    );
  }
}
