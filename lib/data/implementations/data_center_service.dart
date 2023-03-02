import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/business_profile_model.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/indContrib.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/index_detail.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/introduct_company.dart';
import 'package:dtnd/=models=/response/liquidity_model.dart';
import 'package:dtnd/=models=/response/news_detail.dart';
import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/=models=/response/sec_event.dart';
import 'package:dtnd/=models=/response/security_basic_info_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/=models=/response/stock_ranking_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/stock_vol.dart';
import 'package:dtnd/=models=/response/subsidiaries_model.dart';
import 'package:dtnd/=models=/response/top_influence_model.dart';
import 'package:dtnd/=models=/response/top_interested_model.dart';
import 'package:dtnd/=models=/ui_model/field_tree_element_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../=models=/response/index_board.dart';
import '../../=models=/response/stock_industry.dart';

const List<String> defaultListStock = [
  'ACB',
  'BID',
  'CTG',
  'FPT',
  'GAS',
  'GVR',
  'HDB',
  'HPG'
];

class DataCenterService implements IDataCenterService {
  DataCenterService._internal()
      : networkService = NetworkService(),
        localStorageService = LocalStorageService();

  static final DataCenterService _instance = DataCenterService._internal();

  static DataCenterService get instance => _instance;

  factory DataCenterService() => _instance;

  /// Other [Service]
  late final INetworkService networkService;

  late final ILocalStorageService localStorageService;

  /// Data
  late IO.Socket socket;

  bool registering = false;

  bool initingListIndex = false;

  final Map<String, int> listStockStringReg = <String, int>{};

  final List<StockModel> listStockReg = <StockModel>[];

  late final List<Stock> listAllStock;

  final List<StockModel> _listInterestedStocks = [];

  final Set<IndexModel> _listIndex = {};

  @override
  Set<IndexModel> get listIndexs => _listIndex;

  @override
  Future<void> init() async {
    await getListAllStock();
    await startSocket();
  }

  @override
  Future<void> startSocket() async {
    socket = networkService.socket;
    socket.on("public", (data) {
      if (data['data']['id'] == 1101) {
        // print(data);
        return processIndexData(data);
      }
      if (data['data']['id'] == 3220 ||
          data['data']['id'] == 3210 ||
          data['data']['id'] == 3250) {
        return processStockData(data);
      }
      // print(data);
    });
    socket.onPing((data) {
      const String pingMsg =
          "{\"action\":\"ping\",\"mode\":\"sync\",\"data\":\"\"}";
      socket.emit("regs", pingMsg);
    });
    socket.onDisconnect((data) {
      logger.e("Socket disconnected!");
      logger.e(data);
      return startSocket();
    });
    socket.onConnecting((data) {
      logger.i("Try to connecting...");
      return null;
    });
    socket.connect();
    regStocks(_listInterestedStocks.map((e) => e.stock.stockCode).toList());
    return;
  }

  void processIndexData(dynamic data) {
    if (_listIndex.toList().isEmpty) return;
    final Index index = IndexUtil.fromCode(data['data']['mc']);
    late final IndexModel? indexModel;
    try {
      indexModel = _listIndex.firstWhere(
        (element) => element.index == index,
      );
    } catch (e) {
      indexModel = null;
    }
    indexModel?.onSocketData(data);
  }

  //
  void processStockData(dynamic data) {
    try {
      final sym = data['data']['sym'] ?? data['data']['symbol'];
      final stockModel =
          listStockReg.firstWhere((element) => element.stock.stockCode == sym);
      stockModel.onSocketData(data);
    } catch (e) {
      logger.v(e);
    }

    // _listIndex.firstWhere((element) => element.index == _index);
  }

  void regStocks(List<String> stocks) {
    final List<String> join = getUnregisteredCodes(
      stocks,
      onRegisteredCode: (stock) =>
          listStockStringReg.update(stock, (value) => ++value),
      onUnregisteredCode: (stock) => listStockStringReg[stock] = 1,
    );
    regSocketStocks(join);
  }

  Future<List<String>> leaveStocks(List<String> stocks) async {
    for (final String stock in stocks) {
      if (listStockStringReg.containsKey(stock)) {
        listStockStringReg.update(stock, (value) => --value);
      } else {
        continue;
      }
    }
    final List<String> leave = getOneRegisteredCodes(
      stocks,
      onOneRegisteredCode: (stockCode) => listStockStringReg.remove(stockCode),
      onUnregisteredCode: (stockCode) =>
          listStockStringReg.update(stockCode, (value) => --value),
    );
    leaveSocketStocks(leave);
    return leave;
  }

  /// Join socket
  void regSocketStocks(List<String> stocks) {
    final String codes = stocks.join(",");
    String joinMsg = "{\"action\":\"join\",\"data\":\"$codes\"}";
    socket.emit("regs", joinMsg);
    return;
  }

