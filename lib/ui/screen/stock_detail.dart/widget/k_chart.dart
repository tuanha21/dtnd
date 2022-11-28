import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:flutter/material.dart';
import 'package:k_chart/flutter_k_chart.dart';

class KChart extends StatefulWidget {
  const KChart({
    super.key,
    required this.stockTradingHistory,
  });
  final StockTradingHistory stockTradingHistory;
  @override
  State<KChart> createState() => _KChartState();
}

class _KChartState extends State<KChart> {
  final List<KLineEntity> datas = <KLineEntity>[];
  bool initializing = true;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.stockTradingHistory.t!.length; i++) {
      datas.add(KLineEntity.fromCustom(
          open: widget.stockTradingHistory.o![i].toDouble(),
          close: widget.stockTradingHistory.c![i].toDouble(),
          time: widget.stockTradingHistory.t![i].toInt(),
          high: widget.stockTradingHistory.h![i].toDouble(),
          low: widget.stockTradingHistory.l![i].toDouble(),
          vol: widget.stockTradingHistory.v![i].toDouble()));
    }
    setState(() {
      initializing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return KChartWidget(
      datas,
      ChartStyle(),
      ChartColors(),
      isTrendLine: false,
      isLine: true,
    );
  }
}

class KChartColors extends ChartColors {
  @override
  List<Color> bgColor = [const Color(0xff18191d), const Color(0xff18191d)];

  @override
  Color kLineColor = const Color(0xff4C86CD);
  @override
  Color lineFillColor = const Color(0x554C86CD);
  @override
  Color ma5Color = const Color(0xffC9B885);
  @override
  Color ma10Color = const Color(0xff6CB0A6);
  @override
  Color ma30Color = const Color(0xff9979C6);
  @override
  Color upColor = const Color(0xff4DAA90);
  @override
  Color dnColor = const Color(0xffC15466);
  @override
  Color volColor = const Color(0xff4729AE);

  @override
  Color macdColor = const Color(0xff4729AE);
  @override
  Color difColor = const Color(0xffC9B885);
  @override
  Color deaColor = const Color(0xff6CB0A6);

  @override
  Color kColor = const Color(0xffC9B885);
  @override
  Color dColor = const Color(0xff6CB0A6);
  @override
  Color jColor = const Color(0xff9979C6);
  @override
  Color rsiColor = const Color(0xffC9B885);

  @override
  Color defaultTextColor = const Color(0xFF879391);

  @override
  Color nowPriceUpColor = const Color(0xff4DAA90);
  @override
  Color nowPriceDnColor = const Color(0xffC15466);
  @override
  Color nowPriceTextColor = const Color(0xffffffff);

  //depth color
  @override
  Color depthBuyColor = const Color(0xff60A893);
  @override
  Color depthSellColor = const Color(0xffC15866);

  //Display value border color when selected
  @override
  Color selectBorderColor = const Color(0xff6C7A86);

  //The fill color of the displayed value background when selected
  @override
  Color selectFillColor = const Color(0xff0D1722);

  //dividing line color
  @override
  Color gridColor = const Color(0xff4c5c74);

  @override
  Color infoWindowNormalColor = const Color(0xffffffff);
  @override
  Color infoWindowTitleColor = const Color(0xffffffff);
  @override
  Color infoWindowUpColor = const Color(0xff00ff00);
  @override
  Color infoWindowDnColor = const Color(0xffff0000);

  @override
  Color hCrossColor = const Color(0xffffffff);
  @override
  Color vCrossColor = const Color(0x1Effffff);
  @override
  Color crossTextColor = const Color(0xffffffff);

  //The color of the maximum and minimum values ​​in the current display
  @override
  Color maxColor = const Color(0xffffffff);
  @override
  Color minColor = const Color(0xffffffff);

  @override
  Color getMAColor(int index) {
    switch (index % 3) {
      case 1:
        return ma10Color;
      case 2:
        return ma30Color;
      default:
        return ma5Color;
    }
  }
}
