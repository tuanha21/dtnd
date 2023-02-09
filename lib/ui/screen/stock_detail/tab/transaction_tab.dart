import 'package:flutter/material.dart';

import '../../../../=models=/response/stock_model.dart';
import '../widget/stock_detail_overview.dart';
import '../widget/tab_matched_detail.dart';
import '../widget/tab_trading_board.dart';

class TransactionTab extends StatefulWidget {
  final StockModel stockModel;

  const TransactionTab({Key? key, required this.stockModel}) : super(key: key);

  @override
  State<TransactionTab> createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: const SizedBox(),
            automaticallyImplyLeading: false,
            // pinned: false,
            // toolbarHeight: 200,
            expandedHeight: 230,
            floating: true,
            flexibleSpace: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: StockDetailOverview(stockModel: widget.stockModel),
                  ),
                  const SizedBox(height: 16),
                  TabTradingBoard(stockModel: widget.stockModel),
                ],
              ),
            ),
          )
        ];
      },
      body: TabMatchedDetail(
        stockModel: widget.stockModel,
      ),
    );
  }
}
