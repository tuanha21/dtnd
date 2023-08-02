import 'package:dtnd/ui/screen/accumulation/accumulation.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/service/app_services.dart';
import '../../../../generated/l10n.dart';

class ErrorRegisterDialog extends StatelessWidget {
  const ErrorRegisterDialog({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    final themeMode = AppService.instance.themeMode.value;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      margin: EdgeInsets.symmetric(
          horizontal: width / 375 * 24, vertical: height / 812 * 180),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: themeMode.isLight ? Colors.white : AppColors.neutral_01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: 200,
            child: Image.asset(AppImages.illust06),
          ),
          const SizedBox(height: 30),
          Text(error,
              style: textTheme.labelLarge?.copyWith(
                  color: themeMode.isLight ? AppColors.text_black : AppColors.neutral_05, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text(
            S.of(context).please_try_again,
            style: textTheme.bodyLarge?.copyWith(
              color: themeMode.isLight ? AppColors.neutral_02 : AppColors.neutral_05,
            ),
          ),
          const SizedBox(height: 24),
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
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.of(context).come_back,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700, height: 1.4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
