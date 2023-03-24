import 'package:dtnd/=models=/response/cash_transaction_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

class CashTransactionComponent extends StatefulWidget {
  const CashTransactionComponent({super.key, required this.data});
  final CashTransactionHistoryModel data;
  @override
  State<CashTransactionComponent> createState() =>
      _CashTransactionComponentState();
}

class _CashTransactionComponentState extends State<CashTransactionComponent> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.neutral_06,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).time,
                    style: AppTextStyle.bodySmall_8.copyWith(
                      color: AppColors.neutral_04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.data.cTRANSACTIONDATE ?? "",
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Phát sinh tăng/giảm",
                    style: AppTextStyle.bodySmall_8.copyWith(
                      color: AppColors.neutral_04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${NumUtils.formatInteger(widget.data.change)}đ",
                    style: AppTextStyle.titleSmall_14
                        .copyWith(color: widget.data.color),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                  child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Chi tiết: ",
                            style: AppTextStyle.labelSmall_10
                                .copyWith(color: AppColors.neutral_01)),
                        TextSpan(
                            text: widget.data.cCONTENT,
                            style: AppTextStyle.labelSmall_10.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.neutral_03,
                            )),
                      ])))
            ],
          )
        ],
      ),
    );
  }
}