  /// Leave socket
  void leaveSocketStocks(List<String> stocks) {
    final String codes = stocks.join(",");
    String leaveMsg = "{\"action\":\"leave\",\"data\":\"$codes\"}";
    socket.emit("regs", leaveMsg);
    return;
  }

  List<String> getUnregisteredCodes(List<String> codes,
      {ValueChanged<String>? onRegisteredCode,
      ValueChanged<String>? onUnregisteredCode}) {
    final List<String> unregisteredCodes = [];
    if (listStockStringReg.isEmpty) {
      for (final String stockCode in codes) {
        unregisteredCodes.add(stockCode);
        onUnregisteredCode?.call(stockCode);
      }
    } else {
      for (final String stockCode in codes) {
        if (listStockStringReg.containsKey(stockCode)) {
          onRegisteredCode?.call(stockCode);
        } else {
          unregisteredCodes.add(stockCode);
          onUnregisteredCode?.call(stockCode);
        }
      }
    }
    return unregisteredCodes;
  }

  List<String> getRegisteredCodes(List<String> codes) {
    final List<String> registeredCodes = [];
    if (listStockStringReg.isEmpty) {
      registeredCodes.addAll(codes);
    } else {
      for (final String stockCode in codes) {
        if (listStockStringReg.containsKey(stockCode)) {
          registeredCodes.add(stockCode);
        }
      }
    }
    return registeredCodes;
  }

  List<String> getOneRegisteredCodes(List<String> codes,
      {ValueChanged<String>? onOneRegisteredCode,
      ValueChanged<String>? onUnregisteredCode}) {
    final List<String> oneRegisteredCodes = [];
    for (final String stockCode in codes) {
      if (listStockStringReg[stockCode]! <= 1) {
        oneRegisteredCodes.add(stockCode);
        onOneRegisteredCode?.call(stockCode);
      } else {
        onUnregisteredCode?.call(stockCode);
      }
    }
    return oneRegisteredCodes;
  }

  @override
  Future<List<StockModel>?> getStockModelsFromStockCodes(
      List<String> stockCodes) async {
    if (registering) {
      // Wait to recall
      await 1.delay();
      // Recall
      return getStockModelsFromStockCodes(stockCodes);
    }
    registering = true;
    final List<StockModel> listReturn = <StockModel>[];
    for (final String stockCode in stockCodes) {
      final int index = listStockReg
          .indexWhere((element) => element.stock.stockCode == stockCode);
      if (index != -1) {
        listReturn.add(listStockReg[index]);
      } else {
        try {
          final stock = listAllStock
              .firstWhere((element) => element.stockCode == stockCode);
          final stockData = await getStockData(stockCode);
          final stockModel = StockModel(stock: stock, stockData: stockData);
          listStockReg.add(stockModel);
          listReturn.add(stockModel);
        } catch (e) {
          continue;
        }
      }
    }

    regStocks(stockCodes);
    registering = false;
    return listReturn;
  }

  @override
  List<Stock> getStockFromStockCodes(List<String> stockCodes) {
    final List<Stock> listReturn = <Stock>[];
    for (final String code in stockCodes) {
      try {
        final stock =
            listAllStock.firstWhere((element) => element.stockCode == code);
        listReturn.add(stock);
      } catch (e) {
        continue;
      }
    }
    return listReturn;
  }

  @override
  Future<void> removeStockModelsFromStockCodes(List<String> stockCodes) {
    throw UnimplementedError();
  }

  @override
  Future<void> getListAllStock() async {
    List<Stock>? listAllStockSaved = localStorageService.getSavedListAllStock();
    listAllStockSaved ??= await networkService.getListAllStock();
    listAllStock = <Stock>[];
    for (final Stock stock in listAllStockSaved) {
      listAllStock.add(stock);
    }
  }

  @override
  Future<List<StockData>> getListStockData(List<String> listStock) async {
    if (listStock.isEmpty) return [];
    final String listStockString = listStock.join(",");
    final List<StockDataResponse> listResponse =
        await networkService.getListStockData(listStockString);
    if (listResponse.isEmpty) return [];

    final List<StockData> result = [];
    for (var element in listResponse) {
      result.add(StockData.fromResponse(element));
    }
    return result;
  }

  @override
  Future<List<Stock>> getList30Stock(String code) async {
    final listStocks = await networkService.getList30Stocks(code);
    if (listStocks.isEmpty) {
      return [];
    }
    final List<Stock> results = [];
    for (var e in listStocks) {
      try {
        final stock =
            listAllStock.firstWhere((element) => element.stockCode == e);
        results.add(stock);
      } catch (e) {
        continue;
      }
    }
    return results;
  }

