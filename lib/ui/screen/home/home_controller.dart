import 'dart:async';

import 'package:dtnd/=models=/response/commodity_model.dart';
import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/top_signal_stock_model.dart';
import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/=models=/response/world_index_model.dart';
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
  final int _initStep = 4;
  final StreamController<double> _initProcess =
      StreamController<double>.broadcast();
  Stream<double> get initProcess => _initProcess.stream;

  final Rx<List<TopSignalStockModel>?> topSignalStocks = Rxn();
  final Rx<bool> loadingTopSignalStocks = Rx(false);
  final Rx<List<TrashModel>?> hotToday = Rxn();
  List<NewsModel> news = [];
  List<WorldIndexModel> worldIndex = [];
  List<CommodityModel> commodities = [];
  late final Set<IndexModel> listIndexs;
  final Rx<IndexModel?> currentIndexModel = Rxn();
  final Rx<WorldIndexModel?> currentWorldIndexModel = Rxn();
  final Rx<CommodityModel?> currentCommodityModel = Rxn();
  final Rx<bool> newsLoading = true.obs;
  Timer? loadTime;

  final Rx<bool> indexInitialized = false.obs;
  final Rx<bool> topInitialized = false.obs;
  final Rx<bool> suggestInitialized = false.obs;

  Future<void> init() async {
    try {
      if (indexInitialized.value &&
          topInitialized.value &&
          suggestInitialized.value) {
        return;
      }
      await refresh();
    } catch (e) {
      logger.v(e);
    }
  }

  Future<List<TrashModel>> getHotToday() async {
    return dataCenterService.getTopInterested(8);
  }

  Future<List<TrashModel>> getPriceIncrease() async {
    return dataCenterService.getTopStockChange(8);
  }

  Future<List<TrashModel>> getPriceDecrease() async {
    return dataCenterService.getTopStockChange(8, "d");
  }

  Future<List<TrashModel>> getTopVolumn() async {
    return dataCenterService.getTopStockTrade(8);
  }

  // Future<void> getTopForeign() async {
  //   final topStockChange = await dataCenterService.getTopForeignTrade();
  //   final stockModels = await dataCenterService.getStockModelsFromStockCodes(
  //       topStockChange.map((e) => e.sTOCKCODE).toList());
  //   for (var i = 0; i < stockModels.length; i++) {
  //     stockModels.elementAt(i).simpleChartData.value =
  //         topStockChange.elementAt(i).cHART;
  //   }
  //   topForeignToday = stockModels;
  // }

  Future<void> getTopSignal() async {
    loadingTopSignalStocks.value = true;
    topSignalStocks.value = null;
    topSignalStocks.value = await dataCenterService.getTopSignalStocks();
    loadingTopSignalStocks.value = false;
  }

  Future<List<NewsModel>> getNews() async {
    newsLoading.value = true;
    news = await dataCenterService.getNews(1, 5);
    newsLoading.value = false;
    return news;
  }

  Future<List<WorldIndexModel>> getWorldIndex() async {
    worldIndex = await networkService.getWorldIndex();

    currentWorldIndexModel.value = worldIndex.first;
    return worldIndex;
  }

  Future<List<CommodityModel>> getCommodities() async {
    commodities = await networkService.getCommodity();
    currentCommodityModel.value = commodities.first;
    return commodities;
  }

  Future<void> refresh() async {
    _initProcess.sink.add(0 / _initStep);
    indexInitialized.value = false;
    topInitialized.value = false;
    suggestInitialized.value = false;
    listIndexs = await dataCenterService.getListIndex(
        fromTime: TimeUtilities.getPreviousDateTime(TimeUtilities.year(1)),
        resolution: "1D");
    _initProcess.sink.add(1 / _initStep);
    currentIndexModel.value = listIndexs.first;
    indexInitialized.value = true;

    await changeList(0, true, null);
    _initProcess.sink.add(2 / _initStep);
    // marketToday = await dataCenterService.getStockModelsFromStockCodes(
    //     localStorageService.getListInterestedStock() ?? defaultListStock);
    // changeList(hotToday);
    // for (var i = 0; i < hotToday.length; i++) {
    //   await getStockIndayTradingHistory(hotToday.elementAt(i));
    //   _initProcess.sink.add(((2 + (i / hotToday.length)) / _initStep));
    // }
    topInitialized.value = true;
    await getTopSignal();
    _initProcess.sink.add(4 / _initStep);
    suggestInitialized.value = true;
    getWorldIndex();
    getCommodities();
    // getPriceIncrease();
    // getPriceDecrease();
    // // getTopForeign();
    // getTopVolumn();
  }

  void changeIndex(Index index) {
    currentIndexModel.value =
        listIndexs.firstWhere((element) => element.index == index);
  }

  void changeWorldIndex(WorldIndexModel index) {
    currentWorldIndexModel.value = index;
  }

  void changeCommodity(CommodityModel index) {
    currentCommodityModel.value = index;
  }

  Future<void> changeList(
      int index, bool up, List<String>? listStockCodes) async {
    if (listStockCodes != null) {
      dataCenterService.removeStockModelsFromStockCodes(listStockCodes);
    }
    switch (index) {
      case 1:
        if (up) {
          hotToday.value = await getPriceIncrease();
        }
        hotToday.value = await getPriceDecrease();
        break;
      case 2:
        hotToday.value = await getTopVolumn();
        break;
      default:
        hotToday.value = await getHotToday();
    }
    loadTime?.cancel();
    loadTime = Timer(const Duration(minutes: 1),
        () => changeList(index, up, listStockCodes));
  }

  Future<void> getStockIndayTradingHistory(StockModel stockModel) async {
    stockModel.indayTradingHistory.value = await dataCenterService
        .getStockIndayTradingHistory(stockModel.stock.stockCode);
  }
}
