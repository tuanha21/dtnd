import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

class BoundPrice extends StatelessWidget {
  const BoundPrice({
    super.key,
    required this.stockModel,
  });
  final StockModel stockModel;
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: themeMode.isDark ? AppColors.neutral_01 : AppColors.neutral_06,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                BoundPriceElement(
                  title: S.of(context).low,
                  value: stockModel.stockData.lowPrice.value.toString(),
                  valueColor: stockModel.stockData
                      .getPriceColor(stockModel.stockData.lowPrice.value ?? 0),
                ),
                const SizedBox(height: 6),
                BoundPriceElement(
                  title: S.of(context).fbuy,
                  value: NumUtils.formatInteger10(
                      stockModel.stockData.fBVol.value, "-"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                BoundPriceElement(
                  title: S.of(context).average,
                  value: stockModel.stockData.avePrice.value.toString(),
                  valueColor: stockModel.stockData
                      .getPriceColor(stockModel.stockData.avePrice.value ?? 0),
                ),
                const SizedBox(height: 6),
                BoundPriceElement(
                  title: S.of(context).froom,
                  value: NumUtils.formatInteger(
                      stockModel.stockData.fRoom.value, "-"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                BoundPriceElement(
                  title: S.of(context).high,
                  value: stockModel.stockData.highPrice.value.toString(),
                  valueColor: stockModel.stockData
                      .getPriceColor(stockModel.stockData.highPrice.value ?? 0),
                ),
                const SizedBox(height: 6),
                BoundPriceElement(
                  title: S.of(context).fsell,
                  value: NumUtils.formatInteger10(
                      stockModel.stockData.fSVolume.value, "-"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BoundPriceElement extends StatelessWidget {
  const BoundPriceElement({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });
  final String title;
  final String value;
  final Color? valueColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style:
              AppTextStyle.labelSmall_10.copyWith(color: AppColors.neutral_04),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyle.bodySmall_12
              .copyWith(color: valueColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
