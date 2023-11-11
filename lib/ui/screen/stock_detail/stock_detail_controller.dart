import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:get/get.dart';

//add later
class StockDetailController {
  final IDataCenterService dataCenterService = DataCenterService();
  final INetworkService networkService = NetworkService();

  StockDetailController._internal();

  static final StockDetailController _instance =
      StockDetailController._internal();

  static StockDetailController get instance => _instance;

  factory StockDetailController(StockModel stockModel) {
    // _instance.rxStockModel
    return _instance;
  }

  late final Rx<StockModel> rxStockModel;
}
