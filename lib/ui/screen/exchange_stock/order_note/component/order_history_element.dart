import 'package:dtnd/=models=/response/order_history_model.dart';
import 'package:dtnd/=models=/response/order_model/i_order_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

class OrderHistoryElement extends StatefulWidget {
  const OrderHistoryElement({super.key, required this.model});
  final OrderHistoryModel model;
  @override
  State<OrderHistoryElement> createState() => _OrderHistoryElementState();
}

class _OrderHistoryElementState extends State<OrderHistoryElement> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox.square(
                  dimension: 20,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.model.side.kColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    // padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      widget.model.side.nameShort(context),
                      style: AppTextStyle.titleSmall_14
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.model.stockCode,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.model.cORDERDATE ?? "-",
                  style: AppTextStyle.labelSmall_10
                      .copyWith(color: AppColors.neutral_04),
                ),
              ],
            ),
            Text(
              widget.model.orderStatus.statusName(context),
              style: AppTextStyle.labelMedium_12
                  .copyWith(color: widget.model.orderStatus.color),
            )
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).volumn,
                  style: AppTextStyle.labelSmall_10.copyWith(
                    color: AppColors.neutral_03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  NumUtils.formatInteger(widget.model.cORDERVOLUME ?? 0),
                  style: AppTextStyle.labelSmall_10,
                )
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Text(
                  "Giá khớp",
                  style: AppTextStyle.labelSmall_10.copyWith(
                    color: AppColors.neutral_03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                (widget.model.cMATCHPRICE == 0.0)
                    ? Text(
                        '-',
                        style: AppTextStyle.labelSmall_10,
                      )
                    : Text(
                        NumUtils.formatDouble(
                            (widget.model.cMATCHPRICE ?? 0) / 1000),
                        style: AppTextStyle.labelSmall_10,
                      )
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Text(
                  "Phí GD",
                  style: AppTextStyle.labelSmall_10.copyWith(
                    color: AppColors.neutral_03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                widget.model.cFEEVALUE == 0.0
                    ? Text(
                        '-',
                        style: AppTextStyle.labelSmall_10,
                      )
                    : Text(
                        NumUtils.formatInteger(widget.model.cFEEVALUE ?? 0),
                        style: AppTextStyle.labelSmall_10,
                      )
              ],
            )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "KL khớp",
                  style: AppTextStyle.labelSmall_10.copyWith(
                    color: AppColors.neutral_03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.model.cMATCHVOL == 0.0
                      ? '-'
                      : '${NumUtils.formatInteger((widget.model.cMATCHVOL))}/${NumUtils.formatInteger((widget.model.cORDERVOLUME))}',
                  style: AppTextStyle.labelSmall_10,
                )
              ],
            ))
          ],
        ),
      ],
    );
  }
}
