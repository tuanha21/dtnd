import 'package:dtnd/=models=/order_status.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/logic/order_history.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class IndayOrderTab extends StatefulWidget {
  const IndayOrderTab({super.key});

  @override
  State<IndayOrderTab> createState() => _IndayOrderTabState();
}

class _IndayOrderTabState extends State<IndayOrderTab> {
  final List<OrderHistory> list = [
    OrderHistory(
        stockCode: "HPG",
        side: Side.sell,
        orderStatus: OrderStatus.matched,
        price: 18.02),
    OrderHistory(
        stockCode: "HPG",
        side: Side.buy,
        orderStatus: OrderStatus.waitingMatch,
        price: 18.02),
    OrderHistory(
        stockCode: "GAS",
        side: Side.buy,
        orderStatus: OrderStatus.waitingMatch,
        price: 108.02),
    OrderHistory(
        stockCode: "HPG",
        side: Side.sell,
        orderStatus: OrderStatus.matching,
        price: 18.02),
    OrderHistory(
        stockCode: "ACB",
        side: Side.sell,
        orderStatus: OrderStatus.matched,
        price: 17.02),
    OrderHistory(
        stockCode: "FPT",
        side: Side.sell,
        orderStatus: OrderStatus.matched,
        price: 78.02),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                for (int i = 0; i < list.length; i++)
                  Column(
                    children: [
                      i != 0 ? const Divider() : Container(),
                      _IndayOrder(
                        data: list.elementAt(i),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _IndayOrder extends StatelessWidget {
  const _IndayOrder({required this.data});
  final OrderHistory data;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Material(
                    child: Ink(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          color: data.side.isSell
                              ? AppColors.semantic_03
                              : AppColors.semantic_01),
                      child: Text(
                        data.side.code,
                        style: AppTextStyle.bodyMedium_14.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    data.stockCode,
                    style: textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "(${data.price})",
                    style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.semantic_01),
                  ),
                ],
              ),
              Text(
                data.orderStatus.name(context),
                style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600, color: data.orderStatus.color),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).margin,
                    style: AppTextStyle.labelSmall_10.copyWith(
                      color: AppColors.neutral_04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    data.margin,
                    style: textTheme.labelSmall!.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).order_price,
                    style: AppTextStyle.labelSmall_10.copyWith(
                      color: AppColors.neutral_04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    data.orderPrice,
                    style: textTheme.labelSmall!.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).match_price,
                    style: AppTextStyle.labelSmall_10.copyWith(
                      color: AppColors.neutral_04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    data.matchedPrice,
                    style: textTheme.labelSmall!.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).match_vol,
                    style: AppTextStyle.labelSmall_10.copyWith(
                      color: AppColors.neutral_04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    data.matchedVol,
                    style: textTheme.labelSmall!.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}
