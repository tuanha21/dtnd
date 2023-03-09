import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/svg_icon_button.dart';
import 'package:flutter/material.dart';

enum TechnicalTrading {
  professional,
  newbie,
}

extension TechnicalTradingX on TechnicalTrading {
  bool get isNewbie => this == TechnicalTrading.newbie;
  bool get isProfessional => this == TechnicalTrading.professional;

  String get icon {
    switch (this) {
      case TechnicalTrading.newbie:
        return AppImages.wallet_search;
      case TechnicalTrading.professional:
        return AppImages.wallet_icon;
    }
  }

  String describe(BuildContext context) {
    switch (this) {
      case TechnicalTrading.newbie:
        return S.of(context).technical_trading_newbie;
      case TechnicalTrading.professional:
        return S.of(context).technical_trading_pro;
    }
  }
}

class TechnicalTradings extends StatelessWidget {
  const TechnicalTradings({super.key, required this.onChoosen});

  final ValueChanged<TechnicalTrading?> onChoosen;

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final color =
        themeMode.isDark ? AppColors.neutral_01 : AppColors.neutral_06;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => onChoosen.call(null),
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
                ),
              ],
            ),
            for (final TechnicalTrading technicalTrading
                in TechnicalTrading.values)
              TechnicalTradingsElement(
                technicalTrading: technicalTrading,
                onChoosen: onChoosen,
              )
          ],
        ),
      ),
    );
  }
}

class TechnicalTradingsElement extends StatelessWidget {
  const TechnicalTradingsElement({
    super.key,
    required this.technicalTrading,
    required this.onChoosen,
  });
  final TechnicalTrading technicalTrading;
  final ValueChanged<TechnicalTrading?> onChoosen;
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final color =
        themeMode.isDark ? AppColors.neutral_01 : AppColors.neutral_06;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () => onChoosen.call(technicalTrading),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(children: [
            SvgIconButton(technicalTrading.icon),
            Flexible(child: Text(technicalTrading.describe(context)))
          ]),
        ),
      ),
    );
  }
}
