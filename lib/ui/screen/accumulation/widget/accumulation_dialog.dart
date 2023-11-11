import 'package:dtnd/ui/screen/accumulation/accumulation.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/service/app_services.dart';
import '../../../../l10n/generated/l10n.dart';

class AccumulationDialog extends StatelessWidget {
  const AccumulationDialog(
      {super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      margin: EdgeInsets.symmetric(
          horizontal: width / 400 * 24, vertical: height / 880 * 180),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: themeMode.isLight ? Colors.white : AppColors.text_black_1),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 200,
              child: Image.asset(AppImages.illust06),
            ),
            const SizedBox(height: 30),
            Text(title,
                textAlign: TextAlign.center,
                style: textTheme.labelLarge?.copyWith(
                    color: themeMode.isLight
                        ? AppColors.text_black
                        : AppColors.neutral_07,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(content,
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: themeMode.isLight
                      ? AppColors.neutral_02
                      : AppColors.neutral_07,
                )),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.light_tabBar_bg, // Text Color
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Accumlation()),
                          (r) => r.isFirst);
                    },
                    child: Text(
                      S.of(context).product,
                      style: const TextStyle(
                          color: AppColors.text_blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.4),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.color_primary_1, // Text Color
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Accumlation(
                                    defaultab: 1,
                                  )),
                          (r) => r.isFirst);
                    },
                    child: Text(
                      S.of(context).accumulation_book,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.4),
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
