import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
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
        return processIndexData(data);
      }
      if (data['data']['id'] == 3220) {
        return processStockData(data);
      }
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
    if (_listIndex.isEmpty) return;
    final Index index = IndexUtil.fromCode(data['data']['mc']);
    final indexModel =
        _listIndex.firstWhere((element) => element.index == index);
    indexModel.onSocketData(data);
  }

  //
  void processStockData(dynamic data) {
    final stockModel = listStockReg.firstWhere(
        (element) => element.stock.stockCode == data['data']['sym']);
    stockModel.onSocketData(data);
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
    final List<StockModel> listReturn = [];
    final unregisteredCodes = getUnregisteredCodes(
      stockCodes,
      onRegisteredCode: (stockCode) {
        listReturn.add(listStockReg[listStockReg
            .indexWhere((element) => element.stock.stockCode == stockCode)]);
      },
    );
    logger.v(unregisteredCodes);
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
    for (var stock in listAllStockSaved) {
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
  Future<void> getListInterestedStocks() async {
    final List<String> listInterestedString =
        localStorageService.getListInterestedStock() ?? defaultListStock;
    for (var stockCode in listInterestedString) {
      final stock =
          listAllStock.firstWhere((element) => element.stockCode == stockCode);
      final stockTradingHistory = await getStockIndayTradingHistory(stockCode);
      final stockData = await getStockData(stockCode);
      _listInterestedStocks.add(StockModel(
          stock: stock,
          stockData: stockData,
          stockTradingHistory: stockTradingHistory));
    }
  }

  @override
  Future<Set<IndexModel>> getListIndex() async {
    for (var index in Index.values) {
      final response = await networkService.getIndexDetail(index);
      _listIndex.add(IndexModel(index: index, indexDetailResponse: response));
    }
    return _listIndex;
  }
}
