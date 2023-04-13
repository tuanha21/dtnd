import 'package:dtnd/=models=/exchange.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/string_util.dart';
import 'package:flutter/material.dart';

import '../../../../../utilities/num_utils.dart';
import '../../../../../utilities/time_utils.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/app_textstyle.dart';
import '../../../../widget/icon/stock_circle_icon.dart';
import '../../order_note/screen/order_note_screen.dart';

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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  StockCirleIcon(
                    stockCode:
                        widget.orderData?.stockModel.stock.stockCode ?? '',
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.orderData?.stockModel.stock.stockCode ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.orderData?.stockModel.stock.postTo!.name ?? '',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.neutral_03,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: widget.orderData?.side.isBuy ?? true
                      ? AppColors.accent_light_01
                      : AppColors.accent_light_03,
                ),
                child: Text(
                  widget.orderData?.side.name(context).toUpperCase() ?? '',
                  style: AppTextStyle.titleSmall_14.copyWith(
                    color: widget.orderData?.side.isBuy ?? true
                        ? AppColors.semantic_01
                        : AppColors.semantic_03,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.neutral_06,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                _Row(
                  label: S.of(context).volumn,
                  value: widget.orderData?.volumn.toString(),
                ),
                const SizedBox(height: 8),
                _Row(
                  label: widget.orderData?.side.isBuy ?? true
                      ? S.of(context).buy_price
                      : S.of(context).sell_price,
                  value: widget.orderData?.price,
                ),
                const SizedBox(height: 8),
                _Row(
                  label: 'Lệnh',
                  value: widget.orderData?.orderType.detailName,
                ),
                const SizedBox(height: 8),
                _Row(
                  label: 'Thời gian',
                  value: TimeUtilities.commonTimeFormat.format(DateTime.now()),
                ),
                const SizedBox(height: 8),
                _Row(
                  label: S.of(context).exchange_total,
                  value: widget.orderData?.exchangeTotal?.toString(),
                  valueColor: AppColors.primary_01,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                      const OrderNoteScreen(defaultab: 2),
                    ));
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
                    Navigator.of(context).pop(NextCmd(widget.orderData));
                  },
                  child: Text(S.of(context).create_new_order),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    this.value,
    this.valueColor,
  });

  final String label;
  final String? value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final textheme = Theme.of(context).textTheme;
    final valueTheme = textheme.bodyMedium!
        .copyWith(fontWeight: FontWeight.w600, color: valueColor);
    String valueTxt;
    if (value == null) {
      valueTxt = "-";
    } else if (value!.isNum) {
      valueTxt = NumUtils.formatDoubleString(value);
    } else {
      valueTxt = value!;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: AppColors.text_grey_1,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.4),
        ),
        Text(
          valueTxt,
          style: valueTheme,
        ),
      ],
    );
  }
}
