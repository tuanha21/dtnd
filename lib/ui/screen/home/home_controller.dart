import 'dart:async';

import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
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

  late final List<StockModel> interestedCatalog;
  List<StockModel> hotToday = [];
  List<StockModel> priceIncreaseToday = [];
  List<StockModel> priceDecreaseToday = [];
  List<StockModel> topForeignToday = [];
  List<StockModel> topVolumnToday = [];
  List<NewsModel> news = [];
  List<WorldIndexModel> worldIndex = [];
  late final Set<IndexModel> listIndexs;
  final Rx<IndexModel?> currentIndexModel = Rxn();
  final Rx<WorldIndexModel?> currentWorldIndexModel = Rxn();
  final Rx<bool> newsLoading = true.obs;

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

  Future<void> getHotToday() async {
    final list = await dataCenterService.getStockModelsFromStockCodes(
        await dataCenterService.getTopInterested(8));
    hotToday = list;
  }

  Future<void> getPriceIncrease() async {
    final list = await dataCenterService.getStockModelsFromStockCodes(
        await dataCenterService.getTopStockChange(8));
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

  Future<void> getTopVolumn() async {
    final listStrings = await dataCenterService.getTopStockTrade(8);
    // logger.v(listStrings);
    final list =
        await dataCenterService.getStockModelsFromStockCodes(listStrings);
    // list.sort((a, b) => (a.stockData.lastVolume.value ?? 0)
    //     .compareTo((b.stockData.lastVolume.value ?? 0)));
    // for (var element in list) {
    //   print(element.stock.stockCode);
    // }
    topVolumnToday = list;
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

    await getHotToday();
    _initProcess.sink.add(2 / _initStep);
    // marketToday = await dataCenterService.getStockModelsFromStockCodes(
    //     localStorageService.getListInterestedStock() ?? defaultListStock);
    // changeList(hotToday);
    for (var i = 0; i < hotToday.length; i++) {
      await getStockIndayTradingHistory(hotToday.elementAt(i));
      _initProcess.sink.add(((2 + (i / hotToday.length)) / _initStep));
    }
    topInitialized.value = true;
    interestedCatalog = await dataCenterService.getStockModelsFromStockCodes(
        localStorageService.getListInterestedStock() ?? defaultListStock);
    _initProcess.sink.add(4 / _initStep);
    suggestInitialized.value = true;
    getWorldIndex();
    getPriceIncrease();
    getPriceDecrease();
    // getTopForeign();
    getTopVolumn();
  }

  void changeIndex(Index index) {
    currentIndexModel.value =
        listIndexs.firstWhere((element) => element.index == index);
  }

  void changeWorldIndex(WorldIndexModel index) {
    currentWorldIndexModel.value = index;
  }

  Future<void> changeList(List<StockModel> list) async {
    // await Future.forEach<StockModel>(list, (item) async {
    //   await getStockIndayTradingHistory(item);
    // });

    // for (var element in list) {
    //   await getStockIndayTradingHistory(element);
    // }
  }

  Future<void> getStockIndayTradingHistory(StockModel stockModel) async {
    stockModel.indayTradingHistory.value = await dataCenterService
        .getStockIndayTradingHistory(stockModel.stock.stockCode);
  }
}
