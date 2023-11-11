import 'package:dtnd/=models=/response/account/cash_transaction_model.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../config/service/app_services.dart';

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
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeMode.isLight
            ? AppColors.neutral_07
            : AppColors.bg_share_inside_nav,
        borderRadius: const BorderRadius.all(
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
                    style: textTheme.titleSmall?.copyWith(
                      color: themeMode.isLight
                          ? AppColors.neutral_04
                          : AppColors.neutral_07,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).increase_decrease_occurred,
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
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "${S.of(context).detail}: ",
                          style: AppTextStyle.labelSmall_10.copyWith(
                              color: themeMode.isLight
                                  ? AppColors.neutral_01
                                  : AppColors.neutral_03)),
                      TextSpan(
                        text: widget.data.cCONTENT,
                        style: AppTextStyle.labelSmall_10.copyWith(
                          fontWeight: FontWeight.w500,
                          color: themeMode.isLight
                              ? AppColors.neutral_03
                              : AppColors.neutral_07,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
