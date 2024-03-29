import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/market/business_profile_model.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/market/ind_contrib.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/market/index_detail.dart';
import 'package:dtnd/=models=/response/market/index_model.dart';
import 'package:dtnd/=models=/response/market/introduct_company.dart';
import 'package:dtnd/=models=/response/market/liquidity_model.dart';
import 'package:dtnd/=models=/response/market/news_detail.dart';
import 'package:dtnd/=models=/response/market/news_model.dart';
import 'package:dtnd/=models=/response/market/sec_event.dart';
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
import 'package:dtnd/=models=/response/stock_vol.dart';
import 'package:dtnd/=models=/response/subsidiaries_model.dart';
import 'package:dtnd/=models=/response/market/suggested_signal_model.dart';
import 'package:dtnd/=models=/response/market/top_influence_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_detail_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_history_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_stock_model.dart';
import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/=models=/response/market/field_tree_element_model.dart';
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

import '../../=models=/response/market/index_board.dart';
import '../../=models=/response/market/radar_chart_model.dart';
import '../../=models=/response/market/stock_derivative_model.dart';
import '../../=models=/response/market/stock_industry.dart';

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

class DataCenterService
    with WidgetsBindingObserver
    implements IDataCenterService {
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

  bool socketConnecting = false;

  AppLifecycleState appLifecycleState = AppLifecycleState.resumed;

  bool registering = false;

  bool initingListIndex = false;

  final Map<String, int> listStockStringReg = <String, int>{};

  final List<StockModel> listStockReg = <StockModel>[];

  late final List<Stock> listAllStock;

  final Set<IndexModel> _listIndex = {};

  @override
  Set<IndexModel> get listIndexs => _listIndex;

  @override
  Future<void> init() async {
    await getListAllStock();
    socket = networkService.socket;
    await startSocket();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleState = state;
    if (state == AppLifecycleState.resumed) {
      print(socket.disconnected);
      if (socket.disconnected) {
        for (StockModel element in listStockReg) {
          element.getStockData(this);
        }
        for (IndexModel index in _listIndex) {
          index.getIndexData(this);
        }
        socket.connect();
      }
    }
  }

  @override
  Future<void> startSocket() async {
    socket.on("public", (data) {
      if (data['data']['id'] == 1101) {
        return processIndexData(data);
      }
      if (data['data']['id'] == 3220 ||
          data['data']['id'] == 3210 ||
          data['data']['id'] == 3250) {
        return processStockData(data);
      }
    });
    socket.onPing((data) {
      const String pingMsg =
          "{\"action\":\"ping\",\"mode\":\"sync\",\"data\":\"\"}";
      socket.emit("regs", pingMsg);
    });
    socket.onDisconnect((data) {
      print("Socket disconnected!");
      if (appLifecycleState == AppLifecycleState.resumed) {
        return socket.connect();
      } else {
        return null;
      }
    });
    socket.onConnecting((data) {
      print("Try to connecting...");
      print(data.toString());
      socketConnecting = true;
    });
    socket.onConnectError((data) {
      print("Socket connect error!");
      logger.e(data);
      socketConnecting = false;
      return socket.connect();
    });
    socket.onConnect((data) {
      print("Socket connected!");
      regSocketStocks(listStockReg.map((e) => e.stock.stockCode).toList());
      socketConnecting = false;
    });
    socket.connect();
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
    final List<String> joinList = getUnregisteredCodes(
      stocks,
      onRegisteredCode: (stock) =>
          listStockStringReg.update(stock, (value) => ++value),
      onUnregisteredCode: (stock) => listStockStringReg[stock] = 1,
    );
    if (joinList.isNotEmpty) {
      regSocketStocks(joinList);
    }
  }

  Future<List<String>> leaveStocks(List<String> stocks) async {
    for (final String stock in stocks) {
      if (listStockStringReg.containsKey(stock)) {
        listStockStringReg.update(stock, (value) => --value);
      } else {
        continue;
      }
    }
    final List<String> leaveList = getOneRegisteredCodes(
      stocks,
      onOneRegisteredCode: (stockCode) => listStockStringReg.remove(stockCode),
      onUnregisteredCode: (stockCode) =>
          listStockStringReg.update(stockCode, (value) => --value),
    );
    leaveSocketStocks(leaveList);
    return leaveList;
  }

  /// Join socket
  void regSocketStocks(List<String> stocks) {
    final String codes = stocks.join(",");
    String joinMsg = "{\"action\":\"join\",\"data\":\"$codes\"}";
    socket.emit("regs", joinMsg);
    // print(joinMsg);
    return;
  }

  /// Leave socket
  void leaveSocketStocks(List<String> stocks) {
    final String codes = stocks.join(",");
    String leaveMsg = "{\"action\":\"leave\",\"data\":\"$codes\"}";
    socket.emit("regs", leaveMsg);
    // print(leaveMsg);
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
      if ((listStockStringReg[stockCode] ?? 0) <= 1) {
        oneRegisteredCodes.add(stockCode);
        onOneRegisteredCode?.call(stockCode);
      } else {
        onUnregisteredCode?.call(stockCode);
      }
    }
    return oneRegisteredCodes;
  }

  @override
  Future<List<StockModel>?> getStocksModelsFromStockCodes(
      List<String> stockCodes) async {
    if (registering) {
      // Wait to recall
      await 1.delay();
      // Recall
      return getStocksModelsFromStockCodes(stockCodes);
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
  Future<StockModel?> getStockModelFromStockCode(String stockCode) async {
    final res = await getStocksModelsFromStockCodes([stockCode]);
    if (res?.isEmpty ?? true) {
      return null;
    } else {
      return res!.first;
    }
  }

  @override
  List<Stock> getStocksFromStockCodes(List<String> stockCodes) {
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
  Stock getStockFromStockCode(String stockCode) {
    final res = getStocksFromStockCodes([stockCode]);
    return res.first;
  }

  @override
  Future<void> removeStockModelsFromStockCodes(List<String> stockCodes) {
    return leaveStocks(stockCodes);
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
  Future<List<TrashModel>> getTopForeignTrade(
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
  Future<List<TrashModel>> getTopStockChange(
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
  Future<List<TrashModel>> getTopInterested(
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
  Future<List<TrashModel>> getTopStockTrade(
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
  Future<List<TopSignalStockModel>> getTopSignalStocks({int count = 5}) async {
    final Map<String, String> body = {
      "cmd": "top_signal",
      "params": "$count",
    };
    final listTop = await networkService.getTopSignalStocks(body);
    if (listTop?.isEmpty ?? true) {
      return [];
    }
    final List<String> listStrings = listTop!.map((e) => e.cSHARECODE).toList();
    final stockModels = await getStocksModelsFromStockCodes(listStrings);
    if (stockModels?.isEmpty ?? true) {
      return listTop;
    }
    if (stockModels!.length != listTop.length) {
      for (final StockModel stockModel in stockModels) {
        listTop
            .firstWhere(
                (element) => element.cSHARECODE == stockModel.stock.stockCode)
            .stockModel = stockModel;
      }
    } else {
      for (int i = 0; i < listTop.length; i++) {
        listTop[i].stockModel = stockModels[i];
      }
    }
    return listTop;
  }

  @override
  Future<List<SignalType>> getSignalList() async {
    final Map<String, String> body = {
      "cmd": "signal_list",
      "params": "0",
    };
    final listTop = await networkService.getSignalList(body);
    if (listTop?.isEmpty ?? true) {
      return [];
    }
    return listTop ?? [];
  }

  @override
  Future<List<SuggestedSignalModel>> getSuggestedSignal(int day) async {
    final Map<String, String> body = {
      "cmd": "signal_sum",
      "params": "$day",
    };
    final listTop = await networkService.getSuggestedSignal(body);
    if (listTop?.isEmpty ?? true) {
      return [];
    }
    return listTop ?? [];
  }

  @override
  Future<List<SuggestedSignalModel>> getSuggestedSignalFilter(
      int day, String? type) async {
    final Map<String, String> body = {
      "cmd": "signal_sum",
      "params": "$day,${type ?? "ALL"}",
    };
    final listTop = await networkService.getSuggestedSignal(body);
    if (listTop?.isEmpty ?? true) {
      return [];
    }
    return listTop ?? [];
  }

  @override
  Future<TopSignalDetailModel?> getTopSignalDetail(
      String stockCode, String type) {
    final Map<String, String> body = {
      "cmd": "signal_detail",
      "params": "$stockCode,$type",
    };
    return networkService.getTopSignalDetail(body);
  }

  @override
  Future<List<TopSignalHistoryModel>?> getTopSignalHistory(
      String stockCode, String type,
      {int day = 60}) async {
    final Map<String, String> body = {
      "cmd": "signal_his",
      "params": "$stockCode,$type,$day",
    };
    return networkService.getTopSignalHistory(body);
  }

  @override
  Future<List<SignalMonthModel>?> getSignalMonth(
      String stockCode, String type) async {
    final Map<String, String> body = {
      "cmd": "signal_month",
      "params": "$stockCode,$type",
    };
    return networkService.getSignalMonth(body);
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
    for (var i = 0; i < searchedStocks.length; i++) {
      if (searchedStocks[i].stockCode == _sym ||
          searchedStocks[i].stockCode.length == 3) {
        final main = searchedStocks.removeAt(searchedStocks.length - 1);
        searchedStocks.insert(0, main);
      }
    }
    return searchedStocks;
  }

  @override
  Stock? getStocksBySym(String sym) {
    final sym0 = sym.toUpperCase();

    return listAllStock.firstWhere((element) => element.stockCode == sym0);
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
  Future<StockDataResponse> getStockDataResponse(String stockCode) async {
    final List<StockDataResponse> listResponse =
        await networkService.getListStockData(stockCode);
    if (listResponse.isEmpty) return StockDataResponse(sym: stockCode);

    return listResponse.first;
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
      final response = await getIndexDetail(index);
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
  Future<IndexDetailResponse> getIndexDetail(Index index) {
    return networkService.getIndexDetail(index);
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
  Future<RadarChartModel> getDataRadarChart(String code, [String lang = "vi"]) {
    final body = '{"lang":"$lang", "secCode": "$code"}';
    return networkService.getDataRadarChart(body);
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
  Future<List<SecEvent>> getListEvent(String stockCode,
      {required DateTime startDate,
      String lang = "vi",
      String reqLanguage = "VI"}) {
    return networkService.getListEvent(stockCode,
        startDate: startDate, lang: lang, reqLanguage: reqLanguage);
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

  @override
  Future<List<DerivativeResModel>> getListDerivative() {
    return networkService.getListDerivative();
  }
}
