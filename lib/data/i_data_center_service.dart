// ignore_for_file: library_prefixes

import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';

abstract class IDataCenterService {
  List<StockModel> get listInterestedStocks;

  Set<IndexModel> get listIndexs;

  Future<void> init();

  Future<void> startSocket();

  Future<void> fetchData();

  Future<void> getListAllStock();

  Future<List<StockData>> getListStockData(List<String> listStock);

  Future<StockTradingHistory?> getStockIndayTradingHistory(String stockCode);

  Future<StockTradingHistory?> getStockTradingHistory(
      String stockCode, String resolution, int from, int to);

  Future<void> getListInterestedStocks();

  Future<void> getListIndex();
}
