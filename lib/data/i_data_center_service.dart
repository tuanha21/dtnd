// ignore_for_file: library_prefixes

import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/liquidity_model.dart';
import 'package:dtnd/=models=/response/news_detail.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/top_influence_model.dart';

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

  Future<List<StockModel>> getList30Stock(String code);

  Future<List<Stock>> searchStocksBySym(String sym, {int maxSuggestions});

  Future<StockTradingHistory?> getStockIndayTradingHistory(String stockCode);

  Future<StockTradingHistory?> getStockTradingHistory(
      String stockCode, String resolution, int from, int to);

  Future<Set<IndexModel>> getListIndex();

  Future<List<StockNews>> getStockNews(String stockCode);

  Future<NewsDetail?> getNewsDetail(int id);

  Future<List<DeepModel>> getMarketDepth();

  Future<List<IndayMatchedOrder>> getIndayMatchedOrders(String symbol);

  Future<List<TopInfluenceModel>> getTopInfluence(Index index);

  Future<LiquidityModel> getLiquidity(Index index);
}
