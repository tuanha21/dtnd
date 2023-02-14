import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/app_color.dart';
import '../../home/widget/home_section.dart';
import '../widget/index_widget.dart';
import '../widget/introduct_widget.dart';
import '../widget/stock_detail_chart.dart';
import '../widget/stock_detail_news.dart';
import '../widget/stock_event.dart';

class OverviewTab extends StatefulWidget {
  const OverviewTab({
    super.key,
    required this.stockModel,
  });

  final StockModel stockModel;

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StockDetailChart(stockModel: widget.stockModel),
            )),
        const SizedBox(height: 16),
        HomeSection(
          title: "Chỉ số cơ bản",
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Giá thấp nhất',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: AppColors.neutral_04),
                    ),
                    Text(
                      'Giá cao nhất',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: AppColors.neutral_04),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.stockModel.stockData.lowPrice.value.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          return LinearPercentIndicator(
                            barRadius: const Radius.circular(12),
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 10,
                            percent:
                            widget.stockModel.stockData.percent.toDouble(),
                            progressColor: AppColors.neutral_03,
                            backgroundColor: AppColors.neutral_01,
                          );
                        },
                      ),
                    ),
                    Text(
                      widget.stockModel.stockData.highPrice.value.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        IndexWidget(stockModel: widget.stockModel),
        const SizedBox(height: 20),
        IntroduceWidget(stockCode: widget.stockModel),
        const SizedBox(height: 16),
        HomeSection(
          title: S.of(context).news,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                StockDetailNews(stockCode: widget.stockModel.stock.stockCode),
          ),
        ),
        const SizedBox(height: 20),
        HomeSection(
          title: S.of(context).event,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StockEvent(
              stockModel: widget.stockModel,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
