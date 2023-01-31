import 'package:dtnd/ui/screen/market/widget/components/liquidity_chart.dart';
import 'package:dtnd/ui/screen/market/widget/components/top_influence_chart.dart';
import 'package:flutter/material.dart';

import '../components/money_chart.dart';

class MarketAnalysisTab extends StatefulWidget {
  const MarketAnalysisTab({super.key});

  @override
  State<MarketAnalysisTab> createState() => _MarketAnalysisTabState();
}

class _MarketAnalysisTabState extends State<MarketAnalysisTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: const [
          TopInfluenceChart(),
          LiquidityChart(),
          MoneyChart(),
          SizedBox(height: 150)
        ],
      ),
    );
  }
}
