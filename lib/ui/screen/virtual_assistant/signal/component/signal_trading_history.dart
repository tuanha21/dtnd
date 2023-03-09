import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class SignalTradingHistory extends StatelessWidget {
  const SignalTradingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Lịch sử giao dịch",
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
            )
          ],
        ),
        for (int i = 0; i < 3; i++)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: SignalTradingHistoryElement(),
          )
      ],
    );
  }
}

class SignalTradingHistoryElement extends StatelessWidget {
  const SignalTradingHistoryElement({
    super.key,
    this.pc = 25,
    this.buy = 15.5,
    this.sell = 20.6,
    this.buyTime = "13:54:30 24/12/22",
    this.sellTime = "13:54:30 24/12/22",
  });
  final num pc;
  final num buy;
  final num sell;
  final String buyTime;
  final String sellTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        color: Colors.white,
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Lợi nhuận",
                  style: AppTextStyle.labelSmall_10.copyWith(
                      color: AppColors.neutral_04, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 5),
                Image.asset(
                  pc >= 0
                      ? AppImages.prefix_up_icon
                      : AppImages.prefix_down_icon,
                  width: 14,
                  height: 14,
                ),
                const SizedBox(width: 5),
                Text(
                  "$pc%",
                  style: AppTextStyle.titleSmall_14.copyWith(
                      color: pc >= 0
                          ? AppColors.semantic_01
                          : AppColors.semantic_03),
                ),
              ],
            ),
            SizedBox(
              height: 20,
              child: Row(
                children: [
                  Text(
                    "Giá mua/bán",
                    style: AppTextStyle.labelSmall_10.copyWith(
                        color: AppColors.neutral_04,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "$buy",
                    style: AppTextStyle.titleSmall_14
                        .copyWith(color: AppColors.semantic_01),
                  ),
                  const VerticalDivider(
                    width: 10,
                    thickness: 2,
                  ),
                  Text(
                    "$sell",
                    style: AppTextStyle.titleSmall_14
                        .copyWith(color: AppColors.semantic_03),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).buy_date,
                  style: AppTextStyle.labelSmall_10.copyWith(
                      color: AppColors.neutral_04, fontWeight: FontWeight.w500),
                ),
                Text(
                  buyTime,
                  style: AppTextStyle.labelSmall_10,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  S.of(context).sell_date,
                  style: AppTextStyle.labelSmall_10.copyWith(
                      color: AppColors.neutral_04, fontWeight: FontWeight.w500),
                ),
                Text(
                  sellTime,
                  style: AppTextStyle.labelSmall_10,
                ),
              ],
            )
          ],
        )
      ]),
    );
  }
}
