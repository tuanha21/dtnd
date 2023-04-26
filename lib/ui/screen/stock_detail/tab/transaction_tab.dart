import 'package:flutter/material.dart';
import '../../../../=models=/response/stock_model.dart';
import '../../../../generated/l10n.dart';
import '../widget/foreign_widget.dart';
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
            expandedHeight: 440,
            floating: true,
            flexibleSpace: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabTradingBoard(stockModel: widget.stockModel),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      S.of(context).Foreign_investor_transaction,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  ForeignWidget(stockModel: widget.stockModel)
                ],
              ),
            ),
          )
        ];
      },
      body: TabMatchedDetail(stockModel: widget.stockModel),
    );
  }
}