  @override
  Future<List<Stock>> getTopSearch() async {
    final listStrings = await networkService.getTopSearch();
    if (listStrings.isEmpty) {
      return [];
    }
    final List<Stock> results = getStockFromStockCodes(listStrings);

    return results;
  }

  @override
  Future<List<TopInterested>> getTopForeignTrade(
      [int count = 5, String type = "i"]) async {
    final Map<String, String> body = {
      "count": "$count",
      "type": type,
    };
    final listStrings = await networkService.getTopForeignTrade(body);
    if (listStrings.isEmpty) {
      return [];
    }

    return listStrings;
  }

  @override
  Future<List<TopInterested>> getTopStockChange(
      [int count = 5, String type = "i"]) async {
    final Map<String, String> body = {
      "count": "$count",
      "type": type,
    };
    final listStrings = await networkService.getTopStockChange(body);
    if (listStrings.isEmpty) {
      return [];
    }

    return listStrings;
  }

  @override
  Future<List<TopInterested>> getTopInterested(
      [int count = 5, String type = "i"]) async {
    final Map<String, String> body = {
      "count": "$count",
    };
    final listStrings = await networkService.getTopInterested(body);
    if (listStrings.isEmpty) {
      return [];
    }

    return listStrings;
  }

  @override
  Future<List<TopInterested>> getTopStockTrade(
      [int count = 5, String type = "i"]) async {
    final Map<String, String> body = {
      "count": "$count",
      "type": type,
    };
    final listStrings = await networkService.getTopStockTrade(body);
    if (listStrings.isEmpty) {
      return [];
    }

    return listStrings;
  }

  @override
  List<Stock> searchStocksBySym(String sym, {int? maxSuggestions}) {
    if (sym.isEmpty) {
      return [];
    }
    final List<Stock> searchedStocks = <Stock>[];

    final _sym = sym.toUpperCase();
    for (final Stock stock in listAllStock) {
      if (stock.stockCode.contains(_sym)) {
        searchedStocks.add(stock);
        if (maxSuggestions != null && _sym.length == maxSuggestions) {
          return searchedStocks;
        }
      }
    }
    return searchedStocks;
  }

  @override
  Stock? getStocksBySym(String sym) {
    final _sym = sym.toUpperCase();

    return listAllStock.firstWhere((element) => element.stockCode == _sym);
  }

  @override
  Future<StockData> getStockData(String stockCode) async {
    final List<StockDataResponse> listResponse =
        await networkService.getListStockData(stockCode);
    if (listResponse.isEmpty) return StockData.getDefault(stockCode);

    final StockData result = StockData.fromResponse(listResponse.first);
    return result;
  }

  @override
  Future<StockTradingHistory?> getStockIndayTradingHistory(String stockCode) {
    const String resolution = "5";
    final int from = TimeUtilities.timeToEpoch(TimeUtilities.beginningOfDay);
    final int to = TimeUtilities.timeToEpoch(DateTime.now());
    return networkService.getStockTradingHistory(
        stockCode, resolution, from, to);
  }

  @override
  Future<StockTradingHistory?> getStockTradingHistory(
      String stockCode, String resolution, DateTime from, DateTime to) {
    final int fromTime = TimeUtilities.timeToEpoch(from);
    final int toTime = TimeUtilities.timeToEpoch(to);
    return networkService.getStockTradingHistory(
        stockCode, resolution, fromTime, toTime);
  }

  @override
  Future<Set<IndexModel>> getListIndex(
      {DateTime? fromTime, DateTime? toTime, String? resolution}) async {
    if (_listIndex.isNotEmpty) {
      return _listIndex;
    }
    if (initingListIndex) {
      // Wait to recall
      await 1.delay();
      // Recall
      return getListIndex();
    }
    initingListIndex = true;
    for (final Index index in Index.values) {
      final response = await networkService.getIndexDetail(index);
      final chartResponse = await getStockTradingHistory(
          index.chartCode,
          resolution ?? "5",
          fromTime ?? TimeUtilities.getPreviousDateTime(TimeUtilities.week(1)),
          toTime ?? DateTime.now());
      _listIndex.add(IndexModel(
        index: index,
        indexDetailResponse: response,
        stockDayTradingHistory: chartResponse,
      ));
    }
    initingListIndex = false;
    return _listIndex;
  }

  @override
  Future<List<StockNews>> getStockNews(String stockCode) {
    return networkService.getStockNews(stockCode);
  }

  @override
  Future<List<NewsModel>> getNews([int? page, int? records]) {
    final Map<String, String> body = {
      "page": "$page",
      "records": "$records",
    };
    return networkService.getNews(body);
  }

