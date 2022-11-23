import 'package:dtnd/ui/screen/stock_detail.dart/widget/three_price.dart';
import 'package:flutter/material.dart';

class TabTradingBoard extends StatefulWidget {
  const TabTradingBoard({super.key});

  @override
  State<TabTradingBoard> createState() => _TabTradingBoardState();
}

class _TabTradingBoardState extends State<TabTradingBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        SizedBox(
          height: 20,
        ),
        ThreePrices(),
      ],
    );
  }
}
