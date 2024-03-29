// ignore_for_file: library_prefixes

import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/market/business_profile_model.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/market/index_model.dart';
import 'package:dtnd/=models=/response/market/liquidity_model.dart';
import 'package:dtnd/=models=/response/market/news_detail.dart';
import 'package:dtnd/=models=/response/market/news_model.dart';
import 'package:dtnd/=models=/response/market/security_basic_info_model.dart';
import 'package:dtnd/=models=/response/market/signal_month_model.dart';
import 'package:dtnd/=models=/response/market/signal_type.dart';
import 'package:dtnd/=models=/response/market/stock.dart';
import 'package:dtnd/=models=/response/market/stock_data.dart';
import 'package:dtnd/=models=/response/market/stock_financial_index_model.dart';
import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/=models=/response/market/stock_news.dart';
import 'package:dtnd/=models=/response/market/stock_ranking_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/subsidiaries_model.dart';
import 'package:dtnd/=models=/response/market/suggested_signal_model.dart';
import 'package:dtnd/=models=/response/market/top_influence_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_detail_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_history_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_stock_model.dart';
import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/=models=/response/market/field_tree_element_model.dart';

import '../=models=/response/market/ind_contrib.dart';
import '../=models=/response/market/index_board.dart';
import '../=models=/response/market/index_detail.dart';
import '../=models=/response/market/introduct_company.dart';
import '../=models=/response/market/radar_chart_model.dart';
import '../=models=/response/market/sec_event.dart';
import '../=models=/response/market/stock_derivative_model.dart';
import '../=models=/response/market/stock_industry.dart';
import '../=models=/response/stock_vol.dart';

abstract class IDataCenterService {
  Set<IndexModel> get listIndexs;

  Future<void> init();

  Future<void> startSocket();

  Future<List<StockModel>?> getStocksModelsFromStockCodes(
      List<String> stockCodes);

  Future<StockModel?> getStockModelFromStockCode(String stockCode);

  List<Stock> getStocksFromStockCodes(List<String> stockCodes);

  Stock getStockFromStockCode(String stockCode);

  Future<void> removeStockModelsFromStockCodes(List<String> stockCodes);

  Future<StockData> getStockData(String stockCode);

  Future<StockDataResponse> getStockDataResponse(String stockCode);

  Future<void> getListAllStock();

  Future<List<StockData>> getListStockData(List<String> listStock);

  Future<List<Stock>> getList30Stock(String code);

  Future<List<TrashModel>> getTopInterested([int count]);

  Future<List<TrashModel>> getTopStockTrade([int count, String type]);

  Future<List<TrashModel>> getTopStockChange([int count, String type]);

  Future<List<TrashModel>> getTopForeignTrade([int count, String type]);

  Future<List<TopSignalStockModel>> getTopSignalStocks({int count = 5});

  Future<List<SignalType>> getSignalList();

  Future<List<SuggestedSignalModel>> getSuggestedSignal(int day);

  Future<List<SuggestedSignalModel>> getSuggestedSignalFilter(
      int day, String? type);

  Future<TopSignalDetailModel?> getTopSignalDetail(
      String stockCode, String type);

  Future<List<SignalMonthModel>?> getSignalMonth(String stockCode, String type);

  Future<List<TopSignalHistoryModel>?> getTopSignalHistory(
      String stockCode, String type,
      {int day});

  List<Stock> searchStocksBySym(String sym, {int? maxSuggestions});

  Stock? getStocksBySym(String sym);

  Future<StockTradingHistory?> getStockIndayTradingHistory(String stockCode);

  Future<StockTradingHistory?> getStockTradingHistory(
      String stockCode, String resolution, DateTime from, DateTime to);

  Future<Set<IndexModel>> getListIndex(
      {DateTime? fromTime, DateTime? toTime, String? resolution});

  Future<IndexDetailResponse> getIndexDetail(Index index);

  Future<List<StockNews>> getStockNews(String stockCode);

  Future<List<NewsModel>> getNews([int? page, int? records]);

  Future<NewsDetail?> getNewsDetail(int id);

  Future<List<DeepModel>> getMarketDepth();

  Future<List<IndayMatchedOrder>> getIndayMatchedOrders(String symbol);

  Future<List<IndexBoard>> getIndexBoard(String marketCode);

  Future<List<TopInfluenceModel>> getTopInfluence(Index index);

  Future<LiquidityModel> getLiquidity(Index index);

  Future<List<String>> getListIndustry();

  Future<List<StockIndustry>> getListStockByIndust(String industry);

  Future<List<FieldTreeModel>> getListIndustryHeatMap(
      {int top = 8, String type = "KL"});

  Future<List<StockFinancialIndex>> getStockFinancialIndex(String code,
      [String freg, String lang]);

  Future<RadarChartModel> getDataRadarChart(String code, [String lang]);

  Future<StockRankingFinancialIndex?> getStockRankingFinancialIndex(String code,
      [String lang]);

  Future<SecurityBasicInfo?> getSecurityBasicInfo(String code, [String lang]);

  //business info
  Future<BusinnessProfileModel?> getBusinnessProfile(String stockCode);

  Future<List<BusinnessLeaderModel>?> getBusinnessLeaders(String stockCode);

  Future<List<SubsidiariesModel>?> getSubsidiaries(String stockCode);

  Future<List<SubsidiariesModel>?> getAssociatedCompany(String stockCode);

  Future<List<SubsidiariesModel>?> getOtherCompany(String stockCode);

  Future<List<String>> getSectors(String industryCode);

  Future putSearchHistory(String searchString);

  Future<IndContrib> getIndContrib(String marketCode);

  Future<IndContrib> getPIvalue(String marketCode);

  Future<IndContrib> getFIvalue(String marketCode);

  Future<List<IndexDetailResponse>> getListIndexDetail();

  Future<List<SecEvent>> getListEvent(String stockCode,
      {required DateTime startDate, String lang, String reqLanguage});

  Future<CompanyIntroductionResponse> getCompanyIntroduction(String stockCode);

  Future<List<StockMatch>> getListStockMatch(String stockCode);

  Future<IndContrib> getIndFvalue(String marketCode);

  // phái sinh
  Future<List<DerivativeResModel>> getListDerivative();
}
