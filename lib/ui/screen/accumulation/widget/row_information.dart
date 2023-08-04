// ignore_for_file: must_be_immutable

import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../config/service/app_services.dart';

class RowInfomation extends StatelessWidget {
  RowInfomation(
      {super.key,
      required this.leftText,
      required this.rightText,
      this.differentColor});

  final String leftText;
  final String rightText;
  late bool? differentColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ThemeData themeData = Theme.of(context);
    final themeMode = AppService.instance.themeMode.value;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: textTheme.bodyMedium?.copyWith(color: themeMode.isLight ? AppColors.neutral_02 : AppColors.neutral_05),
          ),
          Text(
            rightText,
            style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: differentColor == true
                    ? AppColors.semantic_01
                    : themeData.colorScheme.onBackground),
          ),
        ],
      ),
    );
  }
}
