import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../home/widget/home_section.dart';
import '../widget/component/price_alert.dart';
import '../widget/stock_detail_chart.dart';
import '../widget/stock_detail_news.dart';

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
            child: StockDetailChart(stockModel: widget.stockModel)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: PriceAlert(),
        ),
        const SizedBox(height: 24),
        HomeSection(
          title: S.of(context).news,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StockDetailNews(
              stockCode: widget.stockModel.stock.stockCode
            ),
          ),
        )
      ],
    );
  }
}
