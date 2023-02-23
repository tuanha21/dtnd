import 'dart:convert';
import 'dart:io';

import 'package:dtnd/=models=/response/filter_criterion.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';



class VirtualAssistantFilterController {
  VirtualAssistantFilterController._internal();

  static final VirtualAssistantFilterController _instance =
      VirtualAssistantFilterController._internal();
  static VirtualAssistantFilterController get instance => _instance;

  factory VirtualAssistantFilterController() {
    return _instance;
  }

  final ILocalStorageService localStorageService = LocalStorageService();
  final IDataCenterService dataCenterService = DataCenterService();
  final INetworkService networkService = NetworkService();
  late final Box followingCatalogBox;
  final List<Stock> followingStocks = [];
  final List<StockModel> followingCatalog = [];
  final List<FilterCriterion> filterCriterions = [];
  final Rx<List<StockModel>?> listSuggestionStocks = Rxn();

  final Rx<bool> initialized = false.obs;

  Future<void> init() async {
    if (initialized.value) {
      return;
    }
    final saved = await getFollowingCatalog();
    if (followingStocks.isNotEmpty) return;

    if (saved?.isNotEmpty ?? false) {
      followingStocks.addAll(saved!);
      final List<String> list = [];
      for (var stock in saved) {
        list.add(stock.stockCode);
      }
      final stockModel =
          await dataCenterService.getStockModelsFromStockCodes(list);
      followingCatalog.addAll(stockModel!);
    }
    initialized.value = true;
  }

  Future<List<Stock>?> getFollowingCatalog() async {
    followingCatalogBox = localStorageService.box;
    final followingCatalog =
        followingCatalogBox.get("following_catalog")?.cast<Stock>() ?? [];
    return followingCatalog;
  }

  Future<void> getList30Stocks() async {
    try {
      final top = await dataCenterService.getList30Stock("HSX30");
      listSuggestionStocks.value = await dataCenterService
          .getStockModelsFromStockCodes(top.map((e) => e.stockCode).toList());
    } catch (e) {
      logger.e(e);
    }
    return;
  }

  Future<List<FilterCriterion>> getFilterCriterion() async {
    try {
      final File file = File(
          "/Users/hoangtuan/Mobile/Flutter/Projects/dtnd/lib/ui/screen/virtual_assistant/fake_data/filter_stock.json");
      final data =
          jsonDecode(const Utf8Codec().decode(await file.readAsBytes()));
      List<FilterCriterion> results = [];
      for (var element in data) {
        results.add(FilterCriterion.fromJson(element));
      }
      filterCriterions.clear();
      filterCriterions.addAll(results);
      return results;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  Future<void> addStock(Stock stock) async {
    if (followingStocks.contains(stock)) {
      throw Exception(S.current.stock_already_exist);
    }
    followingStocks.add(stock);
    final stockCode = [stock.stockCode];
    final stockModel =
        await dataCenterService.getStockModelsFromStockCodes(stockCode);
    if (stockModel?.isEmpty ?? true) {
      throw Exception(S.current.something_went_wrong);
    }
    followingCatalog.add(stockModel!.first);
    followingCatalogBox.put("following_catalog", followingStocks);
  }
}
