// ignore_for_file: library_prefixes

import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/news_detail.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';

abstract class IDataCenterService {
  Set<IndexModel> get listIndexs;

  Future<void> init();

  Future<void> startSocket();

  Future<List<StockModel>> getStockModelsFromStockCodes(
      List<String> stockCodes);

  Future<void> removeStockModelsFromStockCodes(List<String> stockCodes);

  Future<StockData> getStockData(String stockCode);

  Future<void> getListAllStock();

  Future<List<StockData>> getListStockData(List<String> listStock);

  Future<StockTradingHistory?> getStockIndayTradingHistory(String stockCode);

  Future<StockTradingHistory?> getStockTradingHistory(
      String stockCode, String resolution, int from, int to);

  Future<Set<IndexModel>> getListIndex();

  Future<List<StockNews>> getStockNews(String stockCode);

  Future<NewsDetail?> getNewsDetail(int id);
}
