// ignore_for_file: must_be_immutable

import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.neutral_02),
          ),
          Text(rightText,
              style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: differentColor == true
                      ? AppColors.semantic_01
                      : AppColors.text_black)),
        ],
      ),
    );
  }
}
