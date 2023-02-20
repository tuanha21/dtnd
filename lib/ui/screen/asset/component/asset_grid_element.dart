import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_textstyle.dart';

class AssetGridElement extends StatelessWidget {
  const AssetGridElement({
    super.key,
    required this.element,
    this.subElements,
    this.subPadding,
    this.contentPadding,
  });
  final Map<String, String?> element;
  final Map<String, String>? subElements;
  final EdgeInsetsGeometry? subPadding;
  final EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextStyle.labelSmall_10;
    final labelTheme = textTheme.copyWith(color: AppColors.neutral_03);
    bool hasSubElements = (subElements != null);
    List<Widget> child;
    if (hasSubElements) {
      child = [];
      for (var i = 0; i < subElements!.keys.length; i++) {
        child.add(Padding(
          padding: subPadding ?? const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subElements!.keys.toList().elementAt(i),
                style: labelTheme,
              ),
              Text(
                subElements!.values.toList().elementAt(i),
                style: textTheme,
              ),
            ],
          ),
        ));
      }
    } else {
      child = [
        Text(
          element.values.toList().first!,
          style: textTheme,
        ),
      ];
    }

    return Container(
      padding: contentPadding ?? const EdgeInsets.all(4),
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            element.keys.toList().first,
            style: labelTheme,
          ),
          ...child,
        ],
      ),
    );
  }
}
