import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class CircleCheckboxWithTitle extends StatelessWidget {
  const CircleCheckboxWithTitle({
    super.key,
    required this.title,
    this.initialValue,
    required this.ischeck,
    required this.onCheck,
  });
  final bool ischeck;
  final String title;
  final bool? initialValue;
  final VoidCallback onCheck;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onCheck,
            child: Ink(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: ischeck
                          ? AppColors.primary_01
                          : AppColors.neutral_03)),
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ischeck ? AppColors.primary_01 : Colors.transparent),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(title)
      ],
    );
  }
}
