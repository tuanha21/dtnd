import 'package:dtnd/=models=/response/business_profile_model.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/security_basic_info_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_info_core.dart';
import 'package:dtnd/=models=/response/stock_ranking_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/subsidiaries_model.dart';
import 'package:get/get.dart';

class StockModel {
  late final Stock stock;
  late final StockData stockData;
  late StockInfoCore? stockDataCore;
  late List<StockTrade>? listStockTrade;
  final Rx<StockTradingHistory?> stockTradingHistory = Rxn();
  final List<IndayMatchedOrder> _listMatchedOrder = [];
  final Rx<SecurityBasicInfo?> securityBasicInfo = Rxn();
  final List<StockFinancialIndex> stockFinancialIndex = [];
  final Rx<StockRankingFinancialIndex?> stockRankingFinancialIndex = Rxn();
  BusinnessProfileModel? businnessProfile;
  List<BusinnessLeaderModel>? businnessLeaders;
  final BusinessSubsidiariesModel subsidiaries = BusinessSubsidiariesModel();

  List<IndayMatchedOrder> get listMatchedOrder => _listMatchedOrder;

  void updateListMatchedOrder(List<IndayMatchedOrder> newList) {
    _listMatchedOrder.clear();
    _listMatchedOrder.addAll(newList);
    return;
  }

  num get maxVolumnMatchedOrder {
    num max = 0;
    for (final IndayMatchedOrder element in _listMatchedOrder) {
      if (element.matchVolume > max) {
        max = element.matchVolume;
      }
    }
    return max;
  }

  StockModel({
    required this.stock,
    required this.stockData,
    this.stockDataCore,
    this.listStockTrade,
    StockTradingHistory? stockTradingHistory,
    List<StockFinancialIndex>? stockFinancialIndex,
    SecurityBasicInfo? securityBasicInfo,
    StockRankingFinancialIndex? stockRankingFinancialIndex,
  }) {
    this.stockTradingHistory.value = stockTradingHistory;
    this.stockRankingFinancialIndex.value = stockRankingFinancialIndex;
    this.securityBasicInfo.value = securityBasicInfo;
    if (stockFinancialIndex != null) {
      this.stockFinancialIndex.addAll(stockFinancialIndex);
    }
  }

  void changeStockFinancialIndex(
      List<StockFinancialIndex> stockFinancialIndex) {
    this.stockFinancialIndex.clear();
    this.stockFinancialIndex.addAll(stockFinancialIndex);
  }

  void onSocketData(dynamic data) {
    if (data["data"]["id"] == 3220) {
      stockData
        ..lastPrice.value = data["data"]["lastPrice"]
        ..lot.value = data["data"]["totalVol"]
        ..changePc.value = num.tryParse(data["data"]["changePc"]) ?? 0
        ..ot.value = num.tryParse(data["data"]["change"]) ?? 0
        ..highPrice.value = data["data"]["hp"]
        ..lowPrice.value = data["data"]["lp"]
        ..avePrice.value = data["data"]["ap"];
    } else if (data["data"]["id"] == 3210) {
      if (data["data"]["side"] == "S") {
        stockData
          ..g4.value = data["data"]["g1"]
          ..g5.value = data["data"]["g2"]
          ..g6.value = data["data"]["g3"];
      } else {
        stockData
          ..g1.value = data["data"]["g1"]
          ..g2.value = data["data"]["g2"]
          ..g3.value = data["data"]["g3"];
      }
    } else if (data["data"]["id"] == 3250) {
      stockData
        ..fBVol.value = num.tryParse(data["data"]["fBVol"])
        ..fBValue.value = num.tryParse(data["data"]["fBValue"])
        ..fSVolume.value = num.tryParse(data["data"]["fSVolume"])
        ..fSValue.value = num.tryParse(data["data"]["fSValue"])
        ..fRoom.value = num.tryParse(data["data"]["fRoom"]);
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is StockModel && other.stock == stock) {
      return true;
    }
    return false;
  }

  @override
  int get hashCode => stock.hashCode;

  @override
  String toString() {
    return 'StockModel{stock: $stock, stockData: $stockData, stockDataCore: $stockDataCore, listStockTrade: $listStockTrade, stockTradingHistory: $stockTradingHistory, _listMatchedOrder: $_listMatchedOrder}';
  }
}
