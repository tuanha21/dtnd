import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_color.dart';
import '../data/order_data.dart';

class StockOrderSuccessSheet extends StatelessWidget {
  final OrderData? orderData;
  const StockOrderSuccessSheet({
    this.orderData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetHeader(
              title: "",
              implementBackButton: false,
              implementDivider: false,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: 200,
                  child: Image.asset(AppImages.illust06),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).create_order_successfully,
                  style: textTheme.labelLarge,
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.neutral_06,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: const [
                      Text('Khối lượng'),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text('Giá mua vào'),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text('Lệnh'),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text('Thời gian'),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text('Tổng giao dịch'),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.light_tabBar_bg, // Text Color
                    ),
                    onPressed: () {
                      print('về sổ lệnh');
                    },
                    child: const Text('Về sổ lệnh',
                        style: TextStyle(color: AppColors.text_blue)),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(const NextCmd());
                        },
                        child: Text(S.of(context).create_new_order))),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
