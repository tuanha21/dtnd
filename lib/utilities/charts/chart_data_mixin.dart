import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'dart:math' as math;

mixin ChartDatasMixin {
  List<OhlcHistoryItem> historyToChartItem(StockTradingHistory data) {
    final listLength = [
      data.t.length,
      data.o.length,
      data.h.length,
      data.l.length,
      data.c.length,
      data.v.length
    ];
    final length = listLength.reduce(math.min);
    final List<OhlcHistoryItem> result = [];
    for (var i = 0; i < length; i++) {
      result.add(OhlcHistoryItem(
        time: data.time.elementAt(i),
        open: data.o.elementAt(i),
        high: data.h.elementAt(i),
        low: data.l.elementAt(i),
        close: data.c.elementAt(i),
        volumn: data.v.elementAt(i),
      ));
    }
    return result;
  }
}

class OhlcHistoryItem {
  late final DateTime time;
  late final num open;
  late final num high;
  late final num low;
  late final num close;
  late final num volumn;

  OhlcHistoryItem({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volumn,
  });
}
