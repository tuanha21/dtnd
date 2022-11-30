import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/utilities/logger.dart';
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

  late final Set<IndexModel> listIndexs;
  final List<StockModel> listIndexStockModel = <StockModel>[];

  final Rx<IndexModel?> currentIndexModel = Rxn();

  final listDeepMarket = <DeepModel>[].obs;
  final Rx<bool> loadingDeepModel = false.obs;

  final Rx<bool> initialized = false.obs;

  void changeSelectedIndex(Index index) {
    currentIndexModel.value =
        listIndexs.firstWhere((element) => element.index == index);
    print("changed ${index.exchangeName}");
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
      listIndexs = await dataCenterService.getListIndex();
      currentIndexModel.value = listIndexs.first;
      getDeepMarket();
      initialized.value = true;
    } catch (e) {
      logger.v(e);
    }
  }
}
