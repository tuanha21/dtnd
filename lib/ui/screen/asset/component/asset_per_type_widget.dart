import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class AssetPerTypeWidget extends StatelessWidget {
  const AssetPerTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: _MoneyType(
                          icon: AppImages.wallet_3,
                          label: S.of(context).investment_value,
                          value: "10.000.000 đ")),
                  Expanded(
                      child: _MoneyType(
                          icon: AppImages.money_2,
                          label: S.of(context).cash,
                          value: "10.000.000 đ")),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: _MoneyType(
                          icon: AppImages.timer_2,
                          label: S.of(context).sold_returning_money,
                          value: "10.000.000 đ")),
                  Expanded(
                      child: _MoneyType(
                          icon: AppImages.money_change,
                          label: S.of(context).withdrawable_money,
                          value: "10.000.000 đ")),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              _StockType(
                label: S.of(context).base,
                value: "1.200.000.000 đ",
              ),
              const SizedBox(width: 10),
              _StockType(
                label: S.of(context).derivative,
                value: "800.000.000đ",
              ),
              const SizedBox(width: 10),
              const _StockType(
                label: "CopyTrade",
                value: "800.000.000đ",
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _MoneyType extends StatelessWidget {
  const _MoneyType({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);
  final String icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            icon,
            width: 20,
            height: 20,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style:
                  textTheme.labelSmall!.copyWith(color: AppColors.neutral_03),
            ),
            Text(
              value,
              style:
                  textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600),
            )
          ],
        )
      ],
    );
  }
}

class _StockType extends StatelessWidget {
  const _StockType({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 100,
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                label,
                style: textTheme.labelMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style:
                    textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "005C193380",
                  style: textTheme.labelSmall!
                      .copyWith(color: AppColors.neutral_03),
                ),
              ),
              Text(
                "+12%",
                style: textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.semantic_01),
              )
            ],
          )
        ],
      ),
    );
  }
}
