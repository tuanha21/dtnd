import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_info_core.dart';
import 'package:dtnd/=models=/response/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';

class StockModel {
  late final Stock stock;
  late StockData? stockData;
  late StockInfoCore? stockDataCore;
  late List<StockTrade>? listStockTrade;
  late List<StockTradingHistory>? listStockTradingHistory;
  StockModel({
    required this.stock,
    this.stockData,
    this.stockDataCore,
    this.listStockTrade,
    this.listStockTradingHistory,
  });
}
