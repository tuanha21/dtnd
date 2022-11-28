import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/bounce_price.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/three_price.dart';
import 'package:flutter/material.dart';

class TabTradingBoard extends StatefulWidget {
  const TabTradingBoard({
    super.key,
    required this.stockModel,
  });
  final StockModel stockModel;
  @override
  State<TabTradingBoard> createState() => _TabTradingBoardState();
}

class _TabTradingBoardState extends State<TabTradingBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
