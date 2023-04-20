import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/order_model/i_order_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderRecordWidget extends StatefulWidget {
  const OrderRecordWidget(
      {super.key, required this.data, this.onChange, this.onCancel});

  final BaseOrderModel data;
  final VoidCallback? onChange;
  final VoidCallback? onCancel;

  @override
  State<OrderRecordWidget> createState() => _OrderRecordWidgetState();
}

class _OrderRecordWidgetState extends State<OrderRecordWidget> {
  final IExchangeService exchangeService = ExchangeService();
  final IUserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Slidable(
      key: ValueKey(widget.data.hashCode),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          Flexible(
            child: Material(
              child: InkWell(
                onTap: widget.onChange,
                child: Ink(
                  decoration: const BoxDecoration(
                    color: AppColors.neutral_05,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                            dimension: 16,
                            child: Image.asset(AppImages.edit_slidable_icon)),
                        const SizedBox(height: 8),
                        Text(
                          S.of(context).edit,
                          style: AppTextStyle.labelSmall_10.copyWith(
                            color: AppColors.semantic_04,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 1,
          ),
          Flexible(
            child: Material(
              child: InkWell(
                onTap: widget.onCancel,
                child: Ink(
                  decoration: const BoxDecoration(
                    color: AppColors.neutral_05,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                            dimension: 16,
                            child: Image.asset(AppImages.trash_slidable_icon)),
                        const SizedBox(height: 8),
                        Text(
                          S.of(context).delete,
                          style: AppTextStyle.labelSmall_10.copyWith(
                            color: AppColors.semantic_03,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Divider(),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(right: 4, left: 4, top: 8),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox.square(
                  dimension: 20,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.data.side.kColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    // padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      widget.data.side.nameShort(context),
                      style: AppTextStyle.titleSmall_14
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.data.symbol,
                  style: textTheme.titleSmall,
                ),
                const SizedBox(width: 6),
                Text(
                  NumUtils.formatDouble(widget.data.matchPrice),
                  style: AppTextStyle.bodySmall_12.copyWith(
                      color: AppColors.semantic_01,
                      fontWeight: FontWeight.w600),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.data.orderStatus.statusName(context),
                      style: AppTextStyle.titleSmall_14
                          .copyWith(color: widget.data.orderStatus.color),
                    )
                  ],
                ))
              ],
            ),
            const SizedBox(height: 12),
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
                        TimeUtilities.onlyHourFormat
                            .format(widget.data.orderTime),
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
                        widget.data.showPrice ?? "-",
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
                        NumUtils.formatDouble(widget.data.matchPrice, "-"),
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
                        widget.data.matchVolume == 0.0
                            ? '_'
                            : '${NumUtils.formatDouble(widget.data.matchVolume)}/${widget.data.volume!}',
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_01),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: AppColors.neutral_05,
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
