import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_color.dart';
import '../business/stock_order_flow.dart';

class ChangeOrderSuccessSheet extends StatefulWidget {
  const ChangeOrderSuccessSheet({
    super.key,
    this.showButton = false,
    this.orderData,
  });

  final bool showButton;
  final OrderData? orderData;

  @override
  State<ChangeOrderSuccessSheet> createState() =>
      _ChangeOrderSuccessSheetState();
}

class _ChangeOrderSuccessSheetState extends State<ChangeOrderSuccessSheet> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
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
                  dimension: 200,
                  child: Image.asset(AppImages.illust06),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).change_order_successfully,
                  style: textTheme.labelLarge,
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    S.of(context).order_will_appear_in_ur_order_note,
                    textAlign: TextAlign.center,
                    // style: textTheme.labelLarge,
                  ),
                )
              ],
            ),
            SizedBox(height: widget.showButton ? 30 : 0),
            widget.showButton
                ? Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                AppColors.light_tabBar_bg, // Text Color
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(
                              ToStockOrderCmd(widget.orderData),
                            );
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
                        width: 8,
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
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
