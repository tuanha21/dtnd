import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../config/service/app_services.dart';
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
    final ThemeData themeData = Theme.of(context);
    final textTheme = AppTextStyle.labelMedium_12;
    final labelTheme = textTheme.copyWith(color: AppColors.neutral_03);
    final ThemeMode themeMode = AppService.instance.themeMode.value;

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
        Flexible(
          child: Text(
            element.values.toList().first!,
            style: textTheme.copyWith(color: themeData.colorScheme.onBackground),
            maxLines: 1,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
          ),
        ),
      ];
    }

    return Container(
      padding: contentPadding ?? const EdgeInsets.all(4),
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: themeMode.isLight ? AppColors.neutral_07 : AppColors.text_black_1,
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
