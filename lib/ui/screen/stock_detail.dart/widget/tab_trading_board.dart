import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/bounce_price.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/tab_matched_detail.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/three_price.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class TabTradingBoard extends StatefulWidget {
  const TabTradingBoard({
    super.key,
    required this.stockModel,
    required this.scrollController,
    required this.panelController,
  });
  final StockModel stockModel;
  final ScrollController scrollController;
  final PanelController panelController;
  @override
  State<TabTradingBoard> createState() => _TabTradingBoardState();
}

class _TabTradingBoardState extends State<TabTradingBoard>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final tabbarBgColor =
        themeMode.isLight ? AppColors.neutral_05 : AppColors.neutral_01;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: tabbarBgColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.primary_01,
            ),
            labelColor: AppColors.neutral_07,
            unselectedLabelColor:
                themeMode.isLight ? AppColors.neutral_01 : AppColors.neutral_07,
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            padding: EdgeInsets.zero,
            // indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Text(S.of(context).trading_board),
              Text(S.of(context).matched_order_detail),
            ],
          ),
        ),
        // TabBarView(children: []),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  physics:
                      PanelScrollPhysics(controller: widget.panelController),
                  controller: widget.scrollController,
                  shrinkWrap: true,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    ThreePrices(
                      stockModel: widget.stockModel,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BoundPrice(
                      stockModel: widget.stockModel,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // HomeSection(
                    //   title: S.of(context).financial_index,
                    //   child: const FinancialIndex(),
                    // ),
                  ],
                ),
              ),
              TabMatchedDetail(
                stockModel: widget.stockModel,
                panelController: widget.panelController,
                scrollController: widget.scrollController,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
