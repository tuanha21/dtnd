import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/bounce_price.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/three_price.dart';
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

class _TabTradingBoardState extends State<TabTradingBoard> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        physics: PanelScrollPhysics(controller: widget.panelController),
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
    );
  }
}
