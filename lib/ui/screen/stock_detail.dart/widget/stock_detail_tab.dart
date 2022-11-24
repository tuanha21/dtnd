import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/tab_trading_board.dart';
import 'package:flutter/material.dart';

class StockDetailTab extends StatefulWidget {
  const StockDetailTab({
    super.key,
    required this.stockModel,
  });
  final StockModel stockModel;

  @override
  State<StockDetailTab> createState() => _StockDetailTabState();
}

class _StockDetailTabState extends State<StockDetailTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                Text(S.of(context).trading_board),
                Text(S.of(context).matched_order_detail),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 300,
          height: 500,
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Center(
                child: TabTradingBoard(
                  stockModel: widget.stockModel,
                ),
              ),
              const Center(
                child: Text("Chi tiết kl"),
              )
            ],
          ),
        )
      ],
    );
  }
}
