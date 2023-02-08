import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/tab_matched_detail.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/tab_trading_board.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class OverviewTab extends StatefulWidget {
  const OverviewTab({
    super.key,
    required this.stockModel,
  });
  final StockModel stockModel;
  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab>
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
              TabTradingBoard(
                stockModel: widget.stockModel,
              ),
              TabMatchedDetail(
                stockModel: widget.stockModel,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
