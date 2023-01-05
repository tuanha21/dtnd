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
    socket.connect();
    regStocks(_listInterestedStocks.map((e) => e.stock.stockCode).toList());
    return;
  }

  void processIndexData(dynamic data) {
    if (_listIndex.toList().isEmpty) return;
    final Index index = IndexUtil.fromCode(data['data']['mc']);
    final indexModel = _listIndex.firstWhere(
      (element) => element.index == index,
    );
    indexModel.onSocketData(data);
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
  Future<List<StockModel>> getStockModelsFromStockCodes(
      List<String> stockCodes) async {
    if (registering) {
      // Wait to recall
      await 1.delay();
      // Recall
      return getStockModelsFromStockCodes(stockCodes);
    }
    registering = true;
    final List<StockModel> listReturn = <StockModel>[];
    final registeredCode = getRegisteredCodes(stockCodes);
    if (registeredCode.isNotEmpty) {
      for (final String stockCode in registeredCode) {
        final int index = listStockReg
            .indexWhere((element) => element.stock.stockCode == stockCode);
        if (index != -1) {
          listReturn.add(listStockReg[index]);
        }
      }
    }
    final unregisteredCodes = getUnregisteredCodes(stockCodes);
    if (unregisteredCodes.isNotEmpty) {
      for (final String code in unregisteredCodes) {
        final stock =
            listAllStock.firstWhere((element) => element.stockCode == code);
        final stockData = await getStockData(code);
        final stockModel = StockModel(stock: stock, stockData: stockData);
        listStockReg.add(stockModel);
        listReturn.add(stockModel);
      }
    }
    regStocks(stockCodes);
    registering = false;
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
  Future<List<StockModel>> getList30Stock(String code) async {
    final listStocks = await networkService.getList30Stocks(code);
    if (listStocks.isEmpty) {
      return [];
    }

    final List<StockModel> results =
        await getStockModelsFromStockCodes(listStocks);
    return results;
  }

  @override
  Future<List<Stock>> searchStocksBySym(String sym,
      {int maxSuggestions = 10}) async {
    if (sym.isEmpty) {
      return [];
    }
    final List<Stock> searchedStocks = <Stock>[];

    final _sym = sym.toUpperCase();
    for (final Stock stock in listAllStock) {
      if (stock.stockCode.contains(_sym)) {
        searchedStocks.add(stock);
        if (_sym.length == maxSuggestions) {
          return searchedStocks;
        }
      }
    }
    return searchedStocks;
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
    final String from =
        TimeUtilities.timeToEpoch(TimeUtilities.beginningOfDay).toString();
    final String to = TimeUtilities.timeToEpoch(DateTime.now()).toString();
    return networkService.getStockTradingHistory(
        stockCode, resolution, from, to);
  }

  @override
  Future<StockTradingHistory?> getStockTradingHistory(
      String stockCode, String resolution, int from, int to) {
    return networkService.getStockTradingHistory(
        stockCode, resolution, from.toString(), to.toString());
  }

  @override
  Future<Set<IndexModel>> getListIndex() async {
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
      final int from = TimeUtilities.timeToEpoch(
          TimeUtilities.getPreviousDateTime(TimeUtilities.week(1)));
      final int to = TimeUtilities.timeToEpoch(DateTime.now());
      final chartResponse =
          await getStockTradingHistory(index.chartCode, "5", from, to);
      _listIndex.add(IndexModel(
        index: index,
        indexDetailResponse: response,
        stockTradingHistory: chartResponse,
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
      {int top = 8, String type = "KL"}) {
    return networkService.getListIndustryHeatMap(top, type);
  }
}
