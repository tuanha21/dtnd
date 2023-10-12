import 'package:dtnd/=models=/response/market/stock_financial_index_model.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../config/service/app_services.dart';

class BenefitChart extends StatelessWidget {
  const BenefitChart({
    super.key,
    required this.listStockFinancialIndex,
    required this.type,
  });

  final List<StockFinancialIndex> listStockFinancialIndex;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final StockFinancialIndex stockFinancialIndex
                in listStockFinancialIndex)
              BenefitChartColumn(
                stockFinancialIndex: stockFinancialIndex,
                type: type,
              )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary_02),
                ),
                const SizedBox(width: 10),
                Text(S.of(context).net_profit),
              ],
            ),
            const SizedBox(width: 20),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.neutral_05),
                ),
                const SizedBox(width: 10),
                Text(S.of(context).revenue),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class BenefitChartColumn extends StatelessWidget {
  const BenefitChartColumn({
    super.key,
    required this.stockFinancialIndex,
    required this.type,
  });

  final StockFinancialIndex stockFinancialIndex;
  final String type;

  num get ratio {
    var nETINC = stockFinancialIndex.nETINC ?? 0;
    var nETREV = stockFinancialIndex.nETREV ?? 1;
    if (nETINC < 0) {
      nETREV += nETREV + nETINC * -1;
    }
    return nETINC / nETREV;
  }

  String get time {
    String time = "";
    if (type == "Q") {
      time =
          'Q${TimeUtilities.getQuarter(stockFinancialIndex.rEPORTDATE)}/${stockFinancialIndex.rEPORTDATE.year}';
    }
    if (type == "Y") {
      time = '${stockFinancialIndex.rEPORTDATE.year}';
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Column(
      children: [
        Container(
          height: 100,
          width: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(ratio > 0 ? 8 : 0),
                bottom: Radius.circular(ratio < 0 ? 8 : 0)),
            color: AppColors.neutral_05,
          ),
          alignment: Alignment.bottomCenter,
          child: LayoutBuilder(
            builder: (context, ctx) {
              var percent = ratio < 0 ? ratio * -1 : ratio;
              return Container(
                height: ctx.maxHeight * percent,
                width: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(ratio > 0 ? 8 : 0),
                      bottom: Radius.circular(ratio < 0 ? 8 : 0)),
                  color: AppColors.neutral_03,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: AppColors.primary_02,
          ),
          child: Text(
            time,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          NumUtils.getMoneyWithPostfix(
              (stockFinancialIndex.nETINC ?? 0) * 1000000, context),
          style: TextStyle(
              color: themeMode.isLight
                  ? AppColors.primary_02
                  : AppColors.neutral_03),
        ),
        const SizedBox(height: 10),
        Text(
          NumUtils.getMoneyWithPostfix(
              (stockFinancialIndex.nETREV ?? 0) * 1000000, context),
          style: TextStyle(
              color: themeMode.isLight
                  ? AppColors.neutral_03
                  : AppColors.neutral_07),
        ),
      ],
    );
  }
}
