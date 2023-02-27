import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/order_model/i_order_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

class OrderRecordWidget extends StatelessWidget {
  const OrderRecordWidget({super.key, required this.data});
  final BaseOrderModel data;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox.square(
                dimension: 20,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: data.side.kColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  // padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    data.side.nameShort(context),
                    style: AppTextStyle.titleSmall_14
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                data.symbol,
                style: textTheme.titleSmall,
              ),
              const SizedBox(width: 6),
              Text(
                NumUtils.formatDouble(data.matchPrice),
                style: AppTextStyle.bodySmall_12.copyWith(
                    color: AppColors.semantic_01, fontWeight: FontWeight.w600),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    data.orderStatus.statusName(context),
                    style: AppTextStyle.titleSmall_14
                        .copyWith(color: data.orderStatus.color),
                  )
                ],
              ))
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).time,
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_04),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      TimeUtilities.onlyHourFormat.format(data.orderTime),
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_01),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         S.of(context).margin,
              //         style: AppTextStyle.labelSmall_10
              //             .copyWith(color: AppColors.neutral_04),
              //       ),
              //       const SizedBox(height: 6),
              //       Text(
              //         "0%",
              //         style: AppTextStyle.labelSmall_10
              //             .copyWith(color: AppColors.neutral_01),
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).order_price,
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_04),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data.orderPrice ?? "-",
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_01),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).match_price,
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_04),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      NumUtils.formatDouble(data.matchPrice, "-"),
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_01),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      S.of(context).match_vol,
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_04),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      NumUtils.formatDouble(data.matchVolume, "-"),
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_01),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
