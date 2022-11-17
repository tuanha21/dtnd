import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'home_quick_access.dart';

enum HomeQuickAccessElementTheme {
  purple,
  orange,
  green,
  blue,
}

extension HomeQuickAccessElementThemeX on HomeQuickAccessElementTheme {
  Color get iconColor {
    switch (this) {
      case HomeQuickAccessElementTheme.purple:
        return AppColors.semantic_05;
      case HomeQuickAccessElementTheme.orange:
        return AppColors.semantic_06;
      case HomeQuickAccessElementTheme.green:
        return AppColors.semantic_01;
      case HomeQuickAccessElementTheme.blue:
        return AppColors.semantic_04;
    }
  }

  Color get bgColor {
    switch (this) {
      case HomeQuickAccessElementTheme.purple:
        return AppColors.accent_light_05;
      case HomeQuickAccessElementTheme.orange:
        return AppColors.accent_light_02;
      case HomeQuickAccessElementTheme.green:
        return AppColors.accent_light_01;
      case HomeQuickAccessElementTheme.blue:
        return AppColors.accent_light_04;
    }
  }
}

class HomeQuickAccessElement extends StatelessWidget {
  const HomeQuickAccessElement({
    super.key,
    required this.value,
  });
  final QuickAccess value;
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(80, 56),
      child: ObxValue<Rx<ThemeMode>>(
        (themeMode) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: themeMode.value.isLight
                  ? value.theme.bgColor
                  : AppColors.neutral_01,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(value.path),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  value.name(context),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          );
        },
        AppService.instance.themeMode,
      ),
    );
  }
}
