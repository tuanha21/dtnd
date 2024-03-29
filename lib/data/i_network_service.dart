// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'dart:convert';

import 'package:dtnd/=models=/check_account_success_data_model.dart';
import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/local/va_portfolio_model.dart';
import 'package:dtnd/=models=/response/accumulation/contract_model.dart';
import 'package:dtnd/=models=/response/accumulation/fee_rate_model.dart';
import 'package:dtnd/=models=/response/market/business_profile_model.dart';
import 'package:dtnd/=models=/response/account/cash_transaction_model.dart';
import 'package:dtnd/=models=/response/market/commodity_model.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/market/index_chart_data.dart';
import 'package:dtnd/=models=/response/market/index_detail.dart';
import 'package:dtnd/=models=/response/market/liquidity_model.dart';
import 'package:dtnd/=models=/response/market/news_model.dart';
import 'package:dtnd/=models=/response/market/security_basic_info_model.dart';
import 'package:dtnd/=models=/response/market/signal_month_model.dart';
import 'package:dtnd/=models=/response/market/signal_type.dart';
import 'package:dtnd/=models=/response/market/stock.dart';
import 'package:dtnd/=models=/response/market/stock_data.dart';
import 'package:dtnd/=models=/response/market/stock_financial_index_model.dart';
import 'package:dtnd/=models=/response/market/stock_news.dart';
import 'package:dtnd/=models=/response/market/stock_ranking_financial_index_model.dart';
import 'package:dtnd/=models=/response/market/stock_report_res.dart';
import 'package:dtnd/=models=/response/market/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/subsidiaries_model.dart';
import 'package:dtnd/=models=/response/market/suggested_signal_model.dart';
import 'package:dtnd/=models=/response/market/top_influence_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_detail_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_history_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_stock_model.dart';
import 'package:dtnd/=models=/response/account/total_asset_model.dart';
import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/=models=/response/market/world_index_model.dart';
import 'package:dtnd/=models=/sign_up_success_data_model.dart';
import 'package:dtnd/=models=/response/market/field_tree_element_model.dart';
import 'package:dtnd/config/service/environment.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../=models=/algo/filter.dart';
import '../=models=/algo/stock_filter.dart';
import '../=models=/request/request_model.dart';
import '../=models=/response/accumulation/contract_fee_model.dart';
import '../=models=/response/accumulation/single_contract.dart';
import '../=models=/response/banner_model.dart';
import '../=models=/response/market/basic_company.dart';
import '../=models=/response/market/company_info.dart';
import '../=models=/response/market/ind_contrib.dart';
import '../=models=/response/market/index_board.dart';
import '../=models=/response/market/introduct_company.dart';
import '../=models=/response/market/radar_chart_model.dart';
import '../=models=/response/market/sec_event.dart';
import '../=models=/response/market/sec_trading.dart';
import '../=models=/response/share_holder.dart';
import '../=models=/response/market/stock_board.dart';
import '../=models=/response/market/stock_derivative_model.dart';
import '../=models=/response/market/stock_his.dart';
import '../=models=/response/market/stock_industry.dart';
import '../=models=/response/stock_vol.dart';
import 'package:http/http.dart' as http;

abstract class INetworkService {
  late final IO.Socket socket;

  Uri url_core(
    String unencodedPath, [
    Map<String, dynamic>? queryParameters,
  ]);

  Uri url_core1(
    String unencodedPath, [
    Map<String, dynamic>? queryParameters,
  ]);

  Uri get url_core_endpoint;

  Uri url_board(String path);

  Uri url_board_sbsi(String path);

  Uri url_board_data_feed(Map<String, dynamic> queryParameters);

  Uri url_info_sbsi(String path, [Map<String, dynamic>? queryParameters]);

  Uri url_algo(String path, [Map<String, dynamic>? queryParameters]);

  Uri url_algo_apec(String path, [Map<String, dynamic>? queryParameters]);

