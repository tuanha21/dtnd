import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class StockOrderSuccessSheet extends StatefulWidget {
  const StockOrderSuccessSheet({
    super.key,
    this.orderData,
  });

  final OrderData? orderData;

  @override
  State<StockOrderSuccessSheet> createState() => _StockOrderSuccessSheetState();
}

class _StockOrderSuccessSheetState extends State<StockOrderSuccessSheet> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.light_bg,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: 180,
                  child: Image.asset(AppImages.illust06),
                )
              ],
            ),
            const SizedBox(height: 10),
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
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.light_tabBar_bg, // Text Color
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(ToStockOrderCmd(widget.orderData));
                    },
                    child: Text(S.of(context).return_command,
                        style: const TextStyle(
                            color: AppColors.text_blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.4)),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.color_primary_1, // Text Color
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(NextCmd(widget.orderData));
                    },
                    child: Text(
                      S.of(context).create_new_order,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.4),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
