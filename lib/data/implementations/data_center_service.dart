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
import 'package:dtnd/utilities/time_utils.dart';

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
  late final List<Stock> listAllStock;

  final List<StockModel> _listInterestedStocks = [];

  final Set<IndexModel> _listIndex = {};

  @override
  List<StockModel> get listInterestedStocks => _listInterestedStocks;

  @override
  Set<IndexModel> get listIndexs => _listIndex;

  @override
  Future<void> init() async {
    await getListAllStock();
    await fetchData();
  }

  @override
  Future<void> fetchData() async {
    await getListInterestedStocks();
    await getListIndex();
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
    return await networkService.getListStockData(listStockString);
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
  Future<void> getListInterestedStocks() async {
    final List<String> listInterestedString =
        localStorageService.getListInterestedStock() ?? defaultListStock;
    for (var stockCode in listInterestedString) {
      final stock =
          listAllStock.firstWhere((element) => element.stockCode == stockCode);
      final stockTradingHistory = await getStockIndayTradingHistory(stockCode);
      _listInterestedStocks.add(
          StockModel(stock: stock, stockTradingHistory: stockTradingHistory));
    }

    final listStockData = await getListStockData(listInterestedString);
    for (var stockModel in _listInterestedStocks) {
      stockModel.stockData = listStockData.firstWhere(
        (element) => element.sym == stockModel.stock.stockCode,
        orElse: () => StockData(sym: stockModel.stock.stockCode),
      );
    }
  }

  @override
  Future<void> getListIndex() async {
    for (var index in Index.values) {
      final response = await networkService.getIndexDetail(index);
      _listIndex.add(IndexModel(index: index, indexDetailResponse: response));
    }
  }
}
