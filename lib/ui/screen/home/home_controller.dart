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
  late final List<StockModel> marketToday;
  late final Set<IndexModel> listIndexs;
  late IndexModel currentIndexModel;

  final Rx<bool> initialized = false.obs;

  void init() async {
    try {
      if (initialized.value) {
        return;
      }
      interestedCatalog = await dataCenterService.getStockModelsFromStockCodes(
          localStorageService.getListInterestedStock() ?? defaultListStock);
      marketToday = await dataCenterService.getStockModelsFromStockCodes(
          localStorageService.getListInterestedStock() ?? defaultListStock);
      for (var element in marketToday) {
        await getStockIndayTradingHistory(element);
      }
      listIndexs = await dataCenterService.getListIndex();
      currentIndexModel = listIndexs.first;
      initialized.value = true;
    } catch (e) {
      logger.v(e);
    }
  }

  void refresh() async {
    initialized.value = false;
    interestedCatalog = await dataCenterService.getStockModelsFromStockCodes(
        localStorageService.getListInterestedStock() ?? defaultListStock);
    marketToday = await dataCenterService.getStockModelsFromStockCodes(
        localStorageService.getListInterestedStock() ?? defaultListStock);
    for (var element in marketToday) {
      await getStockIndayTradingHistory(element);
    }
    listIndexs = await dataCenterService.getListIndex();
    currentIndexModel = listIndexs.first;
    initialized.value = true;
  }

  Future<void> getStockIndayTradingHistory(StockModel stockModel) async {
    stockModel.stockTradingHistory.value = await dataCenterService
        .getStockIndayTradingHistory(stockModel.stock.stockCode);
  }
}
