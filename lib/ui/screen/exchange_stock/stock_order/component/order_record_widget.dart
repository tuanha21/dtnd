import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: data.side == "B"
                          ? AppColors.semantic_01
                          : AppColors.semantic_01,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    child: Text(
                      data.side == "B" ? "M" : "B",
                      style:
                          textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                data.symbol,
                style: textTheme.titleSmall,
              )
              // Visibility(
              //     visible: !MessOrder.canEdit(widget.data),
              //     child: SizedBox(width: 32)),
              // Expanded(
              //   flex: 3,
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           Text(
              //             data.symbol,
              //             style: textTheme.titleSmall,
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 8),
              //       Row(
              //         children: [
              //           Text(
              //             TimeUtilities.onlyHourFormat.format(data.orderTime),
              //           ),
              //           const SizedBox(height: 9),
              //           const SizedBox(height: 14),
              //           Flexible(
              //             child: Text(
              //               data.orderStatus,
              //             ),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              // Expanded(
              //   flex: 2,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Text(
              //         NumUtils.formatIntegerString(data.volume),
              //         textAlign: TextAlign.right,
              //       ),
              //       const SizedBox(height: 6),
              //       Text(
              //         data.showPrice ?? "",
              //         textAlign: TextAlign.right,
              //         style: textTheme.bodyMedium!.copyWith(
              //           color: AppColors.semantic_01,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Expanded(
              //   flex: 2,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Text(
              //         NumUtils.formatInteger(data.matchVolume),
              //         textAlign: TextAlign.right,
              //         style: textTheme.bodyMedium,
              //       ),
              //       const SizedBox(height: 6),
              //       Text(
              //         '${data.matchPrice}',
              //         textAlign: TextAlign.right,
              //         style: textTheme.bodyMedium!.copyWith(
              //           color: AppColors.semantic_01,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Expanded(
              //   flex: 2,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Text(
              //         NumUtils.formatInteger(data.reVol),
              //         textAlign: TextAlign.right,
              //         style: textTheme.bodyMedium,
              //       ),
              //       const SizedBox(height: 6),
              //       Text(
              //         NumUtils.formatIntegerString(data.matchValue),
              //         textAlign: TextAlign.right,
              //         style: textTheme.bodyMedium,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).margin,
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_04),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "0%",
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
                      S.of(context).order_price,
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_04),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data.orderPrice ?? "0",
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
                      NumUtils.formatDouble(data.matchPrice, "0"),
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
                      NumUtils.formatDouble(data.matchVolume, "0"),
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
