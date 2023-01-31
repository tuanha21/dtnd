// ignore_for_file: library_prefixes

import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/=models=/response/business_profile_model.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/index_chart_data.dart';
import 'package:dtnd/=models=/response/index_detail.dart';
import 'package:dtnd/=models=/response/liquidity_model.dart';
import 'package:dtnd/=models=/response/new_order.dart';
import 'package:dtnd/=models=/response/news_detail.dart';
import 'package:dtnd/=models=/response/s_cash_balance.dart';
import 'package:dtnd/=models=/response/security_basic_info_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/=models=/response/stock_ranking_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/subsidiaries_model.dart';
import 'package:dtnd/=models=/response/top_influence_model.dart';
import 'package:dtnd/=models=/ui_model/field_tree_element_model.dart';
import 'package:dtnd/config/service/environment.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../=models=/request/request_model.dart';
import '../=models=/response/index_board.dart';
import '../=models=/response/user_token.dart';

abstract class INetworkService {
  late IO.Socket socket;

  //init service
  Future<void> init(Environment environment);

  void initSocket(String url);

  Future<void> startSocket();

  //core api
  Future<UserEntity?> checkLogin(RequestModel requestModel);

  Future<List<Stock>> getListAllStock();

  Future<List<String>> getList30Stocks(String code);

  Future<List<StockDataResponse>> getListStockData(String listStock);

  /// Should not call, too many data
  Future<List<StockTrade>> getListStockTrade(String stockCode);

  Future<StockTradingHistory?> getStockTradingHistory(
      String symbol, resolution, from, to);

  Future<List<IndexDetailResponse>> getListIndexDetail();

  Future<IndexDetailResponse> getIndexDetail(Index index);

  Future<List<IndexChartData>> getListIndexChartData(Index index);

  Future<List<StockNews>> getStockNews(String stockCode);

  Future<NewsDetail?> getNewsDetail(int id);

  Future<List<DeepModel>> getMarketDepth();

  Future<List<IndayMatchedOrder>> getIndayMatchedOrders(String symbol);

  Future<List<IndexBoard>> getIndexBoard(String marketCode);

  Future<SCashBalance> getSCashBalance(RequestModel requestModel);

  Future<NewOrderResponse?> createNewOrder(RequestModel requestModel);

  Future<List<TopInfluenceModel>> getTopInfluence(String index);

  Future<LiquidityModel> getLiquidity(String index);

  Future<List<FieldTreeModel>> getListIndustryHeatMap(int top, String type);

  Future<List<StockFinancialIndex>> getStockFinancialIndex(String body);

  Future<StockRankingFinancialIndex?> getStockRankingFinancialIndex(
      String body);

  Future<SecurityBasicInfo?> getSecurityBasicInfo(String body);

  Future<UserInfo?> getUserInfo(RequestModel requestModel);

  //business info
  Future<BusinnessProfileModel?> getBusinnessProfile(String body);

  Future<List<BusinnessLeaderModel>?> getBusinnessLeaders(String body);

  Future<List<SubsidiariesModel>?> getSubsidiaries(Map<String, dynamic> body);
}
