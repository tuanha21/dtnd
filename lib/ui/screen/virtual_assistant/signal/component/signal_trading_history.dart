import 'package:dtnd/=models=/response/top_signal_history_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:flutter/material.dart';

class SignalTradingHistory extends StatelessWidget {
  const SignalTradingHistory({super.key, this.listHis});

  final List<TopSignalHistoryModel>? listHis;
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
        if (listHis?.isEmpty ?? true)
          const EmptyListWidget(
            title: "BOT chưa có lịch sử giao dịch",
          )
        else
          ListView.builder(
            shrinkWrap: true,
            itemCount: listHis!.length,
            itemBuilder: (context, index) {
              final his = listHis!.elementAt(index);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SignalTradingHistoryElement(
                  pc: his.pc,
                  buy: his.buyPrice,
                  sell: his.sellPrice,
                  buyTime: his.buyDateString,
                  sellTime: his.sellDateString,
                  icon: his.prefixIcon(),
                  color: his.color,
                ),
              );
            },
          )
      ],
    );
  }
}

class SignalTradingHistoryElement extends StatelessWidget {
  const SignalTradingHistoryElement({
    super.key,
    required this.icon,
    required this.color,
    required this.pc,
    required this.buy,
    required this.sell,
    required this.buyTime,
    required this.sellTime,
  });
  final num? pc;
  final num? buy;
  final num? sell;
  final String? buyTime;
  final String? sellTime;
  final Widget icon;
  final Color color;
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
                SizedBox.square(
                  dimension: 14,
                  child: icon,
                ),
                const SizedBox(width: 5),
                Text(
                  "$pc%",
                  style: AppTextStyle.titleSmall_14.copyWith(color: color),
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
                    "${buy ?? "-"}",
                    style: AppTextStyle.titleSmall_14
                        .copyWith(color: AppColors.semantic_01),
                  ),
                  const VerticalDivider(
                    width: 10,
                    thickness: 2,
                  ),
                  Text(
                    "${sell ?? "-"}",
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
                  buyTime ?? "-",
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
                  sellTime ?? "-",
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
