import 'package:dtnd/ui/screen/virtual_assistant/va_home/va_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../l10n/generated/l10n.dart';
import '../../theme/app_image.dart';

enum VaQuickAccessElementTheme {
  purple,
  orange,
  green,
}

enum VaAccess {
  myDirectory,
  autoTrading,
  volatilityAlert,
}

extension QuickAccessX on VaAccess {
  String get path {
    switch (this) {
      case VaAccess.myDirectory:
        return AppImages.icon_my_directory;
      case VaAccess.autoTrading:
        return AppImages.icon_auto_trading;
      case VaAccess.volatilityAlert:
        return AppImages.icon_volatility_alert;
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case VaAccess.myDirectory:
        return S.of(context).Your_portfolio;
      case VaAccess.autoTrading:
        return S.of(context).Automated_trading;
      case VaAccess.volatilityAlert:
        return S.of(context).volatility_warning;
    }
  }

  route(BuildContext context) {
    switch (this) {
      case VaAccess.myDirectory:
        return () {
          print("myDirectory");
          VAFeature.values[0].onPressed(context);
        };
      //
      case VaAccess.autoTrading:
        return () {
          print("autoTrading");
          VAFeature.values[1].onPressed(context);
        };
      case VaAccess.volatilityAlert:
        return () {
          print("volatilityAlert");
        };
      default:
        return () {};
    }
  }
}

extension HomeQuickAccessElementThemeX on VaQuickAccessElementTheme {
  Color get iconColor {
    switch (this) {
      case VaQuickAccessElementTheme.purple:
        return AppColors.semantic_05;
      case VaQuickAccessElementTheme.orange:
        return AppColors.semantic_06;
      case VaQuickAccessElementTheme.green:
        return AppColors.semantic_01;
    }
  }

  Color get bgColor {
    switch (this) {
      case VaQuickAccessElementTheme.purple:
        return AppColors.accent_light_05;
      case VaQuickAccessElementTheme.orange:
        return AppColors.accent_light_02;
      case VaQuickAccessElementTheme.green:
        return AppColors.accent_light_01;
    }
  }
}

class VaAccessElement extends StatelessWidget {
  const VaAccessElement({
    super.key,
    required this.value,
  });

  final VaAccess value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: MediaQuery.of(context).size.width / 3 - 4,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.neutral_07,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: InkWell(
          onTap: value.route(context),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                value.path,
                width: 28,
                height: 28,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                value.name(context),
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.w500, fontSize: 10),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
