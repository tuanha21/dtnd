import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../config/service/app_services.dart';
import '../widget/tab_matched_detail.dart';
import '../widget/tab_trading_board.dart';

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
  ValueNotifier<int> indexTab = ValueNotifier<int>(0);

  late List<Widget> listWidget;

  @override
  void initState() {
    listWidget = [
      TabTradingBoard(stockModel: widget.stockModel),
      Expanded(child: TabMatchedDetail(stockModel: widget.stockModel)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final tabbarBgColor =
        themeMode.isLight ? AppColors.neutral_05 : AppColors.neutral_01;
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DefaultTabController(
              length: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: tabbarBgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: AppColors.primary_01,
                  ),
                  labelColor: AppColors.neutral_07,
                  unselectedLabelColor: themeMode.isLight
                      ? AppColors.neutral_01
                      : AppColors.neutral_07,
                  labelPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  padding: EdgeInsets.zero,
                  onTap: (index) {
                    indexTab.value = index;
                  },
                  // indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Text(S.of(context).trading_board),
                    Text(S.of(context).matched_order_detail),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder<int>(
              valueListenable: indexTab,
              builder: (context, index, child) {
                return listWidget[index];
              })
        ],
      ),
    );
  }
}
