import 'dart:async';

import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/top_interested_model.dart';
import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/=models=/response/world_index_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/config/service/environment.dart';
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
  final Rx<List<TrashModel>?> hotToday = Rxn();
  final Rx<List<TrashModel>?> priceIncreaseToday = Rxn();
  final Rx<List<TrashModel>?> priceDecreaseToday = Rxn();
  final Rx<List<TrashModel>?> topVolumnToday = Rxn();
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
    // hotToday.clear();
    final topInterested = await dataCenterService.getTopInterested(8);
    hotToday.value = topInterested;
    hotToday.refresh();
  }

  Future<void> getPriceIncrease() async {
    final topStockChange = await dataCenterService.getTopStockChange(8);

    priceIncreaseToday.value = topStockChange;
    priceIncreaseToday.refresh();
  }

  Future<void> getPriceDecrease() async {
    final topStockChange = await dataCenterService.getTopStockChange(8, "d");
    priceDecreaseToday.value = topStockChange;
    priceDecreaseToday.refresh();
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

  Future<void> getTopVolumn() async {
    final topStockChange = await dataCenterService.getTopStockTrade(8);
    topVolumnToday.value = topStockChange;
    topVolumnToday.refresh();
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
    // for (var i = 0; i < hotToday.length; i++) {
    //   await getStockIndayTradingHistory(hotToday.elementAt(i));
    //   _initProcess.sink.add(((2 + (i / hotToday.length)) / _initStep));
    // }
    topInitialized.value = true;
    final stockModels = await dataCenterService.getStockModelsFromStockCodes(
        localStorageService.getListInterestedStock() ?? defaultListStock);
    interestedCatalog = stockModels ?? [];
    _initProcess.sink.add(4 / _initStep);
    suggestInitialized.value = true;
    getWorldIndex();
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

  Future<void> changeList(
      int index, bool up, List<String>? listStockCodes) async {
    if (listStockCodes != null) {
      dataCenterService.removeStockModelsFromStockCodes(listStockCodes);
    }
    switch (index) {
      case 1:
        if (up) {
          return getPriceIncrease();
        }
        return getPriceDecrease();
      case 2:
        return getTopVolumn();
      default:
        return getHotToday();
    }
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
