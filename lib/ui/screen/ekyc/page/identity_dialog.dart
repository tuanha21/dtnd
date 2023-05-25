import 'package:dtnd/ui/screen/accumulation/accumulation.dart';
import 'package:dtnd/ui/screen/home/widget/asset_card.dart';
import 'package:dtnd/ui/screen/home_base/home_base.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class IdentityDialog extends StatelessWidget {
  const IdentityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      margin: EdgeInsets.symmetric(
          horizontal: width / 375 * 24, vertical: height / 812 * 180),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(children: [
        SizedBox.square(
          dimension: 200,
          child: Image.asset(AppImages.ekyc_success),
        ),
        const SizedBox(height: 30),
        Text('Xác minh eKYC thành công',
            style: textTheme.labelLarge?.copyWith(
                color: AppColors.text_black, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Text(
          'Bạn đã có thể thực hiện các giao dịch trong ứng dụng DTND',
          textAlign: TextAlign.center,
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
