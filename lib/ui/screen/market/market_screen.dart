import 'dart:ui';

import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_today.dart';
import 'package:dtnd/ui/screen/market/market_controller.dart';
import 'package:dtnd/ui/screen/market/widget/tabs/market_analysis_tab.dart';
import 'package:dtnd/ui/screen/market/widget/tabs/market_industry_tab.dart';
import 'package:dtnd/ui/screen/market/widget/tabs/market_overview_tab.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen>
    with SingleTickerProviderStateMixin {
  final MarketController marketController = MarketController();
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    marketController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: "DTND"),
        body: Column(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  padding: EdgeInsets.zero,
                  tabs: <Widget>[
                    Text(S.of(context).overview),
                    Text(S.of(context).analysis),
                    Text(S.of(context).industry),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  MarketOverviewTab(),
                  MarketAnalysisTab(),
                  MarketIndustryTab(),
                ],
              ),
            )
          ],
        ));
  }
}
