// ignore_for_file: library_prefixes

import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/=models=/response/business_profile_model.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/index_chart_data.dart';
import 'package:dtnd/=models=/response/index_detail.dart';
import 'package:dtnd/=models=/response/liquidity_model.dart';
import 'package:dtnd/=models=/response/new_order.dart';
import 'package:dtnd/=models=/response/news_detail.dart';
import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/=models=/response/s_cash_balance.dart';
import 'package:dtnd/=models=/response/security_basic_info_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/=models=/response/stock_ranking_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_report_res.dart';
import 'package:dtnd/=models=/response/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/subsidiaries_model.dart';
import 'package:dtnd/=models=/response/top_influence_model.dart';
import 'package:dtnd/=models=/response/total_asset_model.dart';
import 'package:dtnd/=models=/response/world_index_model.dart';
import 'package:dtnd/=models=/ui_model/field_tree_element_model.dart';
import 'package:dtnd/config/service/environment.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../=models=/request/request_model.dart';
import '../=models=/response/basic_company.dart';
import '../=models=/response/company_info.dart';
import '../=models=/response/indContrib.dart';
import '../=models=/response/index_board.dart';
import '../=models=/response/introduct_company.dart';
import '../=models=/response/sec_event.dart';
import '../=models=/response/stock_board.dart';
import '../=models=/response/stock_his.dart';
import '../=models=/response/stock_industry.dart';
import '../=models=/response/stock_vol.dart';
import '../=models=/response/user_token.dart';

abstract class INetworkService {
  late IO.Socket socket;

  //init service
  Future<void> init(Environment environment);

  void initSocket(String url);

  Future<void> startSocket();

  Future<String?> getHomeBanner();

  //core api
  Future<UserEntity?> checkLogin(RequestModel requestModel);

  Future<T?> requestTraditionalApi<T extends CoreResponseModel>(
      RequestModel requestModel);

  Future<List<Stock>> getListAllStock();

  Future<List<String>> getList30Stocks(String code);

  Future<List<String>> getTopSearch();

  Future<List<String>> getTopInterested(Map<String, dynamic> body);

  Future<List<String>> getTopStockTrade(Map<String, dynamic> body);

  Future<List<String>> getTopStockChange(Map<String, dynamic> body);

  Future<List<String>> getTopForeignTrade(Map<String, dynamic> body);

  Future<List<StockDataResponse>> getListStockData(String listStock);

  /// Should not call, too many data
  Future<List<StockTrade>> getListStockTrade(String stockCode);

  Future<StockTradingHistory?> getStockTradingHistory(
      String symbol, String resolution, int from, int to);

  Future<List<IndexDetailResponse>> getListIndexDetail();

  Future<IndexDetailResponse> getIndexDetail(Index index);

  Future<List<IndexChartData>> getListIndexChartData(Index index);

  Future<List<StockNews>> getStockNews(String stockCode);

  Future<List<NewsModel>> getNews(Map<String, String> body);

  Future<String> getNewsContent(int id);

  Future<NewsDetail?> getNewsDetail(int id);

  Future<List<WorldIndexModel>> getWorldIndex();

  Future<List<WorldIndexData>> getWorldIndexData(Map<String, String> body);

  Future<List<DeepModel>> getMarketDepth();

  Future<List<IndayMatchedOrder>> getIndayMatchedOrders(String symbol);

  Future<List<IndexBoard>> getIndexBoard(String marketCode);

  Future<SCashBalance> getSCashBalance(RequestModel requestModel);

  Future<NewOrderResponse?> createNewOrder(RequestModel requestModel);

  Future<List<TopInfluenceModel>> getTopInfluence(String index);

  Future<LiquidityModel> getLiquidity(String index);

  Future<List<String>> getListIndustry();

  Future<List<FieldTreeModel>> getListIndustryHeatMap(int top, String type);

  Future<List<StockIndustry>> getListStockByIndust(String industry);

  Future<List<SecEvent>> getListEvent(String stockCode);

  Future<List<StockFinancialIndex>> getStockFinancialIndex(String body);

  Future<StockRankingFinancialIndex?> getStockRankingFinancialIndex(
      String body);

  Future<SecurityBasicInfo?> getSecurityBasicInfo(String body);

  // user
  Future<UserInfo?> getUserInfo(RequestModel requestModel);

  Future<TotalAsset?> getTotalAsset(RequestModel requestModel);

  Future<List<String>> getSearchHistory(String body);

  Future<void> putSearchHistory(String body);

  //business info
  Future<BusinnessProfileModel?> getBusinnessProfile(String body);

  Future<List<BusinnessLeaderModel>?> getBusinnessLeaders(String body);

  Future<List<SubsidiariesModel>?> getSubsidiaries(Map<String, dynamic> body);

  Future<List<String>> getSectors(String industryCode);

  Future<IndContrib> getIndContrib(String marketCode);

  Future<IndContrib> getPIvalue(String marketCode);

  Future<IndContrib> getFIvalue(String marketCode);

  Future<CompanyIntroductionResponse> getCompanyIntroduction(String stockCode);

  Future<BasicCompany> getBasicProfile(String stockCode);

  Future<CompanyInfo> getCompanyInfo(String stockCode);

  Future<StockReportRes> getStockInfo(String stockCOde);

  Future<List<StockMatch>> getListStockMatch(String stockCode);

  Future<List<StockHis>> getStockHis(String stockCode, String from, String to);

  Future<StockBoard> getStockBoard(String stockCode);

}
