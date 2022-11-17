import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_chart_data.dart';
import 'package:dtnd/=models=/response/index_detail.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/config/service/environment.dart';

import '../=models=/request/request_model.dart';
import '../=models=/response/user_token.dart';

abstract class INetworkService {
  //init service
  Future<void> init(Environment environment);

  //core api
  Future<UserEntity?> checkLogin(RequestModel requestModel);

  Future<List<Stock>> getListAllStock();

  Future<List<StockData>> getListStockData(String listStock);

  /// Should not call, too many data
  Future<List<StockTrade>> getListStockTrade(String stockCode);

  Future<StockTradingHistory> getStockTradingHistory(
      String symbol, resolution, from, to);

  Future<List<IndexDetailResponse>> getListIndexDetail();

  Future<IndexDetailResponse> getIndexDetail(Index index);

  Future<List<IndexChartData>> getListIndexChartData(Index index);
}
