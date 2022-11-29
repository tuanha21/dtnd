import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';

enum _RowType { esp, ppe, ppb, dividend }

extension _RowTypeX on _RowType {
  String label(BuildContext context) {
    switch (this) {
      case _RowType.dividend:
        return S.of(context).dividend;
      case _RowType.esp:
        return "EPS (Earning Per Share)";
      case _RowType.ppe:
        return "P/E (Price/EPS)";
      case _RowType.ppb:
        return "P/B (Price/Book";
    }
  }
}

class FinancialIndex extends StatelessWidget {
  const FinancialIndex({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeMode.isDark ? AppColors.neutral_01 : AppColors.neutral_06,
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Column(
          children: [
            for (final _RowType type in _RowType.values)
              _RowData(
                type: type,
                value: "0",
              )
          ],
        ));
  }
}

class _RowData extends StatelessWidget {
  const _RowData({
    required this.type,
    required this.value,
  });
  final _RowType type;
  final String value;
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            type.label(context),
            style: AppTextStyle.bodySmall_12.copyWith(
              color: themeMode.isDark
                  ? AppColors.neutral_06
                  : AppColors.neutral_03,
            ),
          ),
          Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: type.label(context),
            margin: const EdgeInsets.all(0),
            preferBelow: false,
            height: 20,
            verticalOffset: 10,
            child: Icon(
              Icons.info_outline,
              size: 10,
              color: themeMode.isDark
                  ? AppColors.neutral_06
                  : AppColors.neutral_03,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Text(value)
        ],
      ),
    );
  }
}
