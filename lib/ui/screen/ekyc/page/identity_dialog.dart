import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/service/app_services.dart';

class IdentityDialog extends StatelessWidget {
  const IdentityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    final ThemeMode themeMode = AppService.instance.themeMode.value;


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      margin: EdgeInsets.symmetric(
          horizontal: width / 375 * 24, vertical: height / 812 * 160),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: themeMode.isLight ? Colors.white : AppColors.text_black_1),
      child: Column(children: [
        SizedBox.square(
          dimension: 200,
          child: Image.asset(AppImages.ekyc_success),
        ),
        const SizedBox(height: 30),
        Text('Xác minh eKYC thành công',
            style: textTheme.labelLarge?.copyWith(
                color: themeMode.isLight ? AppColors.text_black : AppColors.neutral_07, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Text(
          'Bạn đã có thể thực hiện các giao dịch trong ứng dụng DTND',
          textAlign: TextAlign.center,
          style: TextStyle(color: themeMode.isLight ? AppColors.text_black : AppColors.neutral_07),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.light_tabBar_bg, // Text Color
                ),
                onPressed: () {
                  Navigator.popUntil(context, (r) => r.isFirst);
                  Navigator.of(context).pop();
                },
                child: const Text('Về trang chủ',
                    style: TextStyle(
                        color: AppColors.text_blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.4)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.color_primary_1, // Text Color
                ),
                onPressed: () {
                  Navigator.popUntil(context, (r) => r.isFirst);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Tiếp tục',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700, height: 1.4),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
