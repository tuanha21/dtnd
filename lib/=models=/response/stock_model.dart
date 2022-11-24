import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_info_core.dart';
import 'package:dtnd/=models=/response/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';

class StockModel {
  late final Stock stock;
  late final StockData stockData;
  late StockInfoCore? stockDataCore;
  late List<StockTrade>? listStockTrade;
  late StockTradingHistory? stockTradingHistory;
  StockModel({
    required this.stock,
    required this.stockData,
    this.stockDataCore,
    this.listStockTrade,
    this.stockTradingHistory,
  });

  void onSocketData(dynamic data) {
    if (data["data"]["id"] == 3220) {
      stockData
        ..lastPrice.value = data["data"]["lastPrice"]
        ..lastVolume.value = data["data"]["totalVol"]
        ..changePc.value = data["data"]["changePc"]
        ..ot.value = data["data"]["change"]
        ..highPrice.value = data["data"]["hp"]
        ..lowPrice.value = data["data"]["lp"]
        ..avePrice.value = data["data"]["ap"];
    } else if (data["data"]["id"] == 3210) {
      if (data["data"]["side"] == "S") {
        stockData
          ..g4.value = data["data"]["g1"]
          ..g5.value = data["data"]["g2"]
          ..g6.value = data["data"]["g3"];
      } else {
        stockData
          ..g1.value = data["data"]["g1"]
          ..g2.value = data["data"]["g2"]
          ..g3.value = data["data"]["g3"];
      }
    }
  }
}
