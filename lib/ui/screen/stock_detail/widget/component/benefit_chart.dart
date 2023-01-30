import 'package:dtnd/=models=/response/stock_financial_index_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BenefitChart extends StatefulWidget {
  const BenefitChart({
    super.key,
    required this.listStockFinancialIndex,
  });
  final List<StockFinancialIndex> listStockFinancialIndex;
  @override
  State<BenefitChart> createState() => _BenefitChartState();
}

class _BenefitChartState extends State<BenefitChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final StockFinancialIndex stockFinancialIndex
                in widget.listStockFinancialIndex)
              BenefitChartColumn(
                stockFinancialIndex: stockFinancialIndex,
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
  });
  final StockFinancialIndex stockFinancialIndex;

  num get ratio =>
      (stockFinancialIndex.nETINC ?? 0) / (stockFinancialIndex.nETREV ?? 1);

  @override
  Widget build(BuildContext context) {
    final double height;
    if (ratio == 0) {
      height = 0;
    } else {
      height = 1 / ratio;
    }
    return Column(
      children: [
        Container(
          height: 100,
          width: 8,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            color: AppColors.neutral_05,
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height,
            width: 8,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              color: AppColors.primary_02,
            ),
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
            DateFormat("yyyy").format(stockFinancialIndex.rEPORTDATE),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          NumUtils.getMoneyWithPostfix(
              (stockFinancialIndex.nETINC ?? 0) * 1000000, context),
          style: const TextStyle(color: AppColors.primary_02),
        ),
        const SizedBox(height: 10),
        Text(
          NumUtils.getMoneyWithPostfix(
              (stockFinancialIndex.nETREV ?? 0) * 1000000, context),
          style: const TextStyle(color: AppColors.neutral_03),
        ),
      ],
    );
  }
}
