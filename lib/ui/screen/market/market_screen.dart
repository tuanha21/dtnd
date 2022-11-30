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
            ObxValue<Rx<bool>>((initialized) {
              print("rebuilt");
              if (!initialized.value) {
                return Center(
                  child: Text(S.of(context).loading),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox.fromSize(
                  size: Size(MediaQuery.of(context).size.width, 64),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: marketController.listIndexs.length,
                      itemBuilder: (context, index) =>
                          ObxValue<Rx<IndexModel?>>((currentIndexModel) {
                        return HomeIndexItem(
                          data: marketController.listIndexs.elementAt(index),
                          selectedIndex: currentIndexModel.value?.index,
                          onSelected: marketController.changeSelectedIndex,
                        );
                      }, marketController.currentIndexModel),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 8,
                      ),
                    ),
                  ),
                ),
              );
            }, marketController.initialized),
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
                children: [
                  MarketOverviewTab(),
                  const MarketAnalysisTab(),
                  const MarketIndustryTab(),
                ],
              ),
            )
          ],
        ));
  }
}
