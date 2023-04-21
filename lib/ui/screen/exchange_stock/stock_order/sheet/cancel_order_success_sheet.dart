import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

import '../business/stock_order_flow.dart';
import '../data/order_data.dart';

class CancelOrderSuccessSheet extends StatefulWidget {
  const CancelOrderSuccessSheet({
    super.key,
    this.showButton = false,
    this.orderData,
  });

  final bool showButton;
  final OrderData? orderData;

  @override
  State<CancelOrderSuccessSheet> createState() =>
      _CancelOrderSuccessSheetState();
}

class _CancelOrderSuccessSheetState extends State<CancelOrderSuccessSheet> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.neutral_06,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: 250,
                  child: Image.asset(AppImages.illust06),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).cancel_order_successfully,
                  style: textTheme.labelLarge,
                )
              ],
            ),
            const SizedBox(height: 10),
            widget.showButton
                ? Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                AppColors.light_tabBar_bg, // Text Color
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(ToStockOrderCmd(widget.orderData));
                          },
                          child: Text(
                            S.of(context).return_command,
                            style: const TextStyle(
                                color: AppColors.text_blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 1.4),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                AppColors.color_primary_1, // Text Color
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(NextCmd(widget.orderData));
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
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
