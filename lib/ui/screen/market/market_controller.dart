import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/utilities/collections.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:get/get.dart';

class MarketController {
  MarketController._internal() {
    appService = AppService();
    networkService = NetworkService();
    dataCenterService = DataCenterService();
  }

  static final MarketController _instance = MarketController._internal();

  factory MarketController() => _instance;

  late final AppService appService;
  late final INetworkService networkService;
  late final IDataCenterService dataCenterService;

  late final Set<Pair<IndexModel, StockTradingHistory?>> listIndexs;

  final Rx<IndexModel?> currentIndexModel = Rxn();
  final Rx<StockTradingHistory?> currentChartData = Rxn();

  final listDeepMarket = <DeepModel>[].obs;
  final Rx<bool> loadingDeepModel = false.obs;

  final Rx<bool> initialized = false.obs;
  final Rx<bool> loadingIndex = false.obs;

  Future<void> changeSelectedIndex(Index index) async {
    loadingIndex.value = true;
    final Pair<IndexModel, StockTradingHistory?> pair =
        listIndexs.firstWhere((element) => element.first.index == index);
    currentIndexModel.value = pair.first;
    if (pair.second == null ||
        pair.second!.lastUpdatedTime
            .isBefore(DateTime.now().subtract(const Duration(minutes: 5)))) {
      pair.second = await dataCenterService.getStockTradingHistory(
        currentIndexModel.value!.index.chartCode,
        "5",
        DateTime.now().subtract(TimeUtilities.week(1)),
        DateTime.now(),
      );
    }
    currentChartData.value = pair.second;
    loadingIndex.value = false;
  }

  Future<void> getDeepMarket() async {
    try {
      if (listDeepMarket.isNotEmpty) {
        return;
      }
      loadingDeepModel.value = true;
      listDeepMarket.value = await networkService.getMarketDepth();
      loadingDeepModel.value = false;
    } catch (e) {
      logger.e(e);
    }
  }

  void init() async {
    try {
      if (initialized.value) {
        return;
      }
      final listIndexsResponse = await dataCenterService.getListIndex();
      listIndexs = <Pair<IndexModel, StockTradingHistory?>>{};
      for (var i = 0; i < listIndexsResponse.length; i++) {
        print(listIndexsResponse.elementAt(i).index.chartCode);
        listIndexs.add(Pair(listIndexsResponse.elementAt(i), null));
      }
      currentIndexModel.value = listIndexsResponse.first;
      currentChartData.value = await dataCenterService.getStockTradingHistory(
        currentIndexModel.value!.index.chartCode,
        "5",
        DateTime.now().subtract(TimeUtilities.week(1)),
        DateTime.now(),
      );
      // getDeepMarket();
      initialized.value = true;
    } catch (e) {
      logger.v(e);
    }
  }
}