  @override
  Future<NewsDetail?> getNewsDetail(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<DeepModel>> getMarketDepth() {
    return networkService.getMarketDepth();
  }

  @override
  Future<List<IndayMatchedOrder>> getIndayMatchedOrders(String symbol) {
    return networkService.getIndayMatchedOrders(symbol);
  }

  @override
  Future<List<TopInfluenceModel>> getTopInfluence(Index index) {
    return networkService.getTopInfluence(index.exchangeCode);
  }

  @override
  Future<LiquidityModel> getLiquidity(Index index) {
    return networkService.getLiquidity(index.exchangeCode);
  }

  @override
  Future<List<FieldTreeModel>> getListIndustryHeatMap(
      {int top = 8, String type = "KL"}) async {
    final result = await networkService.getListIndustryHeatMap(top, type);
    for (var field in result) {
      for (var element in field.stocks) {
        element.getStock(this);
      }
    }
    return result;
  }

  @override
  Future<List<StockFinancialIndex>> getStockFinancialIndex(String code,
      [String freg = "Y", String lang = "vi"]) {
    final body = '{"lang":"$lang", "secCode": "$code", "freq":"$freg"}';
    return networkService.getStockFinancialIndex(body);
  }

  @override
  Future<StockRankingFinancialIndex?> getStockRankingFinancialIndex(String code,
      [String lang = "vi"]) {
    final body = '{"lang":"$lang", "secCode": "$code"}';
    return networkService.getStockRankingFinancialIndex(body);
  }

  @override
  Future<SecurityBasicInfo?> getSecurityBasicInfo(String code,
      [String lang = "vi"]) {
    final body = '{"lang":"$lang", "secList":"$code", "Exchange":""}';
    return networkService.getSecurityBasicInfo(body);
  }

  @override
  Future<BusinnessProfileModel?> getBusinnessProfile(String stockCode) {
    final body = '{"secCode":"$stockCode"}';
    return networkService.getBusinnessProfile(body);
  }

  @override
  Future<List<BusinnessLeaderModel>?> getBusinnessLeaders(String stockCode) {
    final body = '{"secCode":"$stockCode"}';
    return networkService.getBusinnessLeaders(body);
  }

  @override
  Future<List<SubsidiariesModel>?> getSubsidiaries(String stockCode) {
    final body = {
      "ticker": stockCode,
      "relatedType": "D933DCAE2B553EE0E055C3B42B92FC60"
    };
    return networkService.getSubsidiaries(body);
  }

  @override
  Future<List<SubsidiariesModel>?> getAssociatedCompany(String stockCode) {
    final body = {
      "ticker": stockCode,
      "relatedType": "D933DCAE2B563EE0E055C3B42B92FC60"
    };
    return networkService.getSubsidiaries(body);
  }

  @override
  Future<List<SubsidiariesModel>?> getOtherCompany(String stockCode) {
    final body = {
      "ticker": stockCode,
      "relatedType": "D933DCAE2B583EE0E055C3B42B92FC60"
    };
    return networkService.getSubsidiaries(body);
  }

  @override
  Future<List<IndexBoard>> getIndexBoard(String marketCode) {
    return networkService.getIndexBoard(marketCode);
  }

  @override
  Future<List<String>> getSectors(String industryCode) {
    return networkService.getSectors(industryCode);
  }

  @override
  Future putSearchHistory(String searchString) {
    return networkService.putSearchHistory(searchString);
  }

  @override
  Future<IndContrib> getIndContrib(String marketCode) {
    return networkService.getIndContrib(marketCode);
  }

  @override
  Future<IndContrib> getFIvalue(String marketCode) {
    return networkService.getFIvalue(marketCode);
  }

  @override
  Future<IndContrib> getPIvalue(String marketCode) {
    return networkService.getPIvalue(marketCode);
  }

  @override
  Future<List<IndexDetailResponse>> getListIndexDetail() {
    return networkService.getListIndexDetail();
  }

  @override
  Future<List<String>> getListIndustry() {
    return networkService.getListIndustry();
  }

  @override
  Future<List<StockIndustry>> getListStockByIndust(String industry) {
    return networkService.getListStockByIndust(industry);
  }

  @override
  Future<List<SecEvent>> getListEvent(String stockCode) {
    return networkService.getListEvent(stockCode);
  }

  @override
  Future<CompanyIntroductionResponse> getCompanyIntroduction(String stockCode) {
    return networkService.getCompanyIntroduction(stockCode);
  }

  @override
  Future<List<StockMatch>> getListStockMatch(String stockCode) {
    return networkService.getListStockMatch(stockCode);
  }

  @override
  Future<IndContrib> getIndFvalue(String marketCode) {
    return networkService.getIndFvalue(marketCode);
  }
}
