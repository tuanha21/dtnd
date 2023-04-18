// ignore_for_file: library_prefixes

import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/local/va_portfolio_model.dart';
import 'package:dtnd/=models=/response/business_profile_model.dart';
import 'package:dtnd/=models=/response/commodity_model.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/index_chart_data.dart';
import 'package:dtnd/=models=/response/index_detail.dart';
import 'package:dtnd/=models=/response/liquidity_model.dart';
import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/=models=/response/security_basic_info_model.dart';
import 'package:dtnd/=models=/response/signal_month_model.dart';
import 'package:dtnd/=models=/response/signal_type.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/=models=/response/stock_ranking_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_report_res.dart';
import 'package:dtnd/=models=/response/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/subsidiaries_model.dart';
import 'package:dtnd/=models=/response/suggested_signal_model.dart';
import 'package:dtnd/=models=/response/top_influence_model.dart';
import 'package:dtnd/=models=/response/top_signal_detail_model.dart';
import 'package:dtnd/=models=/response/top_signal_history_model.dart';
import 'package:dtnd/=models=/response/top_signal_stock_model.dart';
import 'package:dtnd/=models=/response/total_asset_model.dart';
import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/=models=/response/world_index_model.dart';
import 'package:dtnd/=models=/sign_up_success_data_model.dart';
import 'package:dtnd/=models=/ui_model/field_tree_element_model.dart';
import 'package:dtnd/config/service/environment.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../=models=/algo/filter.dart';
import '../=models=/algo/stock_filter.dart';
import '../=models=/request/request_model.dart';
import '../=models=/response/banner_model.dart';
import '../=models=/response/basic_company.dart';
import '../=models=/response/company_info.dart';
import '../=models=/response/indContrib.dart';
import '../=models=/response/index_board.dart';
import '../=models=/response/introduct_company.dart';
import '../=models=/response/radar_chart_model.dart';
import '../=models=/response/sec_event.dart';
import '../=models=/response/sec_trading.dart';
import '../=models=/response/share_holder.dart';
import '../=models=/response/stock_board.dart';
import '../=models=/response/stock_derivative_model.dart';
import '../=models=/response/stock_his.dart';
import '../=models=/response/stock_industry.dart';
import '../=models=/response/stock_vol.dart';

abstract class INetworkService {
  late final IO.Socket socket;

  //init service
  Future<void> init(Environment environment);

  void initSocket(String url);

  Future<void> startSocket();

  Future<List<DataBanner>?> getHomeBanner();

  void regSessionExpiredCallback(void Function() onSessionExpired);

  //core api
  Future<T?> requestTraditionalApi<T extends CoreResponseModel>(
    RequestModel requestModel, {
    T? Function(Map<String, dynamic>)? onError,
    bool Function(Map<String, dynamic>)? hasError,
    dynamic Function(Map<String, dynamic>)? selectionData,
    Map<String, dynamic> Function(Map<String, dynamic>)? modifyResponse,
  });

  Future<List<T>?> requestTraditionalApiResList<T extends CoreResponseModel>(
    RequestModel requestModel, {
    List<T>? Function(Map<String, dynamic>)? onError,
    bool Function(Map<String, dynamic>)? hasError,
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

  Future<List<SecEvent>> getListEvent(String stockCode);

  Future<List<StockFinancialIndex>> getStockFinancialIndex(String body);

  Future<RadarChartModel> getDataRadarChart(String body);

  Future<StockRankingFinancialIndex?> getStockRankingFinancialIndex(
      String body);

  Future<SecurityBasicInfo?> getSecurityBasicInfo(String body);

  // user

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

  Future<bool> checkInfoVa(String body);

  Future<bool> registerVirtualBroker(String body);

  Future<bool> checkRegisterOtp(String body);

  Future<VAPortfolio> getVAPortfolio(String body);

  Future<void> createBot(String body);

  Future<void> deleteBot(String body);
}
