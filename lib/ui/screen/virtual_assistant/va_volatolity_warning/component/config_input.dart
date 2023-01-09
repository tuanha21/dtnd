import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

enum SuffixType {
  percentage,
  vnd,
  compare,
}

extension SuffixTypeX on SuffixType {
  String get icon {
    switch (this) {
      case SuffixType.percentage:
        return AppImages.percentage_square_icon;
      case SuffixType.vnd:
        return AppImages.vnd_icon;
      case SuffixType.compare:
        return AppImages.expand_more_icon;
    }
  }
}

class ConfigInput extends StatelessWidget {
  const ConfigInput({
    super.key,
    required this.label,
    required this.suffixType,
  });
  final SuffixType suffixType;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        // isDense: true,
        // prefixIcon: const Text("\$"),
        // prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),

        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 10),
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 10,
                    child: Image.asset(AppImages.less_or_equal_icon),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 10,
                    child: Image.asset(AppImages.expand_more_icon),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 2,
                    height: 20,
                    decoration:
                        const BoxDecoration(color: AppColors.neutral_03),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        suffixIcon: Center(
          child: SizedBox.square(
              dimension: 10, child: Image.asset(suffixType.icon)),
        ),
        suffixIconConstraints: const BoxConstraints(maxWidth: 36),
      ),
    );
  }
}
