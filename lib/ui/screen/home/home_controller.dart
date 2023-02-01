import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:get/get.dart';

class HomeController {
  HomeController._internal() {
    localStorageService = LocalStorageService();
    appService = AppService();
    networkService = NetworkService();
    dataCenterService = DataCenterService();
  }

  static final _instance = HomeController._internal();

  factory HomeController() => _instance;

  static HomeController get instance => _instance;

  late final ILocalStorageService localStorageService;
  late final AppService appService;
  late final INetworkService networkService;
  late final IDataCenterService dataCenterService;

  late final List<StockModel> interestedCatalog;
  List<StockModel> hotToday = [];
  List<StockModel> priceIncreaseToday = [];
  List<StockModel> priceDecreaseToday = [];
  List<StockModel> topForeignToday = [];
  late final Set<IndexModel> listIndexs;
  final Rx<IndexModel?> currentIndexModel = Rxn();

  final Rx<bool> initialized = false.obs;

  void init() async {
    try {
      if (initialized.value) {
        return;
      }
      await refresh();
    } catch (e) {
      logger.v(e);
    }
  }

  Future<void> getHotToday() async {
    final list = await dataCenterService.getStockModelsFromStockCodes(
        await dataCenterService.getTopStockTrade());
    hotToday = list;
  }

  Future<void> getPriceIncrease() async {
    final list = await dataCenterService.getStockModelsFromStockCodes(
        await dataCenterService.getTopStockChange());
    priceIncreaseToday = list;
  }

  Future<void> getPriceDecrease() async {
    final list = await dataCenterService.getStockModelsFromStockCodes(
        await dataCenterService.getTopStockChange(8, "d"));
    priceDecreaseToday = list;
  }

  Future<void> getTopForeign() async {
    final list = await dataCenterService.getStockModelsFromStockCodes(
        await dataCenterService.getTopForeignTrade());
    topForeignToday = list;
  }

  Future<void> refresh() async {
    initialized.value = false;
    interestedCatalog = await dataCenterService.getStockModelsFromStockCodes(
        localStorageService.getListInterestedStock() ?? defaultListStock);
    for (var element in interestedCatalog) {
      await getStockIndayTradingHistory(element);
    }
    await getHotToday();
    // marketToday = await dataCenterService.getStockModelsFromStockCodes(
    //     localStorageService.getListInterestedStock() ?? defaultListStock);
    changeList(hotToday);
    for (var element in hotToday) {
      await getStockIndayTradingHistory(element);
    }
    listIndexs = await dataCenterService.getListIndex(
        fromTime: TimeUtilities.getPreviousDateTime(TimeUtilities.year(1)),
        resolution: "1D");
    currentIndexModel.value = listIndexs.first;
    initialized.value = true;
    getPriceIncrease();
    getPriceDecrease();
    getTopForeign();
  }

  void changeIndex(Index index) {
    currentIndexModel.value =
        listIndexs.firstWhere((element) => element.index == index);
  }

  Future<void> changeList(List<StockModel> list) async {
    await Future.forEach<StockModel>(list, (item) async {
      await getStockIndayTradingHistory(item);
    });

    // for (var element in list) {
    //   await getStockIndayTradingHistory(element);
    // }
  }

  Future<void> getStockIndayTradingHistory(StockModel stockModel) async {
    stockModel.stockTradingHistory.value = await dataCenterService
        .getStockIndayTradingHistory(stockModel.stock.stockCode);
  }
}