  /// GET POST PUT DELETE
  Future<http.Response> get(Uri url, {Map<String, String>? headers});

  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding});

  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding});

  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding});

  dynamic decode(dynamic data);

  //init service
  Future<void> init(Environment environment);

  Future<Map<String, dynamic>> getAppConfig();

  void initSocket(String url);

  Future<void> startSocket();

  Future<List<DataBanner>?> getHomeBanner();

  void regSessionExpiredCallback(void Function() onSessionExpired);

  //core api
  Future<T?> requestTraditionalApi<T extends CoreResponseModel>(
    RequestModel requestModel, {
    bool Function(Map<String, dynamic>)? hasError,
    T? Function(Map<String, dynamic>)? onError,
    T? Function()? onParseError,
    dynamic Function(Map<String, dynamic>)? selectionData,
    Map<String, dynamic> Function(Map<String, dynamic>)? modifyResponse,
  });

  Future<List<T>?> requestTraditionalApiResList<T extends CoreResponseModel>(
    RequestModel requestModel, {
    bool Function(Map<String, dynamic>)? hasError,
    List<T>? Function(Map<String, dynamic>)? onError,
    List<T>? Function()? onParseError,
    List<dynamic> Function(Map<String, dynamic>)? selectionData,
    Map<String, dynamic> Function(Map<String, dynamic>)? modifyResponse,
  });

  Future<List<Stock>> getListAllStock();

  Future<List<String>> getList30Stocks(String code);

  Future<List<String>> getTopSearch(String body);

  Future<List<TrashModel>> getTopInterested(Map<String, dynamic> body);

  Future<List<TrashModel>> getTopStockTrade(Map<String, dynamic> body);

  Future<List<TrashModel>> getTopStockChange(Map<String, dynamic> body);

  Future<List<TrashModel>> getTopForeignTrade(Map<String, dynamic> body);

  Future<List<TopSignalStockModel>?> getTopSignalStocks(
      Map<String, String> body);

  Future<List<SignalType>?> getSignalList(Map<String, String> body);

  Future<List<SuggestedSignalModel>?> getSuggestedSignal(
      Map<String, String> body);

  Future<TopSignalDetailModel?> getTopSignalDetail(Map<String, String> body);

  Future<List<TopSignalHistoryModel>?> getTopSignalHistory(
      Map<String, String> body);

  Future<List<SignalMonthModel>?> getSignalMonth(Map<String, String> body);

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

  Future<String> getNewsDetail(int id);

  Future<List<WorldIndexModel>> getWorldIndex();

  Future<List<CommodityModel>> getCommodity();

  Future<List<WorldIndexData>> getWorldIndexData(Map<String, String> body);

  Future<List<DeepModel>> getMarketDepth();

  Future<List<IndayMatchedOrder>> getIndayMatchedOrders(String symbol);

  Future<List<IndexBoard>> getIndexBoard(String marketCode);

  Future<List<TopInfluenceModel>> getTopInfluence(String index);

  Future<LiquidityModel> getLiquidity(String index);

  Future<List<String>> getListIndustry();

  Future<List<FieldTreeModel>> getListIndustryHeatMap(int top, String type);

  Future<List<StockIndustry>> getListStockByIndust(String industry);

  Future<List<SecEvent>> getListEvent(String stockCode,
      {required DateTime startDate,
      required String lang,
      required String reqLanguage});

  Future<List<StockFinancialIndex>> getStockFinancialIndex(String body);

  Future<RadarChartModel> getDataRadarChart(String body);

  Future<StockRankingFinancialIndex?> getStockRankingFinancialIndex(
      String body);

  Future<SecurityBasicInfo?> getSecurityBasicInfo(String body);

  // user

  Future<TotalAsset?> getTotalAsset(RequestModel requestModel);

  Future<List<String>> getSearchHistory(String body);

  Future<void> putSearchHistory(String body);

  Future<void> deleteAccount(String body);

  //business info
  Future<BusinnessProfileModel?> getBusinnessProfile(String body);

  Future<List<BusinnessLeaderModel>?> getBusinnessLeaders(String body);

  Future<List<SubsidiariesModel>?> getSubsidiaries(Map<String, dynamic> body);

  Future<List<String>> getSectors(String industryCode);

  Future<IndContrib> getIndContrib(String marketCode);

  Future<IndContrib> getPIvalue(String marketCode);

  Future<IndContrib> getFIvalue(String marketCode);

  Future<IndContrib> getIndFvalue(String marketCode);

  Future<CompanyIntroductionResponse> getCompanyIntroduction(String stockCode);

  Future<BasicCompany> getBasicProfile(String stockCode);

  Future<CompanyInfo> getCompanyInfo(String stockCode);

  Future<StockReportRes> getStockInfo(String stockCOde);

  Future<List<StockMatch>> getListStockMatch(String stockCode);

  Future<List<StockHis>> getStockHis(String stockCode, String from, String to);

  Future<StockBoard> getStockBoard(String stockCode);

  Future<List<SecTrading>> getSecTradingHistory(String stockCode);

  Future<List<ShareHolders>> getShareHolderCompany(String stockCode);

  Future<List<Filter>> getFilterAccount();

  Future<List<FilterRange>> getFilterRange();

  Future<List<StockFilter>> getStockFilter(Filter filter);

  Future setFilter(Filter filter, String type);

  Future deleteFilter(int id);

  // derivative
  Future<List<DerivativeResModel>> getListDerivative();

  // Signup
  Future<bool> verifySignupInfo(String body);

  Future<bool> verifySignupOTP(String body);

  Future<SignUpSuccessDataModel?> createAccount(String body);

  Future<CheckAccountSuccessDataModel?> checkAccountInfo(String body);

  Future<bool> resetPassword(String body);

  Future<bool> checkInfoVa(String body);

  Future<bool> registerVirtualBroker(String body);

  Future<bool> checkRegisterOtp(String body);

  Future<VAPortfolio> getVAPortfolio(String body);

  Future<void> createBot(String body);

  Future<void> deleteBot(String body);

  Future<List<FeeRateModel>?> getAllFreeRate(String body);

  Future<bool> updateContract(String body);

  Future<List<ContractModel>?> getAllContract(String body);

  Future<List<CashTransactionHistoryModel>?> getHistoryContract(String body);

  Future<bool> checkContractBase(String body);

  Future<void> changeContractBase(String body);

  Future<ContractFee?> getProvisionalFee(String body);

  Future<SingleContract?> getSingleContract(String itemId);

  Future<SingleContract?> liquidAll(String contractId);

  Future<bool> methodUpdate(String body);
}
