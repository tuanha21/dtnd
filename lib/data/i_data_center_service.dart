// ignore_for_file: library_prefixes

import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/business_profile_model.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/liquidity_model.dart';
import 'package:dtnd/=models=/response/news_detail.dart';
import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/=models=/response/security_basic_info_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/=models=/response/stock_ranking_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/subsidiaries_model.dart';
import 'package:dtnd/=models=/response/top_influence_model.dart';
import 'package:dtnd/=models=/response/top_interested_model.dart';
import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/=models=/ui_model/field_tree_element_model.dart';

import '../=models=/response/indContrib.dart';
import '../=models=/response/index_board.dart';
import '../=models=/response/index_detail.dart';
import '../=models=/response/introduct_company.dart';
import '../=models=/response/sec_event.dart';
import '../=models=/response/stock_industry.dart';
import '../=models=/response/stock_vol.dart';
import '../=models=/response/stock_derivative_model.dart';

abstract class IDataCenterService {
  Set<IndexModel> get listIndexs;

  Future<void> init();

  Future<void> startSocket();

  Future<List<StockModel>?> getStockModelsFromStockCodes(
      List<String> stockCodes);

  List<Stock> getStockFromStockCodes(List<String> stockCodes);

  Future<void> removeStockModelsFromStockCodes(List<String> stockCodes);

  Future<StockData> getStockData(String stockCode);

  Future<StockDataResponse> getStockDataResponse(String stockCode);

  Future<void> getListAllStock();

  Future<List<StockData>> getListStockData(List<String> listStock);

  Future<List<Stock>> getList30Stock(String code);

  Future<List<Stock>> getTopSearch();

  Future<List<TrashModel>> getTopInterested([int count]);

  Future<List<TrashModel>> getTopStockTrade([int count, String type]);

  Future<List<TrashModel>> getTopStockChange([int count, String type]);

  Future<List<TrashModel>> getTopForeignTrade([int count, String type]);

  List<Stock> searchStocksBySym(String sym, {int? maxSuggestions});

  Stock? getStocksBySym(String sym);

  Future<StockTradingHistory?> getStockIndayTradingHistory(String stockCode);

  Future<StockTradingHistory?> getStockTradingHistory(
      String stockCode, String resolution, DateTime from, DateTime to);

  Future<Set<IndexModel>> getListIndex(
      {DateTime? fromTime, DateTime? toTime, String? resolution});

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

  Future<List<SecEvent>> getListEvent(String stockCode);

  Future<CompanyIntroductionResponse> getCompanyIntroduction(String stockCode);

  Future<List<StockMatch>> getListStockMatch(String stockCode);

  Future<IndContrib> getIndFvalue(String marketCode);

  // phái sinh
  Future<List<DerivativeResModel>> getListDerivative();
}
