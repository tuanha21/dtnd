import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreePrices extends StatelessWidget {
  const ThreePrices({super.key});

  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<ThemeMode>>(
      (themeMode) {
        return Container(
          decoration: BoxDecoration(
            color: themeMode.value.isDark
                ? AppColors.neutral_06
                : Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ThreePriceHeader(
                      side: Side.buy,
                      themeMode: themeMode.value,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Expanded(
                child: Column(
                  children: [
                    ThreePriceHeader(
                      side: Side.sell,
                      themeMode: themeMode.value,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      AppService.instance.themeMode,
    );
  }
}

class ThreePriceHeader extends StatelessWidget {
  const ThreePriceHeader({
    super.key,
    required this.side,
    required this.themeMode,
  });
  final Side side;
  final ThemeMode themeMode;
  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(4);
    List<Widget> rowChildren;
    BorderRadius borderRadius;
    if (side.isBuy) {
      rowChildren = [Text(S.of(context).volumn), Text(side.name(context))];
      borderRadius = const BorderRadius.only(
        topLeft: radius,
      );
    } else {
      rowChildren = [Text(side.name(context)), Text(S.of(context).volumn)];
      borderRadius = const BorderRadius.only(
        topRight: radius,
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: themeMode.isLight ? AppColors.neutral_05 : AppColors.neutral_01,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      ),
    );
  }
}

class ThreePriceElement extends StatelessWidget {
  const ThreePriceElement({
    super.key,
    required this.side,
    required this.themeMode,
    this.data,
  });
  final Side side;
  final ThemeMode themeMode;
  final String? data;
  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(4);
    List<Widget> rowChildren;
    BorderRadius borderRadius;
    if (side.isBuy) {
      rowChildren = [Text(S.of(context).volumn), Text(side.name(context))];
      borderRadius = const BorderRadius.only(
        topLeft: radius,
      );
    } else {
      rowChildren = [Text(side.name(context)), Text(S.of(context).volumn)];
      borderRadius = const BorderRadius.only(
        topRight: radius,
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: themeMode.isLight ? AppColors.neutral_05 : AppColors.neutral_01,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      ),
    );
  }
}
